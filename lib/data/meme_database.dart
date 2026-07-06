import '../models/meme_template.dart';

/// Massive meme database - hundreds of sarcastic, teasing Vietnamese memes.
///
/// Style: "hỏi đểu đểu" - not bluntly saying "you lost money", but asking
/// teasing questions that imply the loss in a playful, sarcastic way.
///
/// Organized by MemeCondition (8 categories based on P/L severity).
class MemeDatabase {
  /// All memes organized by condition
  static List<MemeTemplate> get allMemes => [
    ...profitHigh,
    ...profitMedium,
    ...profitLow,
    ...lossMinimal,
    ...lossLight,
    ...lossModerate,
    ...lossHeavy,
    ...lossSpiritual,
  ];

  /// Get memes by condition
  static List<MemeTemplate> getByCondition(MemeCondition condition) {
    switch (condition) {
      case MemeCondition.profitHigh:
        return profitHigh;
      case MemeCondition.profitMedium:
        return profitMedium;
      case MemeCondition.profitLow:
        return profitLow;
      case MemeCondition.lossMinimal:
        return lossMinimal;
      case MemeCondition.lossLight:
        return lossLight;
      case MemeCondition.lossModerate:
        return lossModerate;
      case MemeCondition.lossHeavy:
        return lossHeavy;
      case MemeCondition.lossSpiritual:
        return lossSpiritual;
    }
  }

  // ============================================================
  // PROFIT HIGH (>= 10%) - Still teasing, but "lãi đỉnh" style
  // ============================================================
  static const profitHigh = <MemeTemplate>[
    MemeTemplate(id: 'ph_001', condition: MemeCondition.profitHigh, title: 'Lãi đỉnh', content: 'Ông này mua vàng hay mua trúng số vậy?', severityLevel: 0, emoji: '🎉'),
    MemeTemplate(id: 'ph_002', condition: MemeCondition.profitHigh, title: 'Lãi đỉnh', content: 'Lãi thế này thì ai bán được nữa? Chắc giữ tới đời cháu?', severityLevel: 0, emoji: '👑'),
    MemeTemplate(id: 'ph_003', condition: MemeCondition.profitHigh, title: 'Lãi đỉnh', content: 'Bạn có bí quyết gì không? Hay là may mắn thuần túy?', severityLevel: 0, emoji: '🍀'),
    MemeTemplate(id: 'ph_004', condition: MemeCondition.profitHigh, title: 'Lãi đỉnh', content: 'Lãi cao vậy, bạn có nhớ quãng đường đi lên không?', severityLevel: 0, emoji: '📈'),
    MemeTemplate(id: 'ph_005', condition: MemeCondition.profitHigh, title: 'Lãi đỉnh', content: 'Người ta nói vàng giữ giá, bạn thì vàng tăng giá. Khác nhau thế nào nhỉ?', severityLevel: 0, emoji: '💰'),
    MemeTemplate(id: 'ph_006', condition: MemeCondition.profitHigh, title: 'Lãi đỉnh', content: 'Bán đi hay giữ lại? Câu hỏi mà có lãi thì ai cũng muốn trả lời.', severityLevel: 0, emoji: '🤔'),
    MemeTemplate(id: 'ph_007', condition: MemeCondition.profitHigh, title: 'Lãi đỉnh', content: 'Bạn có đi chùa không? Hay là thiên tài tài chính?', severityLevel: 0, emoji: '🛕'),
    MemeTemplate(id: 'ph_008', condition: MemeCondition.profitHigh, title: 'Lãi đỉnh', content: 'Lãi nhiều vậy, định mua thêm hay mua nhà?', severityLevel: 0, emoji: '🏠'),
    MemeTemplate(id: 'ph_009', condition: MemeCondition.profitHigh, title: 'Lãi đỉnh', content: 'Ai dạy bạn mua vàng ở đúng thời điểm vậy? Cho số điện thoại được không?', severityLevel: 0, emoji: '📞'),
    MemeTemplate(id: 'ph_010', condition: MemeCondition.profitHigh, title: 'Lãi đỉnh', content: 'Lãi đỉnh rồi, bạn có còn nhớ mình từng lỗ không?', severityLevel: 0, emoji: '😏'),
    MemeTemplate(id: 'ph_011', condition: MemeCondition.profitHigh, title: 'Lãi đỉnh', content: 'Bạn mua vàng hay đoán trúng tương lai vậy?', severityLevel: 0, emoji: '🔮'),
    MemeTemplate(id: 'ph_012', condition: MemeCondition.profitHigh, title: 'Lãi đỉnh', content: 'Lãi thế này thì vợ hỏi "tiền đâu" trả lời thế nào?', severityLevel: 0, emoji: '😂'),
    MemeTemplate(id: 'ph_013', condition: MemeCondition.profitHigh, title: 'Lãi đỉnh', content: 'Bạn có biết cảm giác lỗ không? Chắc là không rồi nhỉ?', severityLevel: 0, emoji: '🤷'),
    MemeTemplate(id: 'ph_014', condition: MemeCondition.profitHigh, title: 'Lãi đỉnh', content: 'Lãi cao thế, bạn có sợ vàng rớt lại không hay vẫn ngủ ngon?', severityLevel: 0, emoji: '😴'),
    MemeTemplate(id: 'ph_015', condition: MemeCondition.profitHigh, title: 'Lãi đỉnh', content: 'Bạn mua vàng hay mua vé số? Sao trúng tòe hết vậy?', severityLevel: 0, emoji: '🎰'),
    MemeTemplate(id: 'ph_016', condition: MemeCondition.profitHigh, title: 'Lãi đỉnh', content: 'Người ta sợ đỉnh, bạn thì leo đỉnh. Khác biệt ở đâu?', severityLevel: 0, emoji: '🏔️'),
    MemeTemplate(id: 'ph_017', condition: MemeCondition.profitHigh, title: 'Lãi đỉnh', content: 'Lãi nhiều thế, bạn có mời bạn bè ăn mừng chưa?', severityLevel: 0, emoji: '🍽️'),
    MemeTemplate(id: 'ph_018', condition: MemeCondition.profitHigh, title: 'Lãi đỉnh', content: 'Bạn có xem lại giá mua không? Để biết mình giỏi cỡ nào?', severityLevel: 0, emoji: '👍'),
    MemeTemplate(id: 'ph_019', condition: MemeCondition.profitHigh, title: 'Lãi đỉnh', content: 'Lãi đỉnh rồi, định nghỉ hưu sớm hay chơi tiếp?', severityLevel: 0, emoji: '🏖️'),
    MemeTemplate(id: 'ph_020', condition: MemeCondition.profitHigh, title: 'Lãi đỉnh', content: 'Bạn có biết rằng ai cũng ghen tị với bạn không?', severityLevel: 0, emoji: '👀'),
    MemeTemplate(id: 'ph_021', condition: MemeCondition.profitHigh, title: 'Lãi đỉnh', content: 'Lãi cao vậy, bạn có tính làm tỷ phú không hay chỉ cho vui?', severityLevel: 0, emoji: '💎'),
    MemeTemplate(id: 'ph_022', condition: MemeCondition.profitHigh, title: 'Lãi đỉnh', content: 'Sáng ra mở app thấy lãi, bạn có muốn hét lên không?', severityLevel: 0, emoji: '🤩'),
    MemeTemplate(id: 'ph_023', condition: MemeCondition.profitHigh, title: 'Lãi đỉnh', content: 'Bạn mua vàng đúng ngày luôn, hay là có người mách nước?', severityLevel: 0, emoji: '🌊'),
    MemeTemplate(id: 'ph_024', condition: MemeCondition.profitHigh, title: 'Lãi đỉnh', content: 'Lãi thế này thì có đi ăn sushi không hay vẫn cơm tấm?', severityLevel: 0, emoji: '🍣'),
    MemeTemplate(id: 'ph_025', condition: MemeCondition.profitHigh, title: 'Lãi đỉnh', content: 'Bạn có biết người ta gọi gì không? "Nhà đầu tư có tầm nhìn."', severityLevel: 0, emoji: '🎯'),
    MemeTemplate(id: 'ph_026', condition: MemeCondition.profitHigh, title: 'Lãi đỉnh', content: 'Lãi cao, bạn có sợ mình thành người tham lam không?', severityLevel: 0, emoji: '😈'),
    MemeTemplate(id: 'ph_027', condition: MemeCondition.profitHigh, title: 'Lãi đỉnh', content: 'Bạn có còn nhớ ngày xưa mua vàng run tay không? Giờ thì run gì nữa?', severityLevel: 0, emoji: '✋'),
    MemeTemplate(id: 'ph_028', condition: MemeCondition.profitHigh, title: 'Lãi đỉnh', content: 'Lãi đỉnh rồi, định mở tiệm vàng luôn hay sao?', severityLevel: 0, emoji: '🏪'),
    MemeTemplate(id: 'ph_029', condition: MemeCondition.profitHigh, title: 'Lãi đỉnh', content: 'Bạn có biết cảm giác "nâng như nâng trứng" không? Lãi rồi thì khỏi nâng.', severityLevel: 0, emoji: '🥚'),
    MemeTemplate(id: 'ph_030', condition: MemeCondition.profitHigh, title: 'Lãi đỉnh', content: 'Người ta ghen tị với bạn, bạn có tự hào không hay vẫn khiêm tốn?', severityLevel: 0, emoji: '😌'),
    MemeTemplate(id: 'ph_031', condition: MemeCondition.profitHigh, title: 'Lãi đỉnh', content: 'Lãi thế này, bạn có còn dám nói "vàng rủi ro" không?', severityLevel: 0, emoji: '🤭'),
    MemeTemplate(id: 'ph_032', condition: MemeCondition.profitHigh, title: 'Lãi đỉnh', content: 'Bạn mua vàng hay mua may mắn? Sao mọi thứ đều đúng lúc?', severityLevel: 0, emoji: '🍀'),
    MemeTemplate(id: 'ph_033', condition: MemeCondition.profitHigh, title: 'Lãi đỉnh', content: 'Lãi nhiều, bạn có định dạy người khác mua vàng không?', severityLevel: 0, emoji: '👨‍🏫'),
    MemeTemplate(id: 'ph_034', condition: MemeCondition.profitHigh, title: 'Lãi đỉnh', content: 'Bạn có biết cảm giác "đỉnh nóc, kịch trần" không? Chắc là biết rồi.', severityLevel: 0, emoji: '🏆'),
    MemeTemplate(id: 'ph_035', condition: MemeCondition.profitHigh, title: 'Lãi đỉnh', content: 'Lãi cao, vợ bạn có yêu bạn hơn chưa?', severityLevel: 0, emoji: '😍'),
    MemeTemplate(id: 'ph_036', condition: MemeCondition.profitHigh, title: 'Lãi đỉnh', content: 'Bạn có còn đi làm không hay đã nghỉ để trade vàng?', severityLevel: 0, emoji: '💼'),
    MemeTemplate(id: 'ph_037', condition: MemeCondition.profitHigh, title: 'Lãi đỉnh', content: 'Lãi thế này, định mua thêm 10 lượng nữa không?', severityLevel: 0, emoji: '🪙'),
    MemeTemplate(id: 'ph_038', condition: MemeCondition.profitHigh, title: 'Lãi đỉnh', content: 'Người ta nói "vàng là tài sản đề kháng", bạn thì vàng là tài sản sinh lời.', severityLevel: 0, emoji: '🛡️'),
    MemeTemplate(id: 'ph_039', condition: MemeCondition.profitHigh, title: 'Lãi đỉnh', content: 'Lãi nhiều, bạn có tính đi du lịch không? Đi đâu cũng được, tiền có rồi.', severityLevel: 0, emoji: '✈️'),
    MemeTemplate(id: 'ph_040', condition: MemeCondition.profitHigh, title: 'Lãi đỉnh', content: 'Bạn có biết rằng bạn đang ở top 1% người mua vàng giỏi nhất không?', severityLevel: 0, emoji: '📊'),
  ];

