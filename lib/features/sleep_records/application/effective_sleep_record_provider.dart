import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rhythm/core/time/time_context_provider.dart';
import 'package:rhythm/features/goal_schedule/application/goal_schedule_providers.dart';
import 'package:rhythm/features/sleep_records/domain/effective_sleep_record.dart';

import 'query_sleep_records_use_case.dart';
import 'sleep_record_providers.dart';

const int _defaultDayStartMinutes = 4 * 60;

/// 提供有效记录查询用例，统一收口最近 7 天和 30 天窗口计算。
final querySleepRecordsUseCaseProvider = Provider<QuerySleepRecordsUseCase>((
  ref,
) {
  return QuerySleepRecordsUseCase(
    repository: ref.watch(effectiveSleepRecordRepositoryProvider),
  );
});

/// 读取最近 7 天有效睡眠记录，供今日页趋势和后续洞察层复用。
final recentSevenDayEffectiveSleepRecordsProvider =
    FutureProvider<List<EffectiveSleepRecord>>((ref) async {
      final useCase = ref.watch(querySleepRecordsUseCaseProvider);
      final settings = await ref.watch(savedGoalScheduleSettingsProvider.future);
      final timeContext = ref.watch(timeContextProvider);
      return useCase.queryRecentRecords(
        days: 7,
        now: timeContext.now,
        dayStartMinutes: settings?.dayStartMinutes ?? _defaultDayStartMinutes,
      );
    });

/// 读取最近 30 天有效睡眠记录，供阶段三管理页与后续日历页复用。
final recentThirtyDayEffectiveSleepRecordsProvider =
    FutureProvider<List<EffectiveSleepRecord>>((ref) async {
      final useCase = ref.watch(querySleepRecordsUseCaseProvider);
      final settings = await ref.watch(savedGoalScheduleSettingsProvider.future);
      final timeContext = ref.watch(timeContextProvider);
      return useCase.queryRecentRecords(
        days: 30,
        now: timeContext.now,
        dayStartMinutes: settings?.dayStartMinutes ?? _defaultDayStartMinutes,
      );
    });

/// 兼容当前阶段三/阶段四调用方，默认读取最近 30 天有效记录。
final recentEffectiveSleepRecordsProvider =
    recentThirtyDayEffectiveSleepRecordsProvider;
