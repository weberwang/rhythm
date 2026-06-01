import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:rhythm/app/router/app_router.dart';
import 'package:rhythm/app/theme/app_theme_tokens.dart';
import 'package:rhythm/features/calendar/application/calendar_analytics.dart';
import 'package:rhythm/features/calendar/application/calendar_controller.dart';
import 'package:rhythm/features/calendar/application/calendar_view_state.dart';
import 'package:rhythm/features/calendar/domain/calendar_day_summary.dart';
import 'package:rhythm/features/calendar/domain/calendar_filter.dart';
import 'package:rhythm/features/calendar/presentation/widgets/calendar_filter_bar.dart';
import 'package:rhythm/features/calendar/presentation/widgets/calendar_heatmap.dart';
import 'package:rhythm/features/calendar/presentation/widgets/sheets/calendar_filter_sheet.dart';
import 'package:rhythm/features/sleep_records/application/sleep_delay_tag_controller.dart';
import 'package:rhythm/features/sleep_records/presentation/widgets/sheets/sleep_delay_tag_picker_sheet.dart';
import 'package:rhythm/l10n/app_localizations.dart';
import 'package:rhythm/shared/presentation/theme/rhythm_theme_extensions.dart';

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
    final selectedDay = useState<CalendarDaySummary?>(null);

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

    useEffect(() {
      stateAsync.whenData((state) {
        final days = state.monthSummary?.days ?? const <CalendarDaySummary>[];
        if (days.isEmpty) {
          selectedDay.value = null;
          return;
        }
        final current = selectedDay.value;
        if (current != null) {
          final matched = _firstWhereOrNull(
            days,
            (day) => day.date == current.date,
          );
          if (matched != null) {
            selectedDay.value = matched;
            return;
          }
        }
        selectedDay.value =
            state.monthSummary?.latestLateDay ??
            _firstWhereOrNull(days, (day) => day.hasRecord) ??
            days.first;
      });
      return null;
    }, [stateAsync]);

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
        final driftDays = monthSummary.recordedDays - monthSummary.onTargetDays;
        final onTrackRate = monthSummary.recordedDays == 0
            ? 0
            : ((monthSummary.onTargetDays / monthSummary.recordedDays) * 100)
                  .round();
        final latestLateText =
            monthSummary.latestLateDay?.sleepOffsetMinutes == null
            ? '--:--'
            : _formatOffset(monthSummary.latestLateDay!.sleepOffsetMinutes!);
        final heroTitle = _buildCalendarHeroTitle(context, monthSummary.month, l10n);
        final heatmapTitle = _buildCalendarHeatmapTitle(
          context,
          monthSummary.month,
        );
        final heroSubtitle = _buildHeroSubtitle(
          l10n,
          onTrackDays: monthSummary.onTargetDays,
          driftDays: driftDays,
          recordedDays: monthSummary.recordedDays,
        );
        final activeDay =
            selectedDay.value ??
            monthSummary.latestLateDay ??
            _firstWhereOrNull(monthSummary.days, (day) => day.hasRecord) ??
            monthSummary.days.first;

        return SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 18, 20, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _CalendarHeroCard(
                title: heroTitle,
                subtitle: heroSubtitle,
                eyebrow: l10n.calendarHeroEyebrow,
              ),
              const SizedBox(height: 18),
              Card(
                margin: EdgeInsets.zero,
                elevation: 0,
                color: Colors.white.withValues(alpha: 0.84),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(28),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  heatmapTitle,
                                  style: theme.textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  l10n.calendarDescription,
                                  style: theme.textTheme.bodySmall?.copyWith(
                                    color: tokens.textSecondary,
                                    height: 1.45,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 12),
                          _CalendarMonthNavButton(
                            icon: Icons.chevron_left_rounded,
                            onPressed: null,
                          ),
                          const SizedBox(width: 8),
                          _CalendarMonthNavButton(
                            icon: Icons.chevron_right_rounded,
                            onPressed: null,
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      CalendarFilterBar(
                        l10n: l10n,
                        tokens: tokens,
                        activeFilter: state.activeFilter,
                        onOpenFilter: () => _showFilterSheetWithState(
                          context,
                          state.activeFilter.onlyRecordedDays,
                          state.activeFilter.lateOnly,
                          ref,
                        ),
                      ),
                      const SizedBox(height: 18),
                      Container(
                        padding: const EdgeInsets.fromLTRB(14, 14, 14, 16),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF8FAFF),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: const Color(0xFFEEF2FA)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _CalendarWeekdayHeader(
                              labels: _weekdayLabels(context),
                            ),
                            const SizedBox(height: 10),
                            CalendarHeatmap(
                              days: monthSummary.days,
                              onTapDay: (summary) async {
                                selectedDay.value = summary;
                                await ref
                                    .read(calendarAnalyticsProvider)
                                    .trackDayDetailViewed(recordDate: summary.date);
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 18),
              _CalendarSelectedDayCard(
                summary: activeDay,
                onTrackRate: onTrackRate,
                latestLateText: latestLateText,
                onAddTag: () => _showTagPickerFromInlineCard(
                  context,
                  ref,
                  state,
                  activeDay,
                ),
                onEditRecord: activeDay.record == null
                    ? null
                    : () => context.go(
                        manualSleepRecordEditPath(activeDay.record!.recordId),
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

/// 顶部月度摘要卡，承接页面品牌语气与当月结论。
class _CalendarHeroCard extends StatelessWidget {
  const _CalendarHeroCard({
    required this.title,
    required this.subtitle,
    required this.eyebrow,
  });

  final String title;
  final String subtitle;
  final String eyebrow;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final heroTokens = theme.extension<RhythmHeroThemeExtension>();
    final textTheme = theme.textTheme;

    return Container(
      padding: const EdgeInsets.fromLTRB(20, 18, 20, 20),
      decoration: BoxDecoration(
        gradient: heroTokens?.gradient ??
            LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                theme.colorScheme.primary.withValues(alpha: 0.92),
                theme.colorScheme.primaryContainer.withValues(alpha: 0.88),
              ],
            ),
        borderRadius: BorderRadius.circular(32),
        border: Border.all(
          color:
              heroTokens?.borderColor ?? Colors.white.withValues(alpha: 0.32),
        ),
        boxShadow: [
          BoxShadow(
            color: theme.colorScheme.shadow.withValues(alpha: 0.1),
            blurRadius: 26,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            eyebrow,
            style: textTheme.labelMedium?.copyWith(
              color: Colors.white.withValues(alpha: 0.92),
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            title,
            style: textTheme.headlineSmall?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              height: 1.08,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            subtitle,
            style: textTheme.bodyMedium?.copyWith(
              color: const Color(0xFFF0F3FF),
              height: 1.45,
            ),
          ),
        ],
      ),
    );
  }
}

/// 月切换按钮先按设计稿保留位置，当前月切换能力后续由 controller 补齐。
class _CalendarMonthNavButton extends StatelessWidget {
  const _CalendarMonthNavButton({
    required this.icon,
    required this.onPressed,
  });

  final IconData icon;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 34,
      height: 34,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          padding: EdgeInsets.zero,
          side: const BorderSide(color: Color(0xFFE5EBF6)),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(17),
          ),
        ),
        child: Icon(icon, size: 18),
      ),
    );
  }
}

