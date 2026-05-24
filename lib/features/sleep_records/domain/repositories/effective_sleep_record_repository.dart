import '../effective_sleep_record.dart';

/// 定义有效睡眠记录查询契约，供今日页和日历页统一消费。
abstract class EffectiveSleepRecordRepository {
  /// 读取指定归属日范围内的有效记录。
  Future<List<EffectiveSleepRecord>> readEffectiveRecords({
    required DateTime startRecordDate,
    required DateTime endRecordDate,
  });
}
