import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rhythm/features/app_shell/application/providers/account_session_repository_provider.dart';
import 'package:rhythm/features/app_shell/domain/entities/account_session.dart';
import 'package:rhythm/features/app_shell/domain/repositories/account_session_repository.dart';
import 'package:rhythm/features/onboarding_activation/application/providers/onboarding_capability_gateways.dart';
import 'package:rhythm/features/onboarding_activation/domain/entities/onboarding_account_connection_result.dart';
import 'package:rhythm/features/onboarding_activation/application/providers/onboarding_flow_controller.dart';
import 'package:rhythm/features/onboarding_activation/domain/entities/onboarding_draft.dart';
import 'package:rhythm/features/onboarding_activation/domain/gateways/onboarding_account_gateway.dart';
import 'package:rhythm/features/onboarding_activation/domain/gateways/onboarding_health_permission_gateway.dart';
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

/// 用内存账号仓储验证 onboarding 完成后会稳定落下匿名或已连接的本地账号快照。
class _FakeAccountSessionRepository implements AccountSessionRepository {
  AppAccountSession? savedSession;

  @override
  Future<void> clear() async {
    savedSession = null;
  }

  @override
  Future<AppAccountSession?> read() async => savedSession;

  @override
  Future<void> save(AppAccountSession session) async {
    savedSession = session;
  }
}

/// 用假的健康权限网关验证授权结果会进入应用层状态机，而不是散落在页面里。
class _FakeOnboardingHealthPermissionGateway
    implements OnboardingHealthPermissionGateway {
  _FakeOnboardingHealthPermissionGateway(this.result);

  final OnboardingHealthPermissionStatus result;

  @override
  Future<OnboardingHealthPermissionStatus> requestSleepPermission() async {
    return result;
  }
}

/// 用假的账号网关锁定登录结果，验证 entry step 的真实分流不会散落到页面层。
class _FakeOnboardingAccountGateway implements OnboardingAccountGateway {
  _FakeOnboardingAccountGateway(this.result);

  final OnboardingAccountConnectionResult result;

  @override
  Future<OnboardingAccountConnectionResult> signIn(
    OnboardingAccountProvider provider,
  ) async {
    return result;
  }
}