/// 星期标题固定放在热力图上方，匹配 Pencil 的阅读顺序。
class _CalendarWeekdayHeader extends StatelessWidget {
  const _CalendarWeekdayHeader({required this.labels});

  final List<String> labels;

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.labelSmall?.copyWith(
      color: const Color(0xFF8D97AE),
      fontWeight: FontWeight.w500,
    );

    return Row(
      children: [
        for (final label in labels) ...[
          Expanded(
            child: Center(
              child: Text(label, style: textStyle),
            ),
          ),
        ],
      ],
    );
  }
}

/// 详情卡内的紧凑指标块。
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
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(
              context,
            ).textTheme.labelMedium?.copyWith(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 10),
          FittedBox(
            alignment: Alignment.centerLeft,
            fit: BoxFit.scaleDown,
            child: Text(
              value,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// 页内单日详情卡，替代旧的打开后即读的底部详情主链路。
class _CalendarSelectedDayCard extends StatelessWidget {
  const _CalendarSelectedDayCard({
    required this.summary,
    required this.onTrackRate,
    required this.latestLateText,
    required this.onAddTag,
    required this.onEditRecord,
  });

  final CalendarDaySummary summary;
  final int onTrackRate;
  final String latestLateText;
  final VoidCallback onAddTag;
  final VoidCallback? onEditRecord;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final textTheme = Theme.of(context).textTheme;
    final offset = summary.sleepOffsetMinutes;
    final detailText = _buildSelectedDayDescription(
      context,
      l10n,
      summary: summary,
      offset: offset,
    );

    return Card(
      margin: EdgeInsets.zero,
      elevation: 0,
      color: Colors.white.withValues(alpha: 0.82),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final compact = constraints.maxWidth < 260;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _formatDateLabel(context, summary.date),
                  style: textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  detailText,
                  style: textTheme.bodySmall?.copyWith(
                    color: const Color(0xFF6F7891),
                    height: 1.45,
                  ),
                ),
                const SizedBox(height: 16),
                if (compact) ...[
                  Row(
                    children: [
                      Expanded(
                        child: _CalendarMetricCard(
                          title: l10n.calendarDetailSleepTime,
                          value: summary.record == null
                              ? '--:--'
                              : DateFormat(
                                  'HH:mm',
                                ).format(summary.record!.fellAsleepAt),
                          backgroundColor: const Color(0xFFF8FAFF),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: _CalendarMetricCard(
                          title: l10n.calendarMetricOnTrack,
                          value: '$onTrackRate%',
                          backgroundColor: const Color(0xFFFCFBF8),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  _CalendarMetricCard(
                    title: l10n.calendarMetricLatestLate,
                    value: latestLateText,
                    backgroundColor: const Color(0xFFF8F7FB),
                  ),
                ] else
                  Row(
                    children: [
                      Expanded(
                        child: _CalendarMetricCard(
                          title: l10n.calendarDetailSleepTime,
                          value: summary.record == null
                              ? '--:--'
                              : DateFormat(
                                  'HH:mm',
                                ).format(summary.record!.fellAsleepAt),
                          backgroundColor: const Color(0xFFF8FAFF),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: _CalendarMetricCard(
                          title: l10n.calendarMetricOnTrack,
                          value: '$onTrackRate%',
                          backgroundColor: const Color(0xFFFCFBF8),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: _CalendarMetricCard(
                          title: l10n.calendarMetricLatestLate,
                          value: latestLateText,
                          backgroundColor: const Color(0xFFF8F7FB),
                        ),
                      ),
                    ],
                  ),
                if (summary.tags.isNotEmpty) ...[
                  const SizedBox(height: 14),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      for (final tag in summary.tags)
                        Chip(
                          label: Text(tag),
                          visualDensity: VisualDensity.compact,
                        ),
                    ],
                  ),
                ],
                const SizedBox(height: 14),
                Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: [
                    FilledButton.tonal(
                      onPressed: onAddTag,
                      child: Text(l10n.calendarDetailAddTag),
                    ),
                    OutlinedButton(
                      onPressed: onEditRecord,
                      child: Text(l10n.calendarDetailEditRecord),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
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

/// 顶部 hero 标题使用月份 + 产品语义，贴近 Pencil 的月度语气。
String _buildCalendarHeroTitle(
  BuildContext context,
  DateTime month,
  AppLocalizations l10n,
) {
  final locale = Localizations.localeOf(context).toLanguageTag();
  if (locale.startsWith('zh')) {
    return '${DateFormat('M 月').format(month)}${l10n.calendarTitle}';
  }
  return '${DateFormat.MMMM(locale).format(month)} ${l10n.calendarTitle}';
}

/// 热力图主卡标题保留月份感，但比 hero 更明确指向“热力图”。
String _buildCalendarHeatmapTitle(BuildContext context, DateTime month) {
  final locale = Localizations.localeOf(context).toLanguageTag();
  if (locale.startsWith('zh')) {
    return '${DateFormat('M 月').format(month)}热力图';
  }
  return '${DateFormat.MMMM(locale).format(month)} heatmap';
}

/// 页内详情卡仍复用现有标签弹层链路，避免为对齐设计而重写标签保存流程。
Future<void> _showTagPickerFromInlineCard(
  BuildContext context,
  WidgetRef ref,
  CalendarViewState state,
  CalendarDaySummary summary,
) async {
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
              .trackDelayTagAdded(recordDate: summary.date, tag: tags.first);
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
              .trackDelayTagAdded(recordDate: summary.date, tag: normalized);
          if (context.mounted) {
            Navigator.of(context).pop();
          }
        },
      );
    },
  );
}

/// 单日标题沿用现有月日格式，供页内详情卡与旧弹层共用。
String _formatDateLabel(BuildContext context, DateTime date) {
  final locale = Localizations.localeOf(context).toLanguageTag();
  if (locale.startsWith('zh')) {
    return DateFormat('M 月 d 日').format(date);
  }
  return DateFormat.MMMd(locale).format(date);
}

/// 详情卡说明按语言环境拼句，避免英文环境混入中文标点。
String _buildSelectedDayDescription(
  BuildContext context,
  AppLocalizations l10n, {
  required CalendarDaySummary summary,
  required int? offset,
}) {
  if (summary.record == null) {
    return l10n.calendarDetailNoRecord;
  }
  final locale = Localizations.localeOf(context).toLanguageTag();
  final pieces = [
    '${l10n.calendarDetailSleepTime} ${DateFormat('HH:mm').format(summary.record!.fellAsleepAt)}',
    '${l10n.calendarDetailWakeTime} ${DateFormat('HH:mm').format(summary.record!.wokeUpAt)}',
    l10n.calendarDetailOffsetValue(offset?.abs() ?? 0),
  ];
  final separator = locale.startsWith('zh') ? '，' : ', ';
  final suffix = locale.startsWith('zh') ? '。' : '.';
  return '${pieces.join(separator)}$suffix';
}

/// 根据当前语言环境输出紧凑星期标题，避免把中文缩写写死进页面。
List<String> _weekdayLabels(BuildContext context) {
  final locale = Localizations.localeOf(context).toLanguageTag();
  final formatter = DateFormat.E(locale);
  final monday = DateTime.utc(2026, 6, 1);
  return List<String>.generate(7, (index) {
    final raw = formatter.format(monday.add(Duration(days: index)));
    if (!locale.startsWith('zh')) {
      return raw;
    }
    return raw.substring(raw.length - 1);
  });
}

/// 避免依赖 SDK 版本差异，统一在页面内提供首个匹配项查找。
T? _firstWhereOrNull<T>(Iterable<T> items, bool Function(T item) test) {
  for (final item in items) {
    if (test(item)) {
      return item;
    }
  }
  return null;
}
