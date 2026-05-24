import 'package:flutter/material.dart';
import 'package:rhythm/app/theme/app_theme_tokens.dart';
import 'package:rhythm/features/insights/domain/stability_score_rules.dart';
import 'package:rhythm/features/insights/presentation/insights_copy_resolver.dart';
import 'package:rhythm/l10n/app_localizations.dart';

/// 展示稳定度分数与说明，支持从首页打开评分口径说明。
class StabilitySection extends StatelessWidget {
  /// 创建稳定度区块。
  const StabilitySection({
    super.key,
    required this.score,
    required this.onExplain,
  });

  final StabilityScore score;
  final VoidCallback onExplain;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);
    final tokens = theme.brightness == Brightness.dark
        ? AppThemeTokens.dark
        : AppThemeTokens.light;
    return InkWell(
      onTap: onExplain,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: tokens.surface,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.insightsStabilityLabel,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '${score.score}',
              style: theme.textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              InsightsCopyResolver.stabilitySummary(l10n, score),
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