  // ============================================================
  // PROFIT MEDIUM (3% - 10%) - Cautious profit, teasing "chưa đủ"
  // ============================================================
  static const profitMedium = <MemeTemplate>[
    MemeTemplate(id: 'pm_001', condition: MemeCondition.profitMedium, title: 'Lãi vừa', content: 'Lãi vừa vừa thôi, bán hay giữ đây ta?', severityLevel: 0, emoji: '😏'),
    MemeTemplate(id: 'pm_002', condition: MemeCondition.profitMedium, title: 'Lãi vừa', content: 'Lãi được chút rồi, có muốn chờ thêm hay không?', severityLevel: 0, emoji: '🤏'),
    MemeTemplate(id: 'pm_003', condition: MemeCondition.profitMedium, title: 'Lãi vừa', content: 'Lãi ít thôi mà đã cười rồi à? Tham lam quá đi.', severityLevel: 0, emoji: '😊'),
    MemeTemplate(id: 'pm_004', condition: MemeCondition.profitMedium, title: 'Lãi vừa', content: 'Bạn có biết cảm giác "lãi chưa đủ bán, lỗ thì không muốn" không?', severityLevel: 0, emoji: '🤷'),
    MemeTemplate(id: 'pm_005', condition: MemeCondition.profitMedium, title: 'Lãi vừa', content: 'Lãi vừa thôi, bạn định chờ tới bao giờ?', severityLevel: 0, emoji: '⏳'),
    MemeTemplate(id: 'pm_006', condition: MemeCondition.profitMedium, title: 'Lãi vừa', content: 'Có lãi rồi nè, bạn có dám bán không hay vẫn "đầu tư dài hạn"?', severityLevel: 0, emoji: '😎'),
    MemeTemplate(id: 'pm_007', condition: MemeCondition.profitMedium, title: 'Lãi vừa', content: 'Lãi vài phần trăm mà đã vênh mặt rồi hả?', severityLevel: 0, emoji: '😏'),
    MemeTemplate(id: 'pm_008', condition: MemeCondition.profitMedium, title: 'Lãi vừa', content: 'Bạn mua vàng hay mua hi vọng? Hi vọng vàng lên thêm chút nữa?', severityLevel: 0, emoji: '🙏'),
    MemeTemplate(id: 'pm_009', condition: MemeCondition.profitMedium, title: 'Lãi vừa', content: 'Lãi vừa, nhưng lòng tham thì đã bắt đầu xuất hiện rồi đúng không?', severityLevel: 0, emoji: '😈'),
    MemeTemplate(id: 'pm_010', condition: MemeCondition.profitMedium, title: 'Lãi vừa', content: 'Bạn có biết rằng lãi chưa bán thì chưa tính là lãi không?', severityLevel: 0, emoji: '💭'),
    MemeTemplate(id: 'pm_011', condition: MemeCondition.profitMedium, title: 'Lãi vừa', content: 'Lãi thế này, bạn có muốn mời bạn bè cà phê không? Vừa thôi, đừng phung phí.', severityLevel: 0, emoji: '☕'),
    MemeTemplate(id: 'pm_012', condition: MemeCondition.profitMedium, title: 'Lãi vừa', content: 'Mua vàng lãi vài phần trăm, bạn có thấy mình như chuyên gia tài chính chưa?', severityLevel: 0, emoji: '🎓'),
    MemeTemplate(id: 'pm_013', condition: MemeCondition.profitMedium, title: 'Lãi vừa', content: 'Lãi rồi, bạn có sợ vàng rớt lại không hay vẫn tự tin?', severityLevel: 0, emoji: '😬'),
    MemeTemplate(id: 'pm_014', condition: MemeCondition.profitMedium, title: 'Lãi vừa', content: 'Bạn có biết cảm giác "chưa bán, chưa lãi, chưa vui hẳn" không?', severityLevel: 0, emoji: '🤞'),
    MemeTemplate(id: 'pm_015', condition: MemeCondition.profitMedium, title: 'Lãi vừa', content: 'Lãi vừa, bạn có tính chốt lời hay vẫn chơi tiếp?', severityLevel: 0, emoji: '🎲'),
    MemeTemplate(id: 'pm_016', condition: MemeCondition.profitMedium, title: 'Lãi vừa', content: 'Người ta nói "chưa bán là chưa lãi", bạn nghe thấy thấy sao?', severityLevel: 0, emoji: '👂'),
    MemeTemplate(id: 'pm_017', condition: MemeCondition.profitMedium, title: 'Lãi vừa', content: 'Lãi vài phần trăm, bạn có muốn đăng Facebook khoe không? Nhớ đừng khoe quá.', severityLevel: 0, emoji: '📱'),
    MemeTemplate(id: 'pm_018', condition: MemeCondition.profitMedium, title: 'Lãi vừa', content: 'Bạn có biết cảm giác "lãi chút xíu, tham thêm chút xíu" không? Cẩn thận đấy.', severityLevel: 0, emoji: '⚠️'),
    MemeTemplate(id: 'pm_019', condition: MemeCondition.profitMedium, title: 'Lãi vừa', content: 'Lãi vừa, vợ bạn có biết không? Hay vẫn giấu?', severityLevel: 0, emoji: '🤫'),
    MemeTemplate(id: 'pm_020', condition: MemeCondition.profitMedium, title: 'Lãi vừa', content: 'Bạn có tính mở thêm vị thế không hay chốt lời cho chắc?', severityLevel: 0, emoji: '🤔'),
    MemeTemplate(id: 'pm_021', condition: MemeCondition.profitMedium, title: 'Lãi vừa', content: 'Lãi được chút đỉnh, bạn có thấy mình thông minh hơn hôm qua không?', severityLevel: 0, emoji: '🧠'),
    MemeTemplate(id: 'pm_022', condition: MemeCondition.profitMedium, title: 'Lãi vừa', content: 'Vàng lên tí thì vui, vàng rớt tí thì sao? Sẵn sàng chưa?', severityLevel: 0, emoji: '🎢'),
    MemeTemplate(id: 'pm_023', condition: MemeCondition.profitMedium, title: 'Lãi vừa', content: 'Lãi vừa, bạn có muốn đếm tiền trong đầu không? Vừa thôi, chưa bán mà.', severityLevel: 0, emoji: '🔢'),
    MemeTemplate(id: 'pm_024', condition: MemeCondition.profitMedium, title: 'Lãi vừa', content: 'Bạn có biết rằng lòng tham bắt đầu từ vài phần trăm lãi không?', severityLevel: 0, emoji: '🐍'),
    MemeTemplate(id: 'pm_025', condition: MemeCondition.profitMedium, title: 'Lãi vừa', content: 'Lãi thế này, bạn có muốn mua thêm vàng hay mua cái khác?', severityLevel: 0, emoji: '💳'),
    MemeTemplate(id: 'pm_026', condition: MemeCondition.profitMedium, title: 'Lãi vừa', content: 'Người ta nói "bán khi lãi", bạn nghe xong có muốn bán không?', severityLevel: 0, emoji: '🤝'),
    MemeTemplate(id: 'pm_027', condition: MemeCondition.profitMedium, title: 'Lãi vừa', content: 'Lãi chút xíu, bạn có xem app nhiều hơn bình thường không?', severityLevel: 0, emoji: '👀'),
    MemeTemplate(id: 'pm_028', condition: MemeCondition.profitMedium, title: 'Lãi vừa', content: 'Bạn có biết cảm giác "lãi chưa đủ, lỗ thì sợ" không? Khó lựa chọn đúng không?', severityLevel: 0, emoji: '⚖️'),
    MemeTemplate(id: 'pm_029', condition: MemeCondition.profitMedium, title: 'Lãi vừa', content: 'Lãi vừa, bạn có định kể cho con cháu nghe không? Chắc là chưa.', severityLevel: 0, emoji: '📖'),
    MemeTemplate(id: 'pm_030', condition: MemeCondition.profitMedium, title: 'Lãi vừa', content: 'Mua vàng lãi được vậy, bạn có muốn dạy tôi mua không?', severityLevel: 0, emoji: '🙏'),
    MemeTemplate(id: 'pm_031', condition: MemeCondition.profitMedium, title: 'Lãi vừa', content: 'Lãi vừa, nhưng bạn có tự hỏi "có phải may mắn không?"', severityLevel: 0, emoji: '🍀'),
    MemeTemplate(id: 'pm_032', condition: MemeCondition.profitMedium, title: 'Lãi vừa', content: 'Bạn có biết cảm giác "vàng lên vui, vàng đứng sốt ruột" không?', severityLevel: 0, emoji: '😤'),
    MemeTemplate(id: 'pm_033', condition: MemeCondition.profitMedium, title: 'Lãi vừa', content: 'Lãi vài phần trăm, bạn có tính đi ăn mừng không? Ăn bát phở thôi nhé.', severityLevel: 0, emoji: '🍜'),
    MemeTemplate(id: 'pm_034', condition: MemeCondition.profitMedium, title: 'Lãi vừa', content: 'Bạn có sợ vàng sẽ rớt vào ngày mai không? Hay vẫn tự tin "dài hạn"?', severityLevel: 0, emoji: '🌅'),
    MemeTemplate(id: 'pm_035', condition: MemeCondition.profitMedium, title: 'Lãi vừa', content: 'Lãi vừa, bạn có muốn mở champagne không? Bia thôi nhé, tiết kiệm.', severityLevel: 0, emoji: '🍻'),
  ];

