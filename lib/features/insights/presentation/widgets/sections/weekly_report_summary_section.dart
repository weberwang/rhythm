import 'package:flutter/material.dart';
import 'package:rhythm/app/theme/app_theme_tokens.dart';
import 'package:rhythm/features/insights/domain/stability_score_rules.dart';
import 'package:rhythm/features/insights/domain/weekly_report.dart';
import 'package:rhythm/features/insights/presentation/insights_copy_resolver.dart';
import 'package:rhythm/l10n/app_localizations.dart';

/// 洞察首页顶部周报摘要区块，对齐设计稿的标题、摘要和主行动按钮。
class WeeklyReportSummarySection extends StatelessWidget {
  /// 创建周报摘要区块。
  const WeeklyReportSummarySection({
    super.key,
    required this.report,
    required this.onViewDetail,
  });

  final WeeklyReport report;
  final VoidCallback onViewDetail;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);
    final tokens = theme.brightness == Brightness.dark
        ? AppThemeTokens.dark
        : AppThemeTokens.light;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
          decoration: BoxDecoration(
            color: const Color(0xFFDCE8D8),
            borderRadius: BorderRadius.circular(999),
          ),
          child: Text(
            InsightsCopyResolver.stabilitySummary(
              l10n,
              StabilityScoreProxy.fromReport(report),
            ),
            style: theme.textTheme.labelMedium?.copyWith(
              color: tokens.textSecondary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(height: 10),
        Text(
          InsightsCopyResolver.headline(l10n, report.summary),
          style: theme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.w800,
            height: 1.15,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          report.summary.primaryReasonLabel == null
              ? l10n.insightsDescription
              : l10n.insightsWeeklyDescription(report.summary.primaryReasonLabel!),
          style: theme.textTheme.bodyMedium?.copyWith(
            color: tokens.textSecondary,
          ),
        ),
        const SizedBox(height: 18),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: tokens.surfaceInverse,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            children: [
              Expanded(
                child: _MetricCard(
                  title: l10n.insightsOnTrackRateLabel,
                  value: '${report.summary.onTrackRate}%',
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _MetricCard(
                  title: l10n.insightsStabilityLabel,
                  value: '${report.summary.stabilityScore}',
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 18),
        SizedBox(
          width: double.infinity,
          child: FilledButton(
            onPressed: onViewDetail,
            child: Text(l10n.insightsViewWeeklyReportButton),
          ),
        ),
      ],
    );
  }
}

/// 用于在只拿到周报摘要时复用稳定度摘要映射。
class StabilityScoreProxy extends StabilityScore {
  const StabilityScoreProxy({
    required super.score,
    required super.level,
    required super.sampleCount,
    required super.averageOffsetMinutes,
    required super.volatilityMinutes,
  });

  /// 从周报摘要派生一个最小稳定度对象，避免组件依赖完整控制器状态。
  factory StabilityScoreProxy.fromReport(WeeklyReport report) {
    final level = report.summary.stabilityScore >= 80
        ? StabilityScoreLevel.steady
        : report.summary.stabilityScore >= 60
            ? StabilityScoreLevel.recovering
            : StabilityScoreLevel.needsRecovery;
    return StabilityScoreProxy(
      score: report.summary.stabilityScore,
      level: level,
      sampleCount: report.summary.totalRecordedDays,
      averageOffsetMinutes: report.summary.latestLateOffsetMinutes,
      volatilityMinutes: report.summary.latestLateOffsetMinutes,
    );
  }
}

class _MetricCard extends StatelessWidget {
  const _MetricCard({
    required this.title,
    required this.value,
  });

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFF214634),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: Colors.white70,
                  fontWeight: FontWeight.w600,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                ),
          ),
        ],
      ),
    );
  }
}
