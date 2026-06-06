import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../app/startup/launch_state_provider.dart';
import '../../../app_shell/application/providers/account_session_repository_provider.dart';
import '../../../app_shell/application/providers/current_account_session_provider.dart';
import '../../../app_shell/domain/entities/account_session.dart';
import '../../../app_shell/application/providers/current_entry_intent_provider.dart';
import '../../../sleep_data_core/application/providers/goal_schedule_repository_provider.dart';
import '../../../sleep_data_core/domain/entities/goal_schedule.dart';
import '../../domain/entities/onboarding_account_connection_result.dart';
import 'onboarding_capability_gateways.dart';
import '../../domain/entities/onboarding_draft.dart';

part 'onboarding_flow_controller.g.dart';

/// 管理 onboarding 的最小激活状态机，并统一提交权限结果、作息与完成标记。
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
        state.copyWith(step: OnboardingStep.widgetGuide),
      OnboardingStep.reminderStrategy => state,
      OnboardingStep.widgetGuide => state.copyWith(
        step: OnboardingStep.completion,
      ),
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
      OnboardingStep.widgetGuide => state.copyWith(
        step: OnboardingStep.reminderStrategy,
      ),
      OnboardingStep.completion => state.copyWith(step: OnboardingStep.widgetGuide),
    };
  }

  /// 记录当前进入方式选择，为后续账号同步与权限分流预留边界。
  void selectEntryMode(OnboardingEntryMode mode) {
    state = state.copyWith(
      entryMode: mode,
      selectedAccountProvider: null,
      accountConnection: null,
    );
  }

  /// 记录当前选中的账号提供方，并把入口模式切到账号路径。
  void selectAccountProvider(OnboardingAccountProvider provider) {
    state = state.copyWith(
      entryMode: OnboardingEntryMode.account,
      selectedAccountProvider: provider,
      accountConnection: null,
    );
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

  /// 触发最小健康权限请求，并在失败或不可用时自动降级到本地优先路径。
  Future<void> requestHealthPermissionAndContinue() async {
    final gateway = ref.read(onboardingHealthPermissionGatewayProvider);
    final permissionStatus = await gateway.requestSleepPermission();

    state = state.copyWith(
      permissionStatus: permissionStatus,
      step: OnboardingStep.goalSchedule,
    );
  }

  /// 触发当前选中的账号登录，并在成功后推进到权限说明页。
  Future<void> authenticateSelectedAccountAndContinue() async {
    final provider = state.selectedAccountProvider;
    if (provider == null) {
      return;
    }

    final gateway = ref.read(onboardingAccountGatewayProvider);
    final result = await gateway.signIn(provider);

    state = state.copyWith(accountConnection: result);
    if (result.status == OnboardingAccountConnectionStatus.success) {
      state = state.copyWith(step: OnboardingStep.permissionValue);
    }
  }

  /// 提交当前作息并完成引导，让后续启动直接进入主壳。
  Future<void> complete() async {
    final repository = ref.read(goalScheduleRepositoryProvider);
    final accountSessionRepository = ref.read(accountSessionRepositoryProvider);
    await repository.saveActiveSchedule(
      GoalSchedule(
        id: DateTime.now().microsecondsSinceEpoch.toString(),
        bedtimeMinutes: state.bedtimeMinutes,
        wakeTimeMinutes: state.wakeTimeMinutes,
        createdAt: DateTime.now(),
      ),
    );
    await accountSessionRepository.save(_buildAccountSessionSnapshot());
    ref.invalidate(currentAccountSessionProvider);

    // onboarding 完成后首个正式落地页应回到 today，不再继承首启前的一次性通知/小组件目标。
    ref.read(currentEntryIntentProvider.notifier).resetToAppOpen();
    await ref.read(completeOnboardingProvider.future);
  }

  /// 把引导期登录结果折叠成稳定的本地账号快照，先服务设置页与后续同步分流。
  AppAccountSession _buildAccountSessionSnapshot() {
    final connection = state.accountConnection;
    if (connection?.status == OnboardingAccountConnectionStatus.success &&
        connection?.provider != null) {
      return AppAccountSession(
        mode: AppAccountSessionMode.connected,
        provider: _mapAccountProvider(connection!.provider),
        displayName: connection.displayName,
        email: connection.email,
        updatedAt: DateTime.now(),
      );
    }

    return AppAccountSession(
      mode: AppAccountSessionMode.anonymous,
      updatedAt: DateTime.now(),
    );
  }

  /// 统一转换账号来源枚举，避免 app-shell 依赖 onboarding 内部实现细节。
  AppAccountProvider _mapAccountProvider(OnboardingAccountProvider provider) {
    return switch (provider) {
      OnboardingAccountProvider.apple => AppAccountProvider.apple,
      OnboardingAccountProvider.google => AppAccountProvider.google,
    };
  }
}
