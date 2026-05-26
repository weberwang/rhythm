import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:rhythm/features/insights/application/insights_controller.dart';
import 'package:rhythm/features/insights/application/insights_view_state.dart';
import 'package:rhythm/features/insights/domain/weekly_report_generator.dart';
import 'package:rhythm/features/insights/presentation/insights_copy_resolver.dart';
import 'package:rhythm/l10n/app_localizations.dart';

/// 周报详情页，承接本周周报的完整复盘内容。
class WeeklyReportDetailPage extends HookConsumerWidget {
  /// 创建周报详情页。
  const WeeklyReportDetailPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stateAsync = ref.watch(insightsControllerProvider);
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(l10n.insightsWeeklyReportPageTitle)),
      body: stateAsync.when(
        data: (state) => _DetailBody(state: state, l10n: l10n),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => const SizedBox.shrink(),
      ),
    );
  }
}

/// 周报详情主体，负责拼装周报摘要、建议和逐日列表。
class _DetailBody extends StatelessWidget {
  const _DetailBody({required this.state, required this.l10n});

  final InsightsViewState state;
  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    final report = state.weeklyReport;
    if (report == null) {
      return Center(child: Text(l10n.insightsNoWeeklyReport));
    }

    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: const Color(0xFF1B3A28),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                InsightsCopyResolver.stabilitySummary(
                  l10n,
                  state.stabilityScore!,
                ),
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                report.summary.primaryReasonLabel == null
                    ? l10n.insightsDescription
                    : l10n.insightsWeeklyDescription(
                        report.summary.primaryReasonLabel!,
                      ),
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: const Color(0xFFD7E7DA),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _StatCard(
                title: l10n.insightsOnTrackRateLabel,
                value: '${report.summary.onTrackRate}%',
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _StatCard(
                title: l10n.insightsStabilityLabel,
                value: '${report.summary.stabilityScore}',
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        _InfoCard(
          title: l10n.insightsLatestLateTitle,
          content: InsightsCopyResolver.latestLateSummary(l10n, report),
        ),
        const SizedBox(height: 16),
        _InfoCard(
          highlighted: true,
          title: l10n.insightsNextWeekAdviceTitle,
          content: report.recommendations
              .map(
                (item) =>
                    '• ${InsightsCopyResolver.recommendation(l10n, item)}',
              )
              .join('\n'),
        ),
        const SizedBox(height: 16),
        Text(
          InsightsCopyResolver.rangeLabel(
            context,
            report.startDate,
            report.endDate,
          ),
        ),
        const SizedBox(height: 8),
        for (final day in report.days)
          ListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(_formatDayLabel(context, day.date)),
            subtitle: Text(InsightsCopyResolver.tagsOrFallback(l10n, day.tags)),
            trailing: Text(
              day.sleepOffsetMinutes == null
                  ? '--'
                  : WeeklyReportGenerator.formatSleepTime(
                      targetBedtimeMinutes: _deriveTargetBedtimeMinutes(report),
                      offsetMinutes: day.sleepOffsetMinutes!,
                    ),
            ),
          ),
      ],
    );
  }

  /// 通过周报中最晚一天的实际时间和偏差反推目标作息，避免详情页重新依赖目标设置源。
  int _deriveTargetBedtimeMinutes(dynamic report) {
    final minutes =
        report.summary.latestLateSleepMinutesOfDay -
        report.summary.latestLateOffsetMinutes;
    return ((minutes % (24 * 60)) + 24 * 60) % (24 * 60);
  }

  /// 按语言环境格式化逐日标题，中文保留现有习惯，英文使用本地化月日缩写。
  String _formatDayLabel(BuildContext context, DateTime date) {
    final locale = Localizations.localeOf(context).toLanguageTag();
    if (locale.startsWith('zh')) {
      return DateFormat('M月d日 EEE', 'zh').format(date);
    }
    return DateFormat('MMM d EEE', locale).format(date);
  }
}

/// 周报顶部统计卡，统一展示单个摘要指标。
class _StatCard extends StatelessWidget {
  const _StatCard({required this.title, required this.value});

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFE8F0E1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title),
          const SizedBox(height: 8),
          Text(
            value,
            style: Theme.of(
              context,
            ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w800),
          ),
        ],
      ),
    );
  }
}

/// 周报信息卡，统一承载说明性文本块和强调背景样式。
class _InfoCard extends StatelessWidget {
  const _InfoCard({
    required this.title,
    required this.content,
    this.highlighted = false,
  });

  final String title;
  final String content;
  final bool highlighted;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: highlighted ? const Color(0xFFF4E8CF) : const Color(0xFFF9FBF6),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 8),
          Text(content),
        ],
      ),
    );
  }
}
