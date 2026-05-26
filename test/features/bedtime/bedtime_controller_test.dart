import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rhythm/core/analytics/analytics_event.dart';
import 'package:rhythm/core/analytics/in_memory_analytics_gateway.dart';
import 'package:rhythm/core/time/time_context.dart';
import 'package:rhythm/core/time/time_context_provider.dart';
import 'package:rhythm/features/bedtime/application/bedtime_controller.dart';
import 'package:rhythm/features/bedtime/application/bedtime_view_state.dart';
import 'package:rhythm/features/bedtime/data/in_memory_bedtime_session_repository.dart';
import 'package:rhythm/features/bedtime/domain/bedtime_action.dart';
import 'package:rhythm/features/bedtime/domain/bedtime_status.dart';
import 'package:rhythm/features/goal_schedule/application/goal_schedule_providers.dart';
import 'package:rhythm/features/goal_schedule/domain/goal_schedule_settings.dart';
import 'package:rhythm/features/goal_schedule/domain/repositories/goal_schedule_settings_repository.dart';

/// 验证睡前模式控制器会创建会话、更新状态并记录关键埋点。
void main() {
  const settings = GoalScheduleSettings(
    targetBedtimeMinutes: 23 * 60 + 30,
    targetWakeMinutes: 7 * 60 + 30,
    lateThresholdMinutes: 30,
    dayStartMinutes: 4 * 60,
  );

  test('初次进入时创建当天会话并记录进入埋点', () async {
    final analytics = InMemoryAnalyticsGateway();
    final repository = InMemoryBedtimeSessionRepository();
    final container = ProviderContainer(
      overrides: [
        goalScheduleSettingsRepositoryProvider.overrideWithValue(
          _FakeGoalScheduleSettingsRepository(settings),
        ),
        bedtimeSessionRepositoryProvider.overrideWith((ref) => repository),
        analyticsGatewayProvider.overrideWithValue(analytics),
        timeContextProvider.overrideWithValue(
          TimeContext(
            now: DateTime(2026, 5, 24, 22, 45),
            timezoneName: 'Asia/Shanghai',
          ),
        ),
      ],
    );
    addTearDown(container.dispose);

    final state = await container.read(bedtimeControllerProvider.future);

    expect(state.status, BedtimeViewStatus.ready);
    expect(state.sessionId, isNotEmpty);
    expect(await repository.findByDate(DateTime(2026, 5, 24)), isNotNull);
    expect(
      analytics.events.map((event) => event.name),
      contains(AnalyticsEventName.bedtimeModeEntered),
    );
  });

  test('选择准备睡觉后保存状态并记录状态埋点', () async {
    final analytics = InMemoryAnalyticsGateway();
    final repository = InMemoryBedtimeSessionRepository();
    final container = ProviderContainer(
      overrides: [
        goalScheduleSettingsRepositoryProvider.overrideWithValue(
          _FakeGoalScheduleSettingsRepository(settings),
        ),
        bedtimeSessionRepositoryProvider.overrideWith((ref) => repository),
        analyticsGatewayProvider.overrideWithValue(analytics),
        timeContextProvider.overrideWithValue(
          TimeContext(
            now: DateTime(2026, 5, 24, 22, 45),
            timezoneName: 'Asia/Shanghai',
          ),
        ),
      ],
    );
    addTearDown(container.dispose);

    final controller = container.read(bedtimeControllerProvider.notifier);
    await container.read(bedtimeControllerProvider.future);

    await controller.selectStatus(BedtimeStatus.readyToSleep);
    final updated = await container.read(bedtimeControllerProvider.future);
    final session = await repository.findByDate(DateTime(2026, 5, 24));

    expect(updated.selectedStatus, BedtimeStatus.readyToSleep);
    expect(session?.selectedStatus, BedtimeStatus.readyToSleep);
    expect(
      analytics.events.map((event) => event.name),
      contains(AnalyticsEventName.bedtimeStatusSelected),
    );
  });

  test('选择还想拖一会儿后优先给十分钟收尾建议', () async {
    final container = ProviderContainer(
      overrides: [
        goalScheduleSettingsRepositoryProvider.overrideWithValue(
          _FakeGoalScheduleSettingsRepository(settings),
        ),
        bedtimeSessionRepositoryProvider.overrideWith(
          (ref) => InMemoryBedtimeSessionRepository(),
        ),
        analyticsGatewayProvider.overrideWithValue(InMemoryAnalyticsGateway()),
        timeContextProvider.overrideWithValue(
          TimeContext(
            now: DateTime(2026, 5, 24, 23, 35),
            timezoneName: 'Asia/Shanghai',
          ),
        ),
      ],
    );
    addTearDown(container.dispose);

    final controller = container.read(bedtimeControllerProvider.notifier);
    await container.read(bedtimeControllerProvider.future);

    await controller.selectStatus(BedtimeStatus.wantsMoreTime);
    final updated = await container.read(bedtimeControllerProvider.future);

    expect(updated.selectedStatus, BedtimeStatus.wantsMoreTime);
    expect(updated.actions.first.type, BedtimeActionType.tenMinuteWrapUp);
  });

  test('选择大概率晚睡后优先给明早恢复建议', () async {
    final container = ProviderContainer(
      overrides: [
        goalScheduleSettingsRepositoryProvider.overrideWithValue(
          _FakeGoalScheduleSettingsRepository(settings),
        ),
        bedtimeSessionRepositoryProvider.overrideWith(
          (ref) => InMemoryBedtimeSessionRepository(),
        ),
        analyticsGatewayProvider.overrideWithValue(InMemoryAnalyticsGateway()),
        timeContextProvider.overrideWithValue(
          TimeContext(
            now: DateTime(2026, 5, 25, 0, 10),
            timezoneName: 'Asia/Shanghai',
          ),
        ),
      ],
    );
    addTearDown(container.dispose);

    final controller = container.read(bedtimeControllerProvider.notifier);
    await container.read(bedtimeControllerProvider.future);

    await controller.selectStatus(BedtimeStatus.likelyLate);
    final updated = await container.read(bedtimeControllerProvider.future);

    expect(updated.selectedStatus, BedtimeStatus.likelyLate);
    expect(updated.actions.first.type, BedtimeActionType.planRecoveryTomorrow);
  });

  test('缺少目标作息时输出 goalMissing 状态', () async {
    final container = ProviderContainer(
      overrides: [
        goalScheduleSettingsRepositoryProvider.overrideWithValue(
          _FakeGoalScheduleSettingsRepository(null),
        ),
        bedtimeSessionRepositoryProvider.overrideWith(
          (ref) => InMemoryBedtimeSessionRepository(),
        ),
        analyticsGatewayProvider.overrideWithValue(InMemoryAnalyticsGateway()),
        timeContextProvider.overrideWithValue(
          TimeContext(
            now: DateTime(2026, 5, 24, 22, 45),
            timezoneName: 'Asia/Shanghai',
          ),
        ),
      ],
    );
    addTearDown(container.dispose);

    final state = await container.read(bedtimeControllerProvider.future);

    expect(state.status, BedtimeViewStatus.goalMissing);
  });

  test('完成动作后记录动作埋点', () async {
    final analytics = InMemoryAnalyticsGateway();
    final container = ProviderContainer(
      overrides: [
        goalScheduleSettingsRepositoryProvider.overrideWithValue(
          _FakeGoalScheduleSettingsRepository(settings),
        ),
        bedtimeSessionRepositoryProvider.overrideWith(
          (ref) => InMemoryBedtimeSessionRepository(),
        ),
        analyticsGatewayProvider.overrideWithValue(analytics),
        timeContextProvider.overrideWithValue(
          TimeContext(
            now: DateTime(2026, 5, 24, 22, 45),
            timezoneName: 'Asia/Shanghai',
          ),
        ),
      ],
    );
    addTearDown(container.dispose);

    final controller = container.read(bedtimeControllerProvider.notifier);
    final state = await container.read(bedtimeControllerProvider.future);

    await controller.completeAction(state.actions.first);

    expect(
      analytics.events.where(
        (event) => event.name == AnalyticsEventName.bedtimeActionClicked,
      ),
      isNotEmpty,
    );
  });

  test('目标作息更新后会重新计算睡前页状态', () async {
    final repository = _FakeGoalScheduleSettingsRepository(null);
    final container = ProviderContainer(
      overrides: [
        goalScheduleSettingsRepositoryProvider.overrideWithValue(repository),
        bedtimeSessionRepositoryProvider.overrideWith(
          (ref) => InMemoryBedtimeSessionRepository(),
        ),
        analyticsGatewayProvider.overrideWithValue(InMemoryAnalyticsGateway()),
        timeContextProvider.overrideWithValue(
          TimeContext(
            now: DateTime(2026, 5, 24, 22, 45),
            timezoneName: 'Asia/Shanghai',
          ),
        ),
      ],
    );
    addTearDown(container.dispose);

    final initial = await container.read(bedtimeControllerProvider.future);
    expect(initial.status, BedtimeViewStatus.goalMissing);

    await repository.save(settings);
    container.invalidate(savedGoalScheduleSettingsProvider);

    final updated = await container.read(bedtimeControllerProvider.future);

    expect(updated.status, BedtimeViewStatus.ready);
    expect(updated.targetBedtime, isNotNull);
  });
}

/// 提供测试用目标作息仓储，避免控制器测试依赖真实持久化。
class _FakeGoalScheduleSettingsRepository extends GoalScheduleSettingsRepository {
  _FakeGoalScheduleSettingsRepository(this._settings);

  GoalScheduleSettings? _settings;

  @override
  Future<GoalScheduleSettings?> read() async {
    return _settings;
  }

  @override
  Future<void> save(GoalScheduleSettings settings) async {
    // 测试通过直接改写当前值，模拟用户保存新的目标作息。
    _settings = settings;
  }
}