  // ============================================================
  // PROFIT LOW (0% - 3%) - "Về bờ" but not much, teasing "mới về bờ"
  // ============================================================
  static const profitLow = <MemeTemplate>[
    MemeTemplate(id: 'pl_001', condition: MemeCondition.profitLow, title: 'Về bờ', content: 'Về bờ rồi, nhưng bạn có dám bước chân lên bờ không?', severityLevel: 0, emoji: '🏖️'),
    MemeTemplate(id: 'pl_002', condition: MemeCondition.profitLow, title: 'Về bờ', content: 'Hòa vốn rồi nè, bạn có cảm thấy nhẹ nhõm không hay vẫn lo?', severityLevel: 0, emoji: '😌'),
    MemeTemplate(id: 'pl_003', condition: MemeCondition.profitLow, title: 'Về bờ', content: 'Về bờ thành công! Nhưng bạn có muốn bơi tiếp không?', severityLevel: 0, emoji: '🏊'),
    MemeTemplate(id: 'pl_004', condition: MemeCondition.profitLow, title: 'Về bờ', content: 'Lãi tí tẹe thôi mà đã vui rồi hả? Cẩn thận lật ngược bây giờ.', severityLevel: 0, emoji: '😅'),
    MemeTemplate(id: 'pl_005', condition: MemeCondition.profitLow, title: 'Về bờ', content: 'Bạn có biết cảm giác "về bờ nhưng chưa dám bước đi" không?', severityLevel: 0, emoji: '🧐'),
    MemeTemplate(id: 'pl_006', condition: MemeCondition.profitLow, title: 'Về bờ', content: 'Hòa vốn rồi, bán thì cũng được không bán thì cũng không mất. Khó chọn hả?', severityLevel: 0, emoji: '🤷'),
    MemeTemplate(id: 'pl_007', condition: MemeCondition.profitLow, title: 'Về bờ', content: 'Về bờ! Giờ bạn có muốn mời bạn bè cà phê không? Tiền lãi đâu đủ đâu.', severityLevel: 0, emoji: '☕'),
    MemeTemplate(id: 'pl_008', condition: MemeCondition.profitLow, title: 'Về bờ', content: 'Lãi gần như không, bạn có thấy mình đầu tư cho vui không?', severityLevel: 0, emoji: '🎭'),
    MemeTemplate(id: 'pl_009', condition: MemeCondition.profitLow, title: 'Về bờ', content: 'Về bờ rồi, bạn có muốn kể cho mẹ nghe không? Mẹ sẽ nói "thấy chưa, bảo rồi".', severityLevel: 0, emoji: '👵'),
    MemeTemplate(id: 'pl_010', condition: MemeCondition.profitLow, title: 'Về bờ', content: 'Hòa vốn là thắng, bạn nghe câu này bao giờ chưa? Giờ thì hiểu rồi đúng không?', severityLevel: 0, emoji: '🏆'),
    MemeTemplate(id: 'pl_011', condition: MemeCondition.profitLow, title: 'Về bờ', content: 'Về bờ xong, bạn có biết đi đâu tiếp không? Hay đứng ngắm biển?', severityLevel: 0, emoji: '🌊'),
    MemeTemplate(id: 'pl_012', condition: MemeCondition.profitLow, title: 'Về bờ', content: 'Lãi không đáng kể, nhưng bạn có tự hào không? Ít ra không lỗ.', severityLevel: 0, emoji: '🙂'),
    MemeTemplate(id: 'pl_013', condition: MemeCondition.profitLow, title: 'Về bờ', content: 'Bạn có biết cảm giác "vừa về bờ, sóng lại dâng" không?', severityLevel: 0, emoji: '🌊'),
    MemeTemplate(id: 'pl_014', condition: MemeCondition.profitLow, title: 'Về bờ', content: 'Hòa vốn rồi, bạn có muốn bán không hay vẫn "hy vọng" vàng lên thêm?', severityLevel: 0, emoji: '🙏'),
    MemeTemplate(id: 'pl_015', condition: MemeCondition.profitLow, title: 'Về bờ', content: 'Về bờ rồi, bạn có xem app nhiều hơn không? Sợ lật ngược đúng không?', severityLevel: 0, emoji: '📱'),
    MemeTemplate(id: 'pl_016', condition: MemeCondition.profitLow, title: 'Về bờ', content: 'Lãi tí xíu, bạn có dám khoe không? Khoe thì sợ người ta cười.', severityLevel: 0, emoji: '🤫'),
    MemeTemplate(id: 'pl_017', condition: MemeCondition.profitLow, title: 'Về bờ', content: 'Bạn có biết câu "về bờ không bằng không bơi" không? Về bờ rồi thì nghỉ đi.', severityLevel: 0, emoji: '🛑'),
    MemeTemplate(id: 'pl_018', condition: MemeCondition.profitLow, title: 'Về bờ', content: 'Hòa vốn, bạn có thấy mình đầu tư có trách nhiệm không? Ít ra không mất tiền.', severityLevel: 0, emoji: '✅'),
    MemeTemplate(id: 'pl_019', condition: MemeCondition.profitLow, title: 'Về bờ', content: 'Về bờ rồi, bạn có muốn đi ăn mừng không? Bánh mì thôi nhé, lãi đâu nhiều.', severityLevel: 0, emoji: '🥖'),
    MemeTemplate(id: 'pl_020', condition: MemeCondition.profitLow, title: 'Về bờ', content: 'Lãi không đáng kể nhưng cũng hơn lỗ, bạn có thấy an ủi không?', severityLevel: 0, emoji: '😌'),
    MemeTemplate(id: 'pl_021', condition: MemeCondition.profitLow, title: 'Về bờ', content: 'Bạn có biết cảm giác "về bờ nhưng vẫn ngắm biển" không? Có muốn bơi tiếp không?', severityLevel: 0, emoji: '🏖️'),
    MemeTemplate(id: 'pl_022', condition: MemeCondition.profitLow, title: 'Về bờ', content: 'Hòa vốn rồi, bạn có sợ sóng cuốn trôi không?', severityLevel: 0, emoji: '🌊'),
    MemeTemplate(id: 'pl_023', condition: MemeCondition.profitLow, title: 'Về bờ', content: 'Lãi gần như 0, bạn có thấy mình đầu tư để giải trí không?', severityLevel: 0, emoji: '🎮'),
    MemeTemplate(id: 'pl_024', condition: MemeCondition.profitLow, title: 'Về bờ', content: 'Về bờ xong, bạn có muốn mở tiệm vàng không? Vốn đâu mà mở.', severityLevel: 0, emoji: '🏪'),
    MemeTemplate(id: 'pl_025', condition: MemeCondition.profitLow, title: 'Về bờ', content: 'Bạn có biết rằng hòa vốn là thành công đối với người mua ở đỉnh không?', severityLevel: 0, emoji: '🎯'),
    MemeTemplate(id: 'pl_026', condition: MemeCondition.profitLow, title: 'Về bờ', content: 'Lãi tí tẹe, bạn có đếm từng đồng không? Đừng đếm, bán đi rồi đếm.', severityLevel: 0, emoji: '🔢'),
    MemeTemplate(id: 'pl_027', condition: MemeCondition.profitLow, title: 'Về bờ', content: 'Về bờ rồi, bạn có tính nghỉ hưu không? Tiền đâu mà nghỉ.', severityLevel: 0, emoji: '🛌'),
    MemeTemplate(id: 'pl_028', condition: MemeCondition.profitLow, title: 'Về bờ', content: 'Hòa vốn, bạn có thấy mình giỏi hơn người lỗ không? Tự hào chút thôi nhé.', severityLevel: 0, emoji: '😏'),
    MemeTemplate(id: 'pl_029', condition: MemeCondition.profitLow, title: 'Về bờ', content: 'Lãi không đáng kể, bạn có muốn mua thêm không? Cẩn thận lật ngược.', severityLevel: 0, emoji: '⚠️'),
    MemeTemplate(id: 'pl_030', condition: MemeCondition.profitLow, title: 'Về bờ', content: 'Bạn có biết cảm giác "về bờ rồi, nhưng sóng vẫn rì rào" không?', severityLevel: 0, emoji: '🌊'),
  ];

