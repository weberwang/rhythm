import 'package:flutter/material.dart';
import 'package:rhythm/app/theme/app_theme_tokens.dart';
import 'package:rhythm/features/insights/domain/recovery_plan.dart';
import 'package:rhythm/features/insights/presentation/insights_copy_resolver.dart';
import 'package:rhythm/l10n/app_localizations.dart';

/// 展示恢复效果和恢复计划入口，统一承接首页轻说明与详情弹层入口。
class RecoveryEffectSection extends StatelessWidget {
  /// 创建恢复效果区块。
  const RecoveryEffectSection({
    super.key,
    required this.plan,
    required this.onOpenPlan,
  });

  final RecoveryPlan? plan;
  final VoidCallback onOpenPlan;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);
    final tokens = theme.brightness == Brightness.dark
        ? AppThemeTokens.dark
        : AppThemeTokens.light;
    return InkWell(
      onTap: plan == null ? null : onOpenPlan,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: tokens.warningSurface,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.insightsRecoveryEffectTitle,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              InsightsCopyResolver.recoverySummary(l10n, plan),
              style: theme.textTheme.bodyMedium?.copyWith(
                color: tokens.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
