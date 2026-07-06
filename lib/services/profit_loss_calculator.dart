import '../models/user_holding.dart';
import '../models/gold_price.dart';
import '../models/meme_template.dart';

/// ProfitLossCalculator - Core business logic for calculating gold investment P/L.
///
/// Key formulas:
///   Tổng vốn = giá mua ban đầu + phí phát sinh
///   Giá trị hiện tại = số lượng vàng (lượng) × giá mua vào hiện tại (per lượng)
///   Lãi/lỗ = giá trị hiện tại - tổng vốn
///   % lãi/lỗ = lãi/lỗ / tổng vốn × 100
///   Giá hòa vốn = tổng vốn / số lượng vàng (lượng)
///   Cần tăng thêm = giá hòa vốn - giá mua vào hiện tại
class ProfitLossCalculator {
  /// Calculate P/L for a single holding given the current buy price per luong.
  /// [currentBuyPricePerLuong] is the price the shop would pay you (buy-in price).
  static ProfitLossResult calculate({
    required UserHolding holding,
    required double currentBuyPricePerLuong,
  }) {
    // Total cost = original purchase cost + fees
    final totalCost = holding.totalCost;

    // Current value = quantity in luong * current buy price per luong
    // This is how much the user would receive if they sold today
    final currentValue = holding.quantityInLuong * currentBuyPricePerLuong;

    // Profit/Loss in VND
    final profitLoss = currentValue - totalCost;

    // Profit/Loss percentage
    final profitLossPercent =
        totalCost > 0 ? (profitLoss / totalCost) * 100 : 0.0;

    // Break-even price per luong = total cost / quantity in luong
    final breakEvenPricePerLuong = holding.quantityInLuong > 0
        ? totalCost / holding.quantityInLuong
        : 0.0;

    // How much more the buy price needs to increase to break even
    final priceIncreaseNeeded = breakEvenPricePerLuong - currentBuyPricePerLuong;

    // Spread (chênh lệch mua vào/bán ra) - informational
    // This would need the current sell price too; calculated at portfolio level

    return ProfitLossResult(
      holding: holding,
      currentBuyPricePerLuong: currentBuyPricePerLuong,
      totalCost: totalCost,
      currentValue: currentValue,
      profitLoss: profitLoss,
      profitLossPercent: profitLossPercent,
      breakEvenPricePerLuong: breakEvenPricePerLuong,
      priceIncreaseNeeded: priceIncreaseNeeded,
      isProfit: profitLoss >= 0,
    );
  }

  /// Calculate aggregate P/L for an entire portfolio.
  static PortfolioSummary calculatePortfolio({
    required List<UserHolding> holdings,
    required Map<String, double> currentBuyPrices, // goldTypeId -> buyPrice per luong
  }) {
    double totalCost = 0;
    double totalCurrentValue = 0;
    double totalQuantityInLuong = 0;

    final List<ProfitLossResult> results = [];

    for (final holding in holdings) {
      if (holding.status != 'holding') continue;

      final currentPrice =
          currentBuyPrices[holding.goldTypeId] ?? holding.buyPricePerLuong;

      final result = ProfitLossCalculator.calculate(
        holding: holding,
        currentBuyPricePerLuong: currentPrice,
      );

      results.add(result);
      totalCost += result.totalCost;
      totalCurrentValue += result.currentValue;
      totalQuantityInLuong += holding.quantityInLuong;
    }

    final totalProfitLoss = totalCurrentValue - totalCost;
    final totalProfitLossPercent =
        totalCost > 0 ? (totalProfitLoss / totalCost) * 100 : 0.0;

    final breakEvenPricePerLuong = totalQuantityInLuong > 0
        ? totalCost / totalQuantityInLuong
        : 0.0;

    return PortfolioSummary(
      holdings: results,
      totalCost: totalCost,
      totalCurrentValue: totalCurrentValue,
      totalProfitLoss: totalProfitLoss,
      totalProfitLossPercent: totalProfitLossPercent,
      totalQuantityInLuong: totalQuantityInLuong,
      breakEvenPricePerLuong: breakEvenPricePerLuong,
      isProfit: totalProfitLoss >= 0,
    );
  }

  /// Determine emotional status based on P/L percentage
  static EmotionalStatus getEmotionalStatus(double profitLossPercent) {
    if (profitLossPercent >= 3) return EmotionalStatus.profitCautious;
    if (profitLossPercent >= -1) return EmotionalStatus.breakeven;
    if (profitLossPercent >= -3) return EmotionalStatus.lossLight;
    if (profitLossPercent >= -7) return EmotionalStatus.lossModerate;
    if (profitLossPercent >= -15) return EmotionalStatus.lossHeavy;
    return EmotionalStatus.lossSpiritual;
  }

  /// Get the meme condition based on P/L percentage
  static MemeCondition getMemeCondition(double profitLossPercent) {
    if (profitLossPercent >= 10) return MemeCondition.profitHigh;
    if (profitLossPercent >= 3) return MemeCondition.profitMedium;
    if (profitLossPercent >= 0) return MemeCondition.profitLow;
    if (profitLossPercent >= -1) return MemeCondition.lossMinimal;
    if (profitLossPercent >= -3) return MemeCondition.lossLight;
    if (profitLossPercent >= -7) return MemeCondition.lossModerate;
    if (profitLossPercent >= -15) return MemeCondition.lossHeavy;
    return MemeCondition.lossSpiritual;
  }
}

/// Result of a single holding P/L calculation
class ProfitLossResult {
  final UserHolding holding;
  final double currentBuyPricePerLuong;
  final double totalCost;
  final double currentValue;
  final double profitLoss;
  final double profitLossPercent;
  final double breakEvenPricePerLuong;
  final double priceIncreaseNeeded;
  final bool isProfit;

  ProfitLossResult({
    required this.holding,
    required this.currentBuyPricePerLuong,
    required this.totalCost,
    required this.currentValue,
    required this.profitLoss,
    required this.profitLossPercent,
    required this.breakEvenPricePerLuong,
    required this.priceIncreaseNeeded,
    required this.isProfit,
  });

  EmotionalStatus get emotionalStatus =>
      ProfitLossCalculator.getEmotionalStatus(profitLossPercent);

  MemeCondition get memeCondition =>
      ProfitLossCalculator.getMemeCondition(profitLossPercent);
}

/// Aggregate P/L for the entire portfolio
class PortfolioSummary {
  final List<ProfitLossResult> holdings;
  final double totalCost;
  final double totalCurrentValue;
  final double totalProfitLoss;
  final double totalProfitLossPercent;
  final double totalQuantityInLuong;
  final double breakEvenPricePerLuong;
  final bool isProfit;

  PortfolioSummary({
    required this.holdings,
    required this.totalCost,
    required this.totalCurrentValue,
    required this.totalProfitLoss,
    required this.totalProfitLossPercent,
    required this.totalQuantityInLuong,
    required this.breakEvenPricePerLuong,
    required this.isProfit,
  });

  EmotionalStatus get emotionalStatus =>
      ProfitLossCalculator.getEmotionalStatus(totalProfitLossPercent);

  MemeCondition get memeCondition =>
      ProfitLossCalculator.getMemeCondition(totalProfitLossPercent);

  int get holdingCount => holdings.length;
}
