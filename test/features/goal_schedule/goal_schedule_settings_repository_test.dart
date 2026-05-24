import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rhythm/app/bootstrap/launch_state_provider.dart';
import 'package:rhythm/features/goal_schedule/application/goal_schedule_providers.dart';
import 'package:rhythm/features/goal_schedule/data/goal_schedule_settings_repository.dart';
import 'package:rhythm/features/goal_schedule/domain/goal_schedule_settings.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// 验证目标作息配置具备可持久化读取边界，供今日页和后续阶段复用。
void main() {
  test('未保存目标作息时返回空结果', () async {
    SharedPreferences.setMockInitialValues(<String, Object>{});
    final preferences = await SharedPreferences.getInstance();
    final container = ProviderContainer(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(preferences),
      ],
    );
    addTearDown(container.dispose);

    final repository = container.read(goalScheduleSettingsRepositoryProvider);

    final restored = await repository.read();

    expect(restored, isNull);
  });

  test('保存后的目标作息可被读取', () async {
    SharedPreferences.setMockInitialValues(<String, Object>{});
    final preferences = await SharedPreferences.getInstance();
    final container = ProviderContainer(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(preferences),
      ],
    );
    addTearDown(container.dispose);

    final repository = container.read(goalScheduleSettingsRepositoryProvider);
    const settings = GoalScheduleSettings(
      targetBedtimeMinutes: 23 * 60 + 30,
      targetWakeMinutes: 7 * 60 + 30,
      lateThresholdMinutes: 30,
      dayStartMinutes: 4 * 60,
    );

    await repository.save(settings);
    final restored = await repository.read();

    expect(restored, settings);
  });
}
