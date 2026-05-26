import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rhythm/features/goal_schedule/application/goal_schedule_providers.dart';
import 'package:rhythm/features/goal_schedule/application/goal_schedule_settings_save_service.dart';
import 'package:rhythm/features/goal_schedule/domain/goal_schedule_settings.dart';
import 'package:rhythm/features/sleep_records/application/effective_sleep_record_provider.dart';
import 'package:rhythm/features/sleep_records/application/sleep_record_providers.dart';
import 'package:rhythm/features/sleep_records/domain/effective_sleep_record.dart';
import 'package:rhythm/features/sleep_records/domain/health_platform_state.dart';
import 'package:rhythm/features/today/application/today_controller.dart';
import 'package:rhythm/features/today/application/today_view_state.dart';

import '../../../support/sleep_records_test_doubles.dart';

/// 验证目标作息保存服务会同步刷新共享作息状态与依赖它的页面聚合状态。
void main() {
  const settings = GoalScheduleSettings(
    targetBedtimeMinutes: 23 * 60 + 30,
    targetWakeMinutes: 7 * 60 + 30,
    lateThresholdMinutes: 30,
    dayStartMinutes: 4 * 60,
  );

  test('保存目标作息后会刷新共享快照并推动今日页退出 goalMissing', () async {
    final repository = TestGoalScheduleSettingsRepository(null);
    final container = ProviderContainer(
      overrides: [
        goalScheduleSettingsRepositoryProvider.overrideWithValue(repository),
        recentEffectiveSleepRecordsProvider.overrideWith(
          (ref) async => const <EffectiveSleepRecord>[],
        ),
        healthPlatformStateProvider.overrideWith(
          (ref) async => HealthPlatformState.iosAvailable(),
        ),
      ],
    );
    addTearDown(container.dispose);

    final initialState = await container.read(todayControllerProvider.future);

    expect(initialState.status, TodayViewStatus.goalMissing);

    await container.read(goalScheduleSettingsSaveServiceProvider).save(settings);

    final savedSettings = await container.read(
      savedGoalScheduleSettingsProvider.future,
    );
    final updatedState = await container.read(todayControllerProvider.future);

    expect(savedSettings, settings);
    expect(updatedState.status, TodayViewStatus.empty);
  });
}
