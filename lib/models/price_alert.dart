/// Price Alert model - user-configured alerts for gold price movements.
class PriceAlert {
  final String id;
  final PriceAlertType type;
  final String? goldTypeId; // null = applies to all tracked gold types
  final double? targetPrice; // target buy price per luong
  final double? targetProfitLoss; // target profit/loss in VND
  final bool enabled;
  final DateTime createdAt;

  PriceAlert({
    required this.id,
    required this.type,
    this.goldTypeId,
    this.targetPrice,
    this.targetProfitLoss,
    this.enabled = true,
    required this.createdAt,
  });

  PriceAlert copyWith({
    String? id,
    PriceAlertType? type,
    String? goldTypeId,
    double? targetPrice,
    double? targetProfitLoss,
    bool? enabled,
    DateTime? createdAt,
  }) {
    return PriceAlert(
      id: id ?? this.id,
      type: type ?? this.type,
      goldTypeId: goldTypeId ?? this.goldTypeId,
      targetPrice: targetPrice ?? this.targetPrice,
      targetProfitLoss: targetProfitLoss ?? this.targetProfitLoss,
      enabled: enabled ?? this.enabled,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'type': type.name,
      'goldTypeId': goldTypeId,
      'targetPrice': targetPrice,
      'targetProfitLoss': targetProfitLoss,
      'enabled': enabled,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory PriceAlert.fromMap(Map<String, dynamic> map) {
    return PriceAlert(
      id: map['id'] as String,
      type: PriceAlertType.values.firstWhere(
        (e) => e.name == map['type'],
        orElse: () => PriceAlertType.priceTarget,
      ),
      goldTypeId: map['goldTypeId'] as String?,
      targetPrice: (map['targetPrice'] as num?)?.toDouble(),
      targetProfitLoss: (map['targetProfitLoss'] as num?)?.toDouble(),
      enabled: map['enabled'] as bool? ?? true,
      createdAt: DateTime.parse(map['createdAt'] as String),
    );
  }

  /// Returns a user-friendly description of this alert
  String get description {
    switch (type) {
      case PriceAlertType.breakeven:
        return 'Báo khi về bờ (hòa vốn)';
      case PriceAlertType.lossThreshold:
        return 'Báo khi lỗ vượt ${_formatVnd(targetProfitLoss)}';
      case PriceAlertType.profitThreshold:
        return 'Báo khi lãi vượt ${_formatVnd(targetProfitLoss)}';
      case PriceAlertType.priceTarget:
        return 'Báo khi giá mua vào đạt ${_formatVnd(targetPrice)}/lượng';
      case PriceAlertType.priceSurge:
        return 'Báo khi giá tăng/giảm mạnh';
    }
  }

  String _formatVnd(double? value) {
    if (value == null) return '---';
    return '${value.round().abs().toString().replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (m) => '${m[1]},',
        )}đ';
  }
}

enum PriceAlertType {
  breakeven, // alert when breaking even
  lossThreshold, // alert when loss exceeds threshold
  profitThreshold, // alert when profit exceeds threshold
  priceTarget, // alert when buy price reaches a target
  priceSurge, // alert when price changes significantly
}
