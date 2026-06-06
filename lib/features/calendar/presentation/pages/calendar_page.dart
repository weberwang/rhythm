import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:rhythm/l10n/app_localizations.dart';

import '../../../insights/presentation/pages/insights_page.dart';
import '../../../sleep_data_core/domain/entities/sleep_record.dart';
import '../../application/providers/calendar_overview_provider.dart';
import '../../domain/entities/calendar_overview.dart';

/// 日历页负责承接月度热力图、筛选与单日详情，不再停留在占位骨架。
class CalendarPage extends HookConsumerWidget {
  /// 创建日历页。
  const CalendarPage({super.key});

  /// 日历页路由路径。
  static const String routePath = '/calendar';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localization = AppLocalizations.of(context);
    final overviewAsync = ref.watch(calendarOverviewProvider);
    final selectedFilter = ref.watch(calendarFilterControllerProvider);

    return Scaffold(
      body: SafeArea(
        child: overviewAsync.when(
          data: (overview) => _CalendarContent(
            overview: overview,
            selectedFilter: selectedFilter,
            onSelectFilter: (mode) {
              ref.read(calendarFilterControllerProvider.notifier).select(mode);
            },
          ),
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, _) => Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    localization.calendarTitle,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    localization.calendarBody,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  FilledButton(
                    onPressed: () => ref.invalidate(calendarOverviewProvider),
                    child: Text(localization.calendarFilterAll),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// 月视图主体把摘要、筛选、热力图和详情入口收敛在一个滚动页面里。
class _CalendarContent extends StatelessWidget {
  /// 创建月视图主体。
  const _CalendarContent({
    required this.overview,
    required this.selectedFilter,
    required this.onSelectFilter,
  });

  final CalendarOverview overview;
  final CalendarFilterMode selectedFilter;
  final ValueChanged<CalendarFilterMode> onSelectFilter;

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final localeTag = Localizations.localeOf(context).toLanguageTag();
    final monthLabel = DateFormat.yMMMM(localeTag).format(overview.month);

    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 28),
      children: [
        Row(
          children: [
            Text(
              localization.calendarTitle,
              style: theme.textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            const Spacer(),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.more_horiz_rounded),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  monthLabel,
                  style: theme.textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  localization.calendarSummarySubtitle,
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.74),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  localization.calendarRecordedNightsLabel(
                    overview.summary.recordedNights,
                  ),
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 16),
                Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: [
                    _SummaryChip(
                      label: localization.calendarOnTargetLabel(
                        overview.summary.onTargetNights,
                      ),
                      icon: Icons.adjust_rounded,
                      color: const Color(0xFFDFF4F1),
                    ),
                    _SummaryChip(
                      label: localization.calendarDelayedLabel(
                        overview.summary.delayedNights,
                      ),
                      icon: Icons.bedtime_off_rounded,
                      color: const Color(0xFFFFEFE8),
                    ),
                    _SummaryChip(
                      label: localization.calendarAdjustedLabel(
                        overview.summary.adjustedNights,
                      ),
                      icon: Icons.draw_rounded,
                      color: const Color(0xFFEAE9FF),
                    ),
                    _SummaryChip(
                      label: localization.calendarPartialLabel(
                        overview.summary.partialNights,
                      ),
                      icon: Icons.hourglass_bottom_rounded,
                      color: const Color(0xFFF4F0E8),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children:
                CalendarFilterMode.values
                    .map(
                      (mode) => Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: ChoiceChip(
                          selected: selectedFilter == mode,
                          label: Text(_filterLabel(localization, mode)),
                          onSelected: (_) => onSelectFilter(mode),
                        ),
                      ),
                    )
                    .toList(growable: false),
          ),
        ),
        if (overview.accessState == CalendarHistoryAccessState.locked) ...[
          const SizedBox(height: 16),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    localization.calendarLockedTitle,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(localization.calendarLockedMessage),
                  const SizedBox(height: 16),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: FilledButton.tonalIcon(
                      onPressed: () => context.go(InsightsPage.routePath),
                      icon: const Icon(Icons.insights_rounded),
                      label: Text(localization.calendarOpenInsightsCta),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
        if (overview.state == CalendarOverviewState.noData) ...[
          const SizedBox(height: 16),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    localization.calendarNoDataTitle,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(localization.calendarNoDataMessage),
                ],
              ),
            ),
          ),
        ],
        const SizedBox(height: 16),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _HeatmapLegend(localization: localization),
                const SizedBox(height: 16),
                GridView.builder(
                  key: const Key('calendar-heatmap-grid'),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: overview.days.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 7,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                    childAspectRatio: 0.95,
                  ),
                  itemBuilder: (context, index) {
                    final day = overview.days[index];
                    return _CalendarDayCard(day: day);
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  /// 所有筛选文案统一从本地化映射，避免页面散落业务枚举翻译逻辑。
  String _filterLabel(
    AppLocalizations localization,
    CalendarFilterMode mode,
  ) {
    return switch (mode) {
      CalendarFilterMode.all => localization.calendarFilterAll,
      CalendarFilterMode.delayed => localization.calendarFilterDelayed,
      CalendarFilterMode.adjusted => localization.calendarFilterAdjusted,
      CalendarFilterMode.lockedInsights =>
        localization.calendarFilterLockedInsights,
    };
  }
}

/// 摘要 chip 承接一条统计事实，保持月度摘要的扫描节奏。
class _SummaryChip extends StatelessWidget {
  /// 创建摘要 chip。
  const _SummaryChip({
    required this.label,
    required this.icon,
    required this.color,
  });

  final String label;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 18),
            const SizedBox(width: 8),
            Text(label),
          ],
        ),
      ),
    );
  }
}

