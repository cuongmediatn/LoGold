import 'package:uuid/uuid.dart';
import '../models/user_holding.dart';
import '../models/gold_type.dart';
import '../services/price_service.dart';
import '../services/profit_loss_calculator.dart';
import '../utils/gold_units.dart';

/// PortfolioService - Manages user's gold holdings (CRUD operations).
/// Uses Hive for local persistence. All data stays on device.
class PortfolioService {
  static PortfolioService? _instance;
  static PortfolioService get instance => _instance ??= PortfolioService._();

  PortfolioService._();

  final _uuid = const Uuid();
  final List<UserHolding> _holdings = [];
  final List<GoldType> _goldTypes = [];

  /// Initialize with stored data
  void init({
    List<UserHolding>? holdings,
    List<GoldType>? goldTypes,
  }) {
    _holdings.clear();
    if (holdings != null) _holdings.addAll(holdings);

    _goldTypes.clear();
    if (goldTypes != null) {
      _goldTypes.addAll(goldTypes);
    } else {
      _goldTypes.addAll(GoldType.defaults);
    }
  }

  /// Get all gold types
  List<GoldType> get goldTypes => List.unmodifiable(_goldTypes);

  /// Get a gold type by ID
  GoldType? getGoldType(String id) {
    try {
      return _goldTypes.firstWhere((gt) => gt.id == id);
    } catch (e) {
      return null;
    }
  }

  /// Add a custom gold type
  void addGoldType(GoldType goldType) {
    _goldTypes.add(goldType);
  }

  /// Get all active holdings (status = "holding")
  List<UserHolding> get activeHoldings =>
      _holdings.where((h) => h.status == 'holding').toList();

  /// Get all holdings (including sold)
  List<UserHolding> get allHoldings => List.unmodifiable(_holdings);

  /// Add a new gold purchase
  UserHolding addHolding({
    required String goldTypeId,
    required double quantity,
    required String unit,
    required double buyPricePerUnit,
    double fee = 0,
    required DateTime buyDate,
    String? note,
    String? invoiceImageUri,
  }) {
    // Convert quantity to luong
    final quantityInLuong = GoldUnits.toLuong(quantity, unit);

    // Calculate buy price per luong
    final buyPricePerLuong = GoldUnits.pricePerLuong(buyPricePerUnit, unit);

    // Total cost = buy price * quantity + fee
    final totalCost = (buyPricePerLuong * quantityInLuong) + fee;

    final now = DateTime.now();
    final holding = UserHolding(
      id: _uuid.v4(),
      goldTypeId: goldTypeId,
      quantity: quantity,
      unit: unit,
      quantityInLuong: quantityInLuong,
      buyPricePerLuong: buyPricePerLuong,
      totalCost: totalCost,
      fee: fee,
      buyDate: buyDate,
      note: note,
      invoiceImageUri: invoiceImageUri,
      status: 'holding',
      createdAt: now,
      updatedAt: now,
    );

    _holdings.add(holding);
    return holding;
  }

  /// Update an existing holding
  void updateHolding(UserHolding holding) {
    final index = _holdings.indexWhere((h) => h.id == holding.id);
    if (index >= 0) {
      _holdings[index] = holding.copyWith(updatedAt: DateTime.now());
    }
  }

  /// Delete a holding
  void deleteHolding(String id) {
    _holdings.removeWhere((h) => h.id == id);
  }

  /// Mark a holding as sold
  void markAsSold(String id) {
    final index = _holdings.indexWhere((h) => h.id == id);
    if (index >= 0) {
      _holdings[index] =
          _holdings[index].copyWith(status: 'sold', updatedAt: DateTime.now());
    }
  }

  /// Duplicate a holding
  UserHolding? duplicateHolding(String id) {
    final index = _holdings.indexWhere((h) => h.id == id);
    if (index < 0) return null;

    final original = _holdings[index];
    final now = DateTime.now();
    final copy = UserHolding(
      id: _uuid.v4(),
      goldTypeId: original.goldTypeId,
      quantity: original.quantity,
      unit: original.unit,
      quantityInLuong: original.quantityInLuong,
      buyPricePerLuong: original.buyPricePerLuong,
      totalCost: original.totalCost,
      fee: original.fee,
      buyDate: original.buyDate,
      note: original.note,
      invoiceImageUri: original.invoiceImageUri,
      status: 'holding',
      createdAt: now,
      updatedAt: now,
    );
    _holdings.add(copy);
    return copy;
  }

  /// Get the current portfolio summary with live prices
  PortfolioSummary getPortfolioSummary() {
    final holdings = activeHoldings;
    final Map<String, double> currentPrices = {};

    for (final holding in holdings) {
      final price = PriceService.instance.getBuyPrice(holding.goldTypeId);
      if (price != null) {
        currentPrices[holding.goldTypeId] = price;
      }
    }

    return ProfitLossCalculator.calculatePortfolio(
      holdings: holdings,
      currentBuyPrices: currentPrices,
    );
  }

  /// Get P/L result for a single holding
  ProfitLossResult? getHoldingResult(String holdingId) {
    final holding = _holdings.firstWhere(
      (h) => h.id == holdingId,
      orElse: () => throw StateError('Holding not found'),
    );

    final currentPrice =
        PriceService.instance.getBuyPrice(holding.goldTypeId);
    if (currentPrice == null) return null;

    return ProfitLossCalculator.calculate(
      holding: holding,
      currentBuyPricePerLuong: currentPrice,
    );
  }

  /// Export holdings as list of maps (for CSV/JSON export)
  List<Map<String, dynamic>> exportHoldings() {
    return _holdings.map((h) {
      final goldType = getGoldType(h.goldTypeId);
      return {
        'goldType': goldType?.displayName ?? h.goldTypeId,
        'quantity': h.quantity,
        'unit': h.unit,
        'quantityInLuong': h.quantityInLuong,
        'buyPricePerLuong': h.buyPricePerLuong,
        'fee': h.fee,
        'totalCost': h.totalCost,
        'buyDate': h.buyDate.toIso8601String().split('T').first,
        'status': h.status,
        'note': h.note ?? '',
      };
    }).toList();
  }
}
