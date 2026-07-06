import 'package:flutter/material.dart';
import '../constants/app_constants.dart';

/// Reusable UI components for the Lỗ app.

/// A rounded card with the app's dark theme styling.
class AppCard extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final Color? color;
  final VoidCallback? onTap;
  final double borderRadius;

  const AppCard({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.color,
    this.onTap,
    this.borderRadius = 16,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin ?? const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: Material(
        color: color ?? AppColors.bgCard,
        borderRadius: BorderRadius.circular(borderRadius),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(borderRadius),
          child: Padding(
            padding: padding ?? const EdgeInsets.all(16),
            child: child,
          ),
        ),
      ),
    );
  }
}

/// Large P/L amount display with color coding.
class PLDisplay extends StatelessWidget {
  final double amount;
  final String label;
  final bool isProfit;
  final bool isPercentage;
  final bool privacyMode;
  final double fontSize;

  const PLDisplay({
    super.key,
    required this.amount,
    this.label = '',
    required this.isProfit,
    this.isPercentage = false,
    this.privacyMode = false,
    this.fontSize = 36,
  });

  @override
  Widget build(BuildContext context) {
    final color = isProfit ? AppColors.profit : AppColors.loss;
    final displayText = privacyMode
        ? '••••••'
        : isPercentage
            ? _formatPercent(amount)
            : _formatVnd(amount);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label.isNotEmpty)
          Text(
            label,
            style: TextStyle(
              color: AppColors.textSecondary,
              fontSize: 14,
            ),
          ),
        if (label.isNotEmpty) const SizedBox(height: 4),
        Text(
          displayText,
          style: TextStyle(
            color: privacyMode ? AppColors.textHint : color,
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
            fontFeatures: const [FontFeature.tabularFigures()],
          ),
        ),
      ],
    );
  }

  String _formatVnd(double value) {
    final abs = value.abs().round();
    final str = abs.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (m) => '${m[1]}.',
    );
    return value < 0 ? '-$str₫' : '$str₫';
  }

  String _formatPercent(double value) {
    final sign = value > 0 ? '+' : '';
    return '$sign${value.toStringAsFixed(2)}%';
  }
}

/// Status badge showing emotional status.
class StatusBadge extends StatelessWidget {
  final String label;
  final String emoji;
  final bool isProfit;