  // ============================================================
  // LOSS MINIMAL (0% to -1%) - "Xước nhẹ" - teasing very mild loss
  // ============================================================
  static const lossMinimal = <MemeTemplate>[
    MemeTemplate(id: 'lm_001', condition: MemeCondition.lossMinimal, title: 'Xước nhẹ', content: 'Xước nhẹ thôi mà, bạn có cần băng cá nhân không?', severityLevel: 0, emoji: '🩹'),
    MemeTemplate(id: 'lm_002', condition: MemeCondition.lossMinimal, title: 'Xước nhẹ', content: 'Lỗ tí xíu, bạn có muốn khóc không? Khóc xong đi uống trà.', severityLevel: 0, emoji: '🍵'),
    MemeTemplate(id: 'lm_003', condition: MemeCondition.lossMinimal, title: 'Xước nhẹ', content: 'Bạn có biết cảm giác "xước nhẹ nhưng tim đã nhói" không?', severityLevel: 0, emoji: '💔'),
    MemeTemplate(id: 'lm_004', condition: MemeCondition.lossMinimal, title: 'Xước nhẹ', content: 'Lỗ không đáng kể, bạn có lo lắng quá không?', severityLevel: 0, emoji: '🤔'),
    MemeTemplate(id: 'lm_005', condition: MemeCondition.lossMinimal, title: 'Xước nhẹ', content: 'Xước nhẹ ví tiền, bạn có còn đủ tiền xăng không?', severityLevel: 0, emoji: '⛽'),
    MemeTemplate(id: 'lm_006', condition: MemeCondition.lossMinimal, title: 'Xước nhẹ', content: 'Lỗ tí tẹe, bạn có muốn xem app liên tục không? Đừng, đi làm đi.', severityLevel: 0, emoji: '📱'),
    MemeTemplate(id: 'lm_007', condition: MemeCondition.lossMinimal, title: 'Xước nhẹ', content: 'Bạn có biết câu "lỗ nhẹ là học phí" không? Học phí rẻ thế thì ai cũng học.', severityLevel: 0, emoji: '📚'),
    MemeTemplate(id: 'lm_008', condition: MemeCondition.lossMinimal, title: 'Xước nhẹ', content: 'Xước nhẹ, bạn có muốn kể cho vợ nghe không? Nhớ nói nhỏ thôi.', severityLevel: 0, emoji: '🤫'),
    MemeTemplate(id: 'lm_009', condition: MemeCondition.lossMinimal, title: 'Xước nhẹ', content: 'Lỗ không đau, nhưng lòng tự hào thì xước rồi đúng không?', severityLevel: 0, emoji: '😤'),
    MemeTemplate(id: 'lm_010', condition: MemeCondition.lossMinimal, title: 'Xước nhẹ', content: 'Bạn có biết cảm giác "xước nhẹ nhưng soi gương thấy già đi 1 tuổi" không?', severityLevel: 0, emoji: '🪞'),
    MemeTemplate(id: 'lm_011', condition: MemeCondition.lossMinimal, title: 'Xước nhẹ', content: 'Lỗ tí xíu, bạn có muốn ăn mừng "không lỗ nhiều" không? Bánh mì thôi nhé.', severityLevel: 0, emoji: '🥖'),
    MemeTemplate(id: 'lm_012', condition: MemeCondition.lossMinimal, title: 'Xước nhẹ', content: 'Xước nhẹ ví, bạn có tính bỏ vàng không hay vẫn "kiên nhẫn"?', severityLevel: 0, emoji: '🧘'),
    MemeTemplate(id: 'lm_013', condition: MemeCondition.lossMinimal, title: 'Xước nhẹ', content: 'Lỗ không đáng kể, nhưng bạn có soi app 100 lần/ngày không?', severityLevel: 0, emoji: '🔍'),
    MemeTemplate(id: 'lm_014', condition: MemeCondition.lossMinimal, title: 'Xước nhẹ', content: 'Bạn có biết cảm giác "xước nhẹ nhưng sợ lở sâu" không?', severityLevel: 0, emoji: '😰'),
    MemeTemplate(id: 'lm_015', condition: MemeCondition.lossMinimal, title: 'Xước nhẹ', content: 'Lỗ tí tẹe, vợ bạn có hỏi "tiền đâu" chưa? Chưa thì sắp rồi.', severityLevel: 0, emoji: '💬'),
    MemeTemplate(id: 'lm_016', condition: MemeCondition.lossMinimal, title: 'Xước nhẹ', content: 'Xước nhẹ, bạn có muốn cầu nguyện vàng lên không? Đi chùa đi.', severityLevel: 0, emoji: '🛕'),
    MemeTemplate(id: 'lm_017', condition: MemeCondition.lossMinimal, title: 'Xước nhẹ', content: 'Lỗ không đáng kể, bạn có tự nhủ "chưa lỗ thật" không? Tự an ủi giỏi thật.', severityLevel: 0, emoji: '😌'),
    MemeTemplate(id: 'lm_018', condition: MemeCondition.lossMinimal, title: 'Xước nhẹ', content: 'Bạn có biết câu "xước nhẹ là bài học đầu tiên" không? Bài học này rẻ thế?', severityLevel: 0, emoji: '📖'),
    MemeTemplate(id: 'lm_019', condition: MemeCondition.lossMinimal, title: 'Xước nhẹ', content: 'Lỗ tí xíu, bạn có muốn mua thêm để giảm giá hòa vốn không? Cẩn thận đấy.', severityLevel: 0, emoji: '⚠️'),
    MemeTemplate(id: 'lm_020', condition: MemeCondition.lossMinimal, title: 'Xước nhẹ', content: 'Xước nhẹ, bạn có xem giá vàng 50 lần một ngày không? Hồi phục đi.', severityLevel: 0, emoji: '🔄'),
    MemeTemplate(id: 'lm_021', condition: MemeCondition.lossMinimal, title: 'Xước nhẹ', content: 'Bạn có biết cảm giác "lỗ nhẹ nhưng thấy mình đầu tư sai" không?', severityLevel: 0, emoji: '🤦'),
    MemeTemplate(id: 'lm_022', condition: MemeCondition.lossMinimal, title: 'Xước nhẹ', content: 'Lỗ không đau, nhưng ego thì xước rồi. Bạn có thừa nhận không?', severityLevel: 0, emoji: '😤'),
    MemeTemplate(id: 'lm_023', condition: MemeCondition.lossMinimal, title: 'Xước nhẹ', content: 'Xước nhẹ ví, bạn có còn dám khoe với bạn bè không? Chắc là không rồi.', severityLevel: 0, emoji: '🤐'),
    MemeTemplate(id: 'lm_024', condition: MemeCondition.lossMinimal, title: 'Xước nhẹ', content: 'Lỗ tí tẹe, bạn có tự hỏi "có phải mình mua hớ không" chưa?', severityLevel: 0, emoji: '🤔'),
    MemeTemplate(id: 'lm_025', condition: MemeCondition.lossMinimal, title: 'Xước nhẹ', content: 'Bạn có biết câu "xước nhẹ hơn lỗ nặng" không? Vậy là may rồi.', severityLevel: 0, emoji: '🍀'),
    MemeTemplate(id: 'lm_026', condition: MemeCondition.lossMinimal, title: 'Xước nhẹ', content: 'Lỗ không đáng kể, bạn có muốn nghỉ xem app một hôm không? Thử đi.', severityLevel: 0, emoji: '🚫'),
    MemeTemplate(id: 'lm_027', condition: MemeCondition.lossMinimal, title: 'Xước nhẹ', content: 'Xước nhẹ, bạn có uống trà đạo không? Uống đi, cho tâm tĩnh.', severityLevel: 0, emoji: '🍵'),
    MemeTemplate(id: 'lm_028', condition: MemeCondition.lossMinimal, title: 'Xước nhẹ', content: 'Bạn có biết cảm giác "lỗ nhẹ nhưng sợ lỗ nhiều hơn" không? Đừng sợ, hãy hành động.', severityLevel: 0, emoji: '💪'),
    MemeTemplate(id: 'lm_029', condition: MemeCondition.lossMinimal, title: 'Xước nhẹ', content: 'Lỗ tí tẹe, bạn có muốn đọc sách về đầu tư không? Đọc đi, hay hơn lỗ.', severityLevel: 0, emoji: '📚'),
    MemeTemplate(id: 'lm_030', condition: MemeCondition.lossMinimal, title: 'Xước nhẹ', content: 'Xước nhẹ ví tiền, còn đủ tiền ăn phở. Bạn có thấy may mắn không?', severityLevel: 0, emoji: '🍜'),
  ];

