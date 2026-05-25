import 'package:flutter/material.dart';
import 'package:rhythm/l10n/app_localizations.dart';

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
    final l10n = AppLocalizations.of(context);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(l10n.todayQuickActionsTitle),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                OutlinedButton(
                  onPressed: onManualRecord,
                  child: Text(l10n.todayQuickActionManualButton),
                ),
                OutlinedButton(
                  onPressed: onEditRecord,
                  child: Text(l10n.todayQuickActionEditButton),
                ),
                OutlinedButton(
                  onPressed: onOpenRecordsHub,
                  child: Text(l10n.todayQuickActionOpenHubButton),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
