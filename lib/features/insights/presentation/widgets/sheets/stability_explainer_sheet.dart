import 'package:flutter/material.dart';
import 'package:rhythm/features/insights/domain/stability_score_rules.dart';
import 'package:rhythm/features/insights/presentation/insights_copy_resolver.dart';
import 'package:rhythm/l10n/app_localizations.dart';

/// 稳定度说明弹层，解释评分结果和样本门槛。
class StabilityExplainerSheet extends StatelessWidget {
  /// 创建稳定度说明弹层。
  const StabilityExplainerSheet({
    super.key,
    required this.score,
  });

  final StabilityScore score;

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
              l10n.insightsStabilityExplainerTitle,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
            ),
            const SizedBox(height: 8),
            Text(l10n.insightsStabilityScoreLabel(score.score)),
            const SizedBox(height: 8),
            Text(InsightsCopyResolver.stabilityDescription(l10n, score)),
            const SizedBox(height: 12),
            Text(l10n.insightsStabilitySampleHint),
          ],
        ),
      ),
    );
  }
}
