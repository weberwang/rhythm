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
            Text(_formatTargetBedtime(targetBedtimeMinutes, l10n)),
            const SizedBox(height: 12),
            FilledButton(
              onPressed: onPressed,
              child: Text(_labelForAction(primaryAction, l10n)),
            ),
          ],
        ),
      ),
    );
  }

  /// 统一按主行动类型映射本地化按钮文案，避免页面层散落 switch。
  String _labelForAction(TodayPrimaryAction action, AppLocalizations l10n) {
    switch (action) {
      case TodayPrimaryAction.enterBedtimeMode:
        return l10n.todayActionEnterBedtimeMode;
      case TodayPrimaryAction.manualRecord:
        return l10n.todayActionManualRecord;
      case TodayPrimaryAction.openPermissionHelp:
        return l10n.todayActionPermissionHelp;
      case TodayPrimaryAction.openGoalSetup:
        return l10n.todayActionGoalSetup;
      case TodayPrimaryAction.viewRecoveryPlan:
        return l10n.todayActionRecoveryPlan;
    }
  }

  /// 统一格式化今晚目标时间，保证中英文环境都能复用同一时间字符串。
  String _formatTargetBedtime(int minutes, AppLocalizations l10n) {
    final hour = (minutes ~/ 60).toString().padLeft(2, '0');
    final minute = (minutes % 60).toString().padLeft(2, '0');
    return l10n.todayActionTargetBedtime('$hour:$minute');
  }
}
