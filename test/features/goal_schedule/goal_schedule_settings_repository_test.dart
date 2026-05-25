import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rhythm/app/bootstrap/launch_state_provider.dart';
import 'package:rhythm/features/goal_schedule/application/goal_schedule_providers.dart';
import 'package:rhythm/features/goal_schedule/data/goal_schedule_settings_repository.dart';
import 'package:rhythm/features/goal_schedule/domain/goal_schedule_settings.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// 验证目标作息配置仓储会持久化同步所需的更新时间元数据。
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

  test('保存目标作息时会写入 updatedAt 元数据', () async {
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

    expect(
      preferences.getString(
        SharedPreferencesGoalScheduleSettingsRepository.updatedAtKey,
      ),
      isNotNull,
    );
    expect(restored, isNotNull);
    expect(restored!.targetBedtimeMinutes, settings.targetBedtimeMinutes);
    expect(restored.targetWakeMinutes, settings.targetWakeMinutes);
    expect(restored.lateThresholdMinutes, settings.lateThresholdMinutes);
    expect(restored.dayStartMinutes, settings.dayStartMinutes);
    expect(restored.updatedAt, isNotNull);
  });

  test('仓储回写远端目标作息时会保留远端 updatedAt', () async {
    SharedPreferences.setMockInitialValues(<String, Object>{});
    final preferences = await SharedPreferences.getInstance();
    final container = ProviderContainer(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(preferences),
      ],
    );
    addTearDown(container.dispose);

    final repository = container.read(goalScheduleSettingsRepositoryProvider);
    final remoteUpdatedAt = DateTime.utc(2026, 5, 25, 7, 30);
    final settings = GoalScheduleSettings(
      targetBedtimeMinutes: 22 * 60 + 45,
      targetWakeMinutes: 6 * 60 + 45,
      lateThresholdMinutes: 20,
      dayStartMinutes: 4 * 60,
      updatedAt: remoteUpdatedAt,
    );

    await repository.save(settings);
    final restored = await repository.read();

    expect(restored?.updatedAt, remoteUpdatedAt);
  });
}
