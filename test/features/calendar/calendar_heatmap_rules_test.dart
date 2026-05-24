import 'package:flutter_test/flutter_test.dart';
import 'package:rhythm/features/calendar/domain/calendar_heat_level.dart';
import 'package:rhythm/features/calendar/domain/calendar_heatmap_rules.dart';
import 'package:rhythm/features/goal_schedule/domain/goal_schedule_settings.dart';
import 'package:rhythm/features/sleep_records/domain/effective_sleep_record.dart';
import 'package:rhythm/features/sleep_records/domain/sleep_record_confidence.dart';
import 'package:rhythm/features/sleep_records/domain/sleep_record_source.dart';

/// 验证阶段六热力图规则会基于目标作息计算日摘要和热力等级。
void main() {
  const settings = GoalScheduleSettings(
    targetBedtimeMinutes: 23 * 60 + 30,
    targetWakeMinutes: 7 * 60 + 30,
    lateThresholdMinutes: 30,
    dayStartMinutes: 4 * 60,
  );

  test('无记录日期输出 noRecord 热力等级', () {
    final summary = CalendarHeatmapRules.buildDaySummary(
      date: DateTime.utc(2026, 5, 24),
      record: null,
      settings: settings,
      tags: const <String>[],
    );

    expect(summary.heatLevel, CalendarHeatLevel.noRecord);
    expect(summary.hasRecord, isFalse);
  });

  test('目标阈值内的记录输出 onTarget 热力等级', () {
    final summary = CalendarHeatmapRules.buildDaySummary(
      date: DateTime.utc(2026, 5, 24),
      record: _buildRecord(
        id: 'r1',
        recordDate: DateTime.utc(2026, 5, 24),
        fellAsleepAt: DateTime.utc(2026, 5, 24, 23, 45),
      ),
      settings: settings,
      tags: const <String>['刷手机'],
    );

    expect(summary.heatLevel, CalendarHeatLevel.onTarget);
    expect(summary.sleepOffsetMinutes, 15);
    expect(summary.tags, ['刷手机']);
  });

  test('超过阈值但未明显偏离时输出 late 热力等级', () {
    final summary = CalendarHeatmapRules.buildDaySummary(
      date: DateTime.utc(2026, 5, 24),
      record: _buildRecord(
        id: 'r2',
        recordDate: DateTime.utc(2026, 5, 24),
        fellAsleepAt: DateTime.utc(2026, 5, 25, 0, 20),
      ),
      settings: settings,
      tags: const <String>[],
    );

    expect(summary.heatLevel, CalendarHeatLevel.late);
    expect(summary.sleepOffsetMinutes, 50);
    expect(summary.isLate, isTrue);
  });

  test('严重偏离目标时间时输出 severelyLate 热力等级', () {
    final summary = CalendarHeatmapRules.buildDaySummary(
      date: DateTime.utc(2026, 5, 24),
      record: _buildRecord(
        id: 'r3',
        recordDate: DateTime.utc(2026, 5, 24),
        fellAsleepAt: DateTime.utc(2026, 5, 25, 1, 40),
      ),
      settings: settings,
      tags: const <String>[],
    );

    expect(summary.heatLevel, CalendarHeatLevel.severelyLate);
    expect(summary.sleepOffsetMinutes, 130);
  });
}

/// 构造热力规则测试用有效记录。
EffectiveSleepRecord _buildRecord({
  required String id,
  required DateTime recordDate,
  required DateTime fellAsleepAt,
}) {
  return EffectiveSleepRecord(
    recordId: id,
    recordDate: recordDate,
    fellAsleepAt: fellAsleepAt,
    wokeUpAt: fellAsleepAt.add(const Duration(hours: 8)),
    durationMinutes: 8 * 60,
    source: SleepRecordSource.healthKit,
    confidence: SleepRecordConfidence.high,
    timezone: 'Asia/Shanghai',
    isUserConfirmed: false,
    sourceRecordId: null,
  );
}
