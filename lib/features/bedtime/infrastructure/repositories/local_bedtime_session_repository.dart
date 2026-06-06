import 'package:drift/drift.dart';

import '../../../../core/storage/rhythm_database.dart';
import '../../domain/entities/bedtime_session_draft.dart';
import '../../domain/entities/bedtime_session_record.dart';
import '../../domain/repositories/bedtime_session_repository.dart';

/// 基于 Drift 提供睡前会话本地仓储，先服务草稿恢复与完成态写回。
class LocalBedtimeSessionRepository implements BedtimeSessionRepository {
  /// 创建本地仓储实现。
  LocalBedtimeSessionRepository(this._database);

  final RhythmDatabase _database;

  @override
  Future<BedtimeSessionRecord?> readSessionForDate(DateTime sessionDate) async {
    final normalizedDate = _normalizeDate(sessionDate);
    final query = _database.select(_database.bedtimeSessionEntries)
      ..where((table) => table.sessionDate.equals(normalizedDate))
      ..limit(1);
    final row = await query.getSingleOrNull();
    return row == null ? null : _mapRecord(row);
  }

  @override
  Future<void> saveSession(BedtimeSessionRecord record) async {
    await _database.into(_database.bedtimeSessionEntries).insertOnConflictUpdate(
          BedtimeSessionEntriesCompanion.insert(
            sessionDate: _normalizeDate(record.sessionDate),
            selectedChoice: Value(record.selectedChoice?.name),
            entrySource: record.entrySource.name,
            isCompleted: record.isCompleted,
            updatedAt: record.updatedAt,
          ),
        );
  }

  /// 把 Drift 行映射成领域记录，避免控制器依赖数据库字段细节。
  BedtimeSessionRecord _mapRecord(BedtimeSessionEntry row) {
    return BedtimeSessionRecord(
      sessionDate: row.sessionDate,
      selectedChoice: switch (row.selectedChoice) {
        'readyToSleep' => BedtimeStatusChoice.readyToSleep,
        'needWindDown' => BedtimeStatusChoice.needWindDown,
        'likelyDelay' => BedtimeStatusChoice.likelyDelay,
        _ => null,
      },
      entrySource: switch (row.entrySource) {
        'notification' => BedtimeEntrySource.notification,
        'homeWidget' => BedtimeEntrySource.homeWidget,
        _ => BedtimeEntrySource.appOpen,
      },
      isCompleted: row.isCompleted,
      updatedAt: row.updatedAt,
    );
  }

  /// 统一把日期压到日粒度，避免同一天出现多条会话主键。
  DateTime _normalizeDate(DateTime dateTime) {
    return DateTime(dateTime.year, dateTime.month, dateTime.day);
  }
}
