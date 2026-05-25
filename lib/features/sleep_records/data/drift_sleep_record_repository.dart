import 'package:drift/drift.dart';
import 'package:rhythm/data/local/rhythm_database.dart';
import 'package:rhythm/features/sleep_records/domain/effective_sleep_record.dart';
import 'package:rhythm/features/sleep_records/domain/repositories/effective_sleep_record_repository.dart';
import 'package:rhythm/features/sleep_records/domain/repositories/sleep_record_repository.dart';
import 'package:rhythm/features/sleep_records/domain/sleep_record.dart';
import 'package:rhythm/features/sleep_records/domain/sleep_record_rules.dart';

/// 基于 Drift 的睡眠记录仓储实现，统一承接原始记录和有效记录查询。
class DriftSleepRecordRepository
    implements SleepRecordRepository, EffectiveSleepRecordRepository {
  /// 创建睡眠记录仓储。
  DriftSleepRecordRepository(this._database) : _ownsDatabase = false;

  /// 创建基于内存数据库的仓储，供测试和局部隔离场景复用。
  factory DriftSleepRecordRepository.inMemory() {
    final database = RhythmDatabase.inMemory();
    return DriftSleepRecordRepository._owned(database);
  }

  DriftSleepRecordRepository._owned(this._database) : _ownsDatabase = true;

  final RhythmDatabase _database;
  final bool _ownsDatabase;

  @override
  Future<void> saveRecord(SleepRecord record) async {
    await _database.into(_database.sleepRecords).insertOnConflictUpdate(
          SleepRecordsCompanion.insert(
            id: record.id,
            recordDate: record.recordDate,
            fellAsleepAt: record.fellAsleepAt,
            wokeUpAt: record.wokeUpAt,
            durationMinutes: record.durationMinutes,
            source: record.source,
            confidence: record.confidence,
            timezone: record.timezone,
            isUserEdited: record.isUserEdited,
            sourceRecordId: Value(record.sourceRecordId),
            createdAt: record.createdAt,
            updatedAt: record.updatedAt,
          ),
        );
  }

  @override
  Future<SleepRecord?> readRecordById(String id) async {
    final row = await (_database.select(_database.sleepRecords)
          ..where((table) => table.id.equals(id)))
        .getSingleOrNull();
    if (row == null) {
      return null;
    }
    return _toDomain(row);
  }

  @override
  Future<List<SleepRecord>> readRecords({
    required DateTime startRecordDate,
    required DateTime endRecordDate,
  }) async {
    final rows = await (_database.select(_database.sleepRecords)
          ..where(
            (table) =>
                table.recordDate.isBiggerOrEqualValue(startRecordDate) &
                table.recordDate.isSmallerOrEqualValue(endRecordDate),
          )
          ..orderBy([
            (table) => OrderingTerm.asc(table.recordDate),
            (table) => OrderingTerm.desc(table.updatedAt),
          ]))
        .get();
    return rows.map(_toDomain).toList();
  }

  @override
  Future<List<SleepRecord>> readAllRecords() async {
    final rows = await (_database.select(_database.sleepRecords)
          ..orderBy([
            (table) => OrderingTerm.asc(table.recordDate),
            (table) => OrderingTerm.desc(table.updatedAt),
          ]))
        .get();
    return rows.map(_toDomain).toList(growable: false);
  }

  @override
  Future<List<EffectiveSleepRecord>> readEffectiveRecords({
    required DateTime startRecordDate,
    required DateTime endRecordDate,
  }) async {
    final records = await readRecords(
      startRecordDate: startRecordDate,
      endRecordDate: endRecordDate,
    );
    return SleepRecordRules.resolveEffectiveRecords(records: records);
  }

  /// 关闭仓储资源。
  ///
  /// 仅在仓储自持有数据库实例时关闭底层连接，避免共享连接被重复释放。
  Future<void> close() async {
    if (_ownsDatabase) {
      await _database.close();
    }
  }

  /// 把数据库行规范化为领域模型，确保同步比较统一使用 UTC 时间。
  SleepRecord _toDomain(SleepRecordEntry row) {
    return SleepRecord(
      id: row.id,
      recordDate: _normalizeDate(row.recordDate),
      fellAsleepAt: _normalizeInstant(row.fellAsleepAt),
      wokeUpAt: _normalizeInstant(row.wokeUpAt),
      durationMinutes: row.durationMinutes,
      source: row.source,
      confidence: row.confidence,
      timezone: row.timezone,
      isUserEdited: row.isUserEdited,
      sourceRecordId: row.sourceRecordId,
      createdAt: _normalizeInstant(row.createdAt),
      updatedAt: _normalizeInstant(row.updatedAt),
    );
  }

  DateTime _normalizeDate(DateTime value) {
    return DateTime.utc(value.year, value.month, value.day);
  }

  DateTime _normalizeInstant(DateTime value) {
    return value.isUtc ? value : value.toUtc();
  }
}
