import 'dart:math' as math;

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:rhythm/l10n/app_localizations.dart';

import '../../../insights/presentation/pages/insights_page.dart';
import '../../../sleep_data_core/domain/entities/sleep_record.dart';
import '../../application/providers/calendar_overview_provider.dart';
import '../../domain/entities/calendar_overview.dart';
import '../widgets/calendar_page_sections.dart';
import '../widgets/calendar_page_style.dart';

/// 日历页负责承接“按月看偏移 -> 切筛选 -> 看单日解释”的高保真回看主路径。
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
      body: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              CalendarPageStyle.pageTopTint,
              Theme.of(context).scaffoldBackgroundColor,
            ],
          ),
        ),
        child: Stack(
          children: [
            const CalendarDecorativeBackground(),
            SafeArea(
              child: overviewAsync.when(
                data: (overview) => _CalendarReadyView(
                  overview: overview,
                  selectedFilter: selectedFilter,
                  onSelectFilter: (mode) {
                    ref.read(calendarFilterControllerProvider.notifier).select(
                      mode,
                    );
                  },
                ),
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (_, _) => _CalendarErrorState(
                  onRetry: () => ref.invalidate(calendarOverviewProvider),
                  title: localization.calendarTitle,
                  body: localization.calendarBody,
                  retryLabel: localization.retry,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// 真正的日历展示层在这里管理选中日和月视图编排，不把交互状态丢回应用层。
class _CalendarReadyView extends HookWidget {
  /// 创建已就绪视图。
  const _CalendarReadyView({
    required this.overview,
    required this.selectedFilter,
    required this.onSelectFilter,
  });

  /// 月度聚合结果。
  final CalendarOverview overview;

  /// 当前筛选。
  final CalendarFilterMode selectedFilter;

  /// 筛选切换回调。
  final ValueChanged<CalendarFilterMode> onSelectFilter;

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context);
    final localeTag = Localizations.localeOf(context).toLanguageTag();
    final selectedDayNumber = useState<int?>(
      overview.days.lastWhereOrNull((day) => day.detail != null)?.dayOfMonth,
    );
    final availableDayNumbers = overview.days
        .where((day) => day.detail != null)
        .map((day) => day.dayOfMonth)
        .toList(growable: false);

    useEffect(() {
      if (availableDayNumbers.isEmpty) {
        selectedDayNumber.value = null;
        return null;
      }

      if (!availableDayNumbers.contains(selectedDayNumber.value)) {
        selectedDayNumber.value = availableDayNumbers.last;
      }
      return null;
    }, [overview]);

    final selectedCell = overview.days.firstWhereOrNull(
      (day) => day.dayOfMonth == selectedDayNumber.value && day.detail != null,
    );
    final visualCells = _buildVisualCells(overview);
    final metricModels = _buildMetricModels(
      localization,
      overview.summary,
      localeTag,
    );
    final weekdayLabels = _buildWeekdayLabels(localeTag);

    final selectedDetail = selectedCell?.detail;
    final bottomDetail = selectedDetail == null
        ? null
        : SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 18),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxHeight: 276),
                child: SingleChildScrollView(
                  key: const Key('calendar-day-detail-card'),
                  child: CalendarSelectedDayCard(
                    dateLabel: DateFormat.MMMMd(
                      localeTag,
                    ).format(selectedDetail.sleepDate),
                    offsetLabel: _offsetLabel(
                      localization,
                      selectedDetail.delayMinutes,
                    ),
                    bedtimeTitle: localization.calendarDetailBedtimeLabel,
                    wakeTimeTitle: localization.calendarDetailWakeTimeLabel,
                    totalSleepTitle: localization.calendarDetailTotalSleepLabel,
                    bedtimeLabel: DateFormat.jm(
                      localeTag,
                    ).format(_toClockDate(selectedDetail.bedtimeMinutes)),
                    wakeTimeLabel: DateFormat.jm(
                      localeTag,
                    ).format(_toClockDate(selectedDetail.wakeTimeMinutes)),
                    durationLabel: _durationLabel(
                      selectedDetail.sleepDurationMinutes,
                    ),
                    sourceLabel:
                        selectedDetail.source == SleepRecordSource.manual
                        ? localization.calendarRecordSourceManual
                        : localization.calendarRecordSourceHealth,
                    adjustmentLabel: selectedDetail.isManuallyAdjusted
                        ? localization.calendarAdjustmentAdjusted
                        : localization.calendarAdjustmentOriginal,
                    confidenceLabel:
                        selectedDetail.confidence == SleepRecordConfidence.partial
                        ? localization.calendarConfidencePartial
                        : localization.calendarConfidenceTrusted,
                    note: selectedDetail.note,
                  ),
                ),
              ),
            ),
          );

    return Stack(
      children: [
        CustomScrollView(
          slivers: [
            SliverPadding(
              padding: EdgeInsets.fromLTRB(
                20,
                14,
                20,
                bottomDetail == null ? 28 : 300,
              ),
              sliver: SliverList.list(
                children: [
              Row(
                children: [
                  const CalendarWordmark(),
                  const Spacer(),
                  const CalendarHeaderActionButton(onPressed: null),
                ],
              ),
              const SizedBox(height: 18),
              CalendarSurfaceCard(
                key: const Key('calendar-monthly-summary-card'),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      DateFormat.yMMMM(localeTag).format(overview.month),
                      style: CalendarPageStyle.monthTitle(context),
                    ),
                    const SizedBox(height: 10),
                    ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 320),
                      child: Text(
                        localization.calendarSummarySubtitle,
                        style: CalendarPageStyle.summaryBody(context),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        for (var index = 0; index < metricModels.length; index++)
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(
                                right: index == metricModels.length - 1 ? 0 : 12,
                              ),
                              child: CalendarSummaryMetricTile(
                                key: Key(metricModels[index].key),
                                icon: metricModels[index].icon,
                                value: metricModels[index].value,
                                label: metricModels[index].label,
                                tint: metricModels[index].tint,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 18),
              SingleChildScrollView(
                key: const Key('calendar-filter-strip'),
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: CalendarFilterMode.values
                      .map(
                        (mode) => Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: CalendarFilterPill(
                            label: _filterLabel(localization, mode),
                            selected: selectedFilter == mode,
                            onTap: () => onSelectFilter(mode),
                          ),
                        ),
                      )
                      .toList(growable: false),
                ),
              ),
              if (overview.accessState == CalendarHistoryAccessState.locked) ...[
                const SizedBox(height: 18),
                CalendarSurfaceCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        localization.calendarLockedTitle,
                        style: Theme.of(context).textTheme.headlineSmall
                            ?.copyWith(
                              color: CalendarPageStyle.ink,
                              fontWeight: FontWeight.w700,
                              letterSpacing: -0.2,
                            ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        localization.calendarLockedMessage,
                        style: CalendarPageStyle.summaryBody(context),
                      ),
                      const SizedBox(height: 18),
                      FilledButton.tonalIcon(
                        onPressed: () => context.go(InsightsPage.routePath),
                        icon: const Icon(Icons.auto_graph_rounded),
                        label: Text(localization.calendarOpenInsightsCta),
                      ),
                    ],
                  ),
                ),
              ],
              if (overview.state == CalendarOverviewState.noData) ...[
                const SizedBox(height: 18),
                CalendarSurfaceCard(
                  color: const Color(0xFFFFFDF9),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        localization.calendarNoDataTitle,
                        style: Theme.of(context).textTheme.headlineSmall
                            ?.copyWith(
                              color: CalendarPageStyle.ink,
                              fontWeight: FontWeight.w700,
                              letterSpacing: -0.2,
                            ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        localization.calendarNoDataMessage,
                        style: CalendarPageStyle.summaryBody(context),
                      ),
                    ],
                  ),
                ),
              ],
              const SizedBox(height: 18),
              CalendarSurfaceCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        for (var index = 0; index < weekdayLabels.length; index++)
                          Expanded(
                            child: CalendarWeekdayLabel(weekdayLabels[index]),
                          ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    LayoutBuilder(
                      builder: (context, constraints) {
                        final crossAxisSpacing = 8.0;
                        final itemWidth =
                            (constraints.maxWidth - crossAxisSpacing * 6) / 7;
                        final itemHeight = math.max(itemWidth * 1.02, 54);

                        return SizedBox(
                          key: const Key('calendar-heatmap-grid'),
                          height: itemHeight * 6 + crossAxisSpacing * 5,
                          child: GridView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: visualCells.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 7,
                                  crossAxisSpacing: crossAxisSpacing,
                                  mainAxisSpacing: crossAxisSpacing,
                                  childAspectRatio: itemWidth / itemHeight,
                                ),
                            itemBuilder: (context, index) {
                              final cell = visualCells[index];
                              final isSelected =
                                  cell.day?.dayOfMonth == selectedDayNumber.value &&
                                  cell.day?.detail != null;

                              return CalendarHeatmapTile(
                                key: cell.day == null
                                    ? null
                                    : Key('calendar-day-${cell.day!.dayOfMonth}'),
                                dayLabel: cell.dayLabel,
                                offsetLabel: cell.offsetLabel,
                                active: isSelected,
                                currentMonth: cell.currentMonth,
                                fillColor: cell.fillColor,
                                onTap: cell.day?.detail == null
                                    ? null
                                    : () => selectedDayNumber.value =
                                          cell.day!.dayOfMonth,
                              );
                            },
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
                ],
              ),
            ),
          ],
        ),
        if (bottomDetail != null) Align(
          alignment: Alignment.bottomCenter,
          child: bottomDetail,
        ),
      ],
    );
  }

  /// 筛选文案在页面层统一映射，避免区块内部重复写 switch。
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

