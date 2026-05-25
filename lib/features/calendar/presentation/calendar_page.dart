import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:rhythm/app/router/app_router.dart';
import 'package:rhythm/app/theme/app_theme_tokens.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:rhythm/features/calendar/application/calendar_analytics.dart';
import 'package:rhythm/features/calendar/application/calendar_controller.dart';
import 'package:rhythm/features/calendar/application/calendar_view_state.dart';
import 'package:rhythm/features/calendar/domain/calendar_day_summary.dart';
import 'package:rhythm/features/calendar/domain/calendar_filter.dart';
import 'package:rhythm/features/calendar/domain/calendar_heat_level.dart';
import 'package:rhythm/features/calendar/domain/calendar_month_summary.dart';
import 'package:rhythm/features/calendar/presentation/widgets/calendar_heatmap.dart';
import 'package:rhythm/features/calendar/presentation/widgets/sheets/calendar_day_detail_sheet.dart';
import 'package:rhythm/features/calendar/presentation/widgets/sheets/calendar_filter_sheet.dart';
import 'package:rhythm/features/sleep_records/application/sleep_delay_tag_controller.dart';
import 'package:rhythm/features/sleep_records/presentation/widgets/sheets/sleep_delay_tag_picker_sheet.dart';
import 'package:rhythm/l10n/app_localizations.dart';

/// 阶段六日历页入口，先按 Pencil 已确认的首屏结构交付真实页面。
class CalendarPage extends HookConsumerWidget {
  /// 创建日历页实例。
  const CalendarPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final tokens = theme.brightness == Brightness.dark
        ? AppThemeTokens.dark
        : AppThemeTokens.light;
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
        final filterSummaryChips = _buildFilterSummaryChips(
          l10n: l10n,
          tokens: tokens,
          activeFilter: state.activeFilter,
          monthSummary: monthSummary,
        );
        final monthLabel = _formatMonthLabel(context, monthSummary.month);
        final onTrackRate = monthSummary.recordedDays == 0
            ? 0
            : ((monthSummary.onTargetDays / monthSummary.recordedDays) * 100)
                  .round();
        final latestLateText =
            monthSummary.latestLateDay?.sleepOffsetMinutes == null
            ? '--:--'
            : _formatOffset(monthSummary.latestLateDay!.sleepOffsetMinutes!);

        return SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 18, 20, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                l10n.calendarHeroEyebrow,
                style: theme.textTheme.labelMedium?.copyWith(
                  color: tokens.primary,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                l10n.calendarHeroTitle,
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w800,
                  height: 1.2,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                l10n.calendarHeroSubtitle,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: tokens.textSecondary,
                ),
              ),
              const SizedBox(height: 18),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  ...filterSummaryChips,
                  ActionChip(
                    label: Text(l10n.calendarFilterOpen),
                    onPressed: () => _showFilterSheetWithState(
                      context,
                      state.activeFilter.onlyRecordedDays,
                      state.activeFilter.lateOnly,
                      ref,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 18),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        monthLabel,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 12),
                      CalendarHeatmap(
                        days: monthSummary.days,
                        onTapDay: (summary) =>
                            _showDayDetail(context, ref, state, summary),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 14),
              Row(
                children: [
                  Expanded(
                    child: _CalendarMetricCard(
                      title: l10n.calendarMetricOnTrack,
                      value: '$onTrackRate%',
                      backgroundColor: tokens.successSurface,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _CalendarMetricCard(
                      title: l10n.calendarMetricLatestLate,
                      value: latestLateText,
                      backgroundColor: tokens.warningSurface,
                    ),
                  ),
                ],
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

Future<void> _showFilterSheet(BuildContext context) {
  return _showFilterSheetWithState(context, false, false, null);
}

Future<void> _showFilterSheetWithState(
  BuildContext context,
  bool onlyRecordedDays,
  bool lateOnly,
  WidgetRef? ref,
) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    builder: (context) {
      return CalendarFilterSheet(
        onlyRecordedDays: onlyRecordedDays,
        lateOnly: lateOnly,
        onApply: (value) async {
          if (ref != null) {
            await ref
                .read(calendarControllerProvider.notifier)
                .updateFilter(
                  CalendarFilter(
                    onlyRecordedDays: value.onlyRecordedDays,
                    lateOnly: value.lateOnly,
                  ),
                );
          }
          if (context.mounted) {
            Navigator.of(context).pop();
          }
        },
        onReset: () async {
          if (ref != null) {
            await ref
                .read(calendarControllerProvider.notifier)
                .updateFilter(const CalendarFilter());
          }
          if (context.mounted) {
            Navigator.of(context).pop();
          }
        },
      );
    },
  );
}

