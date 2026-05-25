import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../goal_schedule/domain/goal_schedule.dart';
import '../domain/sleep_record.dart';

/// 睡眠记录仓储接口，先支持内存态，后续再落到 Drift 和健康数据同步。
abstract interface class SleepRecordStore {
  /// 读取最近一条睡眠记录，供今日页摘要展示。
  SleepRecord? get latestRecord;

  /// 保存一条手动补录的睡眠记录。
  void saveManualRecord({
    required String id,
    required GoalSchedule schedule,
    required DateTime fellAsleepAt,
    required DateTime wokeUpAt,
    required String timezone,
  });
}

/// 手动睡眠记录控制器，先用内存状态驱动页面联动，后续再落地到持久化仓储。
class ManualSleepRecordController extends Notifier<SleepRecord?>
    implements SleepRecordStore {
  /// 初始化时还没有任何手动记录。
  @override
  SleepRecord? build() {
    return null;
  }

  @override
  SleepRecord? get latestRecord => state;

  @override
  void saveManualRecord({
    required String id,
    required GoalSchedule schedule,
    required DateTime fellAsleepAt,
    required DateTime wokeUpAt,
    required String timezone,
  }) {
    state = SleepRecord(
      id: id,
      recordDate: schedule.resolveRecordDate(fellAsleepAt),
      fellAsleepAt: fellAsleepAt,
      wokeUpAt: wokeUpAt,
      source: SleepRecordSource.manual,
      confidence: SleepRecordConfidence.high,
      timezone: timezone,
      isUserEdited: true,
    );
  }
}

/// 暴露手动睡眠记录状态，供今日页和补录页共同读写。
final manualSleepRecordProvider =
    NotifierProvider<ManualSleepRecordController, SleepRecord?>(
      ManualSleepRecordController.new,
    );

/// 睡眠记录仓储 Provider，统一向上层暴露为接口，方便后续替换为数据库实现。
final sleepRecordStoreProvider = Provider<SleepRecordStore>((ref) {
  return ref.read(manualSleepRecordProvider.notifier);
});
