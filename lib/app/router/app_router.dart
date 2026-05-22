import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
GoRouter createAppRouter() {
  return GoRouter(
    initialLocation: RhythmTab.today.path,
    routes: [
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

/// 今日模块入口页，先放置核心价值文案，后续再接入真实作息数据。
class TodayModulePage extends StatelessWidget {
  const TodayModulePage({super.key});

  /// 渲染今日页的首屏骨架。
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

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
                ],
              ),
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
