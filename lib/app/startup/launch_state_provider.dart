import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../core/logging/app_logger.dart';
import '../../core/storage/shared_preferences_provider.dart';
import '../../features/app_shell/application/providers/current_entry_intent_provider.dart';
import '../../features/sleep_data_core/application/providers/goal_schedule_repository_provider.dart';
import '../../features/sleep_data_core/domain/entities/goal_schedule.dart';
import 'launch_state.dart';

part 'launch_state_provider.g.dart';

const _onboardingCompletedKey = 'onboarding_completed';
final _logger = AppLogger();

/// 读取启动期最小上下文，并输出根级跳转决策。
@riverpod
Future<LaunchSnapshot> launchState(Ref ref) async {
  final entryIntent = ref.watch(currentEntryIntentProvider);

  try {
    final preferences = await ref.watch(sharedPreferencesProvider.future);
    final repository = ref.watch(goalScheduleRepositoryProvider);
    final activeSchedule = await repository.readActiveSchedule();
    final onboardingCompleted =
        preferences.getBool(_onboardingCompletedKey) ?? false;

    return LaunchSnapshot(
      destination: onboardingCompleted && activeSchedule != null
          ? LaunchDestination.shell
          : LaunchDestination.onboarding,
      entryIntent: entryIntent,
    );
  } catch (error, stackTrace) {
    // 启动恢复失败时先降级到本地引导，避免用户被卡死在“启动基线需要修复”错误页。
    _logger.error('Launch restore failed, fallback to onboarding.', error, stackTrace);

    return LaunchSnapshot(
      destination: LaunchDestination.onboarding,
      entryIntent: entryIntent,
    );
  }
}

/// 标记引导已经完成，让后续启动直接进入主壳。
@riverpod
Future<void> completeOnboarding(Ref ref) async {
  final preferences = await ref.watch(sharedPreferencesProvider.future);
  final repository = ref.watch(goalScheduleRepositoryProvider);
  final existingSchedule = await repository.readActiveSchedule();

  // 首次完成引导时立即补齐默认目标作息，避免主壳进入后仍处于“已完成引导但无基础配置”的断裂态。
  if (existingSchedule == null) {
    await repository.saveActiveSchedule(
      GoalSchedule(
        id: 'bootstrap',
        bedtimeMinutes: 23 * 60,
        wakeTimeMinutes: 7 * 60,
        createdAt: DateTime.now(),
      ),
    );
  }

  await preferences.setBool(_onboardingCompletedKey, true);
  ref.invalidate(launchStateProvider);
}
