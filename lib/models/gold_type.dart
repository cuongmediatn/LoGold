/// Gold Type model - represents different types of gold in the Vietnamese market.
/// Examples: SJC bars, 9999 ring gold, jewelry gold, custom types.
class GoldType {
  final String id;
  final String name; // Internal key e.g. "sjc", "ring_9999"
  final String displayName; // UI display name e.g. "Vàng miếng SJC"
  final String defaultUnit; // "luong", "chi", "gram"
  final String sourceKey; // which price source to use
  final bool isCustom;

  GoldType({
    required this.id,
    required this.name,
    required this.displayName,
    required this.defaultUnit,
    required this.sourceKey,
    this.isCustom = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'displayName': displayName,
      'defaultUnit': defaultUnit,
      'sourceKey': sourceKey,
      'isCustom': isCustom,
    };
  }

  factory GoldType.fromMap(Map<String, dynamic> map) {
    return GoldType(
      id: map['id'] as String,
      name: map['name'] as String,
      displayName: map['displayName'] as String,
      defaultUnit: map['defaultUnit'] as String? ?? 'luong',
      sourceKey: map['sourceKey'] as String? ?? 'mock',
      isCustom: map['isCustom'] as bool? ?? false,
    );
  }

  /// Predefined gold types in the Vietnamese market.
  static List<GoldType> get defaults => [
        GoldType(
          id: 'sjc',
          name: 'sjc',
          displayName: 'Vàng miếng SJC',
          defaultUnit: 'luong',
          sourceKey: 'sjc',
        ),
        GoldType(
          id: 'ring_9999',
          name: 'ring_9999',
          displayName: 'Vàng nhẫn 9999',
          defaultUnit: 'chi',
          sourceKey: 'ring_9999',
        ),
        GoldType(
          id: 'gold_9999',
          name: 'gold_9999',
          displayName: 'Vàng 9999 khác',
          defaultUnit: 'luong',
          sourceKey: 'gold_9999',
        ),
        GoldType(
          id: 'jewelry',
          name: 'jewelry',
          displayName: 'Vàng trang sức',
          defaultUnit: 'gram',
          sourceKey: 'jewelry',
        ),
      ];
}
