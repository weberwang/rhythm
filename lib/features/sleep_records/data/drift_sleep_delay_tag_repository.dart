import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:rhythm/data/local/rhythm_database.dart';
import 'package:rhythm/features/sleep_records/domain/repositories/sleep_delay_tag_repository.dart';
import 'package:rhythm/features/sleep_records/domain/sleep_delay_tag_snapshot.dart';

/// 基于 Drift 的晚睡原因标签仓储，按业务归属日保存标签集合。
class DriftSleepDelayTagRepository implements SleepDelayTagRepository {
  /// 创建晚睡原因标签仓储。
  DriftSleepDelayTagRepository(this._database);

  final RhythmDatabase _database;

  @override
  Future<List<String>> readTags({
    required DateTime recordDate,
  }) async {
    final normalizedDate = _normalize(recordDate);
    final row = await (_database.select(_database.sleepDelayTags)
          ..where((table) => table.recordDate.equals(normalizedDate)))
        .getSingleOrNull();
    return row == null ? const <String>[] : _decodeTags(row.tagsJson);
  }

  @override
  Future<List<SleepDelayTagSnapshot>> readAllTags() async {
    final rows = await (_database.select(_database.sleepDelayTags)
          ..orderBy([
            (table) => OrderingTerm.asc(table.recordDate),
          ]))
        .get();
    return rows
        .map(
          (row) => SleepDelayTagSnapshot(
            recordDate: _normalize(row.recordDate),
            tags: _decodeTags(row.tagsJson),
            updatedAt: row.updatedAt.isUtc
                ? row.updatedAt
                : row.updatedAt.toUtc(),
          ),
        )
        .toList(growable: false);
  }

  @override
  Future<void> saveTags({
    required DateTime recordDate,
    required List<String> tags,
  }) async {
    await saveTagsSnapshot(
      recordDate: recordDate,
      tags: tags,
      updatedAt: DateTime.now().toUtc(),
    );
  }

  @override
  Future<void> saveTagsSnapshot({
    required DateTime recordDate,
    required List<String> tags,
    required DateTime updatedAt,
  }) async {
    final normalizedDate = _normalize(recordDate);
    await _database.into(_database.sleepDelayTags).insertOnConflictUpdate(
          SleepDelayTagsCompanion.insert(
            recordDate: normalizedDate,
            tagsJson: jsonEncode(tags),
            updatedAt: updatedAt.isUtc ? updatedAt : updatedAt.toUtc(),
          ),
        );
  }

  /// 统一解析标签 JSON，避免同步链路与页面层重复处理脏数据兜底。
  List<String> _decodeTags(String tagsJson) {
    final decoded = jsonDecode(tagsJson);
    if (decoded is! List) {
      return const <String>[];
    }
    return decoded.map((item) => item.toString()).toList(growable: false);
  }

  DateTime _normalize(DateTime value) {
    return DateTime.utc(value.year, value.month, value.day);
  }
}