/// 热力图图例先把颜色语义讲清楚，避免用户只看见一组浅色块。
class _HeatmapLegend extends StatelessWidget {
  /// 创建热力图图例。
  const _HeatmapLegend({required this.localization});

  final AppLocalizations localization;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 12,
      runSpacing: 8,
      children: [
        _LegendItem(
          color: const Color(0xFFDFF4F1),
          label: localization.calendarHeatmapLegendOnTarget,
        ),
        _LegendItem(
          color: const Color(0xFFFFEFE8),
          label: localization.calendarHeatmapLegendDelayed,
        ),
        _LegendItem(
          color: const Color(0xFFF4F0E8),
          label: localization.calendarHeatmapLegendPartial,
        ),
        _LegendItem(
          color: Colors.white,
          label: localization.calendarHeatmapLegendEmpty,
        ),
      ],
    );
  }
}

/// 热力图图例项只负责表达一种颜色与一种语义。
class _LegendItem extends StatelessWidget {
  /// 创建图例项。
  const _LegendItem({required this.color, required this.label});

  final Color color;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(999),
            border: Border.all(color: Theme.of(context).dividerColor),
          ),
        ),
        const SizedBox(width: 6),
        Text(label),
      ],
    );
  }
}

/// 单日格子只暴露必要信息，点击后再展开详情，保持主页面简洁。
class _CalendarDayCard extends StatelessWidget {
  /// 创建单日格子。
  const _CalendarDayCard({required this.day});

  final CalendarDayCell day;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = switch (day.visualState) {
      CalendarDayVisualState.onTarget => const Color(0xFFDFF4F1),
      CalendarDayVisualState.slightDelay => const Color(0xFFF0FAF9),
      CalendarDayVisualState.majorDelay => const Color(0xFFFFEFE8),
      CalendarDayVisualState.partial => const Color(0xFFF4F0E8),
      CalendarDayVisualState.noData => Colors.white,
    };

