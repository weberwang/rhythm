import 'package:rhythm/core/permissions/app_permission_models.dart';
import 'package:rhythm/core/observability/app_logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:rhythm/features/app_shell/infrastructure/app_shell_launch_state_store.dart';
import 'package:rhythm/features/onboarding_activation/domain/onboarding_activation_models.dart';
import 'package:rhythm/features/onboarding_activation/infrastructure/onboarding_activation_health_gateway.dart';
import 'package:rhythm/features/onboarding_activation/infrastructure/onboarding_activation_notification_gateway.dart';
import 'package:rhythm/features/onboarding_activation/infrastructure/onboarding_activation_preferences_store.dart';

part 'onboarding_activation_controller.g.dart';

const _onboardingCompletionFailedMessageKey =
    'onboardingCompletionFailedMessage';
const _onboardingHealthDeferredMessageKey = 'onboardingHealthDeferredMessage';
const _onboardingReminderDeferredMessageKey =
    'onboardingReminderDeferredMessage';

/// 管理首次激活步骤流和完成动作。
@riverpod
class OnboardingActivationController extends _$OnboardingActivationController {
  @override
  Future<OnboardingActivationState> build() async {
    final preferencesStore = ref.watch(
      onboardingActivationPreferencesStoreProvider,
    );
    return preferencesStore.loadDraft(ref);
  }

  /// 选择进入方式。
  Future<void> selectEntryMode(OnboardingEntryMode entryMode) async {
    await _updateState((current) => current.copyWith(entryMode: entryMode));
  }

  /// 选择健康数据路径。
  Future<void> selectHealthChoice(OnboardingHealthChoice healthChoice) async {
    await _updateState((current) => current.copyWith(healthChoice: healthChoice));
  }

  /// 更新入睡时间。
  Future<void> setBedtimeHour(int hour) async {
    await _updateState((current) => current.copyWith(bedtimeHour: hour));
  }

  /// 更新起床时间。
  Future<void> setWakeHour(int hour) async {
    await _updateState((current) => current.copyWith(wakeHour: hour));
  }

  /// 更新提醒策略。
  Future<void> setReminderChoice(
    OnboardingReminderChoice reminderChoice,
  ) async {
    await _updateState(
      (current) => current.copyWith(reminderChoice: reminderChoice),
    );
  }

  /// 更新提醒提前分钟。
  Future<void> setReminderLeadMinutes(int minutes) async {
    await _updateState(
      (current) => current.copyWith(reminderLeadMinutes: minutes),
    );
  }

  /// 进入下一步。
  Future<bool> continueFlow() async {
    final current = await future;
    if (!_canContinue(current)) {
      return false;
    }

    if (current.currentStep == OnboardingActivationStep.reminders) {
      return completeOnboarding();
    }

    await _updateState(
      (state) => state.copyWith(currentStep: _nextStep(state.currentStep)),
    );
    return true;
  }

  /// 返回上一步。
  Future<void> goBack() async {
    final current = await future;
    if (current.currentStep == OnboardingActivationStep.welcome) {
      return;
    }

    await _updateState(
      (state) => state.copyWith(currentStep: _previousStep(state.currentStep)),
    );
  }

