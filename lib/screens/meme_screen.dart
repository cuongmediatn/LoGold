import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants/app_constants.dart';
import '../stores/app_store.dart';
import '../services/meme_engine.dart';
import '../services/profit_loss_calculator.dart';
import '../components/ui_components.dart';
import '../models/meme_template.dart';

/// Meme/Share Screen - Shows meme collection, current status meme, and share options.
/// Supports privacy mode (blur amounts) for sharing screenshots.
class MemeScreen extends StatefulWidget {
  const MemeScreen({super.key});

  @override
  State<MemeScreen> createState() => _MemeScreenState();
}

class _MemeScreenState extends State<MemeScreen> {
  MemeCondition _selectedCondition = MemeCondition.lossModerate;
  MemeTemplate? _featuredMeme;
  String _searchQuery = '';
  List<MemeTemplate> _cachedMemes = [];

  @override
  void initState() {
    super.initState();
    _cachedMemes = MemeEngine.getMemesByCondition(_selectedCondition);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _updateFeaturedMeme();
    });
  }

  void _updateFeaturedMeme() {
    final store = context.read<AppStore>();
    final summary = store.portfolioSummary;
    final plPercent = summary?.totalProfitLossPercent ?? 0;
    final condition = ProfitLossCalculator.getMemeCondition(plPercent);
    setState(() {
      _selectedCondition = condition;
      _featuredMeme = MemeEngine.getRandomMeme(plPercent);
      _cachedMemes = MemeEngine.getMemesByCondition(condition);
      _searchQuery = '';
    });
  }

  void _selectCondition(MemeCondition condition) {
    setState(() {
      _selectedCondition = condition;
      _searchQuery = '';
      _cachedMemes = MemeEngine.getMemesByCondition(condition);
    });
  }

  List<MemeTemplate> get _filteredMemes {
    if (_searchQuery.isEmpty) return _cachedMemes;
    final q = _searchQuery.toLowerCase();
    return _cachedMemes.where((m) => m.content.toLowerCase().contains(q)).toList();
  }

  @override
  Widget build(BuildContext context) {
    final store = context.watch<AppStore>();
    final summary = store.portfolioSummary;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Meme an ủi'),
        actions: [
          IconButton(
            onPressed: () {
              store.togglePrivacyMode();
            },
            icon: Icon(
              store.privacyMode ? Icons.visibility_off : Icons.visibility,
              color: AppColors.textSecondary,
            ),
          ),
          IconButton(
            onPressed: () => _shareCurrentMeme(context, store),
            icon: const Icon(Icons.share, color: AppColors.textSecondary),
          ),
        ],
      ),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // Current status section
            if (summary != null && summary.holdingCount > 0) ...[
              SliverToBoxAdapter(child: _buildCurrentStatusCard(store, summary)),
            ],

            // Featured meme
            if (_featuredMeme != null) ...[
              SliverToBoxAdapter(
                child: SectionHeader(
                  title: 'Meme của bạn hôm nay',
                  actionText: 'Đổi câu',
                  onAction: _updateFeaturedMeme,
                ),
              ),
              SliverToBoxAdapter(
                child: _buildFeaturedMemeCard(_featuredMeme!, store),
              ),
            ],

            // Condition filter
            SliverToBoxAdapter(child: _buildConditionFilter()),

            // Search bar
            SliverToBoxAdapter(child: _buildSearchBar()),

            // Meme grid for selected condition
            SliverToBoxAdapter(
              child: SectionHeader(
                title: _searchQuery.isEmpty
                    ? _conditionLabel(_selectedCondition)
                    : '${_filteredMemes.length} kết quả',
              ),
            ),
            if (_filteredMemes.isEmpty)
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(32),
                  child: Column(
                    children: [
                      const Text('🔍', style: TextStyle(fontSize: 40)),
                      const SizedBox(height: 12),
                      Text(
                        'Không tìm thấy meme nào cho "$_searchQuery"',
                        style: const TextStyle(color: AppColors.textHint, fontSize: 14),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              )
            else
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final memes = _filteredMemes;
                    if (index < memes.length) {
                      return _buildMemeListItem(memes[index], store);
                    }
                    return null;
                  },
                  childCount: _filteredMemes.length,
                ),
              ),

            // Privacy mode hint
            if (store.privacyMode)
              SliverToBoxAdapter(child: _buildPrivacyHint()),

            // Bottom padding
            const SliverToBoxAdapter(child: SizedBox(height: 80)),
          ],
        ),
      ),
    );
  }

  // ============== Current Status Card ==============

  Widget _buildCurrentStatusCard(AppStore store, PortfolioSummary summary) {
    final status = summary.emotionalStatus;
    final isProfit = summary.isProfit;
    final color = isProfit ? AppColors.profit : AppColors.loss;

    return AppCard(
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  color: isProfit ? AppColors.profitBg : AppColors.lossBg,
                  borderRadius: BorderRadius.circular(32),
                ),
                child: Center(
                  child: Text(status.emoji, style: const TextStyle(fontSize: 32)),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Trạng thái hiện tại',
                      style: TextStyle(color: AppColors.textHint, fontSize: 12),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      status.label,
                      style: TextStyle(
                        color: color,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    if (!store.privacyMode)
                      Text(
                        '${isProfit ? '+' : ''}${summary.totalProfitLossPercent.toStringAsFixed(2)}%',
                        style: TextStyle(
                          color: color,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      )
                    else
                      const Text(
                        '••••••',
                        style: TextStyle(
                          color: AppColors.textHint,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ============== Featured Meme Card ==============

  Widget _buildFeaturedMemeCard(MemeTemplate meme, AppStore store) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.bgCard,
            _getSeverityBg(meme.severityLevel),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.gold.withValues(alpha: 0.2)),
      ),
      child: Column(
        children: [
          if (meme.emoji != null)
            Text(meme.emoji!, style: const TextStyle(fontSize: 48)),
          const SizedBox(height: 16),
          Text(
            meme.title,
            style: const TextStyle(
              color: AppColors.gold,
              fontSize: 14,
              fontWeight: FontWeight.w600,
              letterSpacing: 1,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            meme.content,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: AppColors.textPrimary,
              fontSize: 18,
              fontWeight: FontWeight.w500,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton.icon(
                onPressed: () => _shareMeme(meme, store),
                icon: const Icon(Icons.share, size: 18),
                label: const Text('Chia sẻ'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.gold,
                  foregroundColor: AppColors.bgPrimary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              OutlinedButton.icon(
                onPressed: _updateFeaturedMeme,
                icon: const Icon(Icons.refresh, size: 18),
                label: const Text('Câu khác'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.textSecondary,
                  side: const BorderSide(color: AppColors.divider),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ============== Condition Filter ==============

  Widget _buildConditionFilter() {
    final conditions = [
      (MemeCondition.profitHigh, 'Lãi đỉnh'),
      (MemeCondition.profitMedium, 'Lãi vừa'),
      (MemeCondition.profitLow, 'Về bờ'),
      (MemeCondition.lossMinimal, 'Xước nhẹ'),
      (MemeCondition.lossLight, 'Thấy sai'),
      (MemeCondition.lossModerate, 'Tim nhói'),
      (MemeCondition.lossHeavy, 'Cần ôm'),
      (MemeCondition.lossSpiritual, 'Tâm linh'),
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: conditions.map((c) {
          final isSelected = _selectedCondition == c.$1;
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: GestureDetector(
              onTap: () => _selectCondition(c.$1),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.gold.withValues(alpha: 0.15) : AppColors.bgCard,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: isSelected ? AppColors.gold : AppColors.divider,
                  ),
                ),
                child: Text(
                  c.$2,
                  style: TextStyle(
                    color: isSelected ? AppColors.gold : AppColors.textSecondary,
                    fontSize: 13,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  // ============== Search Bar ==============

  Widget _buildSearchBar() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.bgCard,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.divider),
      ),
      child: TextField(
        onChanged: (value) => setState(() => _searchQuery = value),
        style: const TextStyle(color: AppColors.textPrimary, fontSize: 14),
        decoration: const InputDecoration(
          hintText: 'Tìm meme trong mục này...',
          hintStyle: TextStyle(color: AppColors.textHint, fontSize: 14),
          prefixIcon: Icon(Icons.search, color: AppColors.textHint, size: 20),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          isDense: true,
        ),
      ),
    );
  }

  // ============== Meme List Item ==============

  Widget _buildMemeListItem(MemeTemplate meme, AppStore store) {
    return AppCard(
      color: _getSeverityBg(meme.severityLevel),
      onTap: () => _showMemeDetail(meme, store),
      child: Row(
        children: [
          if (meme.emoji != null) ...[
            Text(meme.emoji!, style: const TextStyle(fontSize: 28)),
            const SizedBox(width: 12),
          ],
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  meme.title,
                  style: const TextStyle(
                    color: AppColors.gold,
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  meme.content,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          const Icon(Icons.chevron_right, color: AppColors.textHint, size: 20),
        ],
      ),
    );
  }

  // ============== Privacy Hint ==============

  Widget _buildPrivacyHint() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.gold.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.gold.withValues(alpha: 0.3)),
      ),
      child: const Row(
        children: [
          Icon(Icons.visibility_off, color: AppColors.gold, size: 18),
          SizedBox(width: 8),
          Expanded(
            child: Text(
              'Chế độ riêng tư đang bật - số tiền sẽ bị ẩn khi chia sẻ',
              style: TextStyle(color: AppColors.gold, fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }

  // ============== Meme Detail Dialog ==============

  void _showMemeDetail(MemeTemplate meme, AppStore store) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.bgCard,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (meme.emoji != null)
              Text(meme.emoji!, style: const TextStyle(fontSize: 56)),
            const SizedBox(height: 16),
            Text(
              meme.title,
              style: const TextStyle(
                color: AppColors.gold,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              meme.content,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: AppColors.textPrimary,
                fontSize: 20,
                fontWeight: FontWeight.w500,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton.icon(
                  onPressed: () {
                    Navigator.pop(context);
                    _shareMeme(meme, store);
                  },
                  icon: const Icon(Icons.share, color: AppColors.gold),
                  label: const Text('Chia sẻ', style: TextStyle(color: AppColors.gold)),
                ),
                TextButton.icon(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close, color: AppColors.textHint),
                  label: const Text('Đóng', style: TextStyle(color: AppColors.textHint)),
                ),
              ],
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  // ============== Share ==============

  void _shareMeme(MemeTemplate meme, AppStore store) {
    final summary = store.portfolioSummary;

    if (summary != null && !store.privacyMode) {
      final isProfit = summary.isProfit;
      final plPercent = summary.totalProfitLossPercent.toStringAsFixed(2);
      final plAmount = _formatVndCompact(summary.totalProfitLoss);
      // Full share text with P/L info (privacy mode off)
      final _ = '${meme.emoji ?? ''} ${meme.content}\n\n'
          'Lỗ - ${isProfit ? "Lãi" : "Lỗ"} ${isProfit ? "+" : ""}$plPercent% ($plAmount)\n'
          '#Lo #LoNhieuChua #VangVietNam';
    } else {
      // Privacy-safe share text without amounts
      final _ = '${meme.emoji ?? ''} ${meme.content}\n\n#Lo #LoNhieuChua #VangVietNam';
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Đã sao chép: "${meme.content}"'),
        backgroundColor: AppColors.bgCard,
        action: SnackBarAction(
          label: 'OK',
          textColor: AppColors.gold,
          onPressed: () {},
        ),
      ),
    );
  }

  void _shareCurrentMeme(BuildContext context, AppStore store) {
    if (_featuredMeme != null) {
      _shareMeme(_featuredMeme!, store);
    }
  }

  // ============== Helpers ==============

  String _conditionLabel(MemeCondition condition) {
    switch (condition) {
      case MemeCondition.profitHigh:
        return 'Meme lãi đỉnh';
      case MemeCondition.profitMedium:
        return 'Meme lãi vừa';
      case MemeCondition.profitLow:
        return 'Meme về bờ';
      case MemeCondition.lossMinimal:
        return 'Meme xước nhẹ';
      case MemeCondition.lossLight:
        return 'Meme thấy sai sai';
      case MemeCondition.lossModerate:
        return 'Meme tim nhói';
      case MemeCondition.lossHeavy:
        return 'Meme cần người ôm';
      case MemeCondition.lossSpiritual:
        return 'Meme lỗ tâm linh';
    }
  }

  Color _getSeverityBg(int severity) {
    switch (severity) {
      case 0:
        return AppColors.bgCard;
      case 1:
        return const Color(0xFF2A2520);
      case 2:
        return const Color(0xFF2A2020);
      case 3:
        return const Color(0xFF2D1A1A);
      case 4:
        return const Color(0xFF300F0F);
      default:
        return AppColors.bgCard;
    }
  }

  String _formatVndCompact(double value) {
    final abs = value.abs();
    String formatted;
    if (abs >= 1000000000) {
      formatted = '${(abs / 1000000000).toStringAsFixed(1)} tỷ';
    } else if (abs >= 1000000) {
      formatted = '${(abs / 1000000).toStringAsFixed(0)} triệu';
    } else if (abs >= 1000) {
      formatted = '${(abs / 1000).toStringAsFixed(0)}k';
    } else {
      formatted = abs.round().toString();
    }
    return value < 0 ? '-$formatted' : formatted;
  }
}
