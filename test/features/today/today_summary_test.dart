import 'package:flutter_test/flutter_test.dart';
import 'package:rhythm/features/goal_schedule/domain/goal_schedule_settings.dart';
import 'package:rhythm/features/sleep_records/domain/effective_sleep_record.dart';
import 'package:rhythm/features/sleep_records/domain/health_platform_state.dart';
import 'package:rhythm/features/sleep_records/domain/sleep_record_confidence.dart';
import 'package:rhythm/features/sleep_records/domain/sleep_record_source.dart';
import 'package:rhythm/features/today/domain/today_primary_action.dart';
import 'package:rhythm/features/today/domain/today_summary.dart';

/// 验证今日页摘要领域口径。
void main() {
  const settings = GoalScheduleSettings(
    targetBedtimeMinutes: 23 * 60 + 30,
    targetWakeMinutes: 7 * 60 + 30,
    lateThresholdMinutes: 30,
    dayStartMinutes: 4 * 60,
  );

  EffectiveSleepRecord buildRecord({
    required String id,
    required DateTime recordDate,
    required DateTime fellAsleepAt,
    required bool isUserConfirmed,
    SleepRecordSource source = SleepRecordSource.manual,
  }) {
    return EffectiveSleepRecord(
      recordId: id,
      recordDate: recordDate,
      fellAsleepAt: fellAsleepAt,
      wokeUpAt: fellAsleepAt.add(const Duration(hours: 8)),
      durationMinutes: 8 * 60,
      source: source,
      confidence: SleepRecordConfidence.high,
      timezone: 'Asia/Shanghai',
      isUserConfirmed: isUserConfirmed,
      sourceRecordId: null,
    );
  }

  test('有目标且昨晚在阈值内时判定为达标', () {
    final summary = TodaySummary.fromRecords(
      settings: settings,
      records: <EffectiveSleepRecord>[
        buildRecord(
          id: 'r1',
          recordDate: DateTime.utc(2026, 5, 23),
          fellAsleepAt: DateTime.utc(2026, 5, 23, 23, 50),
          isUserConfirmed: false,
          source: SleepRecordSource.healthKit,
        ),
      ],
      healthPlatformState: HealthPlatformState.iosAvailable(),
      now: DateTime.utc(2026, 5, 24, 20, 0),
    );

    expect(summary.hasRecord, isTrue);
    expect(summary.isGoalMet, isTrue);
    expect(summary.showRecoveryCard, isFalse);
    expect(summary.primaryAction, TodayPrimaryAction.enterBedtimeMode);
  });

  test('晚睡超过阈值时触发恢复建议', () {
    final summary = TodaySummary.fromRecords(
      settings: settings,
      records: <EffectiveSleepRecord>[
        buildRecord(
          id: 'r1',
          recordDate: DateTime.utc(2026, 5, 23),
          fellAsleepAt: DateTime.utc(2026, 5, 24, 0, 20),
          isUserConfirmed: false,
        ),
      ],
      healthPlatformState: HealthPlatformState.iosAvailable(),
      now: DateTime.utc(2026, 5, 24, 20, 0),
    );

    expect(summary.isGoalMet, isFalse);
    expect(summary.showRecoveryCard, isTrue);
    expect(summary.sleepOffsetMinutes, 50);
    expect(summary.primaryAction, TodayPrimaryAction.viewRecoveryPlan);
  });

  test('无昨晚记录时主行动为手动补录', () {
    final summary = TodaySummary.fromRecords(
      settings: settings,
      records: const <EffectiveSleepRecord>[],
      healthPlatformState: HealthPlatformState.iosAvailable(),
      now: DateTime.utc(2026, 5, 24, 20, 0),
    );

    expect(summary.hasRecord, isFalse);
    expect(summary.primaryAction, TodayPrimaryAction.manualRecord);
    expect(summary.showRecoveryCard, isFalse);
  });

  test('权限失败时主行动为查看权限说明', () {
    final summary = TodaySummary.fromRecords(
      settings: settings,
      records: const <EffectiveSleepRecord>[],
      healthPlatformState: HealthPlatformState.iosPermissionRequired(),
      now: DateTime.utc(2026, 5, 24, 20, 0),
    );

    expect(summary.hasRecord, isFalse);
    expect(summary.primaryAction, TodayPrimaryAction.openPermissionHelp);
  });

  test('仅手动记录时标记为用户确认结果', () {
    final summary = TodaySummary.fromRecords(
      settings: settings,
      records: <EffectiveSleepRecord>[
        buildRecord(
          id: 'r1',
          recordDate: DateTime.utc(2026, 5, 23),
          fellAsleepAt: DateTime.utc(2026, 5, 23, 23, 40),
          isUserConfirmed: true,
        ),
      ],
      healthPlatformState: HealthPlatformState.iosAvailable(),
      now: DateTime.utc(2026, 5, 24, 20, 0),
    );

    expect(summary.hasRecord, isTrue);
    expect(summary.isUserConfirmedRecord, isTrue);
  });
}
