# LoGold — dữ liệu lịch sử giá vàng

Repo này chỉ chứa dữ liệu lịch sử giá vàng dùng cho app **Lỗ**
([cuongtechnology/LoGold](https://github.com/cuongtechnology/LoGold)),
được cào tự động từ [giavang.org](https://giavang.org/trong-nuoc/) mỗi ngày
qua GitHub Action.

## File series (đều dùng chung 1 CDN + format)

| File | Loại vàng (app) | Nguồn trang | Có dữ liệu từ |
|---|---|---|---|
| `sjc_history.json` | `sjc` | `/trong-nuoc/sjc/lich-su/` | 22/07/2009 |
| `ring_9999_history.json` | `ring_9999` | `/trong-nuoc/sjc/lich-su/` (dòng "Nhẫn") | 18/05/2024 |
| `jewelry_history.json` | `jewelry` | `/trong-nuoc/sjc/lich-su/` (dòng "Nữ trang 99,99%") | 18/05/2024 |
| `pnj_hanoi_history.json` | `pnj_hanoi` | `/trong-nuoc/pnj/lich-su/` | 01/01/2015 |
| `pnj_24k_history.json` | `pnj_24k` | `/trong-nuoc/pnj/lich-su/` (dòng "Nhẫn PNJ 24K") | 01/01/2015 |

Các loại vàng khác (`viettin_sjc`, `gold_9999`, `bao_tin_sjc`, `doji_hanoi`,
`doji_hcm`, `vn_gold_sjc`) không có nguồn lịch sử nào trên giavang.org —
app chỉ có dữ liệu gần đây qua backfill từ `vang.today` (xem app repo).

Fetch qua CDN (thay `<file>` bằng tên file ở bảng trên):
```
https://cdn.jsdelivr.net/gh/cuongmediatn/LoGold@main/<file>
```
Sau khi Action cập nhật, gọi API purge cache của jsDelivr để lấy dữ liệu mới
ngay (không phải chờ cache hết hạn):
```
https://purge.jsdelivr.net/gh/cuongmediatn/LoGold@main/<file>
```

## Script cào

- `scripts/scrape_sjc_history.py` — cào `/trong-nuoc/sjc/lich-su/`, build
  `sjc_history.json` + `ring_9999_history.json` + `jewelry_history.json` từ
  cùng 1 cache (`data/sjc_raw.jsonl`).
- `scripts/scrape_pnj_history.py` — cào `/trong-nuoc/pnj/lich-su/`, build
  `pnj_hanoi_history.json` + `pnj_24k_history.json` từ cùng 1 cache
  (`data/pnj_raw.jsonl`).

Cả 2 chạy tự động mỗi ngày qua `.github/workflows/scrape.yml`.

## Giới hạn dữ liệu

giavang.org ngừng công bố lịch sử giá SJC từ khoảng 23/03/2025 (PNJ có thể
dừng ở mốc khác — script tự phát hiện qua trạng thái `no_data` mỗi ngày).
Dữ liệu từ mốc dừng tới hiện tại app tự bổ sung qua giá live từ
`vang.today` (không phụ thuộc repo này).
