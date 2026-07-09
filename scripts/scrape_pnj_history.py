#!/usr/bin/env python3
"""Cào lịch sử giá vàng PNJ theo ngày từ giavang.org.

Nguồn: https://giavang.org/trong-nuoc/pnj/lich-su/ (dữ liệu từ 01/01/2015).
Mỗi ngày có 1 trang /trong-nuoc/pnj/lich-su/YYYY-MM-DD.html chứa bảng theo
nhiều khu vực (TPHCM, Hà Nội, Đà Nẵng...) với dòng "PNJ"/"SJC" (SJC chỉ để
tham chiếu, không dùng), và 1 khu vực riêng "Giá vàng nữ trang" có dòng
"Nhẫn PNJ (24K)" + "Nữ trang 24K/18K/14K/10K".
Lấy 2 series khớp goldType app đang track:
  - "PNJ" khu vực "Hà Nội"       → pnj_hanoi
  - "Nhẫn PNJ (24K)"             → pnj_24k

Giống SJC, nguồn có thể đã ngừng công bố ở 1 mốc nào đó — script cứ cào,
ngày nào không có dữ liệu thì ghi `status: no_data`.

Cách chạy:
    python3 scripts/scrape_pnj_history.py            # cào toàn bộ (resume được)
    python3 scripts/scrape_pnj_history.py --limit 50 # thử 50 ngày đầu

Output:
    data/pnj_raw.jsonl      — cache thô, 1 dòng/ngày
    pnj_hanoi_history.json  — series PNJ Hà Nội: [{d, buy, sell}] (nghìn đồng/lượng)
    pnj_24k_history.json    — series Nhẫn PNJ 24K: [{d, buy, sell}]
"""

import argparse
import json
import re
import sys
import time
import urllib.request
from pathlib import Path

BASE = "https://giavang.org/trong-nuoc/pnj/lich-su/"
UA = "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/126.0 Safari/537.36"
REPO_ROOT = Path(__file__).resolve().parent.parent
RAW_PATH = REPO_ROOT / "data" / "pnj_raw.jsonl"
DELAY_SECONDS = 0.35
MAX_RETRIES = 3

# (tên file output, regex khớp "type", regex khu vực ưu tiên).
SERIES_DEFS = [
    ("pnj_hanoi_history.json", r"^pnj$", r"hà nội"),
    ("pnj_24k_history.json", r"nhẫn pnj", r"nữ trang"),
]


def fetch(url: str) -> str:
    last_err = None
    for attempt in range(MAX_RETRIES):
        try:
            req = urllib.request.Request(url, headers={"User-Agent": UA})
            with urllib.request.urlopen(req, timeout=30) as resp:
                return resp.read().decode("utf-8", errors="replace")
        except Exception as e:  # noqa: BLE001 — retry mọi lỗi mạng
            last_err = e
            time.sleep(2.0 * (attempt + 1))
    raise RuntimeError(f"fetch failed after {MAX_RETRIES} tries: {url}: {last_err}")


def get_date_list() -> list[str]:
    html = fetch(BASE)
    dates = sorted(set(re.findall(r"lich-su/(\d{4}-\d{2}-\d{2})\.html", html)))
    if not dates:
        raise RuntimeError("Không tìm thấy link ngày nào trên trang index")
    return dates


def parse_price(cell: str) -> int | None:
    digits = re.sub(r"[^\d]", "", cell)
    return int(digits) if digits else None


def parse_day(html: str, date: str) -> dict:
    if "Không tìm thấy dữ liệu" in html:
        return {"date": date, "status": "no_data", "rows": []}

    tables = re.findall(r"<table.*?</table>", html, re.S)
    if not tables:
        return {"date": date, "status": "no_table", "rows": []}

    rows_out = []
    region = None
    for tr in re.findall(r"<tr>(.*?)</tr>", tables[0], re.S):
        cells = re.findall(r"<t([hd])[^>]*>(.*?)</t[hd]>", tr, re.S)
        values = [re.sub(r"<[^>]+>", "", c[1]).strip() for c in cells]
        if not values or "giavang.org" in " ".join(values) or values[0] == "Khu vực":
            continue
        if cells[0][0] == "h":
            region = values[0]
            values = values[1:]
        if len(values) < 4 or region is None:
            continue
        gold_type, buy_raw, sell_raw, time_str = values[0], values[1], values[2], values[3]
        buy, sell = parse_price(buy_raw), parse_price(sell_raw)
        if buy is None and sell is None:
            continue
        rows_out.append({
            "region": region,
            "type": gold_type,
            "buy": buy,
            "sell": sell,
            "time": time_str,
        })
    return {"date": date, "status": "ok" if rows_out else "empty", "rows": rows_out}


