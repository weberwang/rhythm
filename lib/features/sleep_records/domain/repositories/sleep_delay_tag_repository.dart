/// 定义晚睡原因标签的读取与保存契约。
abstract class SleepDelayTagRepository {
  /// 读取指定归属日已保存的标签。
  Future<List<String>> readTags({
    required DateTime recordDate,
  });

  /// 保存指定归属日的标签集合。
  Future<void> saveTags({
    required DateTime recordDate,
    required List<String> tags,
  });
}