/// 验证激活漏斗会按冻结的最小路径推进，并在完成时写入作息。
void main() {
  test('onboarding flow advances across all staged onboarding steps', () {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    final controller = container.read(
      onboardingFlowControllerProvider.notifier,
    );

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
      OnboardingStep.widgetGuide,
    );

    controller.goToNextStep();
    expect(
      container.read(onboardingFlowControllerProvider).step,
      OnboardingStep.completion,
    );
  });

  test(
    'permission step defers system authorization and still advances locally',
    () async {
      final container = ProviderContainer(
        overrides: [
          onboardingHealthPermissionGatewayProvider.overrideWithValue(
            _FakeOnboardingHealthPermissionGateway(
              OnboardingHealthPermissionStatus.denied,
            ),
          ),
        ],
      );
      addTearDown(container.dispose);

      final controller = container.read(
        onboardingFlowControllerProvider.notifier,
      );
      controller.goToNextStep();
      controller.selectEntryMode(OnboardingEntryMode.localFirst);
      controller.goToNextStep();

      controller.deferHealthPermissionAndContinue();

      final draft = container.read(onboardingFlowControllerProvider);
      expect(
        draft.permissionStatus,
        OnboardingHealthPermissionStatus.notRequested,
      );
      expect(draft.step, OnboardingStep.goalSchedule);
    },
  );

  test(
    'account sign-in success advances from entry step to permission step',
    () async {
      final container = ProviderContainer(
        overrides: [
          onboardingAccountGatewayProvider.overrideWithValue(
            _FakeOnboardingAccountGateway(
              const OnboardingAccountConnectionResult(
                provider: OnboardingAccountProvider.google,
                status: OnboardingAccountConnectionStatus.success,
                displayName: 'Jamie',
                email: 'jamie@example.com',
              ),
            ),
          ),
        ],
      );
      addTearDown(container.dispose);

      final controller = container.read(
        onboardingFlowControllerProvider.notifier,
      );
      controller.goToNextStep();
      controller.selectAccountProvider(OnboardingAccountProvider.google);

      await controller.authenticateSelectedAccountAndContinue();

      final draft = container.read(onboardingFlowControllerProvider);
      expect(draft.step, OnboardingStep.permissionValue);
      expect(
        draft.accountConnection?.status,
        OnboardingAccountConnectionStatus.success,
      );
      expect(draft.accountConnection?.displayName, 'Jamie');
    },
  );

  test('account sign-in failure keeps onboarding on entry step', () async {
    final container = ProviderContainer(
      overrides: [
        onboardingAccountGatewayProvider.overrideWithValue(
          _FakeOnboardingAccountGateway(
            const OnboardingAccountConnectionResult(
              provider: OnboardingAccountProvider.apple,
              status: OnboardingAccountConnectionStatus.failed,
            ),
          ),
        ),
      ],
    );
    addTearDown(container.dispose);

    final controller = container.read(
      onboardingFlowControllerProvider.notifier,
    );
    controller.goToNextStep();
    controller.selectAccountProvider(OnboardingAccountProvider.apple);

    await controller.authenticateSelectedAccountAndContinue();

    final draft = container.read(onboardingFlowControllerProvider);
    expect(draft.step, OnboardingStep.entryMode);
    expect(
      draft.accountConnection?.status,
      OnboardingAccountConnectionStatus.failed,
    );
  });

  test(
    'local-first onboarding completion persists anonymous account session',
    () async {
      SharedPreferences.setMockInitialValues({});
      final repository = _FakeGoalScheduleRepository();
      final accountSessionRepository = _FakeAccountSessionRepository();
      final container = ProviderContainer(
        overrides: [
          goalScheduleRepositoryProvider.overrideWithValue(repository),
          accountSessionRepositoryProvider.overrideWithValue(
            accountSessionRepository,
          ),
        ],
      );
      addTearDown(container.dispose);

      final controller = container.read(
        onboardingFlowControllerProvider.notifier,
      );
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
      expect(accountSessionRepository.savedSession, isNotNull);
      expect(
        accountSessionRepository.savedSession!.mode,
        AppAccountSessionMode.anonymous,
      );
      expect(
        container.read(onboardingFlowControllerProvider).reminderStrategy,
        OnboardingReminderStrategy.gentle,
      );
      final preferences = await SharedPreferences.getInstance();
      expect(preferences.getBool('onboarding_completed'), isTrue);
      expect(preferences.getString('reminder_preference'), 'gentle');
    },
  );

  test(
    'connected onboarding completion persists authenticated account session',
    () async {
      SharedPreferences.setMockInitialValues({});
      final repository = _FakeGoalScheduleRepository();
      final accountSessionRepository = _FakeAccountSessionRepository();
      final container = ProviderContainer(
        overrides: [
          goalScheduleRepositoryProvider.overrideWithValue(repository),
          accountSessionRepositoryProvider.overrideWithValue(
            accountSessionRepository,
          ),
          onboardingAccountGatewayProvider.overrideWithValue(
            _FakeOnboardingAccountGateway(
              const OnboardingAccountConnectionResult(
                provider: OnboardingAccountProvider.google,
                status: OnboardingAccountConnectionStatus.success,
                displayName: 'Jamie',
                email: 'jamie@example.com',
              ),
            ),
          ),
        ],
      );
      addTearDown(container.dispose);

      final controller = container.read(
        onboardingFlowControllerProvider.notifier,
      );
      controller.goToNextStep();
      controller.selectAccountProvider(OnboardingAccountProvider.google);
      await controller.authenticateSelectedAccountAndContinue();

      await controller.complete();

      expect(accountSessionRepository.savedSession, isNotNull);
      expect(
        accountSessionRepository.savedSession!.mode,
        AppAccountSessionMode.connected,
      );
      expect(accountSessionRepository.savedSession!.email, 'jamie@example.com');
      expect(
        accountSessionRepository.savedSession!.provider,
        AppAccountProvider.google,
      );
    },
  );
}
