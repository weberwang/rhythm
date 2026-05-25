import 'package:flutter/material.dart';
import 'package:rhythm/features/today/domain/today_primary_action.dart';
import 'package:rhythm/l10n/app_localizations.dart';

/// 统一渲染今日页空态，避免页面层散落多套文案和按钮。
class TodayEmptyState extends StatelessWidget {
  /// 创建今日页空态。
  const TodayEmptyState({
    super.key,
    required this.title,
    required this.primaryAction,
    required this.onPressed,
  });

  /// 空态标题。
  final String title;

  /// 当前空态主行动。
  final TodayPrimaryAction primaryAction;

  /// 空态主按钮点击回调，由页面层按具体空态注入跳转行为。
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(title, textAlign: TextAlign.center),
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

  String _labelForAction(TodayPrimaryAction action, AppLocalizations l10n) {
    switch (action) {
      case TodayPrimaryAction.manualRecord:
        return l10n.todayEmptyPrimaryAction;
      case TodayPrimaryAction.openPermissionHelp:
        return l10n.todayPermissionFailedPrimaryAction;
      case TodayPrimaryAction.openGoalSetup:
        return l10n.todayGoalMissingPrimaryAction;
      case TodayPrimaryAction.enterBedtimeMode:
        return l10n.todayActionEnterBedtimeMode;
      case TodayPrimaryAction.viewRecoveryPlan:
        return l10n.todayActionRecoveryPlan;
    }
  }
}
