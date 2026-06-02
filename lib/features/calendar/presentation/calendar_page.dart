import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:rhythm/app/router/app_router.dart';
import 'package:rhythm/features/calendar/application/calendar_analytics.dart';
import 'package:rhythm/features/calendar/application/calendar_controller.dart';
import 'package:rhythm/features/calendar/application/calendar_view_state.dart';
import 'package:rhythm/features/calendar/domain/calendar_day_summary.dart';
import 'package:rhythm/features/calendar/domain/calendar_month_summary.dart';
import 'package:rhythm/features/calendar/presentation/widgets/calendar_heatmap.dart';
import 'package:rhythm/features/calendar/presentation/widgets/sheets/calendar_day_detail_sheet.dart';
import 'package:rhythm/features/sleep_records/application/sleep_delay_tag_controller.dart';
import 'package:rhythm/features/sleep_records/presentation/widgets/sheets/record_source_explainer_sheet.dart';
import 'package:rhythm/features/sleep_records/presentation/widgets/sheets/sleep_delay_tag_picker_sheet.dart';
import 'package:rhythm/l10n/app_localizations.dart';

/// 日历页按 Pencil 设计稿重组首屏，只改显示层结构，不改控制器聚合契约。
class CalendarPage extends HookConsumerWidget {
  /// 创建日历页实例。
  const CalendarPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final stateAsync = ref.watch(calendarControllerProvider);
    final trackedMonths = useRef<Set<String>>(<String>{});

    useEffect(() {
      stateAsync.whenData((state) {
        final month = state.monthSummary?.month;
        if (month == null) {
          return;
        }
        final monthKey =
            '${month.year}-${month.month.toString().padLeft(2, '0')}';
        if (trackedMonths.value.contains(monthKey)) {
          return;
        }
        trackedMonths.value = <String>{...trackedMonths.value, monthKey};
        ref.read(calendarAnalyticsProvider).trackViewed(month: month);
      });
      return null;
    }, [stateAsync, ref]);

    return stateAsync.when(
      data: (state) {
        if (state.status == CalendarViewStatus.goalMissing) {
          return Padding(
            padding: const EdgeInsets.all(24),
            child: Text(
              l10n.todayGoalMissingTitle,
              style: theme.textTheme.headlineSmall,
            ),
          );
        }

        final monthSummary = state.monthSummary!;
        final heroSubtitle = _buildHeroSubtitle(
          l10n,
          onTrackDays: monthSummary.onTargetDays,
          driftDays: monthSummary.recordedDays - monthSummary.onTargetDays,
          recordedDays: monthSummary.recordedDays,
        );
        final onTrackRate = monthSummary.recordedDays == 0
            ? 0
            : ((monthSummary.onTargetDays / monthSummary.recordedDays) * 100)
                  .round();

        return SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 18, 20, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _CalendarChip(
                label: l10n.calendarHeroEyebrow,
                backgroundColor: Color(0xFFE3EEE0),
                foregroundColor: Color(0xFF4A6B52),
              ),
              const SizedBox(height: 10),
              Text(
                l10n.calendarHeroTitle,
                style: theme.textTheme.headlineMedium?.copyWith(
                  fontFamily: 'Funnel Sans',
                  color: const Color(0xFF1B3A28),
                  fontWeight: FontWeight.w700,
                  height: 1.08,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                heroSubtitle,
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontFamily: 'Geist',
                  color: const Color(0xFF4A6B52),
                  fontWeight: FontWeight.w500,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 18),
              _CalendarMonthCard(
                monthLabel: _formatMonthLabel(context, monthSummary.month),
                onTrackLabel: _buildOnTrackLabel(l10n, monthSummary),
                child: CalendarHeatmap(
                  days: monthSummary.days,
                  onTapDay: (summary) =>
                      _showDayDetail(context, ref, state, summary),
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: _CalendarMetricCard(
                      title: l10n.calendarMetricOnTrack,
                      value: '$onTrackRate%',
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _CalendarMetricCard(
                      title: l10n.calendarMetricLatestLate,
                      value: _buildLatestLateText(monthSummary.latestLateDay),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              _CalendarPreviewCard(
                title: _buildPreviewTitle(
                  context,
                  l10n,
                  monthSummary.latestLateDay,
                ),
                summary: _buildPreviewSummary(
                  context,
                  l10n,
                  monthSummary.latestLateDay,
                ),
                onTap: monthSummary.latestLateDay == null
                    ? null
                    : () => _showDayDetail(
                        context,
                        ref,
                        state,
                        monthSummary.latestLateDay!,
                      ),
              ),
            ],
          ),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stackTrace) => Center(
        child: Text(
          l10n.calendarDescription,
          style: theme.textTheme.bodyMedium,
        ),
      ),
    );
  }
}

/// 承接首屏底部两个摘要卡，保持 Pencil 的浅色信息卡视觉。
class _CalendarMetricCard extends StatelessWidget {
  const _CalendarMetricCard({required this.title, required this.value});

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFEEF4EA),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
              fontFamily: 'Geist',
              color: const Color(0xFF4A6B52),
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontFamily: 'IBM Plex Mono',
              color: const Color(0xFF1B3A28),
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

/// 统一渲染页面里的胶囊提示，避免页面层散落重复样式。
class _CalendarChip extends StatelessWidget {
  const _CalendarChip({
    required this.label,
    required this.backgroundColor,
    required this.foregroundColor,
  });

  final String label;
  final Color backgroundColor;
  final Color foregroundColor;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
        child: Text(
          label,
          style: Theme.of(context).textTheme.labelMedium?.copyWith(
            fontFamily: 'Geist',
            color: foregroundColor,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

/// 月份卡统一承接月标题、达标胶囊和热力图内容。
class _CalendarMonthCard extends StatelessWidget {
  const _CalendarMonthCard({
    required this.monthLabel,
    required this.onTrackLabel,
    required this.child,
  });

  final String monthLabel;
  final String onTrackLabel;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF9FBF6),
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0F000000),
            blurRadius: 18,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  monthLabel,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontFamily: 'Geist',
                    color: const Color(0xFF1B3A28),
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              _CalendarChip(
                label: onTrackLabel,
                backgroundColor: const Color(0xFFD7E7DA),
                foregroundColor: const Color(0xFF4F7B5A),
              ),
            ],
          ),
          const SizedBox(height: 12),
          child,
        ],
      ),
    );
  }
}

