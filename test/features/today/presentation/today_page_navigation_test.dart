import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:rhythm/app/bootstrap/launch_state_provider.dart';
import 'package:rhythm/app/router/app_router.dart';
import 'package:rhythm/features/goal_schedule/presentation/goal_setup_page.dart';
import 'package:rhythm/features/today/application/today_controller.dart';
import 'package:rhythm/features/today/application/today_view_state.dart';
import 'package:rhythm/features/today/presentation/today_page.dart';
import 'package:rhythm/l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// 验证今日页空态按钮会进入对应的二级页面，避免主操作按钮出现无响应回归。
void main() {
  testWidgets('goalMissing 状态点击去设置目标作息后进入目标设置页', (tester) async {
    final router = GoRouter(
      initialLocation: RhythmTab.today.path,
      routes: [
        GoRoute(
          path: RhythmTab.today.path,
          builder: (context, state) => ProviderScope(
            overrides: [
              todayControllerProvider.overrideWith(
                (ref) async => const TodayViewState(
                  status: TodayViewStatus.goalMissing,
                  prioritizeRecoveryCard: false,
                ),
              ),
            ],
            child: const TodayPage(),
          ),
        ),
        GoRoute(
          path: onboardingGoalSetupPath,
          builder: (context, state) =>
              const Scaffold(body: Text('goal-setup-page')),
        ),
      ],
    );

    await _pumpRouterApp(tester, router);

    await tester.tap(find.text('去设置目标作息'));
    await tester.pumpAndSettle();

    expect(find.text('goal-setup-page'), findsOneWidget);
  });

  testWidgets('从今日页进入目标设置页后显示公共返回按钮并可返回今日页', (tester) async {
    SharedPreferences.setMockInitialValues(<String, Object>{});
    final sharedPreferences = await SharedPreferences.getInstance();
    final router = GoRouter(
      initialLocation: RhythmTab.today.path,
      routes: [
        GoRoute(
          path: RhythmTab.today.path,
          builder: (context, state) => ProviderScope(
            overrides: [
              todayControllerProvider.overrideWith(
                (ref) async => const TodayViewState(
                  status: TodayViewStatus.goalMissing,
                  prioritizeRecoveryCard: false,
                ),
              ),
            ],
            child: const TodayPage(),
          ),
        ),
        GoRoute(
          path: onboardingGoalSetupPath,
          builder: (context, state) => const GoalSetupPage(),
        ),
      ],
    );

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          sharedPreferencesProvider.overrideWithValue(sharedPreferences),
        ],
        child: MaterialApp.router(
          locale: const Locale('zh'),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          routerConfig: router,
        ),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.text('去设置目标作息'));
    await tester.pumpAndSettle();

    expect(find.byIcon(Icons.arrow_back_ios_new_rounded), findsOneWidget);

    await tester.tap(find.byIcon(Icons.arrow_back_ios_new_rounded));
    await tester.pumpAndSettle();

    expect(find.text('还没有设置作息目标'), findsOneWidget);
  });
}

/// 使用应用本地化和传入路由装配最小测试壳，复现真实页面跳转行为。
Future<void> _pumpRouterApp(WidgetTester tester, GoRouter router) async {
  await tester.pumpWidget(
    MaterialApp.router(
      locale: const Locale('zh'),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      routerConfig: router,
    ),
  );
  await tester.pumpAndSettle();
}
