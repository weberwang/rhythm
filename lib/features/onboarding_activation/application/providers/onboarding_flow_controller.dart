import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../app/startup/launch_state_provider.dart';
import '../../../sleep_data_core/application/providers/goal_schedule_repository_provider.dart';
import '../../../sleep_data_core/domain/entities/goal_schedule.dart';
import '../../domain/entities/onboarding_draft.dart';

part 'onboarding_flow_controller.g.dart';

/// 管理 onboarding 的最小 3 步草稿状态，并统一提交目标作息与完成标记。
@Riverpod(keepAlive: true)
class OnboardingFlowController extends _$OnboardingFlowController {
  /// 构建默认草稿，让首启用户直接从欢迎页进入并带着可用默认作息继续。
  @override
  OnboardingDraft build() {
    return const OnboardingDraft(
      step: OnboardingStep.welcome,
      bedtimeMinutes: 23 * 60,
      wakeTimeMinutes: 7 * 60,
    );
  }

  /// 推进到下一步，但保留进入方式未选时不可越过选择页的边界。
  void goToNextStep() {
    state = switch (state.step) {
      OnboardingStep.welcome => state.copyWith(step: OnboardingStep.entryMode),
      OnboardingStep.entryMode when state.entryMode != null => state.copyWith(
        step: OnboardingStep.permissionValue,
      ),
      OnboardingStep.entryMode => state,
      OnboardingStep.permissionValue => state.copyWith(
        step: OnboardingStep.goalSchedule,
      ),
      OnboardingStep.goalSchedule => state.copyWith(
        step: OnboardingStep.reminderStrategy,
      ),
      OnboardingStep.reminderStrategy when state.reminderStrategy != null =>
        state.copyWith(step: OnboardingStep.completion),
      OnboardingStep.reminderStrategy => state,
      OnboardingStep.completion => state,
    };
  }

  /// 返回上一步，避免用户只能强行完成当前选择。
  void goToPreviousStep() {
    state = switch (state.step) {
      OnboardingStep.welcome => state,
      OnboardingStep.entryMode => state.copyWith(step: OnboardingStep.welcome),
      OnboardingStep.permissionValue => state.copyWith(
        step: OnboardingStep.entryMode,
      ),
      OnboardingStep.goalSchedule => state.copyWith(
        step: OnboardingStep.permissionValue,
      ),
      OnboardingStep.reminderStrategy => state.copyWith(
        step: OnboardingStep.goalSchedule,
      ),
      OnboardingStep.completion => state.copyWith(
        step: OnboardingStep.reminderStrategy,
      ),
    };
  }

  /// 记录当前进入方式选择，为后续账号同步与权限分流预留边界。
  void selectEntryMode(OnboardingEntryMode mode) {
    state = state.copyWith(entryMode: mode);
  }

  /// 更新目标入睡时间，使用分钟偏移保持与共享作息实体一致。
  void updateBedtimeMinutes(int minutes) {
    state = state.copyWith(bedtimeMinutes: minutes);
  }

  /// 更新目标起床时间，使用分钟偏移保持与共享作息实体一致。
  void updateWakeTimeMinutes(int minutes) {
    state = state.copyWith(wakeTimeMinutes: minutes);
  }

  /// 记录当前提醒策略选择，为后续真实通知调度接入保留统一边界。
  void selectReminderStrategy(OnboardingReminderStrategy strategy) {
    state = state.copyWith(reminderStrategy: strategy);
  }

  /// 提交当前作息并完成引导，让后续启动直接进入主壳。
  Future<void> complete() async {
    final repository = ref.read(goalScheduleRepositoryProvider);
    await repository.saveActiveSchedule(
      GoalSchedule(
        id: DateTime.now().microsecondsSinceEpoch.toString(),
        bedtimeMinutes: state.bedtimeMinutes,
        wakeTimeMinutes: state.wakeTimeMinutes,
        createdAt: DateTime.now(),
      ),
    );

    await ref.read(completeOnboardingProvider.future);
  }
}
