import '../services/portfolio_service.dart';

/// ExportService - Handles data export to CSV and JSON formats.
/// Also handles local data backup.
class ExportService {
  static ExportService? _instance;
  static ExportService get instance => _instance ??= ExportService._();

  ExportService._();

  /// Export holdings as CSV string
  String exportToCSV() {
    final holdings = PortfolioService.instance.exportHoldings();

    final buffer = StringBuffer();
    // CSV Header
    buffer.writeln(
        'Loại Vàng,Số Lượng,Đơn Vị,Tương Đương (Lượng),Giá Mua/Lượng (VNĐ),Phí (VNĐ),Tổng Vốn (VNĐ),Ngày Mua,Trạng Thái,Ghi Chú');

    for (final h in holdings) {
      buffer.writeln(
        '"${h['goldType']}",'
        '${h['quantity']},'
        '"${h['unit']}",'
        '${h['quantityInLuong'].toStringAsFixed(4)},'
        '${h['buyPricePerLuong'].round()},'
        '${h['fee'].round()},'
        '${h['totalCost'].round()},'
        '${h['buyDate']},'
        '"${h['status']}",'
        '"${h['note']}"',
      );
    }

    return buffer.toString();
  }

  /// Export holdings as JSON string
  String exportToJSON() {
    final holdings = PortfolioService.instance.exportHoldings();
    final buffer = StringBuffer();
    buffer.writeln('{');
    buffer.writeln('  "exportDate": "${DateTime.now().toIso8601String()}",');
    buffer.writeln('  "appVersion": "1.0.0",');
    buffer.writeln('  "holdings": [');

    for (int i = 0; i < holdings.length; i++) {
      final h = holdings[i];
      buffer.writeln('    {');
      buffer.writeln('      "goldType": "${h['goldType']}",');
      buffer.writeln('      "quantity": ${h['quantity']},');
      buffer.writeln('      "unit": "${h['unit']}",');
      buffer.writeln('      "quantityInLuong": ${h['quantityInLuong']},');
      buffer.writeln('      "buyPricePerLuong": ${h['buyPricePerLuong'].round()},');
      buffer.writeln('      "fee": ${h['fee'].round()},');
      buffer.writeln('      "totalCost": ${h['totalCost'].round()},');
      buffer.writeln('      "buyDate": "${h['buyDate']}",');
      buffer.writeln('      "status": "${h['status']}",');
      buffer.writeln('      "note": "${h['note']}"');
      buffer.write('    }${i < holdings.length - 1 ? ',' : ''}');
      buffer.writeln();
    }

    buffer.writeln('  ]');
    buffer.write('}');

    return buffer.toString();
  }

  /// Create a backup string (same as JSON export but with more metadata)
  String createBackup() {
    return exportToJSON();
  }

  /// Parse CSV content (for import - future feature)
  List<Map<String, String>> parseCSV(String csvContent) {
    final lines = csvContent.split('\n');
    if (lines.isEmpty) return [];

    final headers = lines.first.split(',');
    final results = <Map<String, String>>[];

    for (int i = 1; i < lines.length; i++) {
      if (lines[i].trim().isEmpty) continue;
      final values = _parseCSVLine(lines[i]);
      if (values.length == headers.length) {
        final row = <String, String>{};
        for (int j = 0; j < headers.length; j++) {
          row[headers[j].replaceAll('"', '')] = values[j].replaceAll('"', '');
        }
        results.add(row);
      }
    }

    return results;
  }

  List<String> _parseCSVLine(String line) {
    final result = <String>[];
    var current = StringBuffer();
    var inQuotes = false;

    for (int i = 0; i < line.length; i++) {
      final char = line[i];
      if (char == '"') {
        inQuotes = !inQuotes;
      } else if (char == ',' && !inQuotes) {
        result.add(current.toString().trim());
        current = StringBuffer();
      } else {
        current.write(char);
      }
    }
    result.add(current.toString().trim());
    return result;
  }
}
