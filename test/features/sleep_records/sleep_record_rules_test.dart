import 'package:flutter_test/flutter_test.dart';
import 'package:rhythm/features/goal_schedule/domain/goal_schedule.dart';
import 'package:rhythm/features/sleep_records/domain/sleep_record.dart';

void main() {
  test('在熬夜阈值内的记录判定为达标', () {
    final schedule = GoalSchedule(
      id: 'goal-1',
      targetBedtimeMinutes: 23 * 60,
      targetWakeMinutes: 7 * 60,
      lateThresholdMinutes: 30,
      dayStartMinutes: 4 * 60,
    );
    final record = SleepRecord(
      id: 'record-1',
      recordDate: DateTime(2026, 5, 22),
      fellAsleepAt: DateTime(2026, 5, 22, 23, 20),
      wokeUpAt: DateTime(2026, 5, 23, 7, 30),
      source: SleepRecordSource.manual,
      confidence: SleepRecordConfidence.high,
      timezone: 'Asia/Shanghai',
    );

    expect(record.isWithinSchedule(schedule), isTrue);
    expect(record.delayMinutes(schedule), 20);
  });

  test('超过熬夜阈值的记录判定为未达标', () {
    final schedule = GoalSchedule(
      id: 'goal-1',
      targetBedtimeMinutes: 23 * 60,
      targetWakeMinutes: 7 * 60,
      lateThresholdMinutes: 30,
      dayStartMinutes: 4 * 60,
    );
    final record = SleepRecord(
      id: 'record-2',
      recordDate: DateTime(2026, 5, 22),
      fellAsleepAt: DateTime(2026, 5, 23, 0, 10),
      wokeUpAt: DateTime(2026, 5, 23, 8, 0),
      source: SleepRecordSource.manual,
      confidence: SleepRecordConfidence.high,
      timezone: 'Asia/Shanghai',
    );

    expect(record.isWithinSchedule(schedule), isFalse);
    expect(record.delayMinutes(schedule), 70);
  });

  test('根据一天起始时间归属记录日期', () {
    final schedule = GoalSchedule(
      id: 'goal-1',
      targetBedtimeMinutes: 23 * 60,
      targetWakeMinutes: 7 * 60,
      lateThresholdMinutes: 30,
      dayStartMinutes: 4 * 60,
    );

    expect(
      schedule.resolveRecordDate(DateTime(2026, 5, 23, 2, 30)),
      DateTime(2026, 5, 22),
    );
    expect(
      schedule.resolveRecordDate(DateTime(2026, 5, 23, 6, 0)),
      DateTime(2026, 5, 23),
    );
  });
}