/// 页面错误态只承担当前 feature 的重试入口，不把用户甩回占位页。
class _CalendarErrorState extends StatelessWidget {
  /// 创建错误态。
  const _CalendarErrorState({
    required this.title,
    required this.body,
    required this.retryLabel,
    required this.onRetry,
  });

  /// 标题。
  final String title;

  /// 说明文案。
  final String body;

  /// 重试按钮文案。
  final String retryLabel;

  /// 重试回调。
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 28),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: CalendarPageStyle.ink,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              body,
              textAlign: TextAlign.center,
              style: CalendarPageStyle.summaryBody(context),
            ),
            const SizedBox(height: 18),
            FilledButton(onPressed: onRetry, child: Text(retryLabel)),
          ],
        ),
      ),
    );
  }
}

/// 摘要指标模型把显示层所需的图标、值和标签收敛成单一对象。
class _SummaryMetricModel {
  /// 创建摘要指标模型。
  const _SummaryMetricModel({
    required this.key,
    required this.icon,
    required this.value,
    required this.label,
    required this.tint,
  });

  /// 测试定位键。
  final String key;

  /// 指标图标。
  final IconData icon;

  /// 指标值。
  final String value;

  /// 指标标签。
  final String label;

  /// 指标色块底色。
  final Color tint;
}

