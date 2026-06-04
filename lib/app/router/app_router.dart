import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../features/app_shell/presentation/pages/app_shell_page.dart';
import '../../features/bedtime/presentation/pages/bedtime_page.dart';
import '../../features/calendar/presentation/pages/calendar_page.dart';
import '../../features/insights/presentation/pages/insights_page.dart';
import '../../features/app_shell/domain/entities/shell_tab.dart';
import '../../features/onboarding_activation/presentation/pages/onboarding_flow_page.dart';
import '../../features/profile_settings/presentation/pages/profile_settings_page.dart';
import '../../features/today/presentation/pages/today_page.dart';
import '../startup/launch_page.dart';
import '../startup/launch_state.dart';
import '../startup/launch_state_provider.dart';

part 'app_router.g.dart';

const _shellLocations = <String>{
  TodayPage.routePath,
  CalendarPage.routePath,
  BedtimePage.routePath,
  InsightsPage.routePath,
  ProfileSettingsPage.routePath,
};

/// 统一维护根路由、引导入口与五标签主壳分支。
@riverpod
GoRouter appRouter(Ref ref) {
  final launchState = ref.watch(launchStateProvider);

  return GoRouter(
    initialLocation: LaunchPage.routePath,
    redirect: (context, state) => _redirectFromLaunchState(
      launchState: launchState,
      matchedLocation: state.matchedLocation,
    ),
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

/// 在启动 guard 已解析后统一收敛根路由，避免用户绕过 onboarding 或回流到非法入口。
String? _redirectFromLaunchState({
  required AsyncValue<LaunchSnapshot> launchState,
  required String matchedLocation,
}) {
  // 启动中的 loading / error 继续交给 LaunchPage 承接，避免 provider 刷新时把已进入壳内的用户抖回启动页。
  if (!launchState.hasValue) {
    return null;
  }

  final snapshot = launchState.requireValue;
  final shellLocation = ShellTab.fromEntryIntent(snapshot.entryIntent).location;
  final isLaunchRoute = matchedLocation == LaunchPage.routePath;
  final isOnboardingRoute = matchedLocation == OnboardingFlowPage.routePath;
  final isShellRoute = _shellLocations.contains(matchedLocation);

  return switch (snapshot.destination) {
    LaunchDestination.onboarding => isOnboardingRoute
        ? null
        : OnboardingFlowPage.routePath,
    LaunchDestination.shell => (isLaunchRoute || isOnboardingRoute)
        ? shellLocation
        : isShellRoute
        ? null
        : shellLocation,
  };
}
