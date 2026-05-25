import 'package:flutter/material.dart';
import 'package:rhythm/core/presentation/widgets/rhythm_primary_button.dart';
import 'package:rhythm/features/today/domain/today_primary_action.dart';
import 'package:rhythm/l10n/app_localizations.dart';

/// 渲染今日页行动摘要，统一承载首屏主按钮与今晚目标时间。
class TodayActionSection extends StatelessWidget {
  /// 创建行动摘要。
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
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.todayActionSectionTitle,
          style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 10),
        Text(
          _formatTargetBedtime(targetBedtimeMinutes, l10n),
          style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 16),
        // 主行动固定拉满宽度，避免长文案和状态切换导致按钮宽度抖动。
        RhythmPrimaryButton(
          label: _labelForAction(primaryAction, l10n),
          onPressed: onPressed,
        ),
      ],
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
