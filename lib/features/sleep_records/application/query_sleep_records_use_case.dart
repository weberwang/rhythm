import 'package:rhythm/core/time/sleep_record_day_resolver.dart';
import 'package:rhythm/features/sleep_records/domain/effective_sleep_record.dart';
import 'package:rhythm/features/sleep_records/domain/repositories/effective_sleep_record_repository.dart';

/// 统一承接最近有效睡眠记录查询，避免页面自行计算业务窗口。
class QuerySleepRecordsUseCase {
  /// 创建有效睡眠记录查询用例。
  const QuerySleepRecordsUseCase({
    required EffectiveSleepRecordRepository repository,
  }) : _repository = repository;

  final EffectiveSleepRecordRepository _repository;

  /// 按最近 N 天业务窗口读取最终可展示的有效记录。
  Future<List<EffectiveSleepRecord>> queryRecentRecords({
    required int days,
    required DateTime now,
    required int dayStartMinutes,
  }) {
    final endRecordDate = SleepRecordDayResolver.resolveRecordDate(
      fellAsleepAt: now,
      dayStartMinutes: dayStartMinutes,
    );
    final startRecordDate = endRecordDate.subtract(Duration(days: days - 1));
    return _repository.readEffectiveRecords(
      startRecordDate: startRecordDate,
      endRecordDate: endRecordDate,
    );
  }
}
