import 'dart:convert';

import 'package:rhythm/data/local/rhythm_database.dart';
import 'package:rhythm/features/sleep_records/domain/repositories/sleep_delay_tag_repository.dart';

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
    if (row == null) {
      return const <String>[];
    }
    final decoded = jsonDecode(row.tagsJson);
    if (decoded is! List) {
      return const <String>[];
    }
    return decoded.map((item) => item.toString()).toList();
  }

  @override
  Future<void> saveTags({
    required DateTime recordDate,
    required List<String> tags,
  }) async {
    final normalizedDate = _normalize(recordDate);
    await _database.into(_database.sleepDelayTags).insertOnConflictUpdate(
          SleepDelayTagsCompanion.insert(
            recordDate: normalizedDate,
            tagsJson: jsonEncode(tags),
            updatedAt: DateTime.now().toUtc(),
          ),
        );
  }

  DateTime _normalize(DateTime value) {
    return DateTime.utc(value.year, value.month, value.day);
  }
}
