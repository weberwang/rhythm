import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rhythm/data/local/rhythm_database.dart';
import 'package:rhythm/features/goal_schedule/application/goal_schedule_providers.dart';
import 'package:rhythm/features/goal_schedule/domain/goal_schedule_settings.dart';
import 'package:rhythm/features/sleep_records/application/sleep_record_providers.dart';
import 'package:rhythm/features/sleep_records/data/drift_sleep_record_repository.dart';
import 'package:rhythm/features/sleep_records/domain/sleep_record.dart';
import 'package:rhythm/features/sleep_records/domain/sleep_record_confidence.dart';
import 'package:rhythm/features/sleep_records/domain/sleep_record_source.dart';

import '../../support/sleep_records_test_app.dart';
import '../../support/sleep_records_test_doubles.dart';

/// 验证手动补录保存后会回到管理页并展示新增记录。
void main() {
  testWidgets('手动补录保存后管理页展示新增记录', (tester) async {
    await pumpSleepRecordsFlowApp(tester);
    await tester.pumpAndSettle();

    await tester.tap(
      find.widgetWithText(FilledButton, '改用手动模式'),
    );
    await tester.pumpAndSettle();

    await tester.scrollUntilVisible(find.text('保存补录结果'), 200);
    await tester.tap(find.text('保存补录结果'));
    await tester.pumpAndSettle();

    expect(find.text('睡眠记录管理'), findsOneWidget);
    expect(find.text('手动补录记录'), findsOneWidget);
  });

  testWidgets('从管理页已有记录进入编辑页时展示既有时间', (tester) async {
    final database = RhythmDatabase.inMemory();
    addTearDown(database.close);
    final repository = DriftSleepRecordRepository(database);
    final record = SleepRecord(
      id: 'manual-edit-1',
      recordDate: DateTime.utc(2026, 5, 22),
      fellAsleepAt: DateTime.utc(2026, 5, 23, 0, 48),
      wokeUpAt: DateTime.utc(2026, 5, 23, 7, 26),
      durationMinutes: 398,
      source: SleepRecordSource.manual,
      confidence: SleepRecordConfidence.high,
      timezone: 'Asia/Shanghai',
      isUserEdited: true,
      sourceRecordId: null,
      createdAt: DateTime.utc(2026, 5, 23, 7, 30),
      updatedAt: DateTime.utc(2026, 5, 23, 7, 30),
    );
    await repository.saveRecord(record);

    await pumpSleepRecordsFlowApp(
      tester,
      database: database,
      overrides: [
        sleepRecordRepositoryProvider.overrideWith((ref) => repository),
      ],
    );
    await tester.pumpAndSettle();

    await tester.tap(find.text('手动补录记录'));
    await tester.pumpAndSettle();

    expect(find.text('手动补录'), findsOneWidget);
    expect(find.text('00:48'), findsOneWidget);
    expect(find.text('07:26'), findsOneWidget);
  });

  testWidgets('手动补录保存时使用已保存目标作息的一天起始时间', (tester) async {
    final database = RhythmDatabase.inMemory();
    addTearDown(database.close);
    final repository = DriftSleepRecordRepository(database);
    final settingsRepository = TestGoalScheduleSettingsRepository(
      const GoalScheduleSettings(
        targetBedtimeMinutes: 23 * 60 + 30,
        targetWakeMinutes: 7 * 60 + 30,
        lateThresholdMinutes: 30,
        dayStartMinutes: 5 * 60,
      ),
    );

    await pumpSleepRecordsFlowApp(
      tester,
      database: database,
      overrides: [
        sleepRecordRepositoryProvider.overrideWith((ref) => repository),
        goalScheduleSettingsRepositoryProvider.overrideWithValue(
          settingsRepository,
        ),
      ],
    );
    await tester.pumpAndSettle();

    await tester.tap(
      find.widgetWithText(FilledButton, '改用手动模式'),
    );
    await tester.pumpAndSettle();
    await tester.scrollUntilVisible(find.text('保存补录结果'), 200);
    await tester.tap(find.text('保存补录结果'));
    await tester.pumpAndSettle();

    final records = await repository.readRecords(
      startRecordDate: DateTime.utc(2000, 1, 1),
      endRecordDate: DateTime.utc(2100, 1, 1),
    );

    expect(records.single.recordDate.hour, 0);
    expect(records.single.recordDate.minute, 0);
  });
}
