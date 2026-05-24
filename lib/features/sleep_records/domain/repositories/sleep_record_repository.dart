import '../sleep_record.dart';

/// 定义底层睡眠记录仓储契约，隔离页面与具体存储实现。
abstract class SleepRecordRepository {
  /// 保存一条原始系统记录或手动补录记录。
  Future<void> saveRecord(SleepRecord record);

  /// 读取指定归属日范围内的底层记录。
  Future<List<SleepRecord>> readRecords({
    required DateTime startRecordDate,
    required DateTime endRecordDate,
  });
}
