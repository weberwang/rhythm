import 'package:drift/drift.dart';

import '../../../../core/storage/rhythm_database.dart';
import '../../domain/entities/sleep_record.dart';
import '../../domain/repositories/sleep_record_repository.dart';

/// 基于 Drift 提供睡眠记录本地仓储，先服务 today 的真实反馈和样本趋势。
class LocalSleepRecordRepository implements SleepRecordRepository {
  /// 创建本地仓储实现。
  LocalSleepRecordRepository(this._database);

  final RhythmDatabase _database;

  @override
  Future<SleepRecord?> readLatestRecord() async {
    final query = _database.select(_database.sleepRecordEntries)
      ..orderBy([(table) => OrderingTerm.desc(table.sleepDate)])
      ..orderBy([(table) => OrderingTerm.desc(table.createdAt)])
      ..limit(1);

    final row = await query.getSingleOrNull();
    return row == null ? null : _mapRecord(row);
  }

  @override
  Future<List<SleepRecord>> readRecentRecords({required int limit}) async {
    final query = _database.select(_database.sleepRecordEntries)
      ..orderBy([(table) => OrderingTerm.desc(table.sleepDate)])
      ..orderBy([(table) => OrderingTerm.desc(table.createdAt)])
      ..limit(limit);

    final rows = await query.get();
    return rows.map(_mapRecord).toList(growable: false);
  }

  @override
  Future<void> saveManualRecord(SleepRecord record) {
    return _database
        .into(_database.sleepRecordEntries)
        .insert(
          SleepRecordEntriesCompanion.insert(
            id: record.id,
            sleepDate: record.sleepDate,
            bedtimeMinutes: record.bedtimeMinutes,
            wakeTimeMinutes: record.wakeTimeMinutes,
            source: record.source.name,
            confidence: record.confidence.name,
            isManuallyAdjusted: record.isManuallyAdjusted,
            createdAt: record.createdAt,
            note: Value(record.note),
          ),
        );
  }

  /// 统一把 Drift 行映射成领域实体，避免页面透出数据库字段细节。
  SleepRecord _mapRecord(SleepRecordEntry row) {
    return SleepRecord(
      id: row.id,
      sleepDate: row.sleepDate,
      bedtimeMinutes: row.bedtimeMinutes,
      wakeTimeMinutes: row.wakeTimeMinutes,
      source: switch (row.source) {
        'health' => SleepRecordSource.health,
        _ => SleepRecordSource.manual,
      },
      confidence: switch (row.confidence) {
        'partial' => SleepRecordConfidence.partial,
        _ => SleepRecordConfidence.trusted,
      },
      isManuallyAdjusted: row.isManuallyAdjusted,
      note: row.note,
      createdAt: row.createdAt,
    );
  }
}
