import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fl_chart/fl_chart.dart';

import '../constants/app_constants.dart';
import '../stores/app_store.dart';
import '../services/price_service.dart';
import '../services/profit_loss_calculator.dart';
import '../components/ui_components.dart';
import '../models/gold_price.dart';
import '../utils/formatters.dart';
import '../utils/gold_units.dart';

/// Charts screen - shows price history, portfolio value, and P/L over time.
class ChartsScreen extends StatefulWidget {
  const ChartsScreen({super.key});

  @override
  State<ChartsScreen> createState() => _ChartsScreenState();
}

class _ChartsScreenState extends State<ChartsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _selectedGoldTypeIndex = 0;
  int _selectedDays = 30;
  List<PriceHistoryEntry> _priceHistory = [];
  bool _isLoading = false;

  final _timeRanges = [
    {'label': '7 ngày', 'days': 7},
    {'label': '30 ngày', 'days': 30},
    {'label': '90 ngày', 'days': 90},
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) return;
      setState(() {});
    });
    WidgetsBinding.instance.addPostFrameCallback((_) => _loadPriceHistory());
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _loadPriceHistory() async {
    final store = context.read<AppStore>();
    final goldTypes = store.goldTypes;
    if (goldTypes.isEmpty) return;

    final selectedId = goldTypes[_selectedGoldTypeIndex].id;

    setState(() => _isLoading = true);
    final history = await PriceService.instance.fetchPriceHistory(
      selectedId,
      days: _selectedDays,
    );
    setState(() {
      _priceHistory = history;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final store = context.watch<AppStore>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Biểu đồ'),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: AppColors.gold,
          labelColor: AppColors.gold,
          unselectedLabelColor: AppColors.textHint,
          tabs: const [
            Tab(text: 'Giá vàng'),
            Tab(text: 'Giá trị tài sản'),
            Tab(text: 'Lãi / Lỗ'),
          ],
        ),
      ),
      body: SafeArea(
        child: TabBarView(
          controller: _tabController,
          children: [
            _buildPriceHistoryTab(store),
            _buildPortfolioValueTab(store),
            _buildProfitLossTab(store),
          ],
        ),
      ),
    );
  }

  // =================== Tab 1: Price History ===================

  Widget _buildPriceHistoryTab(AppStore store) {
    final goldTypes = store.goldTypes;

    return SingleChildScrollView(
      padding: const EdgeInsets.only(bottom: 80),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Gold type selector
          if (goldTypes.isNotEmpty)
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: goldTypes.asMap().entries.map((entry) {
                  final idx = entry.key;
                  final gt = entry.value;
                  final selected = idx == _selectedGoldTypeIndex;
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: FilterChip(
                      label: Text(gt.displayName),
                      selected: selected,
                      onSelected: (_) {
                        setState(() => _selectedGoldTypeIndex = idx);
                        _loadPriceHistory();
                      },
                      selectedColor: AppColors.gold.withValues(alpha: 0.2),
                      checkmarkColor: AppColors.gold,
                      labelStyle: TextStyle(
                        color: selected ? AppColors.gold : AppColors.textSecondary,
                        fontSize: 13,
                      ),
                      side: BorderSide(
                        color: selected ? AppColors.gold : AppColors.divider,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),

          // Time range selector
          _buildTimeRangeSelector(),

          // Price chart
          if (_isLoading)
            const SizedBox(
              height: 300,
              child: Center(
                child: CircularProgressIndicator(color: AppColors.gold),
              ),
            )
          else if (_priceHistory.isEmpty)
            const EmptyState(
              emoji: '📊',
              title: 'Chưa có dữ liệu',
              subtitle: 'Không thể tải lịch sử giá vàng',
            )
          else ...[
            _buildPriceChartCard(),
            const SizedBox(height: 16),
            _buildPriceStatsCard(),
          ],
        ],
      ),
    );
  }

  Widget _buildTimeRangeSelector() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Row(
        children: _timeRanges.map((range) {
          final days = range['days'] as int;
          final label = range['label'] as String;
          final selected = days == _selectedDays;
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: ChoiceChip(
              label: Text(label),
              selected: selected,
              onSelected: (_) {
                setState(() => _selectedDays = days);
                _loadPriceHistory();
              },
              selectedColor: AppColors.gold.withValues(alpha: 0.2),
              labelStyle: TextStyle(
                color: selected ? AppColors.gold : AppColors.textSecondary,
                fontSize: 13,
              ),
              side: BorderSide(
                color: selected ? AppColors.gold : AppColors.divider,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildPriceChartCard() {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.trending_up, color: AppColors.gold, size: 20),
              const SizedBox(width: 8),
              const Text(
                'Lịch sử giá mua vào',
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              Text(
                '($_selectedDays ngày)',
                style: const TextStyle(color: AppColors.textHint, fontSize: 12),
              ),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 250,
            child: LineChart(_buildPriceLineChartData()),
          ),
        ],
      ),
    );
  }

  LineChartData _buildPriceLineChartData() {
    if (_priceHistory.isEmpty) {
      return LineChartData(minX: 0, maxX: 1, minY: 0, maxY: 1);
    }

    final spots = <FlSpot>[];
    for (int i = 0; i < _priceHistory.length; i++) {
      spots.add(FlSpot(i.toDouble(), _priceHistory[i].buyPrice / 1000000));
    }

    final prices = _priceHistory.map((e) => e.buyPrice).toList();
    final minPrice = prices.reduce((a, b) => a < b ? a : b) / 1000000;
    final maxPrice = prices.reduce((a, b) => a > b ? a : b) / 1000000;
    final padding = (maxPrice - minPrice) * 0.1;
    if (padding == 0) {
      return LineChartData(
        minX: 0,
        maxX: spots.length.toDouble() - 1,
        minY: minPrice - 1,
        maxY: maxPrice + 1,
        lineBarsData: [
          LineChartBarData(
            spots: spots,
            isCurved: true,
            color: AppColors.gold,
            barWidth: 2.5,
            dotData: const FlDotData(show: false),
            belowBarData: BarAreaData(
              show: true,
              color: AppColors.gold.withValues(alpha: 0.1),
            ),
          ),
        ],
        titlesData: const FlTitlesData(show: false),
        gridData: FlGridData(
          show: true,
          drawVerticalLine: false,
          horizontalInterval: (maxPrice - minPrice) / 4,
          getDrawingHorizontalLine: (value) => const FlLine(
            color: AppColors.divider,
            strokeWidth: 1,
          ),
        ),
        borderData: FlBorderData(show: false),
      );
    }

    return LineChartData(
      minX: 0,
      maxX: spots.length.toDouble() - 1,
      minY: minPrice - padding,
      maxY: maxPrice + padding,
      lineBarsData: [
        LineChartBarData(
          spots: spots,
          isCurved: true,
          color: AppColors.gold,
          barWidth: 2.5,
          dotData: const FlDotData(show: false),
          belowBarData: BarAreaData(
            show: true,
            color: AppColors.gold.withValues(alpha: 0.1),
          ),
        ),
      ],
      titlesData: const FlTitlesData(show: false),
      gridData: FlGridData(
        show: true,
        drawVerticalLine: false,
        horizontalInterval: (maxPrice - minPrice) / 4,
        getDrawingHorizontalLine: (value) => const FlLine(
          color: AppColors.divider,
          strokeWidth: 1,
        ),
      ),
      borderData: FlBorderData(show: false),
    );
  }

  Widget _buildPriceStatsCard() {
    if (_priceHistory.isEmpty) return const SizedBox.shrink();

    final prices = _priceHistory.map((e) => e.buyPrice).toList();
    final first = prices.first;
    final last = prices.last;
    final highest = prices.reduce((a, b) => a > b ? a : b);
    final lowest = prices.reduce((a, b) => a < b ? a : b);
    final change = (last - first).toDouble();
    final changePercent = first > 0 ? (change / first) * 100 : 0.0;
    final isUp = change >= 0;
    final color = isUp ? AppColors.profit : AppColors.loss;

    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Thống kê giá',
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _statItem('Cao nhất', Formatters.formatVndCompact(highest)),
              ),
              Expanded(
                child: _statItem('Thấp nhất', Formatters.formatVndCompact(lowest)),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _statItem('Đầu kỳ', Formatters.formatVndCompact(first)),
              ),
              Expanded(
                child: _statItem('Hiện tại', Formatters.formatVndCompact(last)),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Thay đổi ${_timeRanges.firstWhere((r) => r['days'] == _selectedDays)['label']}',
                  style: const TextStyle(color: AppColors.textSecondary, fontSize: 13),
                ),
                Text(
                  '${isUp ? '+' : ''}${Formatters.formatVndCompact(change)} '
                  '(${Formatters.formatPercent(changePercent)})',
                  style: TextStyle(
                    color: color,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _statItem(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(color: AppColors.textHint, fontSize: 11),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            color: AppColors.textSecondary,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  // =================== Tab 2: Portfolio Value ===================

  Widget _buildPortfolioValueTab(AppStore store) {
    final summary = store.portfolioSummary;
    final privacyMode = store.privacyMode;

    if (summary == null || summary.holdingCount == 0) {
      return const EmptyState(
        emoji: '💰',
        title: 'Chưa có dữ liệu',
        subtitle: 'Thêm vị thế vàng để xem biểu đồ giá trị tài sản',
      );
    }

    // Generate portfolio value history from holdings' buy dates
    final holdings = store.activeHoldings;
    final valueData = _generatePortfolioValueData(holdings, store);

    return SingleChildScrollView(
      padding: const EdgeInsets.only(bottom: 80),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Giá trị tài sản theo thời gian',
                  style: TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Tích lũy vốn theo từng lần mua',
                  style: const TextStyle(color: AppColors.textHint, fontSize: 12),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  height: 250,
                  child: LineChart(_buildPortfolioValueChart(valueData, privacyMode)),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          _buildPortfolioValueSummary(summary, privacyMode),
        ],
      ),
    );
  }

  List<_ValuePoint> _generatePortfolioValueData(
      List holdings, AppStore store) {
    // Sort holdings by buy date
    final sorted = List.from(holdings)
      ..sort((a, b) => a.buyDate.compareTo(b.buyDate));

    final points = <_ValuePoint>[];
    double cumulative = 0;

    for (final h in sorted) {
      cumulative += h.totalCost;
      points.add(_ValuePoint(
        date: h.buyDate,
        value: cumulative,
        label: '${h.quantity.toStringAsFixed(2)} ${GoldUnits.shortLabel(h.unit)}',
      ));
    }

    // Add current value point
    final summary = store.portfolioSummary;
    if (summary != null && points.isNotEmpty) {
      points.add(_ValuePoint(
        date: DateTime.now(),
        value: summary.totalCurrentValue,
        label: 'Hiện tại',
      ));
    }

    return points;
  }

  LineChartData _buildPortfolioValueChart(
      List<_ValuePoint> data, bool privacyMode) {
    if (data.isEmpty) {
      return LineChartData(minX: 0, maxX: 1, minY: 0, maxY: 1);
    }

    final spots = <FlSpot>[];
    for (int i = 0; i < data.length; i++) {
      spots.add(FlSpot(i.toDouble(), data[i].value / 1000000));
    }

    final values = data.map((e) => e.value / 1000000).toList();
    final minVal = values.reduce((a, b) => a < b ? a : b);
    final maxVal = values.reduce((a, b) => a > b ? a : b);
    final padding = (maxVal - minVal) * 0.15;
    if (padding == 0) {
      return LineChartData(
        minX: 0,
        maxX: spots.length.toDouble() - 1,
        minY: minVal - 1,
        maxY: maxVal + 1,
        lineBarsData: [
          LineChartBarData(
            spots: spots,
            isCurved: false,
            color: AppColors.gold,
            barWidth: 3,
            dotData: FlDotData(
              show: true,
              getDotPainter: (spot, percent, barData, index) {
                return FlDotCirclePainter(
                  radius: 4,
                  color: AppColors.gold,
                  strokeWidth: 2,
                  strokeColor: AppColors.bgPrimary,
                );
              },
            ),
            belowBarData: BarAreaData(
              show: true,
              color: AppColors.gold.withValues(alpha: 0.1),
            ),
          ),
        ],
        titlesData: const FlTitlesData(show: false),
        gridData: const FlGridData(show: false),
        borderData: FlBorderData(show: false),
      );
    }

    return LineChartData(
      minX: 0,
      maxX: spots.length.toDouble() - 1,
      minY: minVal - padding,
      maxY: maxVal + padding,
      lineBarsData: [
        LineChartBarData(
          spots: spots,
          isCurved: false,
          color: AppColors.gold,
          barWidth: 3,
          dotData: FlDotData(
            show: true,
            getDotPainter: (spot, percent, barData, index) {
              return FlDotCirclePainter(
                radius: 4,
                color: AppColors.gold,
                strokeWidth: 2,
                strokeColor: AppColors.bgPrimary,
              );
            },
          ),
          belowBarData: BarAreaData(
            show: true,
            color: AppColors.gold.withValues(alpha: 0.1),
          ),
        ),
      ],
      titlesData: const FlTitlesData(show: false),
      gridData: const FlGridData(show: false),
      borderData: FlBorderData(show: false),
    );
  }

  Widget _buildPortfolioValueSummary(PortfolioSummary summary, bool privacyMode) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Tổng quan tài sản',
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          _summaryRow(
            'Tổng vốn đầu tư',
            privacyMode ? '••••••' : Formatters.formatVnd(summary.totalCost),
          ),
          const SizedBox(height: 8),
          _summaryRow(
            'Giá trị hiện tại',
            privacyMode ? '••••••' : Formatters.formatVnd(summary.totalCurrentValue),
            valueColor: summary.isProfit ? AppColors.profit : AppColors.loss,
          ),
          const SizedBox(height: 8),
          _summaryRow(
            'Tổng vàng',
            privacyMode ? '•••' : '${summary.totalQuantityInLuong.toStringAsFixed(2)} lượng',
          ),
          const SizedBox(height: 8),
          _summaryRow(
            'Giá hòa vốn',
            privacyMode ? '••••••' : Formatters.formatVnd(summary.breakEvenPricePerLuong),
          ),
        ],
      ),
    );
  }

  Widget _summaryRow(String label, String value, {Color? valueColor}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(color: AppColors.textSecondary, fontSize: 14),
        ),
        Text(
          value,
          style: TextStyle(
            color: valueColor ?? AppColors.textPrimary,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  // =================== Tab 3: Profit/Loss ===================

  Widget _buildProfitLossTab(AppStore store) {
    final summary = store.portfolioSummary;
    final privacyMode = store.privacyMode;

    if (summary == null || summary.holdingCount == 0) {
      return const EmptyState(
        emoji: '📉',
        title: 'Chưa có dữ liệu',
        subtitle: 'Thêm vị thế vàng để xem biểu đồ lãi/lỗ',
      );
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.only(bottom: 80),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // P/L hero card
          AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Lãi / Lỗ hiện tại',
                  style: TextStyle(color: AppColors.textSecondary, fontSize: 14),
                ),
                const SizedBox(height: 8),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      privacyMode ? '••••••' : Formatters.formatVnd(summary.totalProfitLoss),
                      style: TextStyle(
                        color: privacyMode
                            ? AppColors.textHint
                            : (summary.isProfit ? AppColors.profit : AppColors.loss),
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      privacyMode ? '••' : Formatters.formatPercent(summary.totalProfitLossPercent),
                      style: TextStyle(
                        color: privacyMode
                            ? AppColors.textHint
                            : (summary.isProfit ? AppColors.profit : AppColors.loss),
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                SizedBox(
                  height: 200,
                  child: BarChart(_buildPLBarChart(summary, privacyMode)),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Breakdown by holding
          const SectionHeader(title: 'Lãi/lỗ theo vị thế'),
          ...summary.holdings.map((result) {
            final goldType = store.getGoldType(result.holding.goldTypeId);
            return _buildHoldingPLBar(
              goldType?.displayName ?? result.holding.goldTypeId,
              result,
              privacyMode,
            );
          }),
        ],
      ),
    );
  }

  BarChartData _buildPLBarChart(PortfolioSummary summary, bool privacyMode) {
    final holdings = summary.holdings;
    if (holdings.isEmpty) {
      return BarChartData(minY: 0, maxY: 1);
    }

    final barGroups = holdings.asMap().entries.map((entry) {
      final idx = entry.key;
      final result = entry.value;
      final plValue = result.profitLoss / 1000000;
      final color = result.isProfit ? AppColors.profit : AppColors.loss;

      return BarChartGroupData(
        x: idx,
        barRods: [
          BarChartRodData(
            toY: plValue.abs(),
            color: color,
            width: 20,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(4),
              topRight: Radius.circular(4),
            ),
          ),
        ],
      );
    }).toList();

    final maxPL = holdings
        .map((r) => (r.profitLoss.abs() / 1000000))
        .reduce((a, b) => a > b ? a : b);
    final maxY = maxPL * 1.2;

    return BarChartData(
      alignment: BarChartAlignment.spaceAround,
      maxY: maxY == 0 ? 1 : maxY,
      barGroups: barGroups,
      titlesData: const FlTitlesData(show: false),
      gridData: FlGridData(
        show: true,
        drawVerticalLine: false,
        horizontalInterval: maxY / 4,
        getDrawingHorizontalLine: (value) => const FlLine(
          color: AppColors.divider,
          strokeWidth: 1,
        ),
      ),
      borderData: FlBorderData(show: false),
    );
  }

  Widget _buildHoldingPLBar(
      String name, ProfitLossResult result, bool privacyMode) {
    final isProfit = result.isProfit;
    final color = isProfit ? AppColors.profit : AppColors.loss;

    return AppCard(
      child: Row(
        children: [
          Container(
            width: 4,
            height: 40,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  privacyMode
                      ? '••••'
                      : Formatters.formatVndCompact(result.profitLoss),
                  style: TextStyle(
                    color: privacyMode ? AppColors.textHint : color,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          Text(
            privacyMode ? '••' : Formatters.formatPercent(result.profitLossPercent),
            style: TextStyle(
              color: privacyMode ? AppColors.textHint : color,
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

/// Data point for portfolio value chart
class _ValuePoint {
  final DateTime date;
  final double value;
  final String label;

  _ValuePoint({required this.date, required this.value, required this.label});
}
