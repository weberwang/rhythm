import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/goal_schedule_settings.dart';
import '../domain/repositories/goal_schedule_settings_repository.dart';
import 'goal_schedule_providers.dart';

/// 提供目标作息保存服务，统一收口持久化与共享状态刷新逻辑。
final goalScheduleSettingsSaveServiceProvider =
    Provider<GoalScheduleSettingsSaveService>((ref) {
      return GoalScheduleSettingsSaveService(
        repository: ref.watch(goalScheduleSettingsRepositoryProvider),
        refreshSavedSettings: () => ref.invalidate(
          savedGoalScheduleSettingsProvider,
        ),
      );
    });

/// 负责保存目标作息，并在保存完成后刷新依赖共享作息状态的 Provider。
class GoalScheduleSettingsSaveService {
  /// 创建目标作息保存服务。
  GoalScheduleSettingsSaveService({
    required GoalScheduleSettingsRepository repository,
    required void Function() refreshSavedSettings,
  }) : _repository = repository,
       _refreshSavedSettings = refreshSavedSettings;

  final GoalScheduleSettingsRepository _repository;
  final void Function() _refreshSavedSettings;

  /// 保存最新目标作息，并使共享作息快照失效以驱动相关页面重算。
  Future<void> save(GoalScheduleSettings settings) async {
    await _repository.save(settings);
    _refreshSavedSettings();
  }
}
