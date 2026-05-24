import 'package:flutter/material.dart';
import 'package:rhythm/features/today/domain/today_primary_action.dart';
import 'package:rhythm/l10n/app_localizations.dart';

/// 渲染今日页行动卡，统一承载首屏主按钮。
class TodayActionSection extends StatelessWidget {
  /// 创建行动卡。
  const TodayActionSection({
    super.key,
    required this.primaryAction,
    required this.targetBedtimeMinutes,
    required this.onPressed,
  });

  /// 当前首屏主行动。
  final TodayPrimaryAction primaryAction;

  /// 今晚目标入睡时间。
  final int targetBedtimeMinutes;

  /// 主按钮点击回调。
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(l10n.todayActionSectionTitle),
            const SizedBox(height: 12),
            Text(_formatTargetBedtime(targetBedtimeMinutes)),
            const SizedBox(height: 12),
            FilledButton(
              onPressed: onPressed,
              child: Text(_labelForAction(primaryAction)),
            ),
          ],
        ),
      ),
    );
  }

  String _labelForAction(TodayPrimaryAction action) {
    switch (action) {
      case TodayPrimaryAction.enterBedtimeMode:
        return '进入睡前模式';
      case TodayPrimaryAction.manualRecord:
        return '手动补录昨晚记录';
      case TodayPrimaryAction.openPermissionHelp:
        return '查看权限说明';
      case TodayPrimaryAction.openGoalSetup:
        return '去设置目标作息';
      case TodayPrimaryAction.viewRecoveryPlan:
        return '查看恢复建议';
    }
  }

  String _formatTargetBedtime(int minutes) {
    final hour = (minutes ~/ 60).toString().padLeft(2, '0');
    final minute = (minutes % 60).toString().padLeft(2, '0');
    return '今晚目标 $hour:$minute';
  }
}
