# LoGold — dữ liệu lịch sử giá vàng SJC

Repo này chỉ chứa dữ liệu lịch sử giá vàng SJC dùng cho app **Lỗ**
([cuongtechnology/LoGold](https://github.com/cuongtechnology/LoGold)),
được cào tự động từ [giavang.org](https://giavang.org/trong-nuoc/sjc/lich-su/)
mỗi ngày qua GitHub Action.

## File chính

- **`sjc_history.json`** — series giá theo ngày (nghìn đồng/lượng), dùng để
  app fetch qua CDN:
  ```
  https://cdn.jsdelivr.net/gh/cuongmediatn/LoGold@main/sjc_history.json
  ```
  Sau khi Action cập nhật, gọi API purge cache của jsDelivr để lấy dữ liệu
  mới ngay (không phải chờ cache hết hạn):
  ```
  https://purge.jsdelivr.net/gh/cuongmediatn/LoGold@main/sjc_history.json
  ```
- `data/sjc_raw.jsonl` — cache thô đầy đủ mọi khu vực/loại vàng, dùng để
  script resume mà không cào lại từ đầu.
- `scripts/scrape_sjc_history.py` — script cào, chạy tự động bởi
  `.github/workflows/scrape.yml`.

## Giới hạn dữ liệu

giavang.org ngừng công bố lịch sử giá SJC từ khoảng 23/03/2025. Dữ liệu từ
mốc đó tới hiện tại app tự bổ sung qua giá live của chính app (không phụ
thuộc repo này).