  // ============================================================
  // LOSS LIGHT (-1% to -3%) - "Thấy sai sai" - things feel off
  // ============================================================
  static const lossLight = <MemeTemplate>[
    MemeTemplate(id: 'll_001', condition: MemeCondition.lossLight, title: 'Thấy sai sai', content: 'Bạn có thấy gì đó sai sai không? Hay là cảm giác thôi?', severityLevel: 1, emoji: '🤔'),
    MemeTemplate(id: 'll_002', condition: MemeCondition.lossLight, title: 'Thấy sai sai', content: 'Lỗ một chút, bạn có muốn đổ tại ai không? Tại thị trường? Tại vàng? Tại mình?', severityLevel: 1, emoji: '👉'),
    MemeTemplate(id: 'll_003', condition: MemeCondition.lossLight, title: 'Thấy sai sai', content: 'Bạn có biết cảm giác "mua xong thấy giá rớt" không? Giờ thì biết rồi đúng không?', severityLevel: 1, emoji: '📉'),
    MemeTemplate(id: 'll_004', condition: MemeCondition.lossLight, title: 'Thấy sai sai', content: 'Lỗ nhẹ, bạn có tự nhủ "không bán là chưa lỗ" không? Nghe quen quen hả?', severityLevel: 1, emoji: '🤭'),
    MemeTemplate(id: 'll_005', condition: MemeCondition.lossLight, title: 'Thấy sai sai', content: 'Bạn có mở app rồi tắt, tắt rồi mở lại không? Thấy giá đổi chưa?', severityLevel: 1, emoji: '📱'),
    MemeTemplate(id: 'll_006', condition: MemeCondition.lossLight, title: 'Thấy sai sai', content: 'Lỗ vài phần trăm, bạn có soi gương thấy mặt hơi dài không?', severityLevel: 1, emoji: '🪞'),
    MemeTemplate(id: 'll_007', condition: MemeCondition.lossLight, title: 'Thấy sai sai', content: 'Bạn có biết câu "mua vàng là khoản đầu tư an toàn" không? Nghe xong thấy sao?', severityLevel: 1, emoji: '😏'),
    MemeTemplate(id: 'll_008', condition: MemeCondition.lossLight, title: 'Thấy sai sai', content: 'Lỗ chút xíu, bạn có muốn hỏi mẹ "mẹ ơi con mua vàng có sao không?"', severityLevel: 1, emoji: '👵'),
    MemeTemplate(id: 'll_009', condition: MemeCondition.lossLight, title: 'Thấy sai sai', content: 'Bạn có xem tin tức vàng liên tục không? Thấy gì chưa hay vẫn chờ?', severityLevel: 1, emoji: '📰'),
    MemeTemplate(id: 'll_010', condition: MemeCondition.lossLight, title: 'Thấy sai sai', content: 'Lỗ nhẹ, bạn có muốn gọi điện cho bạn bè than thở không? Gọi đi, miễn phí mà.', severityLevel: 1, emoji: '📞'),
    MemeTemplate(id: 'll_011', condition: MemeCondition.lossLight, title: 'Thấy sai sai', content: 'Bạn có biết cảm giác "mua ở đỉnh" không? Chắc là có rồi, lỗ thế này mà.', severityLevel: 1, emoji: '🏔️'),
    MemeTemplate(id: 'll_012', condition: MemeCondition.lossLight, title: 'Thấy sai sai', content: 'Lỗ vài phần trăm, bạn có tính "cắt lỗ" không hay vẫn "kiên nhẫn"?', severityLevel: 1, emoji: '✂️'),
    MemeTemplate(id: 'll_013', condition: MemeCondition.lossLight, title: 'Thấy sai sai', content: 'Bạn có soi app lúc sáng sớm không? Thấy gì không hay vẫn lỗ?', severityLevel: 1, emoji: '🌅'),
    MemeTemplate(id: 'll_014', condition: MemeCondition.lossLight, title: 'Thấy sai sai', content: 'Lỗ nhẹ, bạn có tự hỏi "mình có mua đúng thời điểm không" chưa?', severityLevel: 1, emoji: '⏰'),
    MemeTemplate(id: 'll_015', condition: MemeCondition.lossLight, title: 'Thấy sai sai', content: 'Bạn có biết câu "vàng giữ giá" không? Giữ giá thì lỗ gì thế này?', severityLevel: 1, emoji: '🤷'),
    MemeTemplate(id: 'll_016', condition: MemeCondition.lossLight, title: 'Thấy sai sai', content: 'Lỗ chút xíu, bạn có muốn đăng status "thất tình" không? Lỗ cũng giống thất tình mà.', severityLevel: 1, emoji: '💔'),
    MemeTemplate(id: 'll_017', condition: MemeCondition.lossLight, title: 'Thấy sai sai', content: 'Bạn có tính đi chùa cầu vàng lên không? Đi đi, không mất gì.', severityLevel: 1, emoji: '🛕'),
    MemeTemplate(id: 'll_018', condition: MemeCondition.lossLight, title: 'Thấy sai sai', content: 'Lỗ vài phần trăm, bạn có muốn nói "đầu tư dài hạn" không? Câu này quen quen đúng không?', severityLevel: 1, emoji: '📏'),
    MemeTemplate(id: 'll_019', condition: MemeCondition.lossLight, title: 'Thấy sai sai', content: 'Bạn có biết cảm giác "mua xong giá rớt, đợi giá lên thì không lên" không?', severityLevel: 1, emoji: '🎢'),
    MemeTemplate(id: 'll_020', condition: MemeCondition.lossLight, title: 'Thấy sai sai', content: 'Lỗ nhẹ, bạn có muốn ăn gì cho đỡ buồn không? Ăn phở đi, lỗ vài phần trăm mà.', severityLevel: 1, emoji: '🍜'),
    MemeTemplate(id: 'll_021', condition: MemeCondition.lossLight, title: 'Thấy sai sai', content: 'Bạn có soi giá vàng ở các tiệm khác nhau không? Thấy rẻ hơn chưa?', severityLevel: 1, emoji: '🔍'),
    MemeTemplate(id: 'll_022', condition: MemeCondition.lossLight, title: 'Thấy sai sai', content: 'Lỗ chút xíu, vợ bạn có biết không? Hay vẫn giấu như giấu tiền tiêu vặt?', severityLevel: 1, emoji: '🤫'),
    MemeTemplate(id: 'll_023', condition: MemeCondition.lossLight, title: 'Thấy sai sai', content: 'Bạn có biết câu "thị trường luôn đúng" không? Vậy sai là ai?', severityLevel: 1, emoji: '🤔'),
    MemeTemplate(id: 'll_024', condition: MemeCondition.lossLight, title: 'Thấy sai sai', content: 'Lỗ vài phần trăm, bạn có muốn hỏi "bao giờ về bờ" không? Câu hỏi thiêng liêng.', severityLevel: 1, emoji: '🏖️'),
    MemeTemplate(id: 'll_025', condition: MemeCondition.lossLight, title: 'Thấy sai sai', content: 'Bạn có mở app rồi thở dài không? Thở thôi, đừng thở dài quá mất sức.', severityLevel: 1, emoji: '😮‍💨'),
    MemeTemplate(id: 'll_026', condition: MemeCondition.lossLight, title: 'Thấy sai sai', content: 'Lỗ nhẹ, bạn có tự hỏi "có phải mình tham lam không" chưa? Mua cao quá mà.', severityLevel: 1, emoji: '😈'),
    MemeTemplate(id: 'll_027', condition: MemeCondition.lossLight, title: 'Thấy sai sai', content: 'Bạn có biết cảm giác "xem app sợ, tắt app nhớ" không?', severityLevel: 1, emoji: '😨'),
    MemeTemplate(id: 'll_028', condition: MemeCondition.lossLight, title: 'Thấy sai sai', content: 'Lỗ chút xíu, bạn có muốn đi ngủ sớm không? Ngủ cho quên.', severityLevel: 1, emoji: '🛌'),
    MemeTemplate(id: 'll_029', condition: MemeCondition.lossLight, title: 'Thấy sai sai', content: 'Bạn có tính "gom thêm để giảm giá hòa vốn" không? Cẩn thận gom rồi lỗ thêm đấy.', severityLevel: 1, emoji: '⚠️'),
    MemeTemplate(id: 'll_030', condition: MemeCondition.lossLight, title: 'Thấy sai sai', content: 'Lỗ vài phần trăm, bạn có thấy mình thành "nhà đầu tư bất đắc dĩ" chưa?', severityLevel: 1, emoji: '🤷'),
    MemeTemplate(id: 'll_031', condition: MemeCondition.lossLight, title: 'Thấy sai sai', content: 'Bạn có biết câu "không bán là chưa lỗ" không? Chắc là biết rồi, nghe hoài.', severityLevel: 1, emoji: '🔁'),
    MemeTemplate(id: 'll_032', condition: MemeCondition.lossLight, title: 'Thấy sai sai', content: 'Lỗ nhẹ, bạn có muốn nghe nhạc buồn không? Nghe đi, hợp mood lắm.', severityLevel: 1, emoji: '🎵'),
    MemeTemplate(id: 'll_033', condition: MemeCondition.lossLight, title: 'Thấy sai sai', content: 'Bạn có soi lại ngày mua vàng không? Ngày đó có gì đặc biệt không hay tại mình?', severityLevel: 1, emoji: '📅'),
    MemeTemplate(id: 'll_034', condition: MemeCondition.lossLight, title: 'Thấy sai sai', content: 'Lỗ chút xíu, bạn có muốn chụp màn hình gửi bạn bè than không? Gửi đi, ai cũng lỗ.', severityLevel: 1, emoji: '📸'),
    MemeTemplate(id: 'll_035', condition: MemeCondition.lossLight, title: 'Thấy sai sai', content: 'Bạn có biết cảm giác "mua vàng xong thấy tiệm bên cạnh rẻ hơn" không?', severityLevel: 1, emoji: '😖'),
  ];

