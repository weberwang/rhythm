import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:rhythm/features/app_shell/presentation/root_shell_page.dart';
import 'package:rhythm/features/app_shell/presentation/startup_gate_page.dart';
import 'package:rhythm/l10n/app_localizations.dart';
import 'package:rhythm/shared/widgets/module_placeholder_page.dart';

part 'app_router.g.dart';

/// 构建应用根路由。
@Riverpod(keepAlive: true)
GoRouter appRouter(Ref ref) {
  return GoRouter(
    initialLocation: StartupGatePage.routePath,
    routes: [
      GoRoute(
        path: StartupGatePage.routePath,
        name: StartupGatePage.routeName,
        builder: (context, state) => const StartupGatePage(),
      ),
      GoRoute(
        path: DeepLinkHandoffPage.routePath,
        name: DeepLinkHandoffPage.routeName,
        builder: (context, state) {
          final args = state.extra as DeepLinkHandoffArgs;
          return DeepLinkHandoffPage(args: args);
        },
      ),
      GoRoute(
        path: '/onboarding',
        builder: (context, state) => ModulePlaceholderPage(
          title: AppLocalizations.of(context).onboardingPlaceholderTitle,
          description:
              AppLocalizations.of(context).onboardingPlaceholderDescription,
        ),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return RootShellPage(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/today',
                builder: (context, state) => ModulePlaceholderPage(
                  title: AppLocalizations.of(context).todayPlaceholderTitle,
                  description:
                      AppLocalizations.of(context).todayPlaceholderDescription,
                ),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/calendar',
                builder: (context, state) => ModulePlaceholderPage(
                  title: AppLocalizations.of(context).calendarPlaceholderTitle,
                  description: AppLocalizations.of(
                    context,
                  ).calendarPlaceholderDescription,
                ),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/bedtime',
                builder: (context, state) => ModulePlaceholderPage(
                  title: AppLocalizations.of(context).bedtimePlaceholderTitle,
                  description:
                      AppLocalizations.of(context).bedtimePlaceholderDescription,
                ),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/insights',
                builder: (context, state) => ModulePlaceholderPage(
                  title: AppLocalizations.of(context).insightsPlaceholderTitle,
                  description:
                      AppLocalizations.of(context).insightsPlaceholderDescription,
                ),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/profile',
                builder: (context, state) => ModulePlaceholderPage(
                  title: AppLocalizations.of(context).profilePlaceholderTitle,
                  description:
                      AppLocalizations.of(context).profilePlaceholderDescription,
                ),
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
