import 'package:rhythm/features/sleep_records/domain/effective_sleep_record.dart';
import 'package:rhythm/features/sleep_records/domain/repositories/effective_sleep_record_repository.dart';
import 'package:rhythm/features/sleep_records/domain/repositories/sleep_record_repository.dart';
import 'package:rhythm/features/sleep_records/domain/sleep_record.dart';
import 'package:rhythm/features/sleep_records/domain/sleep_record_rules.dart';

/// 阶段三睡眠记录仓储实现。
///
/// 当前先以内存仓储维持可验证闭环，等 `drift_dev` 版本矩阵稳定后再替换为
/// 真实 Drift 表实现，避免阶段三剩余主链路被数据库代码生成阻塞。
class DriftSleepRecordRepository
    implements SleepRecordRepository, EffectiveSleepRecordRepository {
  /// 创建内存仓储实例。
  DriftSleepRecordRepository.inMemory() : _records = <SleepRecord>[];

  final List<SleepRecord> _records;

  @override
  Future<void> saveRecord(SleepRecord record) async {
    final index = _records.indexWhere((item) => item.id == record.id);
    if (index == -1) {
      _records.add(record);
      return;
    }

    // 以记录主键做幂等覆盖，保证重复同步和手动编辑不会产生同主键脏数据。
    _records[index] = record;
  }

  @override
  Future<SleepRecord?> readRecordById(String id) async {
    for (final record in _records) {
      if (record.id == id) {
        return record;
      }
    }
    return null;
  }

  @override
  Future<List<SleepRecord>> readRecords({
    required DateTime startRecordDate,
    required DateTime endRecordDate,
  }) async {
    final records = _records
        .where(
          (record) =>
              !record.recordDate.isBefore(startRecordDate) &&
              !record.recordDate.isAfter(endRecordDate),
        )
        .toList()
      ..sort((left, right) {
        final byDate = left.recordDate.compareTo(right.recordDate);
        if (byDate != 0) {
          return byDate;
        }
        return right.updatedAt.compareTo(left.updatedAt);
      });
    return records;
  }

  @override
  Future<List<EffectiveSleepRecord>> readEffectiveRecords({
    required DateTime startRecordDate,
    required DateTime endRecordDate,
  }) async {
    final records = await readRecords(
      startRecordDate: startRecordDate,
      endRecordDate: endRecordDate,
    );
    return SleepRecordRules.resolveEffectiveRecords(records: records);
  }

  /// 关闭仓储资源。
  ///
  /// 当前内存实现没有底层句柄，但保留该接口以便未来平滑替换为真实数据库实现。
  Future<void> close() async {}
}
