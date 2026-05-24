import 'package:flutter/material.dart';

/// 渲染今日页快捷记录卡，提供补录、修改和管理入口。
class TodayQuickActionsSection extends StatelessWidget {
  /// 创建快捷记录卡。
  const TodayQuickActionsSection({
    super.key,
    required this.onManualRecord,
    required this.onEditRecord,
    required this.onOpenRecordsHub,
  });

  /// 进入手动补录。
  final VoidCallback onManualRecord;

  /// 修改昨晚记录。
  final VoidCallback onEditRecord;

  /// 打开睡眠记录管理。
  final VoidCallback onOpenRecordsHub;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('快捷记录'),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                OutlinedButton(
                  onPressed: onManualRecord,
                  child: const Text('手动补录'),
                ),
                OutlinedButton(
                  onPressed: onEditRecord,
                  child: const Text('修改昨晚记录'),
                ),
                OutlinedButton(
                  onPressed: onOpenRecordsHub,
                  child: const Text('进入记录管理'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
