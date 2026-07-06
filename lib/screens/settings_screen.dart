import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../constants/app_constants.dart';
import '../stores/app_store.dart';
import '../services/export_service.dart';
import '../components/ui_components.dart';

/// Settings screen - app settings, privacy, export, and about.
class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    final store = context.watch<AppStore>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cài đặt'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 80),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSectionTitle('Bảo mật'),
              _buildToggleTile(
                icon: Icons.visibility_off,
                title: 'Chế độ ẩn số',
                subtitle: 'Che giấu các số tiền trong ứng dụng',
                value: store.privacyMode,
                onChanged: (_) => store.togglePrivacyMode(),
              ),
              _buildToggleTile(
                icon: Icons.lock_outline,
                title: 'Mã PIN',
                subtitle: 'Yêu cầu mã PIN khi mở ứng dụng',
                value: store.pinEnabled,
                onChanged: (val) => _handlePinToggle(val, store),
              ),
              const SizedBox(height: 16),

              _buildSectionTitle('Hiển thị'),
              _buildToggleTile(
                icon: Icons.dark_mode,
                title: 'Chế độ tối',
                subtitle: 'Giao diện tối vàng-đen',
                value: store.isDarkMode,
                onChanged: (_) => store.toggleDarkMode(),
              ),
              _buildInfoTile(
                icon: Icons.monetization_on,
                title: 'Loại vàng ưu tiên',
                subtitle: _getGoldTypeName(store.preferredGoldTypeId, store),
                onTap: () => _showGoldTypePicker(context, store),
              ),
              const SizedBox(height: 16),

              _buildSectionTitle('Dữ liệu'),
              _buildActionTile(
                icon: Icons.file_download,
                title: 'Xuất CSV',
                subtitle: 'Xuất danh mục vàng ra file CSV',
                onTap: () => _exportData(context, 'csv'),
              ),
              _buildActionTile(
                icon: Icons.code,
                title: 'Xuất JSON',
                subtitle: 'Xuất dữ liệu ra file JSON (backup)',
                onTap: () => _exportData(context, 'json'),
              ),
              _buildActionTile(
                icon: Icons.delete_forever,
                title: 'Xóa tất cả dữ liệu',
                subtitle: 'Xóa toàn bộ danh mục và cài đặt',
                onTap: () => _showClearDataDialog(context),
                isDanger: true,
              ),
              const SizedBox(height: 16),

              _buildSectionTitle('Gói dịch vụ'),
              _buildPlanCard(store),
              const SizedBox(height: 16),

              _buildSectionTitle('Thông tin & Pháp lý'),
              _buildActionTile(
                icon: Icons.info_outline,
                title: 'Miễn trừ trách nhiệm',
                subtitle: 'Thông tin chỉ mang tính tham khảo',
                onTap: () => _showDisclaimerDialog(context),
              ),
              _buildActionTile(
                icon: Icons.privacy_tip_outlined,
                title: 'Chính sách bảo mật',
                subtitle: 'Dữ liệu của bạn được lưu trên thiết bị',
                onTap: () => _showPrivacyDialog(context),
              ),
              _buildActionTile(
                icon: Icons.star_outline,
                title: 'Về ứng dụng Lỗ',
                subtitle: 'Phiên bản 1.0.0 - Gold Loss Tracker',
                onTap: () => _showAboutDialog(context),
              ),
              const SizedBox(height: 16),

              // Disclaimer bar at bottom
              _buildDisclaimerBar(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
      child: Text(
        title,
        style: const TextStyle(
          color: AppColors.gold,
          fontSize: 13,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.8,
        ),
      ),
    );
  }

  Widget _buildToggleTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return AppCard(
      child: Row(
        children: [
          Icon(icon, color: AppColors.gold, size: 24),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: AppColors.textHint,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: AppColors.gold,
          ),
        ],
      ),
    );
  }

  Widget _buildActionTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    bool isDanger = false,
  }) {
    final color = isDanger ? AppColors.loss : AppColors.gold;
    return AppCard(
      onTap: onTap,
      child: Row(
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: isDanger ? AppColors.loss : AppColors.textPrimary,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: AppColors.textHint,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          Icon(Icons.chevron_right, color: AppColors.textHint, size: 20),
        ],
      ),
    );
  }

  Widget _buildInfoTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return AppCard(
      onTap: onTap,
      child: Row(
        children: [
          Icon(icon, color: AppColors.gold, size: 24),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
          Icon(Icons.chevron_right, color: AppColors.textHint, size: 20),
        ],
      ),
    );
  }

  Widget _buildPlanCard(AppStore store) {
    final isPro = AppConstants.isPro;
    final activeCount = store.activeHoldings.length;
    final maxHoldings = AppConstants.freeTierMaxHoldings;

    return AppCard(
      color: isPro ? const Color(0xFF2A2520) : AppColors.bgCard,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                isPro ? Icons.workspace_premium : Icons.free_breakfast,
                color: AppColors.gold,
                size: 28,
              ),
              const SizedBox(width: 12),
              Text(
                isPro ? 'Lỗ Pro' : 'Lỗ Free',
                style: const TextStyle(
                  color: AppColors.gold,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              if (isPro)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: AppColors.gold,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text(
                    'PRO',
                    style: TextStyle(
                      color: AppColors.bgPrimary,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 16),
          if (!isPro) ...[
            _planFeature('Tối đa $maxHoldings vị thế vàng', activeCount < maxHoldings),
            const _PlanFeatureItem(text: 'Theo dõi lãi/lỗ realtime', isIncluded: true),
            const _PlanFeatureItem(text: 'Meme an ủi', isIncluded: true),
            const _PlanFeatureItem(text: 'Cảnh báo giá cơ bản', isIncluded: true),
            const _PlanFeatureItem(text: 'Không giới hạn vị thế', isIncluded: false),
            const _PlanFeatureItem(text: 'Biểu đồ nâng cao', isIncluded: false),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => _showUpgradeDialog(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.gold,
                  foregroundColor: AppColors.bgPrimary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text('Nâng cấp lên Pro'),
              ),
            ),
          ] else ...[
            const _PlanFeatureItem(text: 'Không giới hạn vị thế vàng', isIncluded: true),
            const _PlanFeatureItem(text: 'Tất cả tính năng Pro', isIncluded: true),
            const _PlanFeatureItem(text: 'Biểu đồ nâng cao', isIncluded: true),
            const _PlanFeatureItem(text: 'Xuất dữ liệu không giới hạn', isIncluded: true),
          ],
        ],
      ),
    );
  }

  Widget _planFeature(String text, bool isIncluded) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        children: [
          Icon(
            isIncluded ? Icons.check_circle : Icons.remove_circle_outline,
            color: isIncluded ? AppColors.profit : AppColors.textHint,
            size: 18,
          ),
          const SizedBox(width: 8),
          Text(
            text,
            style: TextStyle(
              color: isIncluded ? AppColors.textPrimary : AppColors.textHint,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDisclaimerBar() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.bgSecondary,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.divider),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.info_outline, size: 16, color: AppColors.textHint),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              AppConstants.disclaimer,
              style: const TextStyle(
                color: AppColors.textHint,
                fontSize: 11,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _getGoldTypeName(String id, AppStore store) {
    final gt = store.getGoldType(id);
    return gt?.displayName ?? id;
  }

  void _showGoldTypePicker(BuildContext context, AppStore store) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.bgCard,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  'Chọn loại vàng ưu tiên',
                  style: TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              ...store.goldTypes.map((gt) {
                final selected = gt.id == store.preferredGoldTypeId;
                return ListTile(
                  leading: Icon(
                    selected ? Icons.radio_button_checked : Icons.radio_button_off,
                    color: AppColors.gold,
                  ),
                  title: Text(
                    gt.displayName,
                    style: TextStyle(
                      color: selected ? AppColors.gold : AppColors.textPrimary,
                    ),
                  ),
                  onTap: () {
                    store.setPreferredGoldType(gt.id);
                    Navigator.pop(ctx);
                  },
                );
              }),
              const SizedBox(height: 8),
            ],
          ),
        );
      },
    );
  }

  void _handlePinToggle(bool enable, AppStore store) {
    if (enable) {
      _showPinEntryDialog(context, store);
    } else {
      store.setPinEnabled(false);
    }
  }

  void _showPinEntryDialog(BuildContext context, AppStore store) {
    final ctrl1 = TextEditingController();
    final ctrl2 = TextEditingController();
    String? error;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) {
        return StatefulBuilder(
          builder: (ctx, setState) {
            return AlertDialog(
              backgroundColor: AppColors.bgCard,
              title: const Text(
                'Đặt mã PIN',
                style: TextStyle(color: AppColors.textPrimary),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: ctrl1,
                    keyboardType: TextInputType.number,
                    obscureText: true,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    maxLength: 6,
                    decoration: const InputDecoration(
                      labelText: 'Mã PIN (4-6 số)',
                      labelStyle: TextStyle(color: AppColors.textHint),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: AppColors.divider),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: AppColors.gold),
                      ),
                    ),
                    style: const TextStyle(color: AppColors.textPrimary),
                  ),
                  TextField(
                    controller: ctrl2,
                    keyboardType: TextInputType.number,
                    obscureText: true,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    maxLength: 6,
                    decoration: const InputDecoration(
                      labelText: 'Nhập lại mã PIN',
                      labelStyle: TextStyle(color: AppColors.textHint),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: AppColors.divider),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: AppColors.gold),
                      ),
                    ),
                    style: const TextStyle(color: AppColors.textPrimary),
                  ),
                  if (error != null) ...[
                    const SizedBox(height: 8),
                    Text(
                      error!,
                      style: const TextStyle(color: AppColors.loss, fontSize: 13),
                    ),
                  ],
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(ctx);
                  },
                  child: const Text('Hủy', style: TextStyle(color: AppColors.textSecondary)),
                ),
                ElevatedButton(
                  onPressed: () {
                    final pin1 = ctrl1.text.trim();
                    final pin2 = ctrl2.text.trim();
                    if (pin1.length < 4) {
                      setState(() => error = 'PIN phải có 4-6 số');
                      return;
                    }
                    if (pin1 != pin2) {
                      setState(() => error = 'Mã PIN không khớp');
                      return;
                    }
                    store.setPinEnabled(true, pin: pin1);
                    Navigator.pop(ctx);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Đã bật mã PIN'),
                        backgroundColor: AppColors.profit,
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.gold,
                    foregroundColor: AppColors.bgPrimary,
                  ),
                  child: const Text('Xác nhận'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _exportData(BuildContext context, String format) {
    final export = ExportService.instance;
    String data;
    String fileName;

    if (format == 'csv') {
      data = export.exportToCSV();
      fileName = 'lo_holdings.csv';
    } else {
      data = export.exportToJSON();
      fileName = 'lo_backup.json';
    }

    Clipboard.setData(ClipboardData(text: data));

    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          backgroundColor: AppColors.bgCard,
          title: Text(
            'Xuất $format',
            style: const TextStyle(color: AppColors.textPrimary),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Dữ liệu đã được sao chép vào clipboard!',
                style: TextStyle(color: AppColors.profit, fontSize: 14),
              ),
              const SizedBox(height: 12),
              Text(
                'File: $fileName (${data.length} ký tự)',
                style: const TextStyle(color: AppColors.textSecondary, fontSize: 13),
              ),
              const SizedBox(height: 12),
              Container(
                constraints: const BoxConstraints(maxHeight: 200),
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.bgPrimary,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: SingleChildScrollView(
                  child: SelectableText(
                    data,
                    style: const TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 11,
                      fontFamily: 'monospace',
                    ),
                  ),
                ),
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () => Navigator.pop(ctx),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.gold,
                foregroundColor: AppColors.bgPrimary,
              ),
              child: const Text('Đóng'),
            ),
          ],
        );
      },
    );
  }

  void _showClearDataDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          backgroundColor: AppColors.bgCard,
          title: const Text(
            'Xóa tất cả dữ liệu?',
            style: TextStyle(color: AppColors.loss),
          ),
          content: const Text(
            'Tất cả danh mục vàng, cài đặt và cảnh báo sẽ bị xóa vĩnh viễn. '
            'Hành động này không thể hoàn tác.',
            style: TextStyle(color: AppColors.textSecondary),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('Hủy', style: TextStyle(color: AppColors.textSecondary)),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(ctx);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Chức năng xóa dữ liệu sẽ khả dụng trong phiên bản tới'),
                    backgroundColor: AppColors.warning,
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.loss,
                foregroundColor: Colors.white,
              ),
              child: const Text('Xóa tất cả'),
            ),
          ],
        );
      },
    );
  }

  void _showDisclaimerDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          backgroundColor: AppColors.bgCard,
          title: const Text(
            'Miễn trừ trách nhiệm',
            style: TextStyle(color: AppColors.gold),
          ),
          content: const SingleChildScrollView(
            child: Text(
              'Ứng dụng "Lỗ" - Lỗ nhiều chưa? - là công cụ theo dõi danh mục vàng cá nhân.\n\n'
              '• Thông tin về giá vàng chỉ mang tính tham khảo\n'
              '• Không phải là khuyến nghị mua/bán vàng\n'
              '• Người dùng tự chịu trách nhiệm về quyết định đầu tư\n'
              '• Giá vàng thực tế có thể chênh lệch tùy tiệm vàng\n'
              '• Dữ liệu có thể không cập nhật theo thời gian thực\n\n'
              'Hãy luôn tham khảo giá từ tiệm vàng hoặc nguồn uy tín '
              'trước khi thực hiện giao dịch.',
              style: TextStyle(color: AppColors.textSecondary, height: 1.5),
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () => Navigator.pop(ctx),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.gold,
                foregroundColor: AppColors.bgPrimary,
              ),
              child: const Text('Đã hiểu'),
            ),
          ],
        );
      },
    );
  }

  void _showPrivacyDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          backgroundColor: AppColors.bgCard,
          title: const Text(
            'Chính sách bảo mật',
            style: TextStyle(color: AppColors.gold),
          ),
          content: const SingleChildScrollView(
            child: Text(
              'Ứng dụng "Lỗ" (Lỗ nhiều chưa?) tôn trọng quyền riêng tư của bạn:\n\n'
              '• Tất cả dữ liệu được lưu trên thiết bị của bạn\n'
              '• Không có thông tin nào được gửi lên máy chủ\n'
              '• Không thu thập dữ liệu cá nhân\n'
              '• Không theo dõi hoạt động người dùng\n'
              '• Bạn có thể xóa dữ liệu bất cứ lúc nào\n\n'
              'Mã PIN (nếu bật) chỉ lưu cục bộ trên thiết bị. '
              'Chế độ ẩn số giúp che giấu thông tin khi người khác nhìn màn hình.',
              style: TextStyle(color: AppColors.textSecondary, height: 1.5),
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () => Navigator.pop(ctx),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.gold,
                foregroundColor: AppColors.bgPrimary,
              ),
              child: const Text('Đã hiểu'),
            ),
          ],
        );
      },
    );
  }

  void _showAboutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          backgroundColor: AppColors.bgCard,
          title: Row(
            children: [
              const Text(
                'Lỗ',
                style: TextStyle(
                  color: AppColors.gold,
                  fontSize: 28,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: AppColors.bgPrimary,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Text(
                  'v1.0.0',
                  style: TextStyle(color: AppColors.textHint, fontSize: 11),
                ),
              ),
            ],
          ),
          content: const Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Gold Loss Tracker',
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 12),
              Text(
                'Ứng dụng theo dõi lãi/lỗ vàng với phong cách meme '
                'dành cho người Việt mua vàng ở giá cao.',
                style: TextStyle(color: AppColors.textSecondary, height: 1.5),
              ),
              SizedBox(height: 12),
              Text(
                '"Bạn không cô đơn, cả làng đang lỗ."',
                style: TextStyle(
                  color: AppColors.gold,
                  fontSize: 14,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () => Navigator.pop(ctx),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.gold,
                foregroundColor: AppColors.bgPrimary,
              ),
              child: const Text('Đóng'),
            ),
          ],
        );
      },
    );
  }

  void _showUpgradeDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          backgroundColor: AppColors.bgCard,
          title: const Text(
            'Nâng cấp lên Lỗ Pro',
            style: TextStyle(color: AppColors.gold),
          ),
          content: const Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Với Lỗ Pro bạn sẽ có:',
                style: TextStyle(color: AppColors.textPrimary, fontSize: 15),
              ),
              SizedBox(height: 12),
              Text(
                '• Không giới hạn vị thế vàng\n'
                '• Biểu đồ phân tích nâng cao\n'
                '• Cảnh báo giá không giới hạn\n'
                '• Xuất dữ liệu không giới hạn\n'
                '• Hỗ trợ ưu tiên\n'
                '• Không quảng cáo',
                style: TextStyle(color: AppColors.textSecondary, height: 1.6),
              ),
              SizedBox(height: 12),
              Text(
                'Tính năng nâng cấp sẽ khả dụng trong phiên bản tới.',
                style: TextStyle(color: AppColors.textHint, fontSize: 12),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('Để sau', style: TextStyle(color: AppColors.textSecondary)),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pop(ctx),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.gold,
                foregroundColor: AppColors.bgPrimary,
              ),
              child: const Text('Quan tâm'),
            ),
          ],
        );
      },
    );
  }
}

/// Plan feature item widget
class _PlanFeatureItem extends StatelessWidget {
  final String text;
  final bool isIncluded;

  const _PlanFeatureItem({required this.text, required this.isIncluded});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        children: [
          Icon(
            isIncluded ? Icons.check_circle : Icons.remove_circle_outline,
            color: isIncluded ? AppColors.profit : AppColors.textHint,
            size: 18,
          ),
          const SizedBox(width: 8),
          Text(
            text,
            style: TextStyle(
              color: isIncluded ? AppColors.textPrimary : AppColors.textHint,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
