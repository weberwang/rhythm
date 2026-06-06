import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../sleep_data_core/application/providers/goal_schedule_repository_provider.dart';
import '../../../sleep_data_core/application/providers/sleep_record_repository_provider.dart';
import '../../../sleep_data_core/domain/entities/goal_schedule.dart';
import '../../../sleep_data_core/domain/entities/sleep_record.dart';
import '../../domain/entities/calendar_overview.dart';

part 'calendar_overview_provider.g.dart';

/// 暴露当前 calendar 月视图的时间锚点，便于测试稳定覆盖月度边界。
@riverpod
DateTime calendarNow(Ref ref) => DateTime.now();

/// 日历页筛选状态留在应用层，避免显示层自己管理业务筛选语义。
@riverpod
class CalendarFilterController extends _$CalendarFilterController {
  /// 默认先展示全部记录，保证用户进入页面就能看见完整热力图。
  @override
  CalendarFilterMode build() => CalendarFilterMode.all;

  /// 切换筛选模式时只更新结构化状态，不在这里拼装文案。
  void select(CalendarFilterMode mode) {
    state = mode;
  }
}

/// 聚合 calendar 所需的月度摘要、热力图格子与锁定态。
@riverpod
Future<CalendarOverview> calendarOverview(Ref ref) async {
  final now = ref.watch(calendarNowProvider);
  final selectedFilter = ref.watch(calendarFilterControllerProvider);
  final scheduleRepository = ref.watch(goalScheduleRepositoryProvider);
  final recordRepository = ref.watch(sleepRecordRepositoryProvider);
  final schedule =
      await scheduleRepository.readActiveSchedule() ?? _fallbackSchedule(now);
  final month = DateTime(now.year, now.month);
  final monthEnd = DateTime(now.year, now.month + 1, 0);
  final records = await recordRepository.readRecordsInRange(
    startDate: month,
    endDate: monthEnd,
  );
  final latestRecordByDay = _latestRecordByDay(records);
  final visibleRecordByDay = _visibleRecordByDay(
    latestRecordByDay: latestRecordByDay,
    selectedFilter: selectedFilter,
    schedule: schedule,
  );

  return CalendarOverview(
    month: month,
    state: latestRecordByDay.isEmpty
        ? CalendarOverviewState.noData
        : CalendarOverviewState.ready,
    selectedFilter: selectedFilter,
    accessState: selectedFilter == CalendarFilterMode.lockedInsights
        ? CalendarHistoryAccessState.locked
        : CalendarHistoryAccessState.available,
    summary: _buildMonthlySummary(
      records: visibleRecordByDay.values.toList(growable: false),
      schedule: schedule,
    ),
    days: _buildDayCells(
      month: month,
      visibleRecordByDay: visibleRecordByDay,
      schedule: schedule,
    ),
  );
}

/// 当前月在还没建立目标作息时，也要保留稳定基线以解释相对偏移。
GoalSchedule _fallbackSchedule(DateTime now) {
  return GoalSchedule(
    id: 'calendar-fallback-${now.year}-${now.month}',
    bedtimeMinutes: 23 * 60,
    wakeTimeMinutes: 7 * 60,
    createdAt: now,
  );
}

/// 同一天可能存在补录与修正，保留最新一条记录作为月视图解释来源。
Map<DateTime, SleepRecord> _latestRecordByDay(List<SleepRecord> records) {
  final result = <DateTime, SleepRecord>{};
  for (final record in records) {
    final normalizedDate = DateTime(
      record.sleepDate.year,
      record.sleepDate.month,
      record.sleepDate.day,
    );
    result.putIfAbsent(normalizedDate, () => record);
  }
  return result;
}

/// 锁定态仍保留基础热力图，只把更深历史筛选解释为升级边界。
Map<DateTime, SleepRecord> _visibleRecordByDay({
  required Map<DateTime, SleepRecord> latestRecordByDay,
  required CalendarFilterMode selectedFilter,
  required GoalSchedule schedule,
}) {
  if (selectedFilter == CalendarFilterMode.lockedInsights) {
    return latestRecordByDay;
  }

  final entries = latestRecordByDay.entries.where((entry) {
    final record = entry.value;
    return switch (selectedFilter) {
      CalendarFilterMode.all => true,
      CalendarFilterMode.delayed =>
        _calculateDelayMinutes(
          actualMinutes: record.bedtimeMinutes,
          targetMinutes: schedule.bedtimeMinutes,
        ) > 15,
      CalendarFilterMode.adjusted => record.isManuallyAdjusted,
      CalendarFilterMode.lockedInsights => true,
    };
  });

  return Map<DateTime, SleepRecord>.fromEntries(entries);
}