/// 预览卡承接最近一条样本摘要，并作为打开详情半屏卡的明确入口。
class _CalendarPreviewCard extends StatelessWidget {
  const _CalendarPreviewCard({
    required this.title,
    required this.summary,
    required this.onTap,
  });

  final String title;
  final String summary;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final content = Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF9FBF6),
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0F000000),
            blurRadius: 18,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontFamily: 'Geist',
              color: const Color(0xFF1B3A28),
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            summary,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontFamily: 'Geist',
              color: const Color(0xFF4A6B52),
              fontWeight: FontWeight.w500,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 10),
          _CalendarChip(
            label: AppLocalizations.of(context).calendarPreviewTapHint,
            backgroundColor: Color(0xFFE3EEE0),
            foregroundColor: Color(0xFF4A6B52),
          ),
        ],
      ),
    );
    if (onTap == null) {
      return content;
    }
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: onTap,
      child: content,
    );
  }
}

/// 根据当月统计生成顶部摘要，确保首屏文案反映真实记录结果。
String _buildHeroSubtitle(
  AppLocalizations l10n, {
  required int onTrackDays,
  required int driftDays,
  required int recordedDays,
}) {
  if (recordedDays == 0) {
    return l10n.calendarHeroSubtitleEmpty;
  }
  return l10n.calendarHeroSubtitle(onTrackDays, driftDays);
}

/// 中文保留设计稿格式，英文沿用本地化月份表达。
String _formatMonthLabel(BuildContext context, DateTime month) {
  final locale = Localizations.localeOf(context).toLanguageTag();
  if (locale.startsWith('zh')) {
    return DateFormat('yyyy 年 M 月').format(month);
  }
  return DateFormat.yMMMM(locale).format(month);
}

/// 月份卡右上角的达标胶囊按当前月份统计输出。
String _buildOnTrackLabel(
  AppLocalizations l10n,
  CalendarMonthSummary monthSummary,
) {
  return l10n.calendarMonthOnTrackBadge(monthSummary.onTargetDays);
}

/// 最新晚睡卡直接展示真实入睡时间，保持 Pencil 的数据观感。
String _buildLatestLateText(CalendarDaySummary? summary) {
  final record = summary?.record;
  if (record == null) {
    return '--:--';
  }
  return DateFormat('HH:mm').format(record.fellAsleepAt);
}

