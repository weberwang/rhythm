import 'effective_sleep_record.dart';
import 'sleep_record.dart';

/// 承载阶段三共享的睡眠记录纯业务规则。
class SleepRecordRules {
  /// 根据入睡和起床时间计算睡眠时长分钟数。
  static int calculateDurationMinutes({
    required DateTime fellAsleepAt,
    required DateTime wokeUpAt,
  }) {
    return wokeUpAt.difference(fellAsleepAt).inMinutes;
  }

  /// 将同一归属日的底层记录解析为最终展示使用的有效记录。
  static List<EffectiveSleepRecord> resolveEffectiveRecords({
    required List<SleepRecord> records,
  }) {
    final recordsByDay = <DateTime, List<SleepRecord>>{};
    for (final record in records) {
      recordsByDay.putIfAbsent(record.recordDate, () => <SleepRecord>[]).add(
            record,
          );
    }

    final effectiveRecords = <EffectiveSleepRecord>[];
    for (final recordsForDay in recordsByDay.values) {
      // 用户手动补录或修正是阶段三的最终展示基准，应优先于系统原始记录。
      recordsForDay.sort((left, right) {
        final leftPriority = left.isUserEdited ? 0 : 1;
        final rightPriority = right.isUserEdited ? 0 : 1;
        if (leftPriority != rightPriority) {
          return leftPriority.compareTo(rightPriority);
        }
        return right.updatedAt.compareTo(left.updatedAt);
      });
      final selectedRecord = recordsForDay.first;
      effectiveRecords.add(
        EffectiveSleepRecord(
          recordId: selectedRecord.id,
          recordDate: selectedRecord.recordDate,
          fellAsleepAt: selectedRecord.fellAsleepAt,
          wokeUpAt: selectedRecord.wokeUpAt,
          durationMinutes: selectedRecord.durationMinutes,
          source: selectedRecord.source,
          confidence: selectedRecord.confidence,
          timezone: selectedRecord.timezone,
          isUserConfirmed: selectedRecord.isUserEdited,
          sourceRecordId: selectedRecord.sourceRecordId,
        ),
      );
    }

    effectiveRecords.sort(
      (left, right) => left.recordDate.compareTo(right.recordDate),
    );
    return effectiveRecords;
  }
}