/// 热力图视图格子承接“业务日 -> 42 格月视图”的显示层映射。
class _VisualCalendarCell {
  /// 创建视图格子。
  const _VisualCalendarCell({
    required this.dayLabel,
    required this.currentMonth,
    required this.fillColor,
    this.offsetLabel,
    this.day,
  });

  /// 日期文案。
  final String dayLabel;

  /// 是否属于当前月份。
  final bool currentMonth;

  /// 底色。
  final Color fillColor;

  /// 偏移文案。
  final String? offsetLabel;

  /// 当前月真实数据格。
  final CalendarDayCell? day;
}

/// 将聚合结果映射成首屏的 4 个摘要指标，保持页面只做消费。
List<_SummaryMetricModel> _buildMetricModels(
  AppLocalizations localization,
  CalendarMonthlySummary summary,
  String localeTag,
) {
  return [
    _SummaryMetricModel(
      key: 'calendar-summary-metric-average-delay',
      icon: Icons.track_changes_rounded,
      value: _signedMinuteLabel(summary.averageDelayMinutes),
      label: localization.calendarMetricAverageDelayLabel,
      tint: const Color(0xFFE5F4F2),
    ),
    _SummaryMetricModel(
      key: 'calendar-summary-metric-average-sleep',
      icon: Icons.bedtime_rounded,
      value: _durationLabel(summary.averageSleepDurationMinutes),
      label: localization.calendarMetricAverageSleepLabel,
      tint: const Color(0xFFE7EBFF),
    ),
    _SummaryMetricModel(
      key: 'calendar-summary-metric-average-wake',
      icon: Icons.wb_sunny_outlined,
      value: DateFormat.jm(
        localeTag,
      ).format(_toClockDate(summary.averageWakeTimeMinutes)),
      label: localization.calendarMetricAverageWakeLabel,
      tint: const Color(0xFFFFEEE7),
    ),
    _SummaryMetricModel(
      key: 'calendar-summary-metric-tracked-days',
      icon: Icons.star_border_rounded,
      value: '${summary.recordedNights}',
      label: localization.calendarMetricTrackedDaysLabel,
      tint: const Color(0xFFE8F5F2),
    ),
  ];
}

