import 'package:flutter/material.dart';
import 'package:rhythm/features/bedtime/domain/bedtime_action.dart';
import 'package:rhythm/l10n/app_localizations.dart';

/// 渲染睡前页动作建议，保持建议条数轻量且可执行。
class BedtimeActionSuggestionSection extends StatelessWidget {
  /// 创建动作建议区块。
  const BedtimeActionSuggestionSection({
    super.key,
    required this.actions,
  });

  /// 当前要展示的建议动作。
  final List<BedtimeAction> actions;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(l10n.bedtimeActionTitle),
            const SizedBox(height: 12),
            for (final action in actions.take(3)) ...[
              Text(_labelForAction(action.type, l10n)),
              if (action != actions.take(3).last) const SizedBox(height: 10),
            ],
          ],
        ),
      ),
    );
  }

  String _labelForAction(
    BedtimeActionType type,
    AppLocalizations l10n,
  ) {
    switch (type) {
      case BedtimeActionType.dimLights:
        return l10n.bedtimeActionDimLights;
      case BedtimeActionType.putPhoneAway:
        return l10n.bedtimeActionPutPhoneAway;
      case BedtimeActionType.tenMinuteWrapUp:
        return l10n.bedtimeActionTenMinuteWrapUp;
      case BedtimeActionType.closeTonight:
        return l10n.bedtimeActionCloseTonight;
      case BedtimeActionType.planRecoveryTomorrow:
        return l10n.bedtimeActionPlanRecoveryTomorrow;
    }
  }
}
