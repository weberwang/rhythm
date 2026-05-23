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

/// 目标设置页路由路径，当前阶段仅保持引导链路闭合。
const String onboardingGoalSetupPath = '/onboarding/goal-setup';

/// 提醒策略设置页路由路径，用于完成首次激活闭环。
const String onboardingReminderSetupPath = '/onboarding/reminder-setup';

/// 一级模块与占位页可复用的文案键，避免在路由层过早读取本地化上下文。
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

/// Rhythm 的一级模块定义，集中管理底部导航文案、图标和路由路径。
enum RhythmTab {
  today(Icons.nights_stay_outlined, '/'),
  calendar(Icons.calendar_month_outlined, '/calendar'),
  bedtime(Icons.bedtime_outlined, '/bedtime'),
  insights(Icons.insights_outlined, '/insights'),
  profile(Icons.person_outline, '/profile');

  const RhythmTab(this.icon, this.path);

  /// 底部导航展示图标。
  final IconData icon;

  /// 模块对应的路由路径。
  final String path;

  /// 根据当前语言返回底部导航文案。
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

/// 创建 App 路由，保持导航规则和 UI 入口解耦。
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
          // 路由层只做依赖转接，避免提醒页直接感知 Provider 装配细节。
          final container = ProviderScope.containerOf(context, listen: false);
          return ReminderSetupPage(
            launchStateRepository: container.read(
              launchStateRepositoryProvider,
            ),
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

/// 承载五个一级模块的通用页面壳，负责底部导航和当前模块内容。
class RhythmShell extends StatelessWidget {
  /// 创建带底部导航的模块页面壳实例。
  const RhythmShell({super.key, required this.currentTab, required this.child});

  /// 当前选中的一级模块。
  final RhythmTab currentTab;

  /// 当前模块页面内容。
  final Widget child;

  /// 渲染带底部导航的应用页面。
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
              final nextTab = RhythmTab.values[index];
              context.go(nextTab.path);
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

/// 今日模块入口页，先放置核心价值文案，后续再接入真实作息数据。
class TodayModulePage extends StatelessWidget {
  /// 创建今日模块入口页实例。
  const TodayModulePage({super.key});

  /// 渲染今日页的首屏骨架。
  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
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
      },
    );
  }
}

/// 一级模块的临时入口页，用于在真实功能接入前保持导航闭环完整。
class ModulePlaceholderPage extends StatelessWidget {
  /// 创建一级模块占位页实例。
  const ModulePlaceholderPage({
    super.key,
    required this.titleKey,
    required this.descriptionKey,
  });

  /// 模块标题文案键。
  final AppCopyKey titleKey;

  /// 模块说明文案键。
  final AppCopyKey descriptionKey;

  /// 渲染模块入口说明。
  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
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
      },
    );
  }
}
