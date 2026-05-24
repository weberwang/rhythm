import 'package:flutter_test/flutter_test.dart';
import 'package:rhythm/data/local/rhythm_database.dart';
import 'package:rhythm/features/sleep_records/data/drift_sleep_record_repository.dart';
import 'package:rhythm/features/sleep_records/domain/sleep_record.dart';
import 'package:rhythm/features/sleep_records/domain/sleep_record_confidence.dart';
import 'package:rhythm/features/sleep_records/domain/sleep_record_source.dart';

/// 验证 Drift 睡眠记录仓储可以保存底层记录并解析有效记录。
void main() {
  late DriftSleepRecordRepository repository;
  late RhythmDatabase database;

  setUp(() {
    database = RhythmDatabase.inMemory();
    repository = DriftSleepRecordRepository(database);
  });

  tearDown(() async {
    await database.close();
    await repository.close();
  });

  test('保存后可按归属日范围读取原始记录', () async {
    final record = SleepRecord(
      id: 'raw-1',
      recordDate: DateTime.utc(2026, 5, 22),
      fellAsleepAt: DateTime.utc(2026, 5, 23, 1, 0),
      wokeUpAt: DateTime.utc(2026, 5, 23, 8, 0),
      durationMinutes: 420,
      source: SleepRecordSource.healthKit,
      confidence: SleepRecordConfidence.high,
      timezone: 'Asia/Shanghai',
      isUserEdited: false,
      sourceRecordId: null,
      createdAt: DateTime.utc(2026, 5, 23, 8, 5),
      updatedAt: DateTime.utc(2026, 5, 23, 8, 5),
    );

    await repository.saveRecord(record);

    final records = await repository.readRecords(
      startRecordDate: DateTime.utc(2026, 5, 22),
      endRecordDate: DateTime.utc(2026, 5, 22),
    );

    expect(records, hasLength(1));
    final loaded = records.single;
    expect(loaded.id, record.id);
    expect(loaded.recordDate, record.recordDate);
    expect(loaded.fellAsleepAt, record.fellAsleepAt);
    expect(loaded.wokeUpAt, record.wokeUpAt);
    expect(loaded.durationMinutes, record.durationMinutes);
    expect(loaded.source, record.source);
    expect(loaded.confidence, record.confidence);
    expect(loaded.timezone, record.timezone);
    expect(loaded.isUserEdited, record.isUserEdited);
    expect(loaded.sourceRecordId, record.sourceRecordId);
    expect(loaded.createdAt, record.createdAt);
    expect(loaded.updatedAt, record.updatedAt);
  });

  test('原始记录与用户修正并存时有效记录优先返回用户确认结果', () async {
    final originalRecord = SleepRecord(
      id: 'raw-1',
      recordDate: DateTime.utc(2026, 5, 22),
      fellAsleepAt: DateTime.utc(2026, 5, 23, 2, 30),
      wokeUpAt: DateTime.utc(2026, 5, 23, 9, 0),
      durationMinutes: 390,
      source: SleepRecordSource.healthConnect,
      confidence: SleepRecordConfidence.high,
      timezone: 'Asia/Shanghai',
      isUserEdited: false,
      sourceRecordId: null,
      createdAt: DateTime.utc(2026, 5, 23, 9, 1),
      updatedAt: DateTime.utc(2026, 5, 23, 9, 1),
    );
    final overrideRecord = SleepRecord(
      id: 'manual-1',
      recordDate: DateTime.utc(2026, 5, 22),
      fellAsleepAt: DateTime.utc(2026, 5, 23, 2, 10),
      wokeUpAt: DateTime.utc(2026, 5, 23, 8, 40),
      durationMinutes: 390,
      source: SleepRecordSource.manual,
      confidence: SleepRecordConfidence.high,
      timezone: 'Asia/Shanghai',
      isUserEdited: true,
      sourceRecordId: 'raw-1',
      createdAt: DateTime.utc(2026, 5, 23, 9, 30),
      updatedAt: DateTime.utc(2026, 5, 23, 9, 30),
    );

    await repository.saveRecord(originalRecord);
    await repository.saveRecord(overrideRecord);

    final records = await repository.readEffectiveRecords(
      startRecordDate: DateTime.utc(2026, 5, 22),
      endRecordDate: DateTime.utc(2026, 5, 22),
    );

    expect(records, hasLength(1));
    expect(records.single.recordId, 'manual-1');
    expect(records.single.isUserConfirmed, isTrue);
  });

  test('可按记录主键读取单条底层记录，供编辑页加载既有值', () async {
    final record = SleepRecord(
      id: 'manual-edit',
      recordDate: DateTime.utc(2026, 5, 24),
      fellAsleepAt: DateTime.utc(2026, 5, 24, 0, 48),
      wokeUpAt: DateTime.utc(2026, 5, 24, 7, 26),
      durationMinutes: 398,
      source: SleepRecordSource.manual,
      confidence: SleepRecordConfidence.high,
      timezone: 'Asia/Shanghai',
      isUserEdited: true,
      sourceRecordId: null,
      createdAt: DateTime.utc(2026, 5, 24, 8, 0),
      updatedAt: DateTime.utc(2026, 5, 24, 8, 0),
    );

    await repository.saveRecord(record);

    final loaded = await repository.readRecordById('manual-edit');

    expect(loaded, isNotNull);
    expect(loaded!.id, record.id);
    expect(loaded.recordDate, record.recordDate);
    expect(loaded.fellAsleepAt, record.fellAsleepAt);
    expect(loaded.wokeUpAt, record.wokeUpAt);
    expect(loaded.durationMinutes, record.durationMinutes);
    expect(loaded.source, record.source);
    expect(loaded.confidence, record.confidence);
    expect(loaded.timezone, record.timezone);
    expect(loaded.isUserEdited, record.isUserEdited);
    expect(loaded.sourceRecordId, record.sourceRecordId);
    expect(loaded.createdAt, record.createdAt);
    expect(loaded.updatedAt, record.updatedAt);
  });
}
