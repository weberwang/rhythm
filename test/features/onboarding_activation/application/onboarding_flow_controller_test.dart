import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rhythm/features/onboarding_activation/application/providers/onboarding_flow_controller.dart';
import 'package:rhythm/features/onboarding_activation/domain/entities/onboarding_draft.dart';
import 'package:rhythm/features/sleep_data_core/application/providers/goal_schedule_repository_provider.dart';
import 'package:rhythm/features/sleep_data_core/domain/entities/goal_schedule.dart';
import 'package:rhythm/features/sleep_data_core/domain/repositories/goal_schedule_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// 用内存仓储验证 onboarding 提交会把目标作息真正交给共享数据层。
class _FakeGoalScheduleRepository implements GoalScheduleRepository {
  GoalSchedule? savedSchedule;

  @override
  Future<GoalSchedule?> readActiveSchedule() async => savedSchedule;

  @override
  Future<void> saveActiveSchedule(GoalSchedule schedule) async {
    savedSchedule = schedule;
  }
}

/// 验证激活漏斗会按冻结的最小路径推进，并在完成时写入作息。
void main() {
  test('onboarding flow advances across all staged onboarding steps', () {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    final controller = container.read(onboardingFlowControllerProvider.notifier);

    expect(
      container.read(onboardingFlowControllerProvider).step,
      OnboardingStep.welcome,
    );

    controller.goToNextStep();
    expect(
      container.read(onboardingFlowControllerProvider).step,
      OnboardingStep.entryMode,
    );

    controller.selectEntryMode(OnboardingEntryMode.localFirst);
    controller.goToNextStep();
    expect(
      container.read(onboardingFlowControllerProvider).step,
      OnboardingStep.permissionValue,
    );

    controller.goToNextStep();
    expect(
      container.read(onboardingFlowControllerProvider).step,
      OnboardingStep.goalSchedule,
    );

    controller.selectReminderStrategy(OnboardingReminderStrategy.gentle);
    controller.goToNextStep();
    expect(
      container.read(onboardingFlowControllerProvider).step,
      OnboardingStep.reminderStrategy,
    );

    controller.goToNextStep();
    expect(
      container.read(onboardingFlowControllerProvider).step,
      OnboardingStep.completion,
    );
  });

  test('onboarding completion persists selected schedule and completion flag',
      () async {
    SharedPreferences.setMockInitialValues({});
    final repository = _FakeGoalScheduleRepository();
    final container = ProviderContainer(
      overrides: [
        goalScheduleRepositoryProvider.overrideWithValue(repository),
      ],
    );
    addTearDown(container.dispose);

    final controller = container.read(onboardingFlowControllerProvider.notifier);
    controller.selectEntryMode(OnboardingEntryMode.localFirst);
    controller.updateBedtimeMinutes(22 * 60 + 30);
    controller.updateWakeTimeMinutes(6 * 60 + 45);
    controller.selectReminderStrategy(OnboardingReminderStrategy.gentle);
    controller.goToNextStep();
    controller.goToNextStep();
    controller.goToNextStep();
    controller.goToNextStep();

    await controller.complete();

    expect(repository.savedSchedule, isNotNull);
    expect(repository.savedSchedule!.bedtimeMinutes, 22 * 60 + 30);
    expect(repository.savedSchedule!.wakeTimeMinutes, 6 * 60 + 45);
    expect(
      container.read(onboardingFlowControllerProvider).reminderStrategy,
      OnboardingReminderStrategy.gentle,
    );
    final preferences = await SharedPreferences.getInstance();
    expect(preferences.getBool('onboarding_completed'), isTrue);
  });
}
