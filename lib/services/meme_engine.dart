import '../models/meme_template.dart';
import '../data/meme_database.dart';
import '../services/profit_loss_calculator.dart';

/// MemeEngine - Selects and generates meme content based on profit/loss levels.
///
/// The engine delegates to [MemeDatabase] which contains hundreds of meme
/// templates organized by condition, in the "hỏi đểu đểu" (teasing question)
/// style. It selects appropriate memes based on the user's current P/L
/// percentage.
class MemeEngine {
  /// Get a deterministic meme for the given P/L percentage.
  /// Uses a deterministic seed based on the date so the same meme shows all day.
  static MemeTemplate getMeme(double profitLossPercent) {
    final condition = ProfitLossCalculator.getMemeCondition(profitLossPercent);
    final templates = MemeDatabase.getByCondition(condition);
    if (templates.isEmpty) {
      return MemeDatabase.getByCondition(MemeCondition.lossMinimal).first;
    }
    // Use day of year as seed for daily meme
    final dayOfYear = DateTime.now().difference(DateTime(2025, 1, 1)).inDays;
    final index = dayOfYear % templates.length;
    return templates[index];
  }

  /// Get a random meme (non-deterministic, for variety on refresh)
  static MemeTemplate getRandomMeme(double profitLossPercent) {
    final condition = ProfitLossCalculator.getMemeCondition(profitLossPercent);
    final templates = MemeDatabase.getByCondition(condition);
    if (templates.isEmpty) {
      return MemeDatabase.getByCondition(MemeCondition.lossMinimal).first;
    }
    final now = DateTime.now().millisecondsSinceEpoch;
    final index = now % templates.length;
    return templates[index];
  }

  /// Get all memes for a specific condition
  static List<MemeTemplate> getMemesByCondition(MemeCondition condition) {
    return MemeDatabase.getByCondition(condition);
  }

  /// Get all meme templates (for the Meme tab)
  static List<MemeTemplate> getAllTemplates() {
    return MemeDatabase.allMemes;
  }

  /// Get memes filtered by severity level
  static List<MemeTemplate> getMemesBySeverity(int severityLevel) {
    return MemeDatabase.allMemes
        .where((m) => m.severityLevel == severityLevel)
        .toList();
  }

  /// Get a short "nói đểu" line for inline display (e.g. under a holding card).
  ///
  /// Uses [seed] to vary the selected meme across contexts while keeping it
  /// stable within a day. If [seed] is null, defaults to the day of year so
  /// the same tease shows all day for a given P/L bucket.
  static MemeTemplate getInlineTease(double profitLossPercent, {String? seed}) {
    final condition = ProfitLossCalculator.getMemeCondition(profitLossPercent);
    final templates = MemeDatabase.getByCondition(condition);
    if (templates.isEmpty) {
      return MemeDatabase.getByCondition(MemeCondition.lossMinimal).first;
    }
    final dayOfYear = DateTime.now().difference(DateTime(2025, 1, 1)).inDays;
    final salt = seed == null ? 0 : seed.hashCode;
    final index = (dayOfYear + salt).abs() % templates.length;
    return templates[index];
  }
}