def load_done() -> dict[str, dict]:
    done = {}
    if RAW_PATH.exists():
        with RAW_PATH.open(encoding="utf-8") as f:
            for line in f:
                line = line.strip()
                if line:
                    rec = json.loads(line)
                    done[rec["date"]] = rec
    return done


def find_row(rows: list[dict], type_pattern: str, region_pattern: str) -> dict | None:
    candidates = [
        r for r in rows
        if r["buy"] is not None and r["sell"] is not None
        and re.search(type_pattern, r["type"].lower())
    ]
    if not candidates:
        return None
    candidates.sort(key=lambda r: 0 if re.search(region_pattern, r["region"].lower()) else 1)
    return candidates[0]


def build_series_json(done: dict[str, dict], filename: str, type_pattern: str, region_pattern: str) -> None:
    series = []
    for date in sorted(done):
        rec = done[date]
        if rec["status"] != "ok":
            continue
        row = find_row(rec["rows"], type_pattern, region_pattern)
        if row:
            series.append({"d": date, "buy": row["buy"], "sell": row["sell"]})
    path = REPO_ROOT / filename
    with path.open("w", encoding="utf-8") as f:
        json.dump({
            "source": "giavang.org",
            "unit": "nghìn đồng/lượng",
            "series": series,
        }, f, ensure_ascii=False, separators=(",", ":"))
    print(f"→ {filename}: {len(series)} ngày có giá")


def build_all_series(done: dict[str, dict]) -> None:
    for filename, type_pattern, region_pattern in SERIES_DEFS:
        build_series_json(done, filename, type_pattern, region_pattern)


def dedupe_raw_file(done: dict[str, dict]) -> None:
    RAW_PATH.parent.mkdir(parents=True, exist_ok=True)
    with RAW_PATH.open("w", encoding="utf-8") as f:
        for date in sorted(done):
            f.write(json.dumps(done[date], ensure_ascii=False) + "\n")


def main() -> int:
    ap = argparse.ArgumentParser()
    ap.add_argument("--limit", type=int, default=0, help="chỉ cào N ngày chưa có (0 = tất cả)")
    ap.add_argument("--rebuild-only", action="store_true", help="chỉ build lại JSON cho app từ cache")
    args = ap.parse_args()

    done = load_done()
    if args.rebuild_only:
        build_all_series(done)
        return 0

    print("Lấy danh sách ngày từ trang index...")
    dates = get_date_list()
    todo = [d for d in dates if d not in done]
    if args.limit:
        todo = todo[: args.limit]
    print(f"Tổng {len(dates)} ngày, đã có {len(done)}, cần cào {len(todo)}")

    ok = missing = failed = 0
    for i, date in enumerate(todo, 1):
        try:
            html = fetch(f"{BASE}{date}.html")
            rec = parse_day(html, date)
        except Exception as e:  # noqa: BLE001 — ghi lỗi rồi đi tiếp
            print(f"  !! {date}: {e}", file=sys.stderr)
            failed += 1
            continue
        done[rec["date"]] = rec
        if rec["status"] == "ok":
            ok += 1
        else:
            missing += 1
        if i % 100 == 0 or i == len(todo):
            print(f"  [{i}/{len(todo)}] ok={ok} no_data={missing} failed={failed} (mốc: {date})")
        time.sleep(DELAY_SECONDS)

    dedupe_raw_file(done)
    build_all_series(done)
    total_ok = sum(1 for r in done.values() if r["status"] == "ok")
    print(f"Hoàn tất: {total_ok}/{len(done)} ngày có dữ liệu trong cache.")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
