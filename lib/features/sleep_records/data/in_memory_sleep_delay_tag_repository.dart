import 'package:rhythm/features/sleep_records/domain/repositories/sleep_delay_tag_repository.dart';
import 'package:rhythm/features/sleep_records/domain/sleep_delay_tag_snapshot.dart';

/// 提供阶段六开发期使用的内存标签仓储，先锁住交互和测试闭环。
class InMemorySleepDelayTagRepository implements SleepDelayTagRepository {
  final Map<DateTime, SleepDelayTagSnapshot> _tagsByDate =
      <DateTime, SleepDelayTagSnapshot>{};

  @override
  Future<List<String>> readTags({
    required DateTime recordDate,
  }) async {
    final snapshot = _tagsByDate[_normalize(recordDate)];
    return List<String>.from(snapshot?.tags ?? const <String>[]);
  }

  @override
  Future<List<SleepDelayTagSnapshot>> readAllTags() async {
    return _tagsByDate.values
        .map(
          (snapshot) => SleepDelayTagSnapshot(
            recordDate: snapshot.recordDate,
            tags: List<String>.from(snapshot.tags),
            updatedAt: snapshot.updatedAt,
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
    _tagsByDate[normalizedDate] = SleepDelayTagSnapshot(
      recordDate: normalizedDate,
      tags: List<String>.from(tags),
      updatedAt: updatedAt.isUtc ? updatedAt : updatedAt.toUtc(),
    );
  }

  DateTime _normalize(DateTime value) {
    return DateTime.utc(value.year, value.month, value.day);
  }
}
