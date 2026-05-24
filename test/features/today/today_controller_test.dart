import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rhythm/features/goal_schedule/application/goal_schedule_providers.dart';
import 'package:rhythm/features/goal_schedule/domain/goal_schedule_settings.dart';
import 'package:rhythm/features/goal_schedule/domain/repositories/goal_schedule_settings_repository.dart';
import 'package:rhythm/features/sleep_records/application/effective_sleep_record_provider.dart';
import 'package:rhythm/features/sleep_records/application/sleep_record_providers.dart';
import 'package:rhythm/features/sleep_records/domain/effective_sleep_record.dart';
import 'package:rhythm/features/sleep_records/domain/health_platform_state.dart';
import 'package:rhythm/features/sleep_records/domain/sleep_record_confidence.dart';
import 'package:rhythm/features/sleep_records/domain/sleep_record_source.dart';
import 'package:rhythm/features/today/application/today_controller.dart';
import 'package:rhythm/features/today/application/today_view_state.dart';

/// 验证今日页控制器状态映射。
void main() {
  const settings = GoalScheduleSettings(
    targetBedtimeMinutes: 23 * 60 + 30,
    targetWakeMinutes: 7 * 60 + 30,
    lateThresholdMinutes: 30,
    dayStartMinutes: 4 * 60,
  );

  EffectiveSleepRecord buildRecord({
    required String id,
    required DateTime recordDate,
    required DateTime fellAsleepAt,
    required bool isUserConfirmed,
  }) {
    return EffectiveSleepRecord(
      recordId: id,
      recordDate: recordDate,
      fellAsleepAt: fellAsleepAt,
      wokeUpAt: fellAsleepAt.add(const Duration(hours: 8)),
      durationMinutes: 8 * 60,
      source: isUserConfirmed
          ? SleepRecordSource.manual
          : SleepRecordSource.healthKit,
      confidence: SleepRecordConfidence.high,
      timezone: 'Asia/Shanghai',
      isUserConfirmed: isUserConfirmed,
      sourceRecordId: null,
    );
  }

  test('有数据时输出 ready 状态', () async {
    final container = ProviderContainer(
      overrides: [
        goalScheduleSettingsRepositoryProvider.overrideWithValue(
          _FakeGoalScheduleSettingsRepository(settings),
        ),
        recentEffectiveSleepRecordsProvider.overrideWith(
          (ref) async => <EffectiveSleepRecord>[
            buildRecord(
              id: 'r1',
              recordDate: DateTime.utc(2026, 5, 23),
              fellAsleepAt: DateTime.utc(2026, 5, 23, 23, 45),
              isUserConfirmed: false,
            ),
          ],
        ),
        healthPlatformStateProvider.overrideWith(
          (ref) async => HealthPlatformState.iosAvailable(),
        ),
      ],
    );
    addTearDown(container.dispose);

    final state = await container.read(todayControllerProvider.future);

    expect(state.status, TodayViewStatus.ready);
    expect(state.summary, isNotNull);
  });

  test('无记录时输出 empty 状态', () async {
    final container = ProviderContainer(
      overrides: [
        goalScheduleSettingsRepositoryProvider.overrideWithValue(
          _FakeGoalScheduleSettingsRepository(settings),
        ),
        recentEffectiveSleepRecordsProvider.overrideWith(
          (ref) async => const <EffectiveSleepRecord>[],
        ),
        healthPlatformStateProvider.overrideWith(
          (ref) async => HealthPlatformState.iosAvailable(),
        ),
      ],
    );
    addTearDown(container.dispose);

    final state = await container.read(todayControllerProvider.future);

    expect(state.status, TodayViewStatus.empty);
  });

  test('权限失败时输出 permissionFailed 状态', () async {
    final container = ProviderContainer(
      overrides: [
        goalScheduleSettingsRepositoryProvider.overrideWithValue(
          _FakeGoalScheduleSettingsRepository(settings),
        ),
        recentEffectiveSleepRecordsProvider.overrideWith(
          (ref) async => const <EffectiveSleepRecord>[],
        ),
        healthPlatformStateProvider.overrideWith(
          (ref) async => HealthPlatformState.iosPermissionRequired(),
        ),
      ],
    );
    addTearDown(container.dispose);

    final state = await container.read(todayControllerProvider.future);

    expect(state.status, TodayViewStatus.permissionFailed);
  });

  test('缺少目标作息时输出 goalMissing 状态', () async {
    final container = ProviderContainer(
      overrides: [
        goalScheduleSettingsRepositoryProvider.overrideWithValue(
          _FakeGoalScheduleSettingsRepository(null),
        ),
        recentEffectiveSleepRecordsProvider.overrideWith(
          (ref) async => const <EffectiveSleepRecord>[],
        ),
        healthPlatformStateProvider.overrideWith(
          (ref) async => HealthPlatformState.iosAvailable(),
        ),
      ],
    );
    addTearDown(container.dispose);

    final state = await container.read(todayControllerProvider.future);

    expect(state.status, TodayViewStatus.goalMissing);
  });

  test('明显晚睡时恢复建议会被置顶', () async {
    final container = ProviderContainer(
      overrides: [
        goalScheduleSettingsRepositoryProvider.overrideWithValue(
          _FakeGoalScheduleSettingsRepository(settings),
        ),
        recentEffectiveSleepRecordsProvider.overrideWith(
          (ref) async => <EffectiveSleepRecord>[
            buildRecord(
              id: 'r1',
              recordDate: DateTime.utc(2026, 5, 23),
              fellAsleepAt: DateTime.utc(2026, 5, 24, 0, 30),
              isUserConfirmed: false,
            ),
          ],
        ),
        healthPlatformStateProvider.overrideWith(
          (ref) async => HealthPlatformState.iosAvailable(),
        ),
      ],
    );
    addTearDown(container.dispose);

    final state = await container.read(todayControllerProvider.future);

    expect(state.status, TodayViewStatus.ready);
    expect(state.summary!.showRecoveryCard, isTrue);
    expect(state.prioritizeRecoveryCard, isTrue);
  });
}

/// 提供测试用目标作息仓储，避免控制器测试依赖真实持久化。
class _FakeGoalScheduleSettingsRepository extends GoalScheduleSettingsRepository {
  _FakeGoalScheduleSettingsRepository(this._settings);

  final GoalScheduleSettings? _settings;

  @override
  Future<GoalScheduleSettings?> read() async {
    return _settings;
  }

  @override
  Future<void> save(GoalScheduleSettings settings) async {}
}
