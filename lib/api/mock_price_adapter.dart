import 'dart:math';
import '../models/gold_price.dart';
import '../api/price_adapter.dart';

/// MockPriceAdapter - Generates realistic mock gold prices for development/testing.
///
/// Simulates real-world Vietnamese gold prices with realistic spreads
/// and small random fluctuations. This adapter is used when no real API
/// is configured, and serves as a reference implementation for the adapter pattern.
///
/// To add a real API later, create a new adapter implementing PriceAdapter
/// and register it in the PriceService.
class MockPriceAdapter implements PriceAdapter {
  @override
  String get sourceKey => 'mock';

  @override
  String get displayName => 'Mock API (dữ liệu mẫu)';

  // Base prices per lượng (tael) in VND - realistic Vietnamese market prices
  static const Map<String, double> _baseBuyPrices = {
    'sjc': 116000000, // SJC bars: ~116M/lượng
    'ring_9999': 114500000, // 9999 ring gold: ~114.5M/lượng
    'gold_9999': 115000000, // Generic 9999 gold: ~115M/lượng
    'jewelry': 112000000, // Jewelry gold: ~112M/lượng (lower due to making charge)
  };

  // Spread between buy and sell (typically 1-3M/lượng in VN)
  static const double _defaultSpread = 2000000;

  final Random _random = Random();

  @override
  Future<List<GoldPrice>> fetchPrices() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));

    final now = DateTime.now();
    final List<GoldPrice> prices = [];

    _baseBuyPrices.forEach((goldTypeId, basePrice) {
      // Add small random fluctuation (-0.5% to +0.5%)
      final fluctuation = (_random.nextDouble() - 0.5) * 0.01;
      final buyPrice = basePrice * (1 + fluctuation);
      final sellPrice = buyPrice + _defaultSpread;

      // Simulate previous price for change calculation
      final prevFluctuation = (_random.nextDouble() - 0.5) * 0.008;
      final previousBuyPrice = basePrice * (1 + prevFluctuation);
      final previousSellPrice = previousBuyPrice + _defaultSpread;

      prices.add(GoldPrice(
        id: '${goldTypeId}_${now.millisecondsSinceEpoch}',
        goldTypeId: goldTypeId,
        buyPrice: buyPrice.roundToDouble(),
        sellPrice: sellPrice.roundToDouble(),
        source: sourceKey,
        updatedAt: now,
        previousBuyPrice: previousBuyPrice.roundToDouble(),
        previousSellPrice: previousSellPrice.roundToDouble(),
      ));
    });

    return prices;
  }

  @override
  Future<List<PriceHistoryEntry>> fetchPriceHistory(
    String goldTypeId, {
    int days = 30,
  }) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 300));

    final basePrice = _baseBuyPrices[goldTypeId] ?? 115000000;
    final List<PriceHistoryEntry> history = [];
    final now = DateTime.now();

    // Generate daily price history with a realistic trend
    double currentPrice = basePrice * 0.98; // Start 2% below current
    for (int i = days; i >= 0; i--) {
      final date = now.subtract(Duration(days: i));

      // Add daily fluctuation
      final dailyChange = (_random.nextDouble() - 0.48) * 0.005;
      currentPrice = currentPrice * (1 + dailyChange);

      // Gradually trend toward current base price
      if (i < days / 2) {
        currentPrice = currentPrice * 0.99 + basePrice * 0.01;
      }

      history.add(PriceHistoryEntry(
        date: date,
        buyPrice: currentPrice.roundToDouble(),
        sellPrice: (currentPrice + _defaultSpread).roundToDouble(),
      ));
    }

    return history;
  }

  @override
  Future<bool> isAvailable() async {
    return true; // Mock is always available
  }
}