  /// 提交首次激活完成动作，并返回是否可以进入主链路。
  Future<bool> completeOnboarding() async {
    final current = await future;
    if (!_canContinue(current) || current.isSubmitting) {
      return false;
    }

    final launchStateStore = ref.read(appShellLaunchStateStoreProvider);
    final preferencesStore = ref.read(onboardingActivationPreferencesStoreProvider);
    final healthGateway = ref.read(onboardingActivationHealthGatewayProvider);
    final notificationGateway = ref.read(
      onboardingActivationNotificationGatewayProvider,
    );
    final logger = ref.read(appLoggerProvider);

    state = AsyncData(
      current.copyWith(isSubmitting: true, submissionErrorMessage: null),
    );

    try {
      var nextState = current.copyWith(
        isSubmitting: true,
        submissionErrorMessage: null,
      );

      if (current.healthChoice == OnboardingHealthChoice.connectHealth) {
        final healthStatus = await healthGateway.requestSleepReadAccess();
        nextState = nextState.copyWith(
          healthPermissionStatus: healthStatus,
          submissionErrorMessage: healthStatus == AppPermissionStatus.granted
              ? null
              : _onboardingHealthDeferredMessageKey,
        );
      } else {
        nextState = nextState.copyWith(
          healthPermissionStatus: AppPermissionStatus.denied,
        );
      }

      final reminderScheduled = await notificationGateway.applyReminderPlan(
        nextState.copyWith(isSubmitting: false),
      );
      nextState = nextState.copyWith(
        reminderScheduled: reminderScheduled,
        submissionErrorMessage: _resolveSubmissionMessage(
          healthPermissionStatus: nextState.healthPermissionStatus,
          reminderChoice: nextState.reminderChoice,
          reminderScheduled: reminderScheduled,
        ),
      );

      await preferencesStore.saveDraft(ref, nextState.copyWith(isSubmitting: false));
      await launchStateStore.markOnboardingCompleted(ref);
      state = AsyncData(
        nextState.copyWith(isSubmitting: false),
      );
      return true;
    } catch (error, stackTrace) {
      logger.error('Failed to complete onboarding activation.', error, stackTrace);
      state = AsyncData(
        current.copyWith(
          isSubmitting: false,
          submissionErrorMessage: _onboardingCompletionFailedMessageKey,
        ),
      );
      return false;
    }
  }

  /// 当前步骤是否允许继续。
  bool canContinue(OnboardingActivationState state) {
    return _canContinue(state);
  }

  Future<void> _updateState(
    OnboardingActivationState Function(OnboardingActivationState current) update,
  ) async {
    final current = await future;
    final nextState = update(
      current.copyWith(isSubmitting: false, submissionErrorMessage: null),
    );
    state = AsyncData(nextState);

    final preferencesStore = ref.read(onboardingActivationPreferencesStoreProvider);
    await preferencesStore.saveDraft(ref, nextState);
  }

  bool _canContinue(OnboardingActivationState state) {
    switch (state.currentStep) {
      case OnboardingActivationStep.welcome:
        return state.entryMode != null;
      case OnboardingActivationStep.healthAccess:
        return state.healthChoice != null;
      case OnboardingActivationStep.sleepWindow:
        return state.bedtimeHour != state.wakeHour;
      case OnboardingActivationStep.reminders:
        return true;
    }
  }

  OnboardingActivationStep _nextStep(OnboardingActivationStep step) {
    switch (step) {
      case OnboardingActivationStep.welcome:
        return OnboardingActivationStep.healthAccess;
      case OnboardingActivationStep.healthAccess:
        return OnboardingActivationStep.sleepWindow;
      case OnboardingActivationStep.sleepWindow:
        return OnboardingActivationStep.reminders;
      case OnboardingActivationStep.reminders:
        return OnboardingActivationStep.reminders;
    }
  }

  OnboardingActivationStep _previousStep(OnboardingActivationStep step) {
    switch (step) {
      case OnboardingActivationStep.welcome:
        return OnboardingActivationStep.welcome;
      case OnboardingActivationStep.healthAccess:
        return OnboardingActivationStep.welcome;
      case OnboardingActivationStep.sleepWindow:
        return OnboardingActivationStep.healthAccess;
      case OnboardingActivationStep.reminders:
        return OnboardingActivationStep.sleepWindow;
    }
  }

  String? _resolveSubmissionMessage({
    required AppPermissionStatus healthPermissionStatus,
    required OnboardingReminderChoice reminderChoice,
    required bool reminderScheduled,
  }) {
    if (healthPermissionStatus != AppPermissionStatus.unknown &&
        healthPermissionStatus != AppPermissionStatus.granted) {
      return _onboardingHealthDeferredMessageKey;
    }

    if (reminderChoice == OnboardingReminderChoice.enabled &&
        !reminderScheduled) {
      return _onboardingReminderDeferredMessageKey;
    }

    return null;
  }
}