  // ============================================================
  // LOSS MODERATE (-3% to -7%) - "Tim nhói" - heart starts hurting
  // ============================================================
  static const lossModerate = <MemeTemplate>[
    MemeTemplate(id: 'lmod_001', condition: MemeCondition.lossModerate, title: 'Tim nhói', content: 'Tim bạn có nhói không? Hay là tim đập nhanh hơn bình thường?', severityLevel: 2, emoji: '💔'),
    MemeTemplate(id: 'lmod_002', condition: MemeCondition.lossModerate, title: 'Tim nhói', content: 'Lỗ thế này, bạn có muốn gọi cho mẹ không? Mẹ sẽ hỏi "bao giờ về bờ".', severityLevel: 2, emoji: '📞'),
    MemeTemplate(id: 'lmod_003', condition: MemeCondition.lossModerate, title: 'Tim nhói', content: 'Bạn có biết cảm giác "mở app thấy đỏ, đóng app thấy buồn" không?', severityLevel: 2, emoji: '🔴'),
    MemeTemplate(id: 'lmod_004', condition: MemeCondition.lossModerate, title: 'Tim nhói', content: 'Lỗ vài phần trăm, bạn có muốn bắt đầu đọc sách về đầu tư giá trị không? Đọc đi, giờ thì muộn rồi.', severityLevel: 2, emoji: '📚'),
    MemeTemplate(id: 'lmod_005', condition: MemeCondition.lossModerate, title: 'Tim nhói', content: 'Bạn có soi app mỗi 5 phút không? Thấy gì chưa hay vẫn đỏ?', severityLevel: 2, emoji: '⏱️'),
    MemeTemplate(id: 'lmod_006', condition: MemeCondition.lossModerate, title: 'Tim nhói', content: 'Lỗ vừa vừa, bạn có tự hỏi "mình có mua ở đỉnh không" chưa? Chắc là có rồi.', severityLevel: 2, emoji: '🏔️'),
    MemeTemplate(id: 'lmod_007', condition: MemeCondition.lossModerate, title: 'Tim nhói', content: 'Bạn có biết câu "đầu tư dài hạn" không? Giờ là lúc áp dụng rồi đúng không?', severityLevel: 2, emoji: '📏'),
    MemeTemplate(id: 'lmod_008', condition: MemeCondition.lossModerate, title: 'Tim nhói', content: 'Lỗ thế này, bạn có muốn đi chùa không? Đi đi, cầu vàng lên.', severityLevel: 2, emoji: '🛕'),
    MemeTemplate(id: 'lmod_009', condition: MemeCondition.lossModerate, title: 'Tim nhói', content: 'Bạn có xem giá vàng các tiệm liên tục không? Thấy ai mua rẻ hơn mình chưa?', severityLevel: 2, emoji: '🔍'),
    MemeTemplate(id: 'lmod_010', condition: MemeCondition.lossModerate, title: 'Tim nhói', content: 'Lỗ vài phần trăm, bạn có muốn đổi avatar thành chữ "Lỗ" không? Thể hiện tinh thần.', severityLevel: 2, emoji: '😅'),
    MemeTemplate(id: 'lmod_011', condition: MemeCondition.lossModerate, title: 'Tim nhói', content: 'Bạn có biết cảm giác "thấy người ta lãi mà mình lỗ" không? Đau hơn lỗ đúng không?', severityLevel: 2, emoji: '😢'),
    MemeTemplate(id: 'lmod_012', condition: MemeCondition.lossModerate, title: 'Tim nhói', content: 'Lỗ vừa, bạn có muốn tự an ủi "còn hơn lỗ nhiều" không? Đúng, tích cực lên.', severityLevel: 2, emoji: '😌'),
    MemeTemplate(id: 'lmod_013', condition: MemeCondition.lossModerate, title: 'Tim nhói', content: 'Bạn có tính cắt lỗ không hay vẫn "kiên nhẫn"? Kiên nhẫn đến bao giờ?', severityLevel: 2, emoji: '⏳'),
    MemeTemplate(id: 'lmod_014', condition: MemeCondition.lossModerate, title: 'Tim nhói', content: 'Lỗ thế này, bạn có muốn ăn gì cho đỡ buồn không? Ăn đi, nhưng đừng ăn nhiều quá.', severityLevel: 2, emoji: '🍽️'),
    MemeTemplate(id: 'lmod_015', condition: MemeCondition.lossModerate, title: 'Tim nhói', content: 'Bạn có biết câu "vàng là tài sản đề kháng" không? Đề kháng gì mà lỗ thế này?', severityLevel: 2, emoji: '🛡️'),
    MemeTemplate(id: 'lmod_016', condition: MemeCondition.lossModerate, title: 'Tim nhói', content: 'Lỗ vài phần trăm, bạn có muốn kể cho bạn bè nghe không? Bạn bè cũng lỗ mà, chia sẻ đi.', severityLevel: 2, emoji: '🤝'),
    MemeTemplate(id: 'lmod_017', condition: MemeCondition.lossModerate, title: 'Tim nhói', content: 'Bạn có soi gương thấy mặt mình buồn không? Cười đi, lỗ rồi cười cho đời nó vui.', severityLevel: 2, emoji: '😄'),
    MemeTemplate(id: 'lmod_018', condition: MemeCondition.lossModerate, title: 'Tim nhói', content: 'Lỗ vừa, bạn có muốn nghe nhạc buồn không? Nghe đi, nước mắt chảy ra cho nhẹ lòng.', severityLevel: 2, emoji: '🎵'),
    MemeTemplate(id: 'lmod_019', condition: MemeCondition.lossModerate, title: 'Tim nhói', content: 'Bạn có biết cảm giác "mở app, thấy đỏ, đóng app, thấy đời tối" không?', severityLevel: 2, emoji: '🌑'),
    MemeTemplate(id: 'lmod_020', condition: MemeCondition.lossModerate, title: 'Tim nhói', content: 'Lỗ thế này, bạn có muốn xin việc thêm không? Làm thêm cho bù lỗ.', severityLevel: 2, emoji: '💼'),
    MemeTemplate(id: 'lmod_021', condition: MemeCondition.lossModerate, title: 'Tim nhói', content: 'Bạn có tính "gom thêm" không? Gom đi, nhưng nhớ là "đường dài mới biết đá dẻo dẻo".', severityLevel: 2, emoji: '🪙'),
    MemeTemplate(id: 'lmod_022', condition: MemeCondition.lossModerate, title: 'Tim nhói', content: 'Lỗ vài phần trăm, bạn có muốn đi ngủ sớm không? Ngủ đi, mai rồi tính.', severityLevel: 2, emoji: '🛌'),
    MemeTemplate(id: 'lmod_023', condition: MemeCondition.lossModerate, title: 'Tim nhói', content: 'Bạn có biết câu "không bán là chưa lỗ" không? Nghe xong thấy an ủi không?', severityLevel: 2, emoji: '🤞'),
    MemeTemplate(id: 'lmod_024', condition: MemeCondition.lossModerate, title: 'Tim nhói', content: 'Lỗ vừa, bạn có muốn đăng Facebook "ai lỗ vàng như mình không?" không? Sẽ có nhiều người like.', severityLevel: 2, emoji: '📱'),
    MemeTemplate(id: 'lmod_025', condition: MemeCondition.lossModerate, title: 'Tim nhói', content: 'Bạn có tính đọc lại lịch sử giá vàng không? Thấy gì không? Tại mình mua hớ.', severityLevel: 2, emoji: '📖'),
    MemeTemplate(id: 'lmod_026', condition: MemeCondition.lossModerate, title: 'Tim nhói', content: 'Lỗ thế này, bạn có muốn bắt đầu ăn chay không? Ăn chay cho tâm tĩnh, cho ví đỡ đau.', severityLevel: 2, emoji: '🥬'),
    MemeTemplate(id: 'lmod_027', condition: MemeCondition.lossModerate, title: 'Tim nhói', content: 'Bạn có biết cảm giác "người ta khoe lãi, mình khoe lỗ" không? Khổ lắm nói mãi.', severityLevel: 2, emoji: '😔'),
    MemeTemplate(id: 'lmod_028', condition: MemeCondition.lossModerate, title: 'Tim nhói', content: 'Lỗ vài phần trăm, bạn có muốn đi dạo không? Đi dạo cho đầu óc thoáng.', severityLevel: 2, emoji: '🚶'),
    MemeTemplate(id: 'lmod_029', condition: MemeCondition.lossModerate, title: 'Tim nhói', content: 'Bạn có tự hỏi "bao giờ về bờ" không? Câu hỏi thiêng liêng hơn cả "bao giờ lấy vợ".', severityLevel: 2, emoji: '🛕'),
    MemeTemplate(id: 'lmod_030', condition: MemeCondition.lossModerate, title: 'Tim nhói', content: 'Lỗ vừa, bạn có muốn viết nhật ký không? "Hôm nay lỗ vài phần trăm, thời tiết đẹp."', severityLevel: 2, emoji: '📔'),
    MemeTemplate(id: 'lmod_031', condition: MemeCondition.lossModerate, title: 'Tim nhói', content: 'Bạn có biết câu "thương mại thì có lãi lỗ, đầu tư thì chỉ có lỗ" không? Đùa thôi, đừng buồn.', severityLevel: 2, emoji: '😏'),
    MemeTemplate(id: 'lmod_032', condition: MemeCondition.lossModerate, title: 'Tim nhói', content: 'Lỗ thế này, bạn có muốn nghe lời khuyên không? Lời khuyên: "Đừng mua ở đỉnh nữa."', severityLevel: 2, emoji: '💡'),
    MemeTemplate(id: 'lmod_033', condition: MemeCondition.lossModerate, title: 'Tim nhói', content: 'Bạn có soi app lúc nửa đêm không? Thấy gì không hay vẫn đỏ?', severityLevel: 2, emoji: '🌙'),
    MemeTemplate(id: 'lmod_034', condition: MemeCondition.lossModerate, title: 'Tim nhói', content: 'Lỗ vài phần trăm, bạn có muốn đổi tên thành "Lỗ" không? Thể hiện tinh thần tự trào.', severityLevel: 2, emoji: '🤣'),
    MemeTemplate(id: 'lmod_035', condition: MemeCondition.lossModerate, title: 'Tim nhói', content: 'Bạn có biết cảm giác "xem app thấy lỗ, tắt app thấy đời đẹp" không? Tắt app đi.', severityLevel: 2, emoji: '🚫'),
    MemeTemplate(id: 'lmod_036', condition: MemeCondition.lossModerate, title: 'Tim nhói', content: 'Lỗ vừa, vợ bạn có biết chưa? Nếu chưa thì... biết rồi sẽ buồn thêm.', severityLevel: 2, emoji: '💔'),
    MemeTemplate(id: 'lmod_037', condition: MemeCondition.lossModerate, title: 'Tim nhói', content: 'Bạn có muốn bắt đầu sưu tầm meme lỗ không? Sưu tầm đi, lỗ nhiều thì cười nhiều.', severityLevel: 2, emoji: '😂'),
    MemeTemplate(id: 'lmod_038', condition: MemeCondition.lossModerate, title: 'Tim nhói', content: 'Lỗ vài phần trăm, bạn có thấy mình đang "tài trợ thanh khoản cho thị trường" không?', severityLevel: 2, emoji: '🤝'),
    MemeTemplate(id: 'lmod_039', condition: MemeCondition.lossModerate, title: 'Tim nhói', content: 'Bạn có biết câu "đầu tư vàng là đầu tư dài hạn" không? Dài hạn đến bao giờ vậy?', severityLevel: 2, emoji: '📏'),
    MemeTemplate(id: 'lmod_040', condition: MemeCondition.lossModerate, title: 'Tim nhói', content: 'Lỗ thế này, bạn có muốn mở tiệm vàng để bán đắt không? Vốn đâu mà mở.', severityLevel: 2, emoji: '🏪'),
  ];