List<Widget> _buildFilterSummaryChips({
  required AppLocalizations l10n,
  required AppThemeTokens tokens,
  required CalendarFilter activeFilter,
  required CalendarMonthSummary monthSummary,
}) {
  final chips = <Widget>[];
  final lateCount = monthSummary.days
      .where((day) => day.heatLevel == CalendarHeatLevel.late)
      .length;

  if (!activeFilter.onlyRecordedDays && !activeFilter.lateOnly) {
    chips.add(
      _CalendarChip(
        label: l10n.calendarFilterAllDays,
        backgroundColor: tokens.successSurface,
        foregroundColor: tokens.primary,
      ),
    );
  }
  if (activeFilter.onlyRecordedDays) {
    chips.add(
      _CalendarChip(
        label: l10n.calendarFilterRecordedOnly,
        backgroundColor: tokens.successSurface,
        foregroundColor: tokens.primary,
      ),
    );
  }
  if (activeFilter.lateOnly) {
    chips.add(
      _CalendarChip(
        label: l10n.calendarFilterLateOnly,
        backgroundColor: tokens.warningSurface,
        foregroundColor: tokens.textPrimary,
      ),
    );
  }
  chips.add(
    _CalendarChip(
      label: l10n.calendarFilterLateCountSummary(lateCount),
      backgroundColor: tokens.surface,
      foregroundColor: tokens.textSecondary,
    ),
  );
  return chips;
}

/// 轻量筛选胶囊，先承接阶段六首屏结构。
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
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.labelMedium?.copyWith(
          color: foregroundColor,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

/// 承接首屏底部两个摘要卡。
class _CalendarMetricCard extends StatelessWidget {
  const _CalendarMetricCard({
    required this.title,
    required this.value,
    required this.backgroundColor,
  });

  final String title;
  final String value;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(
              context,
            ).textTheme.labelMedium?.copyWith(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 10),
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

/// 将偏差分钟数转成摘要卡可读时间。
String _formatOffset(int minutes) {
  final safeMinutes = minutes.abs();
  final hours = safeMinutes ~/ 60;
  final remainingMinutes = safeMinutes % 60;
  return '${hours.toString().padLeft(2, '0')}:${remainingMinutes.toString().padLeft(2, '0')}';
}

/// 按语言环境输出月份标题，中文保留当前视觉稿格式，英文走本地化月份表达。
String _formatMonthLabel(BuildContext context, DateTime month) {
  final locale = Localizations.localeOf(context).toLanguageTag();
  if (locale.startsWith('zh')) {
    return DateFormat('yyyy 年 M 月').format(month);
  }
  return DateFormat.yMMMM(locale).format(month);
}

/// 打开单日详情，并在详情内继续承接补标签动作。
Future<void> _showDayDetail(
  BuildContext context,
  WidgetRef ref,
  CalendarViewState state,
  CalendarDaySummary summary,
) async {
  await ref
      .read(calendarAnalyticsProvider)
      .trackDayDetailViewed(recordDate: summary.date);
  await showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    builder: (context) {
      return CalendarDayDetailSheet(
        summary: summary,
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
