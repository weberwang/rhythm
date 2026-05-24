import 'package:flutter/material.dart';
import 'package:rhythm/features/insights/domain/recovery_plan.dart';
import 'package:rhythm/features/insights/presentation/insights_copy_resolver.dart';
import 'package:rhythm/l10n/app_localizations.dart';

/// 恢复计划详情弹层，展示 1 到 3 天动作步骤。
class RecoveryPlanDetailSheet extends StatelessWidget {
  /// 创建恢复计划详情弹层。
  const RecoveryPlanDetailSheet({
    super.key,
    required this.plan,
  });

  final RecoveryPlan plan;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 64,
                height: 6,
                decoration: BoxDecoration(
                  color: const Color(0xFFD5DFCE),
                  borderRadius: BorderRadius.circular(999),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              l10n.insightsRecoveryPlanDetailTitle,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
            ),
            const SizedBox(height: 8),
            Text(InsightsCopyResolver.recoverySummary(l10n, plan)),
            const SizedBox(height: 16),
            for (final step in plan.steps) ...[
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(
                  l10n.insightsRecoveryStepLabel(
                    step.dayIndex,
                    InsightsCopyResolver.recoveryStepTitle(l10n, step),
                  ),
                ),
                subtitle: Text(InsightsCopyResolver.recoveryStepDetail(l10n, step)),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
