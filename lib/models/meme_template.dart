/// MemeTemplate model - defines meme content based on profit/loss severity.
/// The meme engine selects templates based on the user's current P/L percentage.
class MemeTemplate {
  final String id;
  final MemeCondition condition;
  final String title;
  final String content; // the meme text/quote
  final int severityLevel; // 0=mild, 1=moderate, 2=severe, 3=spiritual
  final String? emoji;

  const MemeTemplate({
    required this.id,
    required this.condition,
    required this.title,
    required this.content,
    required this.severityLevel,
    this.emoji,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'condition': condition.name,
      'title': title,
      'content': content,
      'severityLevel': severityLevel,
      'emoji': emoji,
    };
  }

  factory MemeTemplate.fromMap(Map<String, dynamic> map) {
    return MemeTemplate(
      id: map['id'] as String,
      condition: MemeCondition.values.firstWhere(
        (e) => e.name == map['condition'],
        orElse: () => MemeCondition.profitHigh,
      ),
      title: map['title'] as String,
      content: map['content'] as String,
      severityLevel: map['severityLevel'] as int? ?? 0,
      emoji: map['emoji'] as String?,
    );
  }
}

/// Conditions for meme selection based on profit/loss percentage
enum MemeCondition {
  profitHigh, // >= 10%
  profitMedium, // 3% to 10%
  profitLow, // 0% to 3%
  lossMinimal, // 0% to -1%
  lossLight, // -1% to -3%
  lossModerate, // -3% to -7%
  lossHeavy, // -7% to -15%
  lossSpiritual, // < -15%
}

/// Emotional status levels for display
enum EmotionalStatus {
  profitCautious, // "Lãi rồi nhưng vẫn chưa dám bán"
  breakeven, // "Về bờ"
  lossLight, // "Lỗ nhẹ"
  lossModerate, // "Lỗ vừa"
  lossHeavy, // "Lỗ sâu"
  lossSpiritual, // "Lỗ tâm linh"
}

extension EmotionalStatusX on EmotionalStatus {
  String get label {
    switch (this) {
      case EmotionalStatus.profitCautious:
        return 'Lãi rồi nhưng vẫn chưa dám bán';
      case EmotionalStatus.breakeven:
        return 'Về bờ';
      case EmotionalStatus.lossLight:
        return 'Lỗ nhẹ';
      case EmotionalStatus.lossModerate:
        return 'Lỗ vừa';
      case EmotionalStatus.lossHeavy:
        return 'Lỗ sâu';
      case EmotionalStatus.lossSpiritual:
        return 'Lỗ tâm linh';
    }
  }

  String get emoji {
    switch (this) {
      case EmotionalStatus.profitCautious:
        return '🎉';
      case EmotionalStatus.breakeven:
        return '😌';
      case EmotionalStatus.lossLight:
        return '😅';
      case EmotionalStatus.lossModerate:
        return '😣';
      case EmotionalStatus.lossHeavy:
        return '😭';
      case EmotionalStatus.lossSpiritual:
        return '🧘';
    }
  }
}
