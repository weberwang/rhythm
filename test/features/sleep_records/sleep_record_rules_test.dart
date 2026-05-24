import 'package:flutter_test/flutter_test.dart';
import 'package:rhythm/core/time/sleep_record_day_resolver.dart';
import 'package:rhythm/features/sleep_records/domain/effective_sleep_record.dart';
import 'package:rhythm/features/sleep_records/domain/sleep_record.dart';
import 'package:rhythm/features/sleep_records/domain/sleep_record_confidence.dart';
import 'package:rhythm/features/sleep_records/domain/sleep_record_rules.dart';
import 'package:rhythm/features/sleep_records/domain/sleep_record_source.dart';

/// 验证睡眠记录的归属日规则和有效记录优先级。
void main() {
  group('SleepRecordDayResolver', () {
    test('一天起始时间之前入睡的记录归属到上一日', () {
      final recordDate = SleepRecordDayResolver.resolveRecordDate(
        fellAsleepAt: DateTime.utc(2026, 5, 23, 2, 30),
        dayStartMinutes: 4 * 60,
      );

      expect(recordDate, DateTime.utc(2026, 5, 22));
    });

    test('一天起始时间之后入睡的记录归属到当天', () {
      final recordDate = SleepRecordDayResolver.resolveRecordDate(
        fellAsleepAt: DateTime.utc(2026, 5, 23, 23, 30),
        dayStartMinutes: 4 * 60,
      );

      expect(recordDate, DateTime.utc(2026, 5, 23));
    });
  });

  group('SleepRecordRules', () {
    test('根据起止时间计算睡眠时长分钟数', () {
      final durationMinutes = SleepRecordRules.calculateDurationMinutes(
        fellAsleepAt: DateTime.utc(2026, 5, 23, 23, 30),
        wokeUpAt: DateTime.utc(2026, 5, 24, 7, 0),
      );

      expect(durationMinutes, 450);
    });

    test('同一归属日存在用户修正时优先输出用户确认记录', () {
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

      final effectiveRecords = SleepRecordRules.resolveEffectiveRecords(
        records: [originalRecord, overrideRecord],
      );

      expect(effectiveRecords, hasLength(1));
      expect(effectiveRecords.single.recordId, 'manual-1');
      expect(effectiveRecords.single.source, SleepRecordSource.manual);
      expect(effectiveRecords.single.isUserConfirmed, isTrue);
    });

    test('同一归属日只有原始记录时输出原始记录', () {
      final originalRecord = SleepRecord(
        id: 'raw-1',
        recordDate: DateTime.utc(2026, 5, 22),
        fellAsleepAt: DateTime.utc(2026, 5, 23, 1, 0),
        wokeUpAt: DateTime.utc(2026, 5, 23, 8, 0),
        durationMinutes: 420,
        source: SleepRecordSource.healthKit,
        confidence: SleepRecordConfidence.medium,
        timezone: 'Asia/Shanghai',
        isUserEdited: false,
        sourceRecordId: null,
        createdAt: DateTime.utc(2026, 5, 23, 8, 5),
        updatedAt: DateTime.utc(2026, 5, 23, 8, 5),
      );

      final effectiveRecords = SleepRecordRules.resolveEffectiveRecords(
        records: [originalRecord],
      );

      expect(effectiveRecords, hasLength(1));
      expect(
        effectiveRecords.single,
        EffectiveSleepRecord(
          recordId: 'raw-1',
          recordDate: DateTime.utc(2026, 5, 22),
          fellAsleepAt: DateTime.utc(2026, 5, 23, 1, 0),
          wokeUpAt: DateTime.utc(2026, 5, 23, 8, 0),
          durationMinutes: 420,
          source: SleepRecordSource.healthKit,
          confidence: SleepRecordConfidence.medium,
          timezone: 'Asia/Shanghai',
          isUserConfirmed: false,
          sourceRecordId: null,
        ),
      );
    });
  });
}
