import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:rhythm/app/theme/rhythm_theme.dart';
import 'package:rhythm/features/app_shell/application/app_shell_bootstrap_controller.dart';
import 'package:rhythm/features/app_shell/domain/app_shell_models.dart';
import 'package:rhythm/features/app_shell/presentation/startup_gate_page.dart';
import 'package:rhythm/l10n/app_localizations.dart';

void main() {
  testWidgets('启动中展示单焦点 loading shell', (tester) async {
    final completer = Completer<LaunchDecision>();

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          appShellBootstrapControllerProvider.overrideWith(
            (ref) => completer.future,
          ),
        ],
        child: const _StartupGateScaffold(
          child: StartupGatePage(),
        ),
      ),
    );

    expect(find.text('Getting Rhythm ready'), findsOneWidget);
    expect(find.text('Checking your launch state.'), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('启动失败时展示重试主动作', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          appShellBootstrapControllerProvider.overrideWith(
            (ref) async => const LaunchDecision.failure(
              message: 'startupFailed',
            ),
          ),
        ],
        child: const _StartupGateScaffold(
          child: StartupGatePage(),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Startup needs attention'), findsOneWidget);
    expect(find.text('startupFailed'), findsOneWidget);
    expect(find.text('Retry'), findsOneWidget);
  });

  testWidgets('点击重试会重新触发 bootstrap provider', (tester) async {
    var attempts = 0;

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          appShellBootstrapControllerProvider.overrideWith((ref) async {
            attempts += 1;
            return const LaunchDecision.failure(message: 'startupFailed');
          }),
        ],
        child: const _StartupGateScaffold(
          child: StartupGatePage(),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(attempts, 1);

    await tester.tap(find.text('Retry'));
    await tester.pump();
    await tester.pumpAndSettle();

    expect(attempts, 2);
  });

  testWidgets('blocked handoff 展示安全回退语义', (tester) async {
    final router = GoRouter(
      initialLocation: '/handoff',
      routes: [
        GoRoute(
          path: '/handoff',
          builder: (context, state) {
            return const DeepLinkHandoffPage(
              args: DeepLinkHandoffArgs.blocked(
                target: LaunchRouteTarget.onboarding,
                reason: 'deepLinkNeedsOnboarding',
              ),
            );
          },
        ),
        GoRoute(
          path: '/onboarding',
          builder: (context, state) => const Scaffold(
            body: Center(child: Text('Onboarding Destination')),
          ),
        ),
      ],
    );

    await tester.pumpWidget(
      MaterialApp.router(
        theme: buildRhythmLightTheme(),
        routerConfig: router,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
      ),
    );
    await tester.pump();

    expect(find.text('Redirecting safely'), findsOneWidget);
    expect(
      find.text('Complete onboarding before opening shortcuts.'),
      findsOneWidget,
    );

    await tester.pump(const Duration(milliseconds: 500));
    await tester.pumpAndSettle();

    expect(find.text('Onboarding Destination'), findsOneWidget);
  });
}

class _StartupGateScaffold extends StatelessWidget {
  const _StartupGateScaffold({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: buildRhythmLightTheme(),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: child,
    );
  }
}
