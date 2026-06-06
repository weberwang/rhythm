import 'dart:async';

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

/// 用抛错仓储模拟启动恢复失败，验证启动链会降级到本地引导而不是停在错误页。
class _ThrowingGoalScheduleRepository implements GoalScheduleRepository {
  /// 创建用于测试的异常仓储。
  const _ThrowingGoalScheduleRepository();

  @override
  Future<GoalSchedule?> readActiveSchedule() {
    throw StateError('database unavailable');
  }

  @override
  Future<void> saveActiveSchedule(GoalSchedule schedule) async {}
}

/// 用可控异步读取模拟 provider 在等待期间被销毁的竞态。
class _DelayedGoalScheduleRepository implements GoalScheduleRepository {
  /// 创建用于测试销毁竞态的假仓储。
  _DelayedGoalScheduleRepository(this._scheduleFuture);

  final Future<GoalSchedule?> _scheduleFuture;

  @override
  Future<GoalSchedule?> readActiveSchedule() => _scheduleFuture;

  @override
  Future<void> saveActiveSchedule(GoalSchedule schedule) async {}
}

/// 用顺序可控的仓储模拟慢 IO 场景，验证完成引导后仍会刷新已缓存的启动决策。
class _SequencedGoalScheduleRepository implements GoalScheduleRepository {
  /// 创建带顺序阻塞能力的假仓储。
  _SequencedGoalScheduleRepository({
    GoalSchedule? initialSchedule,
    required this.blockedReadNumber,
    required this.readBlocker,
  }) : _schedule = initialSchedule;

  GoalSchedule? _schedule;
  final int blockedReadNumber;
  final Completer<void> readBlocker;
  int _readCount = 0;

  @override
  Future<GoalSchedule?> readActiveSchedule() async {
    _readCount += 1;
    if (_readCount == blockedReadNumber) {
      // 用受控阻塞放大真实设备上的异步窗口，稳定复现 autoDispose 竞态。
      await readBlocker.future;
    }
    return _schedule;
  }

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

  test(
    'launchState falls back to onboarding when schedule restore fails',
    () async {
      SharedPreferences.setMockInitialValues({'onboarding_completed': true});
      final container = ProviderContainer(
        overrides: [
          goalScheduleRepositoryProvider.overrideWithValue(
            const _ThrowingGoalScheduleRepository(),
          ),
        ],
      );

      addTearDown(container.dispose);

      final snapshot = await container.read(launchStateProvider.future);

      expect(snapshot.destination, LaunchDestination.onboarding);
    },
  );

  test(
    'completeOnboarding does not use disposed ref after async gap',
    () async {
      SharedPreferences.setMockInitialValues({});
      final readCompleter = Completer<GoalSchedule?>();
      final container = ProviderContainer(
        overrides: [
          goalScheduleRepositoryProvider.overrideWithValue(
            _DelayedGoalScheduleRepository(readCompleter.future),
          ),
        ],
      );

      final future = container.read(completeOnboardingProvider.future);
      container.dispose();
      readCompleter.complete(null);

      await expectLater(future.timeout(const Duration(seconds: 1)), completes);
    },
  );

  test(
    'completeOnboarding refreshes cached launch state after slow async gap',
    () async {
      SharedPreferences.setMockInitialValues({});
      final readCompleter = Completer<void>();
      final repository = _SequencedGoalScheduleRepository(
        blockedReadNumber: 2,
        readBlocker: readCompleter,
      );
      final container = ProviderContainer(
        overrides: [
          goalScheduleRepositoryProvider.overrideWithValue(repository),
        ],
      );
      addTearDown(container.dispose);

      final subscription = container.listen<AsyncValue<LaunchSnapshot>>(
        launchStateProvider,
        (_, _) {},
        fireImmediately: true,
      );
      addTearDown(subscription.close);

      final initialSnapshot = await container.read(launchStateProvider.future);
      expect(initialSnapshot.destination, LaunchDestination.onboarding);

      final completionFuture = container.read(completeOnboardingProvider.future);
      await Future<void>.delayed(Duration.zero);
      readCompleter.complete();

      await completionFuture;
      await Future<void>.delayed(Duration.zero);

      final refreshedSnapshot = subscription.read();
      expect(refreshedSnapshot.hasValue, isTrue);
      expect(
        refreshedSnapshot.requireValue.destination,
        LaunchDestination.shell,
      );
    },
  );
}
