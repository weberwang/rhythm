import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rhythm/features/app_shell/application/app_shell_overlay_controller.dart';
import 'package:rhythm/app/theme/rhythm_theme.dart';
import 'package:rhythm/features/app_shell/presentation/root_shell_page.dart';
import 'package:rhythm/l10n/app_localizations.dart';

void main() {
  testWidgets('当前 tab 高亮并保留五个一级入口', (tester) async {
    final router = _buildTestRouter(initialLocation: '/bedtime');

    await tester.pumpWidget(_TestApp(router: router));
    await tester.pumpAndSettle();

    expect(find.text('Today'), findsOneWidget);
    expect(find.text('Calendar'), findsOneWidget);
    expect(find.text('Bedtime'), findsOneWidget);
    expect(find.text('Insights'), findsOneWidget);
    expect(find.text('You'), findsOneWidget);

    final bedtimeLabel = tester.widget<Text>(find.text('Bedtime'));
    final todayLabel = tester.widget<Text>(find.text('Today'));
    expect(bedtimeLabel.style?.color, RhythmColors.brandPrimary);
    expect(todayLabel.style?.color, RhythmColors.textSecondary);
  });

  testWidgets('点击未激活 tab 时切换到对应分支', (tester) async {
    final router = _buildTestRouter(initialLocation: '/bedtime');

    await tester.pumpWidget(_TestApp(router: router));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Today'));
    await tester.pumpAndSettle();

    expect(find.text('Today Page'), findsOneWidget);
    expect(find.text('Bedtime Page'), findsNothing);
  });

  testWidgets('root shell 会消费 app-shell 全局 overlay 队列', (tester) async {
    final router = _buildTestRouter(initialLocation: '/today');
    final container = ProviderContainer();
    addTearDown(container.dispose);

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: _MaterialRouterApp(router: router),
      ),
    );
    await tester.pumpAndSettle();

    container
        .read(appShellOverlayControllerProvider.notifier)
        .showSuccess('Session restored.');
    await tester.pump();

    expect(find.text('Session restored.'), findsOneWidget);

    await tester.pump(const Duration(seconds: 3));
    await tester.pumpAndSettle();

    expect(find.text('Session restored.'), findsNothing);
  });
}

GoRouter _buildTestRouter({required String initialLocation}) {
  return GoRouter(
    initialLocation: initialLocation,
    routes: [
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return RootShellPage(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/today',
                builder: (context, state) =>
                    const _BranchPage(title: 'Today Page'),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/calendar',
                builder: (context, state) =>
                    const _BranchPage(title: 'Calendar Page'),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/bedtime',
                builder: (context, state) =>
                    const _BranchPage(title: 'Bedtime Page'),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/insights',
                builder: (context, state) =>
                    const _BranchPage(title: 'Insights Page'),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/profile',
                builder: (context, state) =>
                    const _BranchPage(title: 'Profile Page'),
              ),
            ],
          ),
        ],
      ),
    ],
  );
}

class _TestApp extends StatelessWidget {
  const _TestApp({required this.router});

  final GoRouter router;

  @override
  Widget build(BuildContext context) {
    return ProviderScope(child: _MaterialRouterApp(router: router));
  }
}

/// 复用测试环境下的 MaterialApp.router 装配，避免每条用例重复配置。
class _MaterialRouterApp extends StatelessWidget {
  /// 创建测试用路由壳。
  const _MaterialRouterApp({required this.router});

  final GoRouter router;

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
      theme: buildRhythmLightTheme(),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
    );
  }
}

/// 测试用的分支页面。
class _BranchPage extends StatelessWidget {
  /// 创建测试分支页面。
  const _BranchPage({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text(title)));
  }
}