  // ============================================================
  // LOSS HEAVY (-7% to -15%) - "Cần người ôm" - need a hug
  // ============================================================
  static const lossHeavy = <MemeTemplate>[
    MemeTemplate(id: 'lh_001', condition: MemeCondition.lossHeavy, title: 'Cần người ôm', content: 'Bạn có cần ôm không? Không phải ôm vàng, ôm mình.', severityLevel: 3, emoji: '🫂'),
    MemeTemplate(id: 'lh_002', condition: MemeCondition.lossHeavy, title: 'Cần người ôm', content: 'Lỗ nhiều thế, bạn có còn dám mở app không? Hay nhờ người khác mở thay?', severityLevel: 3, emoji: '🙈'),
    MemeTemplate(id: 'lh_003', condition: MemeCondition.lossHeavy, title: 'Cần người ôm', content: 'Bạn có biết cảm giác "mở app thấy đỏ chót, đóng app thấy đời đen" không?', severityLevel: 3, emoji: '🔴'),
    MemeTemplate(id: 'lh_004', condition: MemeCondition.lossHeavy, title: 'Cần người ôm', content: 'Lỗ nặng, bạn có muốn bắt đầu hành trình tâm linh không? Ngay bây giờ.', severityLevel: 3, emoji: '🧘'),
    MemeTemplate(id: 'lh_005', condition: MemeCondition.lossHeavy, title: 'Cần người ôm', content: 'Bạn có soi app rồi khóc không? Khóc đi, xong rồi tính tiếp.', severityLevel: 3, emoji: '😭'),
    MemeTemplate(id: 'lh_006', condition: MemeCondition.lossHeavy, title: 'Cần người ôm', content: 'Lỗ thế này, bạn có muốn gọi điện cho mẹ không? Mẹ sẽ nói "con có còn tiền ăn không?"', severityLevel: 3, emoji: '📞'),
    MemeTemplate(id: 'lh_007', condition: MemeCondition.lossHeavy, title: 'Cần người ôm', content: 'Bạn có biết câu "vàng không sai, sai là người mua" không? Nghe xong thấy sao?', severityLevel: 3, emoji: '🤔'),
    MemeTemplate(id: 'lh_008', condition: MemeCondition.lossHeavy, title: 'Cần người ôm', content: 'Lỗ nhiều, bạn có muốn đi chùa ở luôn không? Ở luôn cho tâm tĩnh.', severityLevel: 3, emoji: '🛕'),
    MemeTemplate(id: 'lh_009', condition: MemeCondition.lossHeavy, title: 'Cần người ôm', content: 'Bạn có soi gương thấy mặt mình già đi 10 tuổi không? Lỗ nặng thì ai mà trẻ được.', severityLevel: 3, emoji: '🪞'),
    MemeTemplate(id: 'lh_010', condition: MemeCondition.lossHeavy, title: 'Cần người ôm', content: 'Lỗ nặng, bạn có muốn đổi avatar thành "cần người ôm" không? Sẽ có người ôm.', severityLevel: 3, emoji: '🥺'),
    MemeTemplate(id: 'lh_011', condition: MemeCondition.lossHeavy, title: 'Cần người ôm', content: 'Bạn có biết cảm giác "thấy người ta khoe lãi, mình muốn tắt Facebook" không?', severityLevel: 3, emoji: '📱'),
    MemeTemplate(id: 'lh_012', condition: MemeCondition.lossHeavy, title: 'Cần người ôm', content: 'Lỗ thế này, bạn có tính "cắt lỗ" không? Cắt đi, còn chút tiền còn cơ hội.', severityLevel: 3, emoji: '✂️'),
    MemeTemplate(id: 'lh_013', condition: MemeCondition.lossHeavy, title: 'Cần người ôm', content: 'Bạn có muốn bắt đầu ăn chay trường không? Ăn chay cho nhẹ ví, nhẹ lòng.', severityLevel: 3, emoji: '🥬'),
    MemeTemplate(id: 'lh_014', condition: MemeCondition.lossHeavy, title: 'Cần người ôm', content: 'Lỗ nhiều, bạn có muốn nghe nhạc không? Nhạc buồn, nước mắt chảy cho nhẹ lòng.', severityLevel: 3, emoji: '🎵'),
    MemeTemplate(id: 'lh_015', condition: MemeCondition.lossHeavy, title: 'Cần người ôm', content: 'Bạn có biết câu "không bán là chưa lỗ" không? Nghe xong có thấy đỡ không? Không phải không.', severityLevel: 3, emoji: '🤞'),
    MemeTemplate(id: 'lh_016', condition: MemeCondition.lossHeavy, title: 'Cần người ôm', content: 'Lỗ nặng, bạn có muốn đi làm thêm không? Làm thêm 3 công cho bù lỗ.', severityLevel: 3, emoji: '💼'),
    MemeTemplate(id: 'lh_017', condition: MemeCondition.lossHeavy, title: 'Cần người ôm', content: 'Bạn có tính "gom thêm để giảm giá hòa vốn" không? Gom đi, nhưng nhớ "đường dài mới biết đá dẻo dẻo".', severityLevel: 3, emoji: '🪙'),
    MemeTemplate(id: 'lh_018', condition: MemeCondition.lossHeavy, title: 'Cần người ôm', content: 'Lỗ thế này, bạn có muốn viết di chúc không? Đùa thôi, vàng để lại cho con cháu.', severityLevel: 3, emoji: '📝'),
    MemeTemplate(id: 'lh_019', condition: MemeCondition.lossHeavy, title: 'Cần người ôm', content: 'Bạn có biết cảm giác "mua vàng ở đỉnh, đỉnh nào cũng được" không? Đỉnh nào cũng lỗ.', severityLevel: 3, emoji: '🏔️'),
    MemeTemplate(id: 'lh_020', condition: MemeCondition.lossHeavy, title: 'Cần người ôm', content: 'Lỗ nhiều, bạn có muốn bắt đầu hành trình "đầu tư dài hạn bất đắc dĩ" không? Chào mừng.', severityLevel: 3, emoji: '♾️'),
    MemeTemplate(id: 'lh_021', condition: MemeCondition.lossHeavy, title: 'Cần người ôm', content: 'Bạn có soi app 100 lần một ngày không? Soi thêm cũng không đổi màu từ đỏ sang xanh.', severityLevel: 3, emoji: '🔄'),
    MemeTemplate(id: 'lh_022', condition: MemeCondition.lossHeavy, title: 'Cần người ôm', content: 'Lỗ nặng, bạn có muốn xin việc bán vàng không? Ít nhất được sờ vàng mỗi ngày.', severityLevel: 3, emoji: '🏪'),
    MemeTemplate(id: 'lh_023', condition: MemeCondition.lossHeavy, title: 'Cần người ôm', content: 'Bạn có biết câu "vàng vẫn sáng, chỉ có tài khoản là tối" không? Cảm nhận được chưa?', severityLevel: 3, emoji: '🌑'),
    MemeTemplate(id: 'lh_024', condition: MemeCondition.lossHeavy, title: 'Cần người ôm', content: 'Lỗ thế này, bạn có muốn bắt đầu sưu tầm câu nói hay không? "Lỗ là mẹ thành công" - chưa thấy thành công đâu.', severityLevel: 3, emoji: '📖'),
    MemeTemplate(id: 'lh_025', condition: MemeCondition.lossHeavy, title: 'Cần người ôm', content: 'Bạn có muốn đi xin xăm ở chùa không? Xin xăm cho tâm tĩnh, cho ví đỡ đau.', severityLevel: 3, emoji: '🛕'),
    MemeTemplate(id: 'lh_026', condition: MemeCondition.lossHeavy, title: 'Cần người ôm', content: 'Lỗ nhiều, bạn có biết cảm giác "đang đi đường thấy ai cũng giàu hơn mình" không?', severityLevel: 3, emoji: '🚶'),
    MemeTemplate(id: 'lh_027', condition: MemeCondition.lossHeavy, title: 'Cần người ôm', content: 'Bạn có muốn đăng status "tôi cần người ôm" không? Sẽ có người like, sẽ có người ôm.', severityLevel: 3, emoji: '🤗'),
    MemeTemplate(id: 'lh_028', condition: MemeCondition.lossHeavy, title: 'Cần người ôm', content: 'Lỗ nặng, bạn có muốn bắt đầu uống trà đạo không? Trà cho tâm tĩnh, cho tim đỡ nhói.', severityLevel: 3, emoji: '🍵'),
    MemeTemplate(id: 'lh_029', condition: MemeCondition.lossHeavy, title: 'Cần người ôm', content: 'Bạn có biết câu "đầu tư vàng là đề kháng lạm phát" không? Đề kháng gì mà lỗ thế này?', severityLevel: 3, emoji: '🛡️'),
    MemeTemplate(id: 'lh_030', condition: MemeCondition.lossHeavy, title: 'Cần người ôm', content: 'Lỗ thế này, bạn có muốn kể cho con cháu nghe không? "Ngày xưa ông/bà cũng từng lỗ."', severityLevel: 3, emoji: '👴'),
    MemeTemplate(id: 'lh_031', condition: MemeCondition.lossHeavy, title: 'Cần người ôm', content: 'Bạn có muốn bắt đầu đọc sách "Nghèo làm giàu" không? Đọc đi, lỗ rồi thì đọc cho khuây khỏa.', severityLevel: 3, emoji: '📚'),
    MemeTemplate(id: 'lh_032', condition: MemeCondition.lossHeavy, title: 'Cần người ôm', content: 'Lỗ nhiều, bạn có muốn đổi số điện thoại không? Để chủ nợ không gọi được. Đùa thôi, không có chủ nợ.', severityLevel: 3, emoji: '📞'),
    MemeTemplate(id: 'lh_033', condition: MemeCondition.lossHeavy, title: 'Cần người ôm', content: 'Bạn có biết cảm giác "mở app thấy lỗ, đóng app thấy đời trôi qua" không?', severityLevel: 3, emoji: '🌊'),
    MemeTemplate(id: 'lh_034', condition: MemeCondition.lossHeavy, title: 'Cần người ôm', content: 'Lỗ nặng, bạn có muốn bắt đầu tập yoga không? Yoga cho tâm tĩnh, cho ví đỡ đau.', severityLevel: 3, emoji: '🧘‍♂️'),
    MemeTemplate(id: 'lh_035', condition: MemeCondition.lossHeavy, title: 'Cần người ôm', content: 'Bạn có muốn gửi tin nhắn cho bản thân tương lai không? "Tương lai ơi, vàng lên chưa?"', severityLevel: 3, emoji: '✉️'),
    MemeTemplate(id: 'lh_036', condition: MemeCondition.lossHeavy, title: 'Cần người ôm', content: 'Lỗ thế này, bạn có thấy mình thành "cổ đông bất đắc dỹ" chưa? Chào mừng câu lạc bộ.', severityLevel: 3, emoji: '🎫'),
    MemeTemplate(id: 'lh_037', condition: MemeCondition.lossHeavy, title: 'Cần người ôm', content: 'Bạn có biết câu "lỗ hôm nay, bài học ngày mai" không? Bài học này đắt quá.', severityLevel: 3, emoji: '💡'),
    MemeTemplate(id: 'lh_038', condition: MemeCondition.lossHeavy, title: 'Cần người ôm', content: 'Lỗ nhiều, bạn có muốn đi dạo ngoài đường không? Nhìn người ta may mắn hơn mình cho đỡ lỗ.', severityLevel: 3, emoji: '🚶'),
    MemeTemplate(id: 'lh_039', condition: MemeCondition.lossHeavy, title: 'Cần người ôm', content: 'Bạn có muốn viết thơ không? "Vàng ơi sao nỡ rời xa ta, để ta lõa lồ giữa chợ đời."', severityLevel: 3, emoji: '✍️'),
    MemeTemplate(id: 'lh_040', condition: MemeCondition.lossHeavy, title: 'Cần người ôm', content: 'Lỗ nặng, bạn có biết rằng bạn không cô đơn không? Cả làng đang lỗ mà.', severityLevel: 3, emoji: '🏘️'),
  ];

