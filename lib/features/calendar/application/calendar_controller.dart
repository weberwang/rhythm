import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rhythm/core/time/time_context_provider.dart';
import 'package:rhythm/features/calendar/application/calendar_view_state.dart';
import 'package:rhythm/features/calendar/domain/calendar_day_summary.dart';
import 'package:rhythm/features/calendar/domain/calendar_filter.dart';
import 'package:rhythm/features/calendar/domain/calendar_heatmap_rules.dart';
import 'package:rhythm/features/goal_schedule/application/goal_schedule_providers.dart';
import 'package:rhythm/features/goal_schedule/domain/goal_schedule_settings.dart';
import 'package:rhythm/features/sleep_records/application/effective_sleep_record_provider.dart';
import 'package:rhythm/features/sleep_records/application/sleep_delay_tag_providers.dart';
import 'package:rhythm/features/sleep_records/domain/effective_sleep_record.dart';
import 'package:rhythm/features/sleep_records/domain/sleep_delay_tag_rules.dart';

/// 聚合目标作息、有效记录、标签和筛选状态，向日历页输出单一状态。
final calendarControllerProvider =
    AsyncNotifierProvider.autoDispose<CalendarController, CalendarViewState>(
      CalendarController.new,
    );

/// 承接日历页月份摘要、标签聚合和筛选应用。
class CalendarController extends AsyncNotifier<CalendarViewState> {
  CalendarFilter _filter = const CalendarFilter();

  @override
  Future<CalendarViewState> build() async {
    return _buildState();
  }

  /// 更新筛选条件并重新计算当前月份摘要。
  Future<void> updateFilter(CalendarFilter filter) async {
    _filter = filter;
    await reload();
  }

  /// 重新读取记录和标签并刷新当前月份摘要，供标签保存后实时回写页面。
  Future<void> reload() async {
    state = const AsyncLoading();
    state = AsyncData(await _buildState());
  }

  Future<CalendarViewState> _buildState() async {
    final settings = await ref.read(savedGoalScheduleSettingsProvider.future);
    if (settings == null) {
      return const CalendarViewState(status: CalendarViewStatus.goalMissing);
    }

    final records = await ref.read(
      recentThirtyDayEffectiveSleepRecordsProvider.future,
    );
    final now = ref.read(timeContextProvider).now;
    final month = DateTime.utc(now.year, now.month);
    final savedTagsByDate = await _loadTagsForMonth(ref: ref, month: month);
    final days = _buildMonthDays(
      month: month,
      settings: settings,
      records: records,
      savedTagsByDate: savedTagsByDate,
      filter: _filter,
    );

    return CalendarViewState(
      status: CalendarViewStatus.ready,
      monthSummary: CalendarHeatmapRules.buildMonthSummary(
        month: month,
        days: days,
      ),
      availableTags: SleepDelayTagRules.defaultTags,
      savedTagsByDate: savedTagsByDate,
      activeFilter: _filter,
    );
  }
}

/// 生成当前月份所有日期的热力摘要，避免页面层自行遍历记录。
List<CalendarDaySummary> _buildMonthDays({
  required DateTime month,
  required GoalScheduleSettings settings,
  required List<EffectiveSleepRecord> records,
  required Map<DateTime, List<String>> savedTagsByDate,
  required CalendarFilter filter,
}) {
  final daysInMonth = DateTime.utc(month.year, month.month + 1, 0).day;
  final recordByDate = <DateTime, EffectiveSleepRecord>{
    for (final record in records)
      DateTime.utc(
        record.recordDate.year,
        record.recordDate.month,
        record.recordDate.day,
      ): record,
  };

  final days = List<CalendarDaySummary>.generate(daysInMonth, (index) {
    final date = DateTime.utc(month.year, month.month, index + 1);
    return CalendarHeatmapRules.buildDaySummary(
      date: date,
      record: recordByDate[date],
      settings: settings,
      tags: savedTagsByDate[date] ?? const <String>[],
    );
  });

  if (!filter.onlyRecordedDays) {
    if (!filter.lateOnly) {
      return days;
    }
    return days.where((day) => day.isLate).toList();
  }
  final filtered = days.where((day) => day.hasRecord);
  if (!filter.lateOnly) {
    return filtered.toList();
  }
  return filtered.where((day) => day.isLate).toList();
}

Future<Map<DateTime, List<String>>> _loadTagsForMonth({
  required Ref ref,
  required DateTime month,
}) async {
  final repository = ref.read(sleepDelayTagRepositoryProvider);
  final daysInMonth = DateTime.utc(month.year, month.month + 1, 0).day;
  final result = <DateTime, List<String>>{};
  for (var day = 1; day <= daysInMonth; day++) {
    final date = DateTime.utc(month.year, month.month, day);
    final tags = await repository.readTags(recordDate: date);
    if (tags.isNotEmpty) {
      result[date] = tags;
    }
  }
  return result;
}
