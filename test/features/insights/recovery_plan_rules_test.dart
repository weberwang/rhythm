import 'package:flutter_test/flutter_test.dart';
import 'package:rhythm/features/goal_schedule/domain/goal_schedule_settings.dart';
import 'package:rhythm/features/insights/domain/recovery_plan_rules.dart';
import 'package:rhythm/features/sleep_records/domain/effective_sleep_record.dart';
import 'package:rhythm/features/sleep_records/domain/sleep_record_confidence.dart';
import 'package:rhythm/features/sleep_records/domain/sleep_record_source.dart';

/// 验证明显晚睡后会触发 1 到 3 天恢复计划。
void main() {
  const settings = GoalScheduleSettings(
    targetBedtimeMinutes: 23 * 60 + 30,
    targetWakeMinutes: 7 * 60 + 30,
    lateThresholdMinutes: 30,
    dayStartMinutes: 4 * 60,
  );

  test('明显晚睡后会生成 1 到 3 天恢复计划', () {
    final plan = RecoveryPlanRules.build(
      settings: settings,
      records: <EffectiveSleepRecord>[
        _buildRecord(
          id: 'late',
          recordDate: DateTime.utc(2026, 5, 23),
          fellAsleepAt: DateTime.utc(2026, 5, 24, 1, 20),
        ),
      ],
      now: DateTime.utc(2026, 5, 24, 20),
    );

    expect(plan, isNotNull);
    expect(plan!.steps.length, inInclusiveRange(1, 3));
  });

  test('轻微偏晚时不生成恢复计划', () {
    final plan = RecoveryPlanRules.build(
      settings: settings,
      records: <EffectiveSleepRecord>[
        _buildRecord(
          id: 'mild',
          recordDate: DateTime.utc(2026, 5, 23),
          fellAsleepAt: DateTime.utc(2026, 5, 23, 23, 45),
        ),
      ],
      now: DateTime.utc(2026, 5, 24, 20),
    );

    expect(plan, isNull);
  });
}

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
    isUserConfirmed: true,
    sourceRecordId: null,
  );
}
