import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:rhythm/app/bootstrap/launch_state_provider.dart';

import '../data/goal_schedule_settings_repository.dart';
import '../domain/goal_schedule_settings.dart';
import '../domain/repositories/goal_schedule_settings_repository.dart';

part 'goal_schedule_providers.g.dart';

/// 提供目标作息设置仓储，统一封装持久化读写入口。
@riverpod
GoalScheduleSettingsRepository goalScheduleSettingsRepository(Ref ref) {
  return SharedPreferencesGoalScheduleSettingsRepository(
    ref.watch(sharedPreferencesProvider),
  );
}

/// 读取最近保存的目标作息设置，供今日页和后续阶段复用。
@riverpod
Future<GoalScheduleSettings?> savedGoalScheduleSettings(Ref ref) {
  return ref.watch(goalScheduleSettingsRepositoryProvider).read();
}
