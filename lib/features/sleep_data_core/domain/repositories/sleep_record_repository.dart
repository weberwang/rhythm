import '../entities/sleep_record.dart';

/// 统一约束睡眠记录读取与手动补录边界，避免 today 直接依赖 Drift 明细。
abstract class SleepRecordRepository {
  /// 读取最近一条有效记录，供 today 首屏生成“昨晚结果”。
  Future<SleepRecord?> readLatestRecord();

  /// 读取最近若干条记录，供趋势摘要或后续月历复用。
  Future<List<SleepRecord>> readRecentRecords({required int limit});

  /// 保存用户手动补录或修正后的记录。
  Future<void> saveManualRecord(SleepRecord record);
}
