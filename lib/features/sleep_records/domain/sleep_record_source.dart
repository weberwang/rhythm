/// 标记睡眠记录来源，供同步链路和展示层解释记录出处。
enum SleepRecordSource {
  /// 来自 iOS Apple Health / HealthKit 的系统记录。
  healthKit,

  /// 来自 Android Health Connect 的系统记录。
  healthConnect,

  /// 来自用户手动补录的记录。
  manual,

  /// 预留给外部导入或未来迁移场景。
  imported,
}
