/// UserHolding model - represents a single gold purchase entry by the user.
/// This is the core data model for tracking gold investments.
class UserHolding {
  final String id;
  final String goldTypeId; // references GoldType.id
  final double quantity; // quantity in the original unit
  final String unit; // "luong", "chi", "gram"
  final double quantityInLuong; // normalized to luong for calculations
  final double buyPricePerLuong; // buy price per luong (VND)
  final double totalCost; // total cost = buyPrice * quantity + fee
  final double fee; // additional fees
  final DateTime buyDate;
  final String? note;
  final String? invoiceImageUri;
  final String status; // "holding" or "sold"
  final DateTime createdAt;
  final DateTime updatedAt;

  UserHolding({
    required this.id,
    required this.goldTypeId,
    required this.quantity,
    required this.unit,
    required this.quantityInLuong,
    required this.buyPricePerLuong,
    required this.totalCost,
    this.fee = 0,
    required this.buyDate,
    this.note,
    this.invoiceImageUri,
    this.status = 'holding',
    required this.createdAt,
    required this.updatedAt,
  });

  /// Create a copy with updated fields
  UserHolding copyWith({
    String? id,
    String? goldTypeId,
    double? quantity,
    String? unit,
    double? quantityInLuong,
    double? buyPricePerLuong,
    double? totalCost,
    double? fee,
    DateTime? buyDate,
    String? note,
    String? invoiceImageUri,
    String? status,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return UserHolding(
      id: id ?? this.id,
      goldTypeId: goldTypeId ?? this.goldTypeId,
      quantity: quantity ?? this.quantity,
      unit: unit ?? this.unit,
      quantityInLuong: quantityInLuong ?? this.quantityInLuong,
      buyPricePerLuong: buyPricePerLuong ?? this.buyPricePerLuong,
      totalCost: totalCost ?? this.totalCost,
      fee: fee ?? this.fee,
      buyDate: buyDate ?? this.buyDate,
      note: note ?? this.note,
      invoiceImageUri: invoiceImageUri ?? this.invoiceImageUri,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'goldTypeId': goldTypeId,
      'quantity': quantity,
      'unit': unit,
      'quantityInLuong': quantityInLuong,
      'buyPricePerLuong': buyPricePerLuong,
      'totalCost': totalCost,
      'fee': fee,
      'buyDate': buyDate.toIso8601String(),
      'note': note,
      'invoiceImageUri': invoiceImageUri,
      'status': status,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  factory UserHolding.fromMap(Map<String, dynamic> map) {
    return UserHolding(
      id: map['id'] as String,
      goldTypeId: map['goldTypeId'] as String,
      quantity: (map['quantity'] as num).toDouble(),
      unit: map['unit'] as String,
      quantityInLuong: (map['quantityInLuong'] as num).toDouble(),
      buyPricePerLuong: (map['buyPricePerLuong'] as num).toDouble(),
      totalCost: (map['totalCost'] as num).toDouble(),
      fee: (map['fee'] as num?)?.toDouble() ?? 0,
      buyDate: DateTime.parse(map['buyDate'] as String),
      note: map['note'] as String?,
      invoiceImageUri: map['invoiceImageUri'] as String?,
      status: map['status'] as String? ?? 'holding',
      createdAt: DateTime.parse(map['createdAt'] as String),
      updatedAt: DateTime.parse(map['updatedAt'] as String),
    );
  }
}
