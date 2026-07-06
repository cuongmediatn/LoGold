import '../models/price_alert.dart';
import '../services/profit_loss_calculator.dart';

/// NotificationService - Handles price alerts and notifications.
/// In the MVP, this provides in-app notification simulation.
/// Can be extended with local notifications (flutter_local_notifications) later.
class NotificationService {
  static NotificationService? _instance;
  static NotificationService get instance => _instance ??= NotificationService._();

  NotificationService._();

  final List<PriceAlert> _alerts = [];
  final List<AppNotification> _notifications = [];

  List<PriceAlert> get alerts => List.unmodifiable(_alerts);
  List<AppNotification> get notifications => List.unmodifiable(_notifications);

  /// Add a new price alert
  void addAlert(PriceAlert alert) {
    _alerts.add(alert);
  }

  /// Remove an alert
  void removeAlert(String id) {
    _alerts.removeWhere((a) => a.id == id);
  }

  /// Toggle alert enabled status
  void toggleAlert(String id) {
    final index = _alerts.indexWhere((a) => a.id == id);
    if (index >= 0) {
      _alerts[index] = _alerts[index].copyWith(enabled: !_alerts[index].enabled);
    }
  }

  /// Check all alerts against current portfolio summary and price changes.
  /// Returns triggered notifications.
  List<AppNotification> checkAlerts({
    required PortfolioSummary summary,
    required Map<String, double> priceChanges, // goldTypeId -> change amount
  }) {
    final triggered = <AppNotification>[];

    for (final alert in _alerts) {
      if (!alert.enabled) continue;

      bool shouldTrigger = false;
      String title = '';
      String body = '';

      switch (alert.type) {
        case PriceAlertType.breakeven:
          // Check if just crossed breakeven
          if (summary.totalProfitLoss >= 0 && summary.totalProfitLoss < 100000) {
            shouldTrigger = true;
            title = 'Tin vui: Bạn sắp nhìn thấy bờ';
            body = 'Tổng tài sản đã gần hòa vốn!';
          }
          break;

        case PriceAlertType.lossThreshold:
          if (alert.targetProfitLoss != null &&
              summary.totalProfitLoss <= -alert.targetProfitLoss!.abs()) {
            shouldTrigger = true;
            title = 'Cảnh báo: mức lỗ đã vượt ngưỡng chịu đựng';
            body = 'Tổng lỗ hiện tại: ${_formatVnd(summary.totalProfitLoss)}';
          }
          break;

        case PriceAlertType.profitThreshold:
          if (alert.targetProfitLoss != null &&
              summary.totalProfitLoss >= alert.targetProfitLoss!.abs()) {
            shouldTrigger = true;
            title = 'Chúc mừng: Lãi đã đạt mục tiêu!';
            body = 'Tổng lãi hiện tại: ${_formatVnd(summary.totalProfitLoss)}';
          }
          break;

        case PriceAlertType.priceTarget:
          if (alert.goldTypeId != null &&
              alert.targetPrice != null &&
              priceChanges.containsKey(alert.goldTypeId)) {
            final currentPrice = priceChanges[alert.goldTypeId]!;
            // Simplified: trigger when price is near target
            shouldTrigger = true;
            title = 'Giá vàng vừa nhúc nhích';
            body = 'Ví bạn cũng hồi hộp theo.';
          }
          break;

        case PriceAlertType.priceSurge:
          final hasSurge = priceChanges.values.any((c) => c.abs() > 1000000);
          if (hasSurge) {
            shouldTrigger = true;
            title = 'Giá vàng biến động mạnh!';
            body = 'Thay đổi lớn vừa xảy ra, kiểm tra ngay.';
          }
          break;
      }

      if (shouldTrigger) {
        final notification = AppNotification(
          id: '${alert.id}_${DateTime.now().millisecondsSinceEpoch}',
          title: title,
          body: body,
          timestamp: DateTime.now(),
          type: alert.type,
        );
        triggered.add(notification);
        _notifications.insert(0, notification);
      }
    }

    // Keep only last 50 notifications
    if (_notifications.length > 50) {
      _notifications.removeRange(50, _notifications.length);
    }

    return triggered;
  }

  /// Clear all notifications
  void clearNotifications() {
    _notifications.clear();
  }

  /// Mark notification as read
  void markAsRead(String id) {
    final index = _notifications.indexWhere((n) => n.id == id);
    if (index >= 0) {
      _notifications[index] = _notifications[index].copyWith(isRead: true);
    }
  }

  String _formatVnd(double value) {
    final abs = value.abs().round();
    final str = abs.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (m) => '${m[1]}.',
    );
    return value < 0 ? '-${str}đ' : '${str}đ';
  }
}

/// In-app notification model
class AppNotification {
  final String id;
  final String title;
  final String body;
  final DateTime timestamp;
  final PriceAlertType type;
  final bool isRead;

  AppNotification({
    required this.id,
    required this.title,
    required this.body,
    required this.timestamp,
    required this.type,
    this.isRead = false,
  });

  AppNotification copyWith({
    String? id,
    String? title,
    String? body,
    DateTime? timestamp,
    PriceAlertType? type,
    bool? isRead,
  }) {
    return AppNotification(
      id: id ?? this.id,
      title: title ?? this.title,
      body: body ?? this.body,
      timestamp: timestamp ?? this.timestamp,
      type: type ?? this.type,
      isRead: isRead ?? this.isRead,
    );
  }
}
