#!/usr/bin/env python3
"""Cào lịch sử giá vàng SJC theo ngày từ giavang.org.

Nguồn: https://giavang.org/trong-nuoc/sjc/lich-su/ (dữ liệu từ 22/07/2009).
Mỗi ngày có 1 trang /trong-nuoc/sjc/lich-su/YYYY-MM-DD.html chứa bảng
(Khu vực | Loại vàng | Mua vào | Bán ra | Thời gian), đơn vị nghìn đồng/lượng.
Từ ~18/05/2024 trang này còn có thêm dòng "Vàng nhẫn SJC 99,99..." và
"Nữ trang 99,99%" — tận dụng luôn để build thêm 2 series ring_9999/jewelry
(baseline ngắn hơn SJC, chỉ từ mốc đó).

Lưu ý: giavang.org ngừng công bố lịch sử SJC từ ~23/03/2025. Script vẫn cào
lại mỗi ngày (qua GitHub Action) để tự bắt kịp nếu nguồn công bố lại.

Cách chạy:
    python3 scripts/scrape_sjc_history.py            # cào toàn bộ (resume được)
    python3 scripts/scrape_sjc_history.py --limit 50 # thử 50 ngày đầu

Output:
    data/sjc_raw.jsonl        — cache thô, 1 dòng/ngày (kể cả ngày không có dữ liệu)
    sjc_history.json          — series SJC 1L: [{d, buy, sell}] (nghìn đồng/lượng)
    ring_9999_history.json    — series Nhẫn SJC 99,99 (từ ~18/05/2024)
    jewelry_history.json      — series Nữ trang 99,99% (từ ~18/05/2024)
"""

import argparse
import json
import re
import sys
import time
import urllib.request
from pathlib import Path

BASE = "https://giavang.org/trong-nuoc/sjc/lich-su/"
UA = "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/126.0 Safari/537.36"
REPO_ROOT = Path(__file__).resolve().parent.parent
RAW_PATH = REPO_ROOT / "data" / "sjc_raw.jsonl"
DELAY_SECONDS = 0.35
MAX_RETRIES = 3

# Mỗi entry: (tên file output, regex khớp "type", regex khu vực ưu tiên).
SERIES_DEFS = [
    ("sjc_history.json", r"sjc\s*1\s*l", r"hồ chí minh"),
    ("ring_9999_history.json", r"nhẫn", r"hồ chí minh"),
    ("jewelry_history.json", r"nữ trang\s*99,99", r"hồ chí minh"),
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
    """'21.060' / '76,980' -> 21060 / 76980 (nghìn đồng/lượng)."""
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
    """Tìm row khớp [type_pattern] (regex trên "type"), ưu tiên
    [region_pattern] nếu có nhiều region cùng khớp."""
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
    """Ghi lại data/sjc_raw.jsonl gọn, mỗi ngày đúng 1 dòng (loại bản ghi trùng)."""
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
