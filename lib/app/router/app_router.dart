import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../features/goal_schedule/presentation/goal_setup_page.dart';
import '../../features/onboarding/presentation/onboarding_flow_page.dart';
import '../../features/sleep_records/presentation/manual_sleep_record_page.dart';
import '../../features/today/application/today_controller.dart';

/// Rhythm 的一级模块定义，集中管理底部导航文案、图标和路由路径。
enum RhythmTab {
  today('今日', Icons.nights_stay_outlined, '/'),
  calendar('日历', Icons.calendar_month_outlined, '/calendar'),
  bedtime('睡前', Icons.bedtime_outlined, '/bedtime'),
  insights('洞察', Icons.insights_outlined, '/insights'),
  profile('我的', Icons.person_outline, '/profile');

  const RhythmTab(this.label, this.icon, this.path);

  /// 底部导航展示文案。
  final String label;

  /// 底部导航展示图标。
  final IconData icon;

  /// 模块对应的路由路径。
  final String path;
}

/// 创建 App 路由，保持导航规则和 UI 入口解耦。
GoRouter createAppRouter({required bool hasCompletedOnboarding}) {
  return GoRouter(
    initialLocation: hasCompletedOnboarding
        ? RhythmTab.today.path
        : '/onboarding',
    routes: [
      GoRoute(
        path: '/onboarding',
        builder: (context, state) => const OnboardingFlowPage(),
      ),
      GoRoute(
        path: '/goal-setup',
        builder: (context, state) => const GoalSetupPage(),
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
            title: '日历',
            description: '用热力图看清最近的作息节奏。',
          ),
        ),
      ),
      GoRoute(
        path: RhythmTab.bedtime.path,
        builder: (context, state) => const RhythmShell(
          currentTab: RhythmTab.bedtime,
          child: ModulePlaceholderPage(
            title: '睡前',
            description: '进入准备睡了模式，给今晚一个温和收尾。',
          ),
        ),
      ),
      GoRoute(
        path: RhythmTab.insights.path,
        builder: (context, state) => const RhythmShell(
          currentTab: RhythmTab.insights,
          child: ModulePlaceholderPage(
            title: '洞察',
            description: '复盘一周表现，找到更稳定的作息线索。',
          ),
        ),
      ),
      GoRoute(
        path: RhythmTab.profile.path,
        builder: (context, state) => const RhythmShell(
          currentTab: RhythmTab.profile,
          child: ModulePlaceholderPage(
            title: '我的',
            description: '管理目标、提醒、账号和隐私设置。',
          ),
        ),
      ),
    ],
  );
}

/// 承载五个一级模块的通用页面壳，负责底部导航和当前模块内容。
class RhythmShell extends StatelessWidget {
  const RhythmShell({super.key, required this.currentTab, required this.child});

  /// 当前选中的一级模块。
  final RhythmTab currentTab;

  /// 当前模块页面内容。
  final Widget child;

  /// 渲染带底部导航的应用页面。
  @override
  Widget build(BuildContext context) {
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
            NavigationDestination(icon: Icon(tab.icon), label: tab.label),
        ],
      ),
    );
  }
}

/// 今日模块入口页，先承接目标、摘要和快捷行动，逐步扩展为完整今日面板。
class TodayModulePage extends ConsumerWidget {
  const TodayModulePage({super.key});

  /// 渲染今日页的首屏骨架。
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;
    final summary = ref.watch(todaySummaryProvider);

    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('今日', style: textTheme.headlineMedium),
          const SizedBox(height: 24),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('今晚先轻一点', style: textTheme.titleLarge),
                  const SizedBox(height: 8),
                  const Text('设置目标作息后，这里会展示昨晚结果和今晚行动。'),
                  if (summary.latestRecordLabel != null) ...[
                    const SizedBox(height: 12),
                    Text(summary.latestRecordLabel!),
                  ],
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Align(
            alignment: Alignment.centerLeft,
            child: OutlinedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute<void>(
                    builder: (_) => const ManualSleepRecordPage(),
                  ),
                );
              },
              child: const Text('手动补录'),
            ),
          ),
        ],
      ),
    );
  }
}

/// 一级模块的临时入口页，用于在真实功能接入前保持导航闭环完整。
class ModulePlaceholderPage extends StatelessWidget {
  const ModulePlaceholderPage({
    super.key,
    required this.title,
    required this.description,
  });

  /// 模块标题。
  final String title;

  /// 模块说明文案。
  final String description;

  /// 渲染模块入口说明。
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: textTheme.headlineMedium),
          const SizedBox(height: 24),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Text(description),
            ),
          ),
        ],
      ),
    );
  }
}
