import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../features/app_shell/presentation/pages/app_shell_page.dart';
import '../../features/bedtime/presentation/pages/bedtime_page.dart';
import '../../features/calendar/presentation/pages/calendar_page.dart';
import '../../features/insights/presentation/pages/insights_page.dart';
import '../../features/onboarding_activation/presentation/pages/onboarding_flow_page.dart';
import '../../features/profile_settings/presentation/pages/profile_settings_page.dart';
import '../../features/today/presentation/pages/today_page.dart';
import '../startup/launch_page.dart';

part 'app_router.g.dart';

/// 统一维护根路由、引导入口与五标签主壳分支。
@riverpod
GoRouter appRouter(Ref ref) {
  return GoRouter(
    initialLocation: LaunchPage.routePath,
    routes: [
      GoRoute(
        path: LaunchPage.routePath,
        builder: (context, state) => const LaunchPage(),
      ),
      GoRoute(
        path: OnboardingFlowPage.routePath,
        builder: (context, state) => const OnboardingFlowPage(),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return AppShellPage(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: TodayPage.routePath,
                builder: (context, state) => const TodayPage(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: CalendarPage.routePath,
                builder: (context, state) => const CalendarPage(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: BedtimePage.routePath,
                builder: (context, state) => const BedtimePage(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: InsightsPage.routePath,
                builder: (context, state) => const InsightsPage(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: ProfileSettingsPage.routePath,
                builder: (context, state) => const ProfileSettingsPage(),
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
