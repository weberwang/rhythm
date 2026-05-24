import 'package:flutter_test/flutter_test.dart';
import 'package:rhythm/features/goal_schedule/domain/goal_schedule_settings.dart';
import 'package:rhythm/features/insights/domain/stability_score_rules.dart';
import 'package:rhythm/features/sleep_records/domain/effective_sleep_record.dart';
import 'package:rhythm/features/sleep_records/domain/sleep_record_confidence.dart';
import 'package:rhythm/features/sleep_records/domain/sleep_record_source.dart';

/// 验证稳定度规则覆盖样本不足和分值区间。
void main() {
  const settings = GoalScheduleSettings(
    targetBedtimeMinutes: 23 * 60 + 30,
    targetWakeMinutes: 7 * 60 + 30,
    lateThresholdMinutes: 30,
    dayStartMinutes: 4 * 60,
  );

  test('样本不足时返回数据不足说明', () {
    final score = StabilityScoreRules.calculate(
      settings: settings,
      records: _records(<int>[5, 55]),
    );

    expect(score.level, StabilityScoreLevel.insufficient);
    expect(score.score, 0);
  });

  test('波动很小时返回高稳定度', () {
    final score = StabilityScoreRules.calculate(
      settings: settings,
      records: _records(<int>[5, 8, 10, 6, 12]),
    );

    expect(score.level, StabilityScoreLevel.steady);
    expect(score.score, greaterThanOrEqualTo(80));
  });

  test('明显波动时返回待恢复稳定度', () {
    final score = StabilityScoreRules.calculate(
      settings: settings,
      records: _records(<int>[10, 75, 92, 40, 88]),
    );

    expect(score.level, StabilityScoreLevel.needsRecovery);
    expect(score.score, lessThan(60));
  });
}

List<EffectiveSleepRecord> _records(List<int> offsets) {
  return offsets.asMap().entries.map((entry) {
    final day = 18 + entry.key;
    return EffectiveSleepRecord(
      recordId: 'r$day',
      recordDate: DateTime.utc(2026, 5, day),
      fellAsleepAt: DateTime.utc(
        2026,
        5,
        day,
        23,
        30 + entry.value,
      ),
      wokeUpAt: DateTime.utc(2026, 5, day + 1, 7, 30),
      durationMinutes: 8 * 60,
      source: SleepRecordSource.healthKit,
      confidence: SleepRecordConfidence.high,
      timezone: 'Asia/Shanghai',
      isUserConfirmed: false,
      sourceRecordId: null,
    );
  }).toList();
}