/// 6x7 月视图由当前月数据加前后补位组成，保证截图和真机都有稳定骨架。
List<_VisualCalendarCell> _buildVisualCells(CalendarOverview overview) {
  final firstDay = overview.month;
  final leadingDays = firstDay.weekday % 7;
  final previousMonthLastDay = DateTime(firstDay.year, firstDay.month, 0).day;
  final cells = <_VisualCalendarCell>[];

  for (var index = 0; index < leadingDays; index++) {
    cells.add(
      _VisualCalendarCell(
        dayLabel: '${previousMonthLastDay - leadingDays + index + 1}',
        currentMonth: false,
        fillColor: Colors.white.withValues(alpha: 0.82),
      ),
    );
  }

  for (final day in overview.days) {
    cells.add(
      _VisualCalendarCell(
        dayLabel: '${day.dayOfMonth}',
        currentMonth: true,
        fillColor: _cellFillColor(day.visualState),
        offsetLabel: day.detail == null
            ? null
            : _signedMinuteLabel(day.detail!.delayMinutes),
        day: day,
      ),
    );
  }

  for (var index = 1; cells.length < 42; index++) {
    cells.add(
      _VisualCalendarCell(
        dayLabel: '$index',
        currentMonth: false,
        fillColor: Colors.white.withValues(alpha: 0.82),
      ),
    );
  }

  return cells;
}

/// 按星期日起始生成短标签，中文环境压成单字，其他环境保留缩写。
List<String> _buildWeekdayLabels(String localeTag) {
  return List<String>.generate(7, (index) {
    final rawLabel = DateFormat.E(localeTag).format(DateTime(2026, 6, 7 + index));
    if (rawLabel.startsWith('周') || rawLabel.startsWith('星期')) {
      return rawLabel.substring(rawLabel.length - 1);
    }
    return rawLabel.toUpperCase();
  });
}

/// 热力图底色继续尊重聚合层给出的视觉语义，不在显示层重定义业务颜色。
Color _cellFillColor(CalendarDayVisualState state) {
  return switch (state) {
    CalendarDayVisualState.noData => Colors.white.withValues(alpha: 0.86),
    CalendarDayVisualState.onTarget => CalendarPageStyle.onTargetFill,
    CalendarDayVisualState.slightDelay => CalendarPageStyle.slightDelayFill,
    CalendarDayVisualState.majorDelay => CalendarPageStyle.majorDelayFill,
    CalendarDayVisualState.partial => CalendarPageStyle.partialFill,
  };
}

/// 月度与单日都复用同一套偏移紧凑格式，避免页面出现两种时间口径。
String _signedMinuteLabel(int minutes) {
  final absoluteMinutes = minutes.abs();
  final hours = absoluteMinutes ~/ 60;
  final remainingMinutes = absoluteMinutes % 60;
  final sign = minutes < 0 ? '-' : '+';

  if (hours == 0) {
    return '$sign${remainingMinutes}m';
  }
  return '$sign${hours}h ${remainingMinutes.toString().padLeft(2, '0')}m';
}

/// 详情层偏移说明继续优先讲语义，而不是只露出原始分钟差。
String _offsetLabel(AppLocalizations localization, int delayMinutes) {
  if (delayMinutes.abs() <= 5) {
    return localization.calendarOffsetOnTarget;
  }
  if (delayMinutes < 0) {
    return localization.calendarOffsetEarly(delayMinutes.abs());
  }
  return localization.calendarOffsetLate(delayMinutes);
}

/// 把分钟时长格式化成紧凑展示值，贴近摘要卡和详情卡的视觉密度。
String _durationLabel(int minutes) {
  final hours = minutes ~/ 60;
  final remainingMinutes = minutes % 60;
  return '${hours}h ${remainingMinutes.toString().padLeft(2, '0')}m';
}

/// 把分钟恢复成时钟时间，保证月度摘要和详情卡共享一套时间基线。
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
