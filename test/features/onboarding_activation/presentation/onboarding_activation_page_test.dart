import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rhythm/app/theme/rhythm_theme.dart';
import 'package:rhythm/core/permissions/app_permission_models.dart';
import 'package:rhythm/features/app_shell/infrastructure/app_shell_launch_state_store.dart';
import 'package:rhythm/features/onboarding_activation/domain/onboarding_activation_models.dart';
import 'package:rhythm/features/onboarding_activation/infrastructure/onboarding_activation_health_gateway.dart';
import 'package:rhythm/features/onboarding_activation/infrastructure/onboarding_activation_notification_gateway.dart';
import 'package:rhythm/features/onboarding_activation/infrastructure/onboarding_activation_preferences_store.dart';
import 'package:rhythm/features/onboarding_activation/presentation/onboarding_activation_page.dart';
import 'package:rhythm/l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  testWidgets('首次激活流完成后写入完成标记并进入 today', (tester) async {
    SharedPreferences.setMockInitialValues({});
    final router = GoRouter(
      initialLocation: '/onboarding',
      routes: [
        GoRoute(
          path: '/onboarding',
          builder: (context, state) => const OnboardingActivationPage(),
        ),
        GoRoute(
          path: '/today',
          builder: (context, state) =>
              const Scaffold(body: Center(child: Text('Today Destination'))),
        ),
      ],
    );

    await tester.pumpWidget(
      _OnboardingTestApp(
        router: router,
        healthGateway: _FakeHealthGateway(AppPermissionStatus.denied),
        notificationGateway: _FakeNotificationGateway(true),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Welcome'), findsOneWidget);
    expect(find.text('Continue'), findsOneWidget);
    expect(
      tester.widget<FilledButton>(find.byType(FilledButton)).onPressed,
      isNull,
    );

    await tester.ensureVisible(find.text('Continue on this device'));
    await tester.tap(find.text('Continue on this device'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Continue'));
    await tester.pumpAndSettle();
    expect(find.text('Choose your health path'), findsOneWidget);

    await tester.ensureVisible(find.text('Stay manual for now'));
    await tester.tap(find.text('Stay manual for now'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Continue'));
    await tester.pumpAndSettle();
    expect(find.text('Set a target sleep window'), findsOneWidget);

    await tester.tap(find.text('Continue'));
    await tester.pumpAndSettle();
    expect(find.text('Choose a reminder rhythm'), findsOneWidget);

    await tester.tap(find.text('Enter Today'));
    await tester.pump();
    await tester.pumpAndSettle();

    final preferences = await SharedPreferences.getInstance();
    expect(
      preferences.getBool(AppShellLaunchStateStore.onboardingCompletedKey),
      isTrue,
    );
    expect(
      preferences.getInt(OnboardingActivationPreferencesStore.currentStepKey),
      3,
    );
    expect(find.text('Today Destination'), findsOneWidget);
  });

  testWidgets('首次激活草稿会从本地恢复到上次步骤', (tester) async {
    SharedPreferences.setMockInitialValues({
      OnboardingActivationPreferencesStore.currentStepKey: 2,
      OnboardingActivationPreferencesStore.entryModeKey: 'anonymous',
      OnboardingActivationPreferencesStore.healthChoiceKey: 'manualOnly',
      OnboardingActivationPreferencesStore.bedtimeHourKey: 22,
      OnboardingActivationPreferencesStore.wakeHourKey: 6,
    });

    final router = GoRouter(
      initialLocation: '/onboarding',
      routes: [
        GoRoute(
          path: '/onboarding',
          builder: (context, state) => const OnboardingActivationPage(),
        ),
      ],
    );

    await tester.pumpWidget(
      _OnboardingTestApp(
        router: router,
        healthGateway: _FakeHealthGateway(AppPermissionStatus.denied),
        notificationGateway: _FakeNotificationGateway(true),
      ),
    );
    await tester.pumpAndSettle();

    await tester.ensureVisible(find.text('10:00 PM'));
    expect(find.text('Set a target sleep window'), findsOneWidget);
    expect(find.text('10:00 PM'), findsOneWidget);
    expect(find.text('6:00 AM'), findsOneWidget);
  });

  testWidgets('健康或提醒降级时仍允许完成 onboarding', (tester) async {
    SharedPreferences.setMockInitialValues({});
    final router = GoRouter(
      initialLocation: '/onboarding',
      routes: [
        GoRoute(
          path: '/onboarding',
          builder: (context, state) => const OnboardingActivationPage(),
        ),
        GoRoute(
          path: '/today',
          builder: (context, state) =>
              const Scaffold(body: Center(child: Text('Today Destination'))),
        ),
      ],
    );

    await tester.pumpWidget(
      _OnboardingTestApp(
        router: router,
        healthGateway: _FakeHealthGateway(AppPermissionStatus.denied),
        notificationGateway: _FakeNotificationGateway(false),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.text('Continue on this device'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Continue'));
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.text('Connect health data later'));
    await tester.tap(find.text('Connect health data later'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Continue'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Continue'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Enter Today'));
    await tester.pump();
    await tester.pumpAndSettle();

    expect(find.text('Today Destination'), findsOneWidget);
  });
}

/// 承接首次激活页测试的最小应用壳。
class _OnboardingTestApp extends StatelessWidget {
  /// 创建测试应用壳。
  const _OnboardingTestApp({
    required this.router,
    this.healthGateway,
    this.notificationGateway,
  });

  /// 当前测试使用的路由配置。
  final GoRouter router;
  final OnboardingActivationHealthGateway? healthGateway;
  final OnboardingActivationNotificationGateway? notificationGateway;

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      overrides: [
        if (healthGateway != null)
          onboardingActivationHealthGatewayProvider.overrideWithValue(
            healthGateway!,
          ),
        if (notificationGateway != null)
          onboardingActivationNotificationGatewayProvider.overrideWithValue(
            notificationGateway!,
          ),
      ],
      child: MaterialApp.router(
        routerConfig: router,
        theme: buildRhythmLightTheme(),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
      ),
    );
  }
}

class _FakeHealthGateway extends OnboardingActivationHealthGateway {
  _FakeHealthGateway(this.status) : super();

  final AppPermissionStatus status;

  @override
  Future<AppPermissionStatus> requestSleepReadAccess() async {
    return status;
  }
}

class _FakeNotificationGateway extends OnboardingActivationNotificationGateway {
  _FakeNotificationGateway(this.result) : super();

  final bool result;

  @override
  Future<bool> applyReminderPlan(OnboardingActivationState state) async {
    return result;
  }
}
