/// GoldPrice model - represents the current buy/sell price of a gold type.
/// buyPrice = price the shop buys from you (what you can sell at)
/// sellPrice = price the shop sells to you (what you buy at)
class GoldPrice {
  final String id;
  final String goldTypeId;
  final double buyPrice; // price per luong - what shop pays you
  final double sellPrice; // price per luong - what shop charges you
  final String source; // e.g. "mock", "sjc_api", "doji_api"
  final DateTime updatedAt;
  final double? previousBuyPrice; // for change calculation
  final double? previousSellPrice;

  GoldPrice({
    required this.id,
    required this.goldTypeId,
    required this.buyPrice,
    required this.sellPrice,
    required this.source,
    required this.updatedAt,
    this.previousBuyPrice,
    this.previousSellPrice,
  });

  /// Change in buy price from previous
  double get buyPriceChange => previousBuyPrice != null
      ? buyPrice - previousBuyPrice!
      : 0;

  /// Change in sell price from previous
  double get sellPriceChange => previousSellPrice != null
      ? sellPrice - previousSellPrice!
      : 0;

  /// Spread between buy and sell (chênh lệch mua vào/bán ra)
  double get spread => sellPrice - buyPrice;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'goldTypeId': goldTypeId,
      'buyPrice': buyPrice,
      'sellPrice': sellPrice,
      'source': source,
      'updatedAt': updatedAt.toIso8601String(),
      'previousBuyPrice': previousBuyPrice,
      'previousSellPrice': previousSellPrice,
    };
  }

  factory GoldPrice.fromMap(Map<String, dynamic> map) {
    return GoldPrice(
      id: map['id'] as String,
      goldTypeId: map['goldTypeId'] as String,
      buyPrice: (map['buyPrice'] as num).toDouble(),
      sellPrice: (map['sellPrice'] as num).toDouble(),
      source: map['source'] as String,
      updatedAt: DateTime.parse(map['updatedAt'] as String),
      previousBuyPrice: (map['previousBuyPrice'] as num?)?.toDouble(),
      previousSellPrice: (map['previousSellPrice'] as num?)?.toDouble(),
    );
  }
}

/// Price history entry for charts
class PriceHistoryEntry {
  final DateTime date;
  final double buyPrice;
  final double sellPrice;

  PriceHistoryEntry({
    required this.date,
    required this.buyPrice,
    required this.sellPrice,
  });
}
