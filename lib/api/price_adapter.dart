import '../models/gold_price.dart';

/// Abstract price adapter interface - allows plugging in different gold price sources.
/// New sources can be added by implementing this interface.
/// The price service uses these adapters to fetch current gold prices.
abstract class PriceAdapter {
  /// Unique source identifier (e.g. "mock", "sjc_api", "doji_api")
  String get sourceKey;

  /// Human-readable source name for display
  String get displayName;

  /// Fetch current prices for all gold types
  Future<List<GoldPrice>> fetchPrices();

  /// Fetch price history for a specific gold type (for charts)
  Future<List<PriceHistoryEntry>> fetchPriceHistory(
    String goldTypeId, {
    int days = 30,
  });

  /// Check if this source is currently available
  Future<bool> isAvailable();
}

/// Price source status
enum PriceSourceStatus {
  fresh, // data is current
  stale, // data is old
  error, // failed to fetch
  unavailable, // source not configured
}

extension PriceSourceStatusX on PriceSourceStatus {
  String get label {
    switch (this) {
      case PriceSourceStatus.fresh:
        return 'Cập nhật mới';
      case PriceSourceStatus.stale:
        return 'Dữ liệu cũ';
      case PriceSourceStatus.error:
        return 'Lỗi kết nối';
      case PriceSourceStatus.unavailable:
        return 'Nguồn chưa cấu hình';
    }
  }
}