  // ============================================================
  // LOSS SPIRITUAL (< -15%) - "Lỗ tâm linh" - spiritual loss mode
  // ============================================================
  static const lossSpiritual = <MemeTemplate>[
    MemeTemplate(id: 'ls_001', condition: MemeCondition.lossSpiritual, title: 'Lỗ tâm linh', content: 'Bạn đã mở khóa "cổ đông bất đắc dỹ vĩnh viễn" chưa? Chúc mừng.', severityLevel: 4, emoji: '🧿'),
    MemeTemplate(id: 'ls_002', condition: MemeCondition.lossSpiritual, title: 'Lỗ tâm linh', content: 'Bao giờ về bờ? Câu hỏi thiêng liêng hơn cả "bao giờ lấy vợ".', severityLevel: 4, emoji: '🛕'),
    MemeTemplate(id: 'ls_003', condition: MemeCondition.lossSpiritual, title: 'Lỗ tâm linh', content: 'Bạn có biết cảm giác "vàng để dành cho đời sau" không? Đời sau mấy đời nữa?', severityLevel: 4, emoji: '♾️'),
    MemeTemplate(id: 'ls_004', condition: MemeCondition.lossSpiritual, title: 'Lỗ tâm linh', content: 'Lỗ tâm linh rồi, bạn có muốn xuất gia không? Xuất gia cho nhẹ lòng, nhẹ ví.', severityLevel: 4, emoji: '🧘'),
    MemeTemplate(id: 'ls_005', condition: MemeCondition.lossSpiritual, title: 'Lỗ tâm linh', content: 'Bạn có soi app rồi cười buồn không? Cười buồn vì lỗ quá nên cười bù.', severityLevel: 4, emoji: '😅'),
    MemeTemplate(id: 'ls_006', condition: MemeCondition.lossSpiritual, title: 'Lỗ tâm linh', content: 'Lỗ thế này, bạn có còn tin vào "vàng giữ giá" không? Giữ giá gì mà lỗ tâm linh.', severityLevel: 4, emoji: '🤔'),
    MemeTemplate(id: 'ls_007', condition: MemeCondition.lossSpiritual, title: 'Lỗ tâm linh', content: 'Bạn có muốn xin số điện thoại thầy tu không? Thầy tu xem vận hạn cho.', severityLevel: 4, emoji: '🙏'),
    MemeTemplate(id: 'ls_008', condition: MemeCondition.lossSpiritual, title: 'Lỗ tâm linh', content: 'Lỗ tâm linh, bạn có biết câu "đầu tư dài hạn bất đắc dỹ" không? Chào mừng.', severityLevel: 4, emoji: '📏'),
    MemeTemplate(id: 'ls_009', condition: MemeCondition.lossSpiritual, title: 'Lỗ tâm linh', content: 'Bạn có muốn viết di chúc "vàng để cho cháu" không? Cháu nhận xong lỗ tiếp.', severityLevel: 4, emoji: '📝'),
    MemeTemplate(id: 'ls_010', condition: MemeCondition.lossSpiritual, title: 'Lỗ tâm linh', content: 'Lỗ thế này, bạn có thấy mình thành "thiền sư vàng" chưa? Thiền cho tâm tĩnh, cho ví đỡ đau.', severityLevel: 4, emoji: '🧘‍♂️'),
    MemeTemplate(id: 'ls_011', condition: MemeCondition.lossSpiritual, title: 'Lỗ tâm linh', content: 'Bạn có biết cảm giác "mở app, thấy đỏ, đóng app, thấy cuộc đời là bể khổ" không?', severityLevel: 4, emoji: '🍂'),
    MemeTemplate(id: 'ls_012', condition: MemeCondition.lossSpiritual, title: 'Lỗ tâm linh', content: 'Lỗ tâm linh, bạn có muốn đổi tên thành "Lỗ Tâm Linh" không? Thể hiện tinh thần.', severityLevel: 4, emoji: '🤣'),
    MemeTemplate(id: 'ls_013', condition: MemeCondition.lossSpiritual, title: 'Lỗ tâm linh', content: 'Bạn có muốn đi chùa ở luôn không? Ở luôn cho nhẹ lòng, nhẹ ví, nhẹ mọi thứ.', severityLevel: 4, emoji: '🛕'),
    MemeTemplate(id: 'ls_014', condition: MemeCondition.lossSpiritual, title: 'Lỗ tâm linh', content: 'Lỗ thế này, bạn có còn dám mở app không? Hay nhờ người khác mở rồi báo kết quả?', severityLevel: 4, emoji: '🙈'),
    MemeTemplate(id: 'ls_015', condition: MemeCondition.lossSpiritual, title: 'Lỗ tâm linh', content: 'Bạn có biết câu "vàng không sai, sai là thời điểm" không? Và bạn chọn sai thời điểm.', severityLevel: 4, emoji: '⏰'),
    MemeTemplate(id: 'ls_016', condition: MemeCondition.lossSpiritual, title: 'Lỗ tâm linh', content: 'Lỗ tâm linh, bạn có muốn bắt đầu hành trình "hóa giải nghiệp lực" không? Nghiệp mua ở đỉnh.', severityLevel: 4, emoji: '🔮'),
    MemeTemplate(id: 'ls_017', condition: MemeCondition.lossSpiritual, title: 'Lỗ tâm linh', content: 'Bạn có soi gương thấy mình thành thiền sư chưa? Lỗ thế này thì thiền là chân ái.', severityLevel: 4, emoji: '🪞'),
    MemeTemplate(id: 'ls_018', condition: MemeCondition.lossSpiritual, title: 'Lỗ tâm linh', content: 'Lỗ thế này, bạn có muốn viết sách "Nghệ thuật lỗ vàng" không? Best seller chắc.', severityLevel: 4, emoji: '📖'),
    MemeTemplate(id: 'ls_019', condition: MemeCondition.lossSpiritual, title: 'Lỗ tâm linh', content: 'Bạn có biết cảm giác "thấy ai cũng giàu, chỉ mình lỗ tâm linh" không? Đừng buồn, ai cũng lỗ.', severityLevel: 4, emoji: '😔'),
    MemeTemplate(id: 'ls_020', condition: MemeCondition.lossSpiritual, title: 'Lỗ tâm linh', content: 'Lỗ tâm linh, bạn có muốn bắt đầu sống thanh tịnh không? Thanh tịnh cho ví đỡ đau.', severityLevel: 4, emoji: '🌿'),
    MemeTemplate(id: 'ls_021', condition: MemeCondition.lossSpiritual, title: 'Lỗ tâm linh', content: 'Bạn có muốn gửi email cho tương lai không? "Tương lai ơi, 10 năm nữa vàng lên chưa?"', severityLevel: 4, emoji: '📧'),
    MemeTemplate(id: 'ls_022', condition: MemeCondition.lossSpiritual, title: 'Lỗ tâm linh', content: 'Lỗ thế này, bạn có biết câu "đầu tư vàng là đầu tư cho thế hệ sau" không? Thế hệ sau mấy đời?', severityLevel: 4, emoji: '👶'),
    MemeTemplate(id: 'ls_023', condition: MemeCondition.lossSpiritual, title: 'Lỗ tâm linh', content: 'Bạn có muốn bắt đầu ăn chay trường không? Ăn chay cho nhẹ nghiệp, nhẹ ví.', severityLevel: 4, emoji: '🥬'),
    MemeTemplate(id: 'ls_024', condition: MemeCondition.lossSpiritual, title: 'Lỗ tâm linh', content: 'Lỗ tâm linh, bạn có muốn mở lớp dạy "cách lỗ vàng" không? Học phí cao, học viên chắc đông.', severityLevel: 4, emoji: '👨‍🏫'),
    MemeTemplate(id: 'ls_025', condition: MemeCondition.lossSpiritual, title: 'Lỗ tâm linh', content: 'Bạn có biết cảm giác "đang ngồi thiền, mở mắt ra thấy vẫn lỗ" không? Thiền cũng không cứu được.', severityLevel: 4, emoji: '🧘'),
    MemeTemplate(id: 'ls_026', condition: MemeCondition.lossSpiritual, title: 'Lỗ tâm linh', content: 'Lỗ thế này, bạn có muốn đi hành hương không? Hành hương cho nhẹ nghiệp, nhẹ ví.', severityLevel: 4, emoji: '🚶'),
    MemeTemplate(id: 'ls_027', condition: MemeCondition.lossSpiritual, title: 'Lỗ tâm linh', content: 'Bạn có muốn đổi số điện thoại không? Để ai cũng không liên lạc được, thanh tịnh.', severityLevel: 4, emoji: '📞'),
    MemeTemplate(id: 'ls_028', condition: MemeCondition.lossSpiritual, title: 'Lỗ tâm linh', content: 'Lỗ tâm linh, bạn có biết câu "vàng là vàng, ta là ta" không? Vàng không lỗ, ta lỗ.', severityLevel: 4, emoji: '🪙'),
    MemeTemplate(id: 'ls_029', condition: MemeCondition.lossSpiritual, title: 'Lỗ tâm linh', content: 'Bạn có muốn viết nhật ký "Hành trình lỗ tâm linh" không? Best seller chắc.', severityLevel: 4, emoji: '📔'),
    MemeTemplate(id: 'ls_030', condition: MemeCondition.lossSpiritual, title: 'Lỗ tâm linh', content: 'Lỗ thế này, bạn có thấy mình thành "đại sứ lỗ vàng" chưa? Đại sứ cho những người lỗ.', severityLevel: 4, emoji: '👑'),
    MemeTemplate(id: 'ls_031', condition: MemeCondition.lossSpiritual, title: 'Lỗ tâm linh', content: 'Bạn có biết cảm giác "nghe tin vàng lên, mở app thấy vẫn lỗ" không? Vàng lên cho ai đâu cho mình.', severityLevel: 4, emoji: '📈'),
    MemeTemplate(id: 'ls_032', condition: MemeCondition.lossSpiritual, title: 'Lỗ tâm linh', content: 'Lỗ tâm linh, bạn có muốn bắt đầu sưu tầm câu "bao giờ về bờ" không? Sưu tầm đi, về bờ không biết bao giờ.', severityLevel: 4, emoji: '🏖️'),
    MemeTemplate(id: 'ls_033', condition: MemeCondition.lossSpiritual, title: 'Lỗ tâm linh', content: 'Bạn có muốn xin xăm ở chùa không? Xin xăm cho hóa giải nghiệp lực.', severityLevel: 4, emoji: '🛕'),
    MemeTemplate(id: 'ls_034', condition: MemeCondition.lossSpiritual, title: 'Lỗ tâm linh', content: 'Lỗ thế này, bạn có biết rằng "lỗ tâm linh" là cấp độ cao nhất không? Xin chúc mừng.', severityLevel: 4, emoji: '🏆'),
    MemeTemplate(id: 'ls_035', condition: MemeCondition.lossSpiritual, title: 'Lỗ tâm linh', content: 'Bạn có muốn bắt đầu tập thiền tĩnh tâm không? Thiền cho đỡ nghĩ về lỗ.', severityLevel: 4, emoji: '🧘'),
    MemeTemplate(id: 'ls_036', condition: MemeCondition.lossSpiritual, title: 'Lỗ tâm linh', content: 'Lỗ tâm linh, bạn có còn nhớ mình từng có tiền không? Nhớ để biết mình từng giàu.', severityLevel: 4, emoji: '💭'),
    MemeTemplate(id: 'ls_037', condition: MemeCondition.lossSpiritual, title: 'Lỗ tâm linh', content: 'Bạn có muốn đăng status "tôi đã giác ngộ" không? Giác ngộ rằng lỗ là chân lý.', severityLevel: 4, emoji: '🪷'),
    MemeTemplate(id: 'ls_038', condition: MemeCondition.lossSpiritual, title: 'Lỗ tâm linh', content: 'Lỗ thế này, bạn có biết câu "khổ rồi mới ngộ" không? Ngộ rồi thì đừng mua ở đỉnh nữa.', severityLevel: 4, emoji: '💡'),
    MemeTemplate(id: 'ls_039', condition: MemeCondition.lossSpiritual, title: 'Lỗ tâm linh', content: 'Bạn có muốn bắt đầu viết thơ "Lỗ tâm linh" không? Thơ cho nhẹ lòng, nhẹ ví.', severityLevel: 4, emoji: '✍️'),
    MemeTemplate(id: 'ls_040', condition: MemeCondition.lossSpiritual, title: 'Lỗ tâm linh', content: 'Lỗ tâm linh, bạn có biết rằng bạn không cô đơn không? Cả làng đang lỗ tâm linh.', severityLevel: 4, emoji: '🏘️'),
  ];
}
