import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rhythm/app/startup/launch_state.dart';
import 'package:rhythm/app/startup/launch_state_provider.dart';
import 'package:rhythm/features/sleep_data_core/application/providers/goal_schedule_repository_provider.dart';
import 'package:rhythm/features/sleep_data_core/domain/entities/goal_schedule.dart';
import 'package:rhythm/features/sleep_data_core/domain/repositories/goal_schedule_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// 用可控假仓储验证启动期 guard 是否同时检查引导完成度与目标作息。
class _FakeGoalScheduleRepository implements GoalScheduleRepository {
  /// 创建用于测试的假仓储。
  _FakeGoalScheduleRepository(this._schedule);

  GoalSchedule? _schedule;

  @override
  Future<GoalSchedule?> readActiveSchedule() async => _schedule;

  @override
  Future<void> saveActiveSchedule(GoalSchedule schedule) async {
    _schedule = schedule;
  }
}

/// 覆盖启动期 provider，保证根分发在进入实现后仍遵守 Stage 1 guard 规则。
void main() {
  test('launchState enters onboarding when schedule is missing', () async {
    SharedPreferences.setMockInitialValues({'onboarding_completed': true});
    final container = ProviderContainer(
      overrides: [
        goalScheduleRepositoryProvider.overrideWithValue(
          _FakeGoalScheduleRepository(null),
        ),
      ],
    );

    addTearDown(container.dispose);

    final snapshot = await container.read(launchStateProvider.future);

    expect(snapshot.destination, LaunchDestination.onboarding);
  });

  test(
    'launchState enters shell when onboarding and schedule are ready',
    () async {
      SharedPreferences.setMockInitialValues({'onboarding_completed': true});
      final container = ProviderContainer(
        overrides: [
          goalScheduleRepositoryProvider.overrideWithValue(
            _FakeGoalScheduleRepository(
              GoalSchedule(
                id: 'fixture',
                bedtimeMinutes: 23 * 60,
                wakeTimeMinutes: 7 * 60,
                createdAt: DateTime(2026, 6, 4),
              ),
            ),
          ),
        ],
      );

      addTearDown(container.dispose);

      final snapshot = await container.read(launchStateProvider.future);

      expect(snapshot.destination, LaunchDestination.shell);
    },
  );
}