    return InkWell(
      key: Key('calendar-day-${day.dayOfMonth}'),
      borderRadius: BorderRadius.circular(20),
      onTap: day.detail == null
          ? null
          : () => showModalBottomSheet<void>(
              context: context,
              showDragHandle: true,
              builder: (_) => _DayDetailSheet(detail: day.detail!),
            ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final compact = constraints.maxHeight < 56 || constraints.maxWidth < 44;
          final contentPadding = compact
              ? const EdgeInsets.symmetric(horizontal: 4, vertical: 6)
              : const EdgeInsets.symmetric(horizontal: 10, vertical: 12);
          final dayTextStyle = (compact
                  ? theme.textTheme.bodyMedium
                  : theme.textTheme.titleMedium)
              ?.copyWith(
                fontWeight: FontWeight.w700,
                color: day.hasRecord
                    ? theme.colorScheme.onSurface
                    : theme.colorScheme.onSurface.withValues(alpha: 0.28),
              );
          final dotSize = compact ? 6.0 : 8.0;

          return DecoratedBox(
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: theme.dividerColor),
            ),
            child: Padding(
              padding: contentPadding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('${day.dayOfMonth}', style: dayTextStyle),
                  if (day.hasRecord)
                    Container(
                      width: dotSize,
                      height: dotSize,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                        borderRadius: BorderRadius.circular(999),
                      ),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

/// 单日详情 bottom sheet 统一解释来源、修正状态、偏移和备注。
class _DayDetailSheet extends StatelessWidget {
  /// 创建单日详情层。
  const _DayDetailSheet({required this.detail});

  final CalendarDayDetail detail;

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final localeTag = Localizations.localeOf(context).toLanguageTag();
    final dateLabel = DateFormat.MMMMd(localeTag).format(detail.sleepDate);
    final bedtimeLabel = DateFormat(
      'h:mm a',
      localeTag,
    ).format(_toClockDate(detail.bedtimeMinutes));
    final wakeTimeLabel = DateFormat(
      'h:mm a',
      localeTag,
    ).format(_toClockDate(detail.wakeTimeMinutes));

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                dateLabel,
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 20),
              _DetailRow(
                label: localization.calendarDayDetailSourceLabel,
                value: detail.source == SleepRecordSource.manual
                    ? localization.calendarRecordSourceManual
                    : localization.calendarRecordSourceHealth,
              ),
              _DetailRow(
                label: localization.calendarDayDetailAdjustmentLabel,
                value: detail.isManuallyAdjusted
                    ? localization.calendarAdjustmentAdjusted
                    : localization.calendarAdjustmentOriginal,
              ),
              _DetailRow(
                label: localization.calendarDayDetailOffsetLabel,
                value: _offsetLabel(localization, detail.delayMinutes),
              ),
              _DetailRow(
                label: localization.calendarDayDetailDurationLabel,
                value: localization.calendarDurationLabel(
                  detail.sleepDurationMinutes ~/ 60,
                  detail.sleepDurationMinutes % 60,
                ),
              ),
              _DetailRow(
                label: localization.calendarDayDetailConfidenceLabel,
                value: detail.confidence == SleepRecordConfidence.partial
                    ? localization.calendarConfidencePartial
                    : localization.calendarConfidenceTrusted,
              ),
              _DetailRow(
                label: localization.calendarSleepWindowLabel,
                value: '$bedtimeLabel - $wakeTimeLabel',
              ),
              _DetailRow(
                label: localization.calendarDayDetailNoteLabel,
                value: detail.note?.isNotEmpty == true
                    ? detail.note!
                    : localization.calendarDayDetailNoNote,
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// 偏移说明必须统一处理正负值，避免详情层重复拼装晚睡/提前语义。
  String _offsetLabel(AppLocalizations localization, int delayMinutes) {
    if (delayMinutes.abs() <= 5) {
      return localization.calendarOffsetOnTarget;
    }
    if (delayMinutes < 0) {
      return localization.calendarOffsetEarly(delayMinutes.abs());
    }
    return localization.calendarOffsetLate(delayMinutes);
  }

  /// 把分钟偏移恢复成时钟时间，避免显示层散落同一套转换逻辑。
  DateTime _toClockDate(int minutes) {
    final normalizedMinutes =
        ((minutes % Duration.minutesPerDay) + Duration.minutesPerDay) %
        Duration.minutesPerDay;
    return DateTime(
      2026,
      1,
      1,
      normalizedMinutes ~/ 60,
      normalizedMinutes % 60,
    );
  }
}

/// 详情层信息行统一使用同一版式，降低结构噪音。
class _DetailRow extends StatelessWidget {
  /// 创建详情行。
  const _DetailRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 92,
            child: Text(
              label,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurface.withValues(alpha: 0.64),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              value,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
