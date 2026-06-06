import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rhythm/core/storage/rhythm_database.dart';
import 'package:rhythm/features/sleep_data_core/domain/entities/sleep_record.dart';
import 'package:rhythm/features/sleep_data_core/infrastructure/repositories/local_sleep_record_repository.dart';

/// 验证睡眠记录仓储真正落到 Drift，本轮实现不再停留在 today 的静态趋势假数据。
void main() {
  test(
    'LocalSleepRecordRepository persists latest and recent manual records',
    () async {
      final database = RhythmDatabase.forTesting(NativeDatabase.memory());
      final repository = LocalSleepRecordRepository(database);
      addTearDown(database.close);

      final first = SleepRecord(
        id: 'record-1',
        sleepDate: DateTime(2026, 6, 4),
        bedtimeMinutes: 23 * 60 + 40,
        wakeTimeMinutes: 7 * 60 + 20,
        source: SleepRecordSource.manual,
        confidence: SleepRecordConfidence.trusted,
        isManuallyAdjusted: false,
        note: '加班晚了',
        createdAt: DateTime(2026, 6, 5, 7, 30),
      );
      final second = SleepRecord(
        id: 'record-2',
        sleepDate: DateTime(2026, 6, 5),
        bedtimeMinutes: 22 * 60 + 55,
        wakeTimeMinutes: 6 * 60 + 50,
        source: SleepRecordSource.manual,
        confidence: SleepRecordConfidence.trusted,
        isManuallyAdjusted: true,
        note: '手动修正',
        createdAt: DateTime(2026, 6, 6, 7, 10),
      );

      expect(await repository.readLatestRecord(), isNull);

      await repository.saveManualRecord(first);
      await repository.saveManualRecord(second);

      final latest = await repository.readLatestRecord();
      final recent = await repository.readRecentRecords(limit: 7);

      expect(latest, isNotNull);
      expect(latest!.id, second.id);
      expect(latest.isManuallyAdjusted, isTrue);
      expect(recent, hasLength(2));
      expect(recent.first.id, second.id);
      expect(recent.last.id, first.id);
    },
  );

  test('LocalSleepRecordRepository reads records inside a date range', () async {
    final database = RhythmDatabase.forTesting(NativeDatabase.memory());
    final repository = LocalSleepRecordRepository(database);
    addTearDown(database.close);

    await repository.saveManualRecord(
      SleepRecord(
        id: 'record-1',
        sleepDate: DateTime(2026, 5, 30),
        bedtimeMinutes: 23 * 60 + 40,
        wakeTimeMinutes: 7 * 60 + 20,
        source: SleepRecordSource.manual,
        confidence: SleepRecordConfidence.trusted,
        isManuallyAdjusted: false,
        note: null,
        createdAt: DateTime(2026, 5, 31, 7, 30),
      ),
    );
    await repository.saveManualRecord(
      SleepRecord(
        id: 'record-2',
        sleepDate: DateTime(2026, 6, 2),
        bedtimeMinutes: 23 * 60 + 10,
        wakeTimeMinutes: 7 * 60,
        source: SleepRecordSource.health,
        confidence: SleepRecordConfidence.trusted,
        isManuallyAdjusted: false,
        note: null,
        createdAt: DateTime(2026, 6, 3, 7, 30),
      ),
    );
    await repository.saveManualRecord(
      SleepRecord(
        id: 'record-3',
        sleepDate: DateTime(2026, 6, 8),
        bedtimeMinutes: 0 * 60 + 25,
        wakeTimeMinutes: 7 * 60 + 15,
        source: SleepRecordSource.manual,
        confidence: SleepRecordConfidence.partial,
        isManuallyAdjusted: true,
        note: '手动修正',
        createdAt: DateTime(2026, 6, 9, 7, 30),
      ),
    );

    final juneRecords = await repository.readRecordsInRange(
      startDate: DateTime(2026, 6, 1),
      endDate: DateTime(2026, 6, 30),
    );

    expect(juneRecords.map((record) => record.id), ['record-3', 'record-2']);
  });
}
