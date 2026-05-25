/// 表示某个归属日保存的晚睡标签快照，供同步链路比较标签内容与更新时间。
class SleepDelayTagSnapshot {
  /// 创建晚睡标签快照。
  const SleepDelayTagSnapshot({
    required this.recordDate,
    required this.tags,
    required this.updatedAt,
  });

  /// 业务归属日，统一按 UTC 零点表达。
  final DateTime recordDate;

  /// 该归属日当前保存的最终标签集合。
  final List<String> tags;

  /// 最近一次更新的 UTC 时间戳。
  final DateTime updatedAt;
}