/// 预览卡标题优先展示样本日期，无样本时回退到模块描述。
String _buildPreviewTitle(
  BuildContext context,
  AppLocalizations l10n,
  CalendarDaySummary? summary,
) {
  final locale = Localizations.localeOf(context).toLanguageTag();
  if (summary == null) {
    return locale.startsWith('zh')
        ? '${l10n.calendarTitle}${l10n.calendarPreviewSuffix}'
        : '${l10n.calendarTitle} ${l10n.calendarPreviewSuffix}';
  }
  if (locale.startsWith('zh')) {
    return '${DateFormat('M 月 d 日').format(summary.date)}${l10n.calendarPreviewSuffix}';
  }
  return '${DateFormat.MMMd(locale).format(summary.date)} ${l10n.calendarPreviewSuffix}';
}

/// 预览卡文案直接消费已聚合样本，避免页面层重算业务规则。
String _buildPreviewSummary(
  BuildContext context,
  AppLocalizations l10n,
  CalendarDaySummary? summary,
) {
  if (summary?.record == null) {
    return l10n.calendarHeroSubtitleEmpty;
  }
  final record = summary!.record!;
  final offset = summary.sleepOffsetMinutes ?? 0;
  final offsetLabel = switch (offset) {
    < 0 => l10n.calendarPreviewOffsetEarly(offset.abs()),
    > 0 => l10n.calendarPreviewOffsetLate(offset),
    _ => l10n.calendarPreviewOffsetOnTarget,
  };
  final locale = Localizations.localeOf(context).toLanguageTag();
  final tags = summary.tags.join(locale.startsWith('zh') ? '、' : ', ');
  final sleepTime = DateFormat('HH:mm').format(record.fellAsleepAt);
  if (tags.isEmpty) {
    return l10n.calendarPreviewSummaryNoTags(sleepTime, offsetLabel);
  }
  return l10n.calendarPreviewSummaryWithTags(sleepTime, offsetLabel, tags);
}

/// 打开单日详情，并在详情内继续承接补标签和来源说明动作。
Future<void> _showDayDetail(
  BuildContext context,
  WidgetRef ref,
  CalendarViewState state,
  CalendarDaySummary summary,
) async {
  unawaited(
    ref
        .read(calendarAnalyticsProvider)
        .trackDayDetailViewed(recordDate: summary.date),
  );
  await showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    builder: (context) {
      return CalendarDayDetailSheet(
        summary: summary,
        onExplainSource: () async {
          await showModalBottomSheet<void>(
            context: context,
            isScrollControlled: true,
            builder: (context) => const RecordSourceExplainerSheet(),
          );
        },
        onAddTag: () async {
          Navigator.of(context).pop();
          await showModalBottomSheet<void>(
            context: context,
            isScrollControlled: true,
            builder: (context) {
              return SleepDelayTagPickerSheet(
                tags: state.availableTags,
                selectedTags: summary.tags,
                onSave: (tags) async {
                  await ref
                      .read(sleepDelayTagControllerProvider)
                      .saveTags(recordDate: summary.date, tags: tags);
                  await ref
                      .read(calendarControllerProvider.notifier)
                      .refreshDayTags(summary.date);
                  await ref
                      .read(calendarAnalyticsProvider)
                      .trackDelayTagAdded(
                        recordDate: summary.date,
                        tag: tags.first,
                      );
                  if (context.mounted) {
                    Navigator.of(context).pop();
                  }
                },
                onCustomTag: (value) async {
                  final normalized = value.trim();
                  await ref
                      .read(sleepDelayTagControllerProvider)
                      .saveCustomTag(recordDate: summary.date, input: value);
                  await ref
                      .read(calendarControllerProvider.notifier)
                      .refreshDayTags(summary.date);
                  await ref
                      .read(calendarAnalyticsProvider)
                      .trackDelayTagAdded(
                        recordDate: summary.date,
                        tag: normalized,
                      );
                  if (context.mounted) {
                    Navigator.of(context).pop();
                  }
                },
              );
            },
          );
        },
        onEditRecord: summary.record == null
            ? null
            : () {
                Navigator.of(context).pop();
                context.go(manualSleepRecordEditPath(summary.record!.recordId));
              },
      );
    },
  );
}