/// 月度摘要只基于当前筛选可见记录统计，确保筛选切换后语义同步变化。
CalendarMonthlySummary _buildMonthlySummary({
  required List<SleepRecord> records,
  required GoalSchedule schedule,
}) {
  var onTargetNights = 0;
  var delayedNights = 0;
  var adjustedNights = 0;
  var partialNights = 0;

  for (final record in records) {
    final visualState = _resolveVisualState(record: record, schedule: schedule);
    final delayMinutes = _calculateDelayMinutes(
      actualMinutes: record.bedtimeMinutes,
      targetMinutes: schedule.bedtimeMinutes,
    );
    if (visualState == CalendarDayVisualState.onTarget) {
      onTargetNights += 1;
    }
    // 即便数据仍属 partial，只要已能看出明显偏移，就要计入“晚睡”摘要。
    if (delayMinutes > 15) {
      delayedNights += 1;
    }
    if (record.isManuallyAdjusted) {
      adjustedNights += 1;
    }
    if (record.confidence == SleepRecordConfidence.partial) {
      partialNights += 1;
    }
  }

  return CalendarMonthlySummary(
    recordedNights: records.length,
    onTargetNights: onTargetNights,
    delayedNights: delayedNights,
    adjustedNights: adjustedNights,
    partialNights: partialNights,
  );
}

/// 热力图始终按整月生成格子，筛选仅决定哪些日期被强调为“有记录”。
List<CalendarDayCell> _buildDayCells({
  required DateTime month,
  required Map<DateTime, SleepRecord> visibleRecordByDay,
  required GoalSchedule schedule,
}) {
  final totalDays = DateTime(month.year, month.month + 1, 0).day;

  return List<CalendarDayCell>.generate(totalDays, (index) {
    final date = DateTime(month.year, month.month, index + 1);
    final record = visibleRecordByDay[date];

    if (record == null) {
      return CalendarDayCell(
        date: date,
        dayOfMonth: index + 1,
        hasRecord: false,
        visualState: CalendarDayVisualState.noData,
      );
    }

    return CalendarDayCell(
      date: date,
      dayOfMonth: index + 1,
      hasRecord: true,
      visualState: _resolveVisualState(record: record, schedule: schedule),
      detail: CalendarDayDetail(
        sleepDate: record.sleepDate,
        bedtimeMinutes: record.bedtimeMinutes,
        wakeTimeMinutes: record.wakeTimeMinutes,
        delayMinutes: _calculateDelayMinutes(
          actualMinutes: record.bedtimeMinutes,
          targetMinutes: schedule.bedtimeMinutes,
        ),
        sleepDurationMinutes: _calculateSleepDurationMinutes(record),
        source: record.source,
        confidence: record.confidence,
        isManuallyAdjusted: record.isManuallyAdjusted,
        note: record.note,
      ),
    );
  });
}

/// 视觉优先级先看数据完整度，再看相对目标的偏移强度。
CalendarDayVisualState _resolveVisualState({
  required SleepRecord record,
  required GoalSchedule schedule,
}) {
  if (record.confidence == SleepRecordConfidence.partial) {
    return CalendarDayVisualState.partial;
  }

  final delayMinutes = _calculateDelayMinutes(
    actualMinutes: record.bedtimeMinutes,
    targetMinutes: schedule.bedtimeMinutes,
  );
  if (delayMinutes.abs() <= 15) {
    return CalendarDayVisualState.onTarget;
  }
  if (delayMinutes <= 60) {
    return CalendarDayVisualState.slightDelay;
  }
  return CalendarDayVisualState.majorDelay;
}

/// 相对目标偏移允许跨午夜归一，保持“提前为负、晚睡为正”的语义。
int _calculateDelayMinutes({
  required int actualMinutes,
  required int targetMinutes,
}) {
  final normalizedDiff =
      ((actualMinutes - targetMinutes) % Duration.minutesPerDay +
          Duration.minutesPerDay) %
      Duration.minutesPerDay;
  return normalizedDiff > 12 * 60
      ? normalizedDiff - Duration.minutesPerDay
      : normalizedDiff;
}

/// 睡眠时长在跨午夜场景下仍需保持正值，供单日详情直接消费。
int _calculateSleepDurationMinutes(SleepRecord record) {
  final rawDuration = record.wakeTimeMinutes - record.bedtimeMinutes;
  return rawDuration <= 0 ? rawDuration + Duration.minutesPerDay : rawDuration;
}
