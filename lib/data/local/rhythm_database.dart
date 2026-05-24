/// Rhythm 本地数据库占位壳。
///
/// 当前工程在 `riverpod_generator 3.0.3`、`flutter_test` 与 `drift_dev`
/// 的版本组合下无法完成代码生成，因此阶段三先通过仓储实现打通
/// 可验证的数据闭环，并保留数据库壳作为后续替换真实 Drift 生成层的落点。
class RhythmDatabase {
  /// 创建真实数据库壳实例。
  RhythmDatabase();

  /// 创建内存数据库壳实例，供测试或后续替换用。
  RhythmDatabase.inMemory();

  /// 关闭数据库资源。
  Future<void> close() async {}
}