  const StatusBadge({
    super.key,
    required this.label,
    required this.emoji,
    this.isProfit = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: isProfit ? AppColors.profitBg : AppColors.lossBg,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isProfit ? AppColors.profit : AppColors.loss,
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(emoji, style: const TextStyle(fontSize: 18)),
          const SizedBox(width: 8),
          Text(
            label,
            style: TextStyle(
              color: isProfit ? AppColors.profit : AppColors.loss,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

/// Meme card showing a funny quote.
class MemeCard extends StatelessWidget {
  final String title;
  final String content;
  final String? emoji;
  final int severityLevel;

  const MemeCard({
    super.key,
    required this.title,
    required this.content,
    this.emoji,
    this.severityLevel = 0,
  });

  @override
  Widget build(BuildContext context) {
    return AppCard(
      color: _getSeverityColor(),
      child: Row(
        children: [
          if (emoji != null) ...[
            Text(emoji!, style: const TextStyle(fontSize: 36)),
            const SizedBox(width: 16),
          ],
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: AppColors.gold,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  content,
                  style: const TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Color _getSeverityColor() {
    switch (severityLevel) {
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
}

/// Compact "nói đểu" line for inline placement (under P/L, above holdings, etc).
/// Uses italic muted text with a small emoji, keeping the vibe playful without
/// dominating the layout the way [MemeCard] does.
class TeaseLine extends StatelessWidget {
  final String content;
  final String? emoji;
  final int severityLevel;
  final EdgeInsets? margin;
  final EdgeInsets? padding;

  const TeaseLine({
    super.key,
    required this.content,
    this.emoji,
    this.severityLevel = 0,
    this.margin,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin ?? EdgeInsets.zero,
      padding: padding ??
          const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: _bgColor(),
        borderRadius: BorderRadius.circular(10),
        border: Border(
          left: BorderSide(color: _accentColor(), width: 3),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (emoji != null && emoji!.isNotEmpty) ...[
            Text(emoji!, style: const TextStyle(fontSize: 18)),
            const SizedBox(width: 10),
          ],
          Expanded(
            child: Text(
              content,
              style: TextStyle(
                color: AppColors.textSecondary,
                fontSize: 13,
                fontStyle: FontStyle.italic,
                height: 1.35,
                letterSpacing: 0.1,
              ),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Color _bgColor() {
    switch (severityLevel) {
      case 0:
        return AppColors.bgCardHighlight;
      case 1:
        return const Color(0xFF2A2318);
      case 2:
        return const Color(0xFF2A1E1E);
      case 3:
        return const Color(0xFF2D1818);
      case 4:
        return const Color(0xFF2E1010);
      default:
        return AppColors.bgCardHighlight;
    }
  }

  Color _accentColor() {
    switch (severityLevel) {
      case 0:
      case 1:
        return AppColors.gold.withValues(alpha: 0.5);
      case 2:
        return AppColors.warning;
      case 3:
      case 4:
        return AppColors.loss;
      default:
        return AppColors.gold.withValues(alpha: 0.5);
    }
  }
}

/// Section header
class SectionHeader extends StatelessWidget {
  final String title;
  final String? actionText;
  final VoidCallback? onAction;

  const SectionHeader({
    super.key,
    required this.title,
    this.actionText,
    this.onAction,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: AppColors.textPrimary,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          if (actionText != null)
            TextButton(
              onPressed: onAction,
              child: Text(
                actionText!,
                style: const TextStyle(color: AppColors.gold, fontSize: 14),
              ),
            ),
        ],
      ),
    );
  }
}

/// Empty state widget
class EmptyState extends StatelessWidget {
  final String emoji;
  final String title;
  final String subtitle;
  final String? actionText;
  final VoidCallback? onAction;

  const EmptyState({
    super.key,
    required this.emoji,
    required this.title,
    required this.subtitle,
    this.actionText,
    this.onAction,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(emoji, style: const TextStyle(fontSize: 64)),
            const SizedBox(height: 24),
            Text(
              title,
              style: const TextStyle(
                color: AppColors.textPrimary,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              subtitle,
              style: const TextStyle(
                color: AppColors.textSecondary,
                fontSize: 15,
              ),
              textAlign: TextAlign.center,
            ),
            if (actionText != null) ...[
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: onAction,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.gold,
                  foregroundColor: AppColors.bgPrimary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(actionText!),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

/// Loading overlay
class LoadingOverlay extends StatelessWidget {
  final String message;
  final Widget child;
  final bool isLoading;

  const LoadingOverlay({
    super.key,
    required this.message,
    required this.child,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        if (isLoading)
          Container(
            color: Colors.black54,
            child: Center(
              child: Card(
                color: AppColors.bgCard,
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const CircularProgressIndicator(
                        color: AppColors.gold,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        message,
                        style: const TextStyle(color: AppColors.textPrimary),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}

/// Animated number that transitions when value changes
class AnimatedNumber extends StatefulWidget {
  final double value;
  final String format;
  final TextStyle? style;
  final Duration duration;

  const AnimatedNumber({
    super.key,
    required this.value,
    required this.format,
    this.style,
    this.duration = const Duration(milliseconds: 600),
  });

  @override
  State<AnimatedNumber> createState() => _AnimatedNumberState();
}

class _AnimatedNumberState extends State<AnimatedNumber>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  double _oldValue = 0;

  @override
  void initState() {
    super.initState();
    _oldValue = widget.value;
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );
    _animation = Tween<double>(begin: _oldValue, end: widget.value)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
  }

  @override
  void didUpdateWidget(AnimatedNumber oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) {
      _oldValue = oldWidget.value;
      _animation = Tween<double>(begin: _oldValue, end: widget.value)
          .animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
      _controller.forward(from: 0);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Text(
          _formatValue(_animation.value),
          style: widget.style,
        );
      },
    );
  }

  String _formatValue(double value) {
    switch (widget.format) {
      case 'vnd':
        final abs = value.abs().round();
        final str = abs.toString().replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (m) => '${m[1]}.',
        );
        return value < 0 ? '-$str₫' : '$str₫';
      case 'percent':
        final sign = value > 0 ? '+' : '';
        return '$sign${value.toStringAsFixed(2)}%';
      default:
        return value.toStringAsFixed(0);
    }
  }
}

/// Global disclaimer bar widget - shown at the bottom of key screens.
class DisclaimerBar extends StatelessWidget {
  const DisclaimerBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      color: AppColors.bgSecondary,
      child: Row(
        children: [
          const Icon(Icons.info_outline, size: 14, color: AppColors.textHint),
          const SizedBox(width: 6),
          Expanded(
            child: Text(
              AppConstants.disclaimer,
              style: const TextStyle(
                color: AppColors.textHint,
                fontSize: 11,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
