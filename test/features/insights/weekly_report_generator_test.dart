import 'package:flutter_test/flutter_test.dart';
import 'package:rhythm/features/goal_schedule/domain/goal_schedule_settings.dart';
import 'package:rhythm/features/insights/domain/weekly_report_generator.dart';
import 'package:rhythm/features/sleep_records/domain/effective_sleep_record.dart';
import 'package:rhythm/features/sleep_records/domain/sleep_record_confidence.dart';
import 'package:rhythm/features/sleep_records/domain/sleep_record_source.dart';

/// 验证周报生成器只在满足样本要求时输出最近 7 天周报。
void main() {
  const settings = GoalScheduleSettings(
    targetBedtimeMinutes: 23 * 60 + 30,
    targetWakeMinutes: 7 * 60 + 30,
    lateThresholdMinutes: 30,
    dayStartMinutes: 4 * 60,
  );

  test('最近 7 天内至少 3 天有效记录时生成周报', () {
    final report = WeeklyReportGenerator.generate(
      settings: settings,
      records: _recordsWithThreeDays(),
      tagsByDate: <DateTime, List<String>>{
        DateTime.utc(2026, 5, 20): const <String>['刷手机'],
        DateTime.utc(2026, 5, 21): const <String>['加班'],
        DateTime.utc(2026, 5, 22): const <String>['刷手机'],
      },
      now: DateTime.utc(2026, 5, 24, 20),
    );

    expect(report, isNotNull);
    expect(report!.summary.qualifiedDayCount, greaterThanOrEqualTo(1));
    expect(report.days, hasLength(7));
    expect(report.reasonDistribution.first.label, '刷手机');
  });

  test('少于 3 天有效记录时不生成正式周报', () {
    final report = WeeklyReportGenerator.generate(
      settings: settings,
      records: _recordsWithThreeDays().take(2).toList(),
      tagsByDate: <DateTime, List<String>>{
        DateTime.utc(2026, 5, 20): const <String>['刷手机'],
      },
      now: DateTime.utc(2026, 5, 24, 20),
    );

    expect(report, isNull);
  });

  test('原因分布只统计用户确认标签', () {
    final report = WeeklyReportGenerator.generate(
      settings: settings,
      records: _recordsWithThreeDays(),
      tagsByDate: <DateTime, List<String>>{
        DateTime.utc(2026, 5, 20): const <String>['刷手机'],
        DateTime.utc(2026, 5, 21): const <String>[],
        DateTime.utc(2026, 5, 22): const <String>['加班'],
      },
      now: DateTime.utc(2026, 5, 24, 20),
    );

    expect(report, isNotNull);
    expect(
      report!.reasonDistribution.map((item) => item.label),
      containsAll(<String>['刷手机', '加班']),
    );
    expect(report.reasonDistribution.length, 2);
  });
}

List<EffectiveSleepRecord> _recordsWithThreeDays() {
  return <EffectiveSleepRecord>[
    _buildRecord(
      id: 'r1',
      recordDate: DateTime.utc(2026, 5, 20),
      fellAsleepAt: DateTime.utc(2026, 5, 20, 23, 40),
    ),
    _buildRecord(
      id: 'r2',
      recordDate: DateTime.utc(2026, 5, 21),
      fellAsleepAt: DateTime.utc(2026, 5, 22, 0, 52),
    ),
    _buildRecord(
      id: 'r3',
      recordDate: DateTime.utc(2026, 5, 22),
      fellAsleepAt: DateTime.utc(2026, 5, 22, 23, 58),
      isUserConfirmed: true,
    ),
  ];
}

/// 构造周报测试用有效记录。
EffectiveSleepRecord _buildRecord({
  required String id,
  required DateTime recordDate,
  required DateTime fellAsleepAt,
  bool isUserConfirmed = false,
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
    isUserConfirmed: isUserConfirmed,
    sourceRecordId: null,
  );
}
