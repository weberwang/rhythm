import 'package:rhythm/features/calendar/domain/calendar_day_summary.dart';
import 'package:rhythm/features/calendar/domain/calendar_heat_level.dart';
import 'package:rhythm/features/calendar/domain/calendar_month_summary.dart';
import 'package:rhythm/features/goal_schedule/domain/goal_schedule_settings.dart';
import 'package:rhythm/features/sleep_records/domain/effective_sleep_record.dart';

/// 统一承接阶段六热力图和月份摘要计算规则。
class CalendarHeatmapRules {
  const CalendarHeatmapRules._();

  /// 计算某一天的热力摘要，避免页面层重复推导时间差和颜色等级。
  static CalendarDaySummary buildDaySummary({
    required DateTime date,
    required EffectiveSleepRecord? record,
    required GoalScheduleSettings settings,
    required List<String> tags,
  }) {
    if (record == null) {
      return CalendarDaySummary(
        date: date,
        record: null,
        sleepOffsetMinutes: null,
        heatLevel: CalendarHeatLevel.noRecord,
        tags: tags,
      );
    }

    final target = DateTime.utc(
      date.year,
      date.month,
      date.day,
      settings.targetBedtimeMinutes ~/ 60,
      settings.targetBedtimeMinutes % 60,
    );
    final offsetMinutes = record.fellAsleepAt.difference(target).inMinutes;

    return CalendarDaySummary(
      date: date,
      record: record,
      sleepOffsetMinutes: offsetMinutes,
      heatLevel: _resolveHeatLevel(
        offsetMinutes: offsetMinutes,
        lateThresholdMinutes: settings.lateThresholdMinutes,
      ),
      tags: tags,
    );
  }

  /// 按月份聚合单日摘要，用于页面头部摘要卡和热力图数据源。
  static CalendarMonthSummary buildMonthSummary({
    required DateTime month,
    required List<CalendarDaySummary> days,
  }) {
    final onTargetDays = days
        .where((day) => day.heatLevel == CalendarHeatLevel.onTarget)
        .length;
    final recordedDays = days.where((day) => day.hasRecord).length;
    final lateDays = days.where((day) => day.isLate).toList()
      ..sort((left, right) => left.date.compareTo(right.date));

    return CalendarMonthSummary(
      month: DateTime.utc(month.year, month.month),
      days: days,
      onTargetDays: onTargetDays,
      recordedDays: recordedDays,
      latestLateDay: lateDays.isEmpty ? null : lateDays.last,
    );
  }

  static CalendarHeatLevel _resolveHeatLevel({
    required int offsetMinutes,
    required int lateThresholdMinutes,
  }) {
    if (offsetMinutes <= lateThresholdMinutes) {
      return CalendarHeatLevel.onTarget;
    }
    if (offsetMinutes <= lateThresholdMinutes + 15) {
      return CalendarHeatLevel.slightlyLate;
    }
    if (offsetMinutes <= lateThresholdMinutes + 60) {
      return CalendarHeatLevel.late;
    }
    return CalendarHeatLevel.severelyLate;
  }
}
