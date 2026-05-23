import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:rhythm/app/bootstrap/launch_state_provider.dart';
import 'package:rhythm/features/goal_schedule/presentation/goal_setup_page.dart';
import 'package:rhythm/features/notifications/presentation/reminder_setup_page.dart';
import 'package:rhythm/features/onboarding/presentation/onboarding_flow_page.dart';
import 'package:rhythm/l10n/app_localizations.dart';

import '../bootstrap/launch_gate.dart';

/// 首次引导欢迎页路由路径。
const String onboardingWelcomePath = '/onboarding/welcome';

/// 目标设置页路由路径。
const String onboardingGoalSetupPath = '/onboarding/goal-setup';

/// 提醒策略设置页路由路径。
const String onboardingReminderSetupPath = '/onboarding/reminder-setup';

/// 一级模块与占位页可复用的文案键。
enum AppCopyKey {
  goalSetupTitle,
  goalSetupDescription,
  calendarTitle,
  calendarDescription,
  bedtimeTitle,
  bedtimeDescription,
  insightsTitle,
  insightsDescription,
  profileTitle,
  profileDescription,
}

/// 根据文案键读取当前语言对应的展示文案。
String appCopy(AppLocalizations l10n, AppCopyKey key) {
  switch (key) {
    case AppCopyKey.goalSetupTitle:
      return l10n.goalSetupTitle;
    case AppCopyKey.goalSetupDescription:
      return l10n.goalSetupDescription;
    case AppCopyKey.calendarTitle:
      return l10n.calendarTitle;
    case AppCopyKey.calendarDescription:
      return l10n.calendarDescription;
    case AppCopyKey.bedtimeTitle:
      return l10n.bedtimeTitle;
    case AppCopyKey.bedtimeDescription:
      return l10n.bedtimeDescription;
    case AppCopyKey.insightsTitle:
      return l10n.insightsTitle;
    case AppCopyKey.insightsDescription:
      return l10n.insightsDescription;
    case AppCopyKey.profileTitle:
      return l10n.profileTitle;
    case AppCopyKey.profileDescription:
      return l10n.profileDescription;
  }
}

/// Rhythm 的一级模块定义。
enum RhythmTab {
  today(Icons.nights_stay_outlined, '/'),
  calendar(Icons.calendar_month_outlined, '/calendar'),
  bedtime(Icons.bedtime_outlined, '/bedtime'),
  insights(Icons.insights_outlined, '/insights'),
  profile(Icons.person_outline, '/profile');

  const RhythmTab(this.icon, this.path);

  final IconData icon;
  final String path;

  String label(AppLocalizations l10n) {
    switch (this) {
      case RhythmTab.today:
        return l10n.tabToday;
      case RhythmTab.calendar:
        return l10n.tabCalendar;
      case RhythmTab.bedtime:
        return l10n.tabBedtime;
      case RhythmTab.insights:
        return l10n.tabInsights;
      case RhythmTab.profile:
        return l10n.tabProfile;
    }
  }
}

/// 创建 App 路由。
GoRouter createAppRouter() {
  return GoRouter(
    initialLocation: '/launch',
    routes: [
      GoRoute(path: '/launch', builder: (context, state) => const LaunchGate()),
      GoRoute(
        path: onboardingWelcomePath,
        builder: (context, state) => const OnboardingFlowPage(),
      ),
      GoRoute(
        path: onboardingGoalSetupPath,
        builder: (context, state) => const GoalSetupPage(),
      ),
      GoRoute(
        path: onboardingReminderSetupPath,
        builder: (context, state) {
          final container = ProviderScope.containerOf(context, listen: false);
          return ReminderSetupPage(
            launchStateRepository: container.read(launchStateRepositoryProvider),
          );
        },
      ),
      GoRoute(
        path: RhythmTab.today.path,
        builder: (context, state) => const RhythmShell(
          currentTab: RhythmTab.today,
          child: TodayModulePage(),
        ),
      ),
      GoRoute(
        path: RhythmTab.calendar.path,
        builder: (context, state) => const RhythmShell(
          currentTab: RhythmTab.calendar,
          child: ModulePlaceholderPage(
            titleKey: AppCopyKey.calendarTitle,
            descriptionKey: AppCopyKey.calendarDescription,
          ),
        ),
      ),
      GoRoute(
        path: RhythmTab.bedtime.path,
        builder: (context, state) => const RhythmShell(
          currentTab: RhythmTab.bedtime,
          child: ModulePlaceholderPage(
            titleKey: AppCopyKey.bedtimeTitle,
            descriptionKey: AppCopyKey.bedtimeDescription,
          ),
        ),
      ),
      GoRoute(
        path: RhythmTab.insights.path,
        builder: (context, state) => const RhythmShell(
          currentTab: RhythmTab.insights,
          child: ModulePlaceholderPage(
            titleKey: AppCopyKey.insightsTitle,
            descriptionKey: AppCopyKey.insightsDescription,
          ),
        ),
      ),
      GoRoute(
        path: RhythmTab.profile.path,
        builder: (context, state) => const RhythmShell(
          currentTab: RhythmTab.profile,
          child: ModulePlaceholderPage(
            titleKey: AppCopyKey.profileTitle,
            descriptionKey: AppCopyKey.profileDescription,
          ),
        ),
      ),
    ],
  );
}

/// 带底部导航的通用壳。
class RhythmShell extends StatelessWidget {
  /// 创建模块壳。
  const RhythmShell({super.key, required this.currentTab, required this.child});

  final RhythmTab currentTab;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        final l10n = AppLocalizations.of(context);

        return Scaffold(
          body: SafeArea(child: child),
          bottomNavigationBar: NavigationBar(
            selectedIndex: currentTab.index,
            onDestinationSelected: (index) {
              context.go(RhythmTab.values[index].path);
            },
            destinations: [
              for (final tab in RhythmTab.values)
                NavigationDestination(
                  icon: Icon(tab.icon),
                  label: tab.label(l10n),
                ),
            ],
          ),
        );
      },
    );
  }
}

/// 今日页入口。
class TodayModulePage extends StatelessWidget {
  /// 创建今日页。
  const TodayModulePage({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final l10n = AppLocalizations.of(context);

    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(l10n.todayPageTitle, style: textTheme.headlineMedium),
          const SizedBox(height: 24),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(l10n.todayCardTitle, style: textTheme.titleLarge),
                  const SizedBox(height: 8),
                  Text(l10n.todayCardDescription),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// 占位页。
class ModulePlaceholderPage extends StatelessWidget {
  /// 创建占位页。
  const ModulePlaceholderPage({
    super.key,
    required this.titleKey,
    required this.descriptionKey,
  });

  final AppCopyKey titleKey;
  final AppCopyKey descriptionKey;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(appCopy(l10n, titleKey), style: textTheme.headlineMedium),
          const SizedBox(height: 24),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Text(appCopy(l10n, descriptionKey)),
            ),
          ),
        ],
      ),
    );
  }
}
