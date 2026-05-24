/// 表示一个晚睡原因标签，供日历、今日页和睡前页复用。
class SleepDelayTag {
  /// 创建原因标签实例。
  const SleepDelayTag({
    required this.id,
    required this.name,
    required this.isDefault,
  });

  /// 标签唯一标识。
  final String id;

  /// 标签展示名称。
  final String name;

  /// 是否为系统默认标签。
  final bool isDefault;
}
