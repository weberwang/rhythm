import '../sleep_delay_tag_snapshot.dart';

/// 定义晚睡原因标签的读取与保存契约。
abstract class SleepDelayTagRepository {
  /// 读取指定归属日已保存的标签。
  Future<List<String>> readTags({
    required DateTime recordDate,
  });

  /// 读取当前本地全部晚睡标签快照，供同步服务做全量对账。
  Future<List<SleepDelayTagSnapshot>> readAllTags();

  /// 保存指定归属日的标签集合。
  Future<void> saveTags({
    required DateTime recordDate,
    required List<String> tags,
  });

  /// 按远端时间戳写回标签快照，避免同步回写时丢失原始更新时间。
  Future<void> saveTagsSnapshot({
    required DateTime recordDate,
    required List<String> tags,
    required DateTime updatedAt,
  });
}
