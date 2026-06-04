import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rhythm/l10n/app_localizations.dart';

import '../../domain/entities/shell_tab.dart';

/// 五标签主壳只负责全局导航结构，不持有具体业务查询逻辑。
class AppShellPage extends HookConsumerWidget {
  /// 创建主壳页面。
  const AppShellPage({super.key, required this.navigationShell});

  /// `go_router` 提供的多分支导航宿主。
  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localization = AppLocalizations.of(context);
    final destinations = ShellTab.values
        .map(
          (tab) => NavigationDestination(
            icon: Icon(_iconForTab(tab)),
            label: _labelForTab(localization, tab),
          ),
        )
        .toList(growable: false);

    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: NavigationBar(
        selectedIndex: navigationShell.currentIndex,
        destinations: destinations,
        onDestinationSelected: (index) => _onDestinationSelected(index),
      ),
    );
  }

  /// 切换标签时优先回到各自分支根节点，保持主壳结构稳定。
  void _onDestinationSelected(int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  /// 统一维护底部导航图标，避免标签顺序调整时图标和文案错位。
  IconData _iconForTab(ShellTab tab) {
    return switch (tab) {
      ShellTab.today => Icons.today_outlined,
      ShellTab.calendar => Icons.calendar_month_outlined,
      ShellTab.bedtime => Icons.nightlight_round,
      ShellTab.insights => Icons.auto_graph_outlined,
      ShellTab.profile => Icons.person_outline,
    };
  }

  /// 统一维护底部导航文案，保证实现顺序与冻结信息架构一致。
  String _labelForTab(AppLocalizations localization, ShellTab tab) {
    return switch (tab) {
      ShellTab.today => localization.tabToday,
      ShellTab.calendar => localization.tabCalendar,
      ShellTab.bedtime => localization.tabBedtime,
      ShellTab.insights => localization.tabInsights,
      ShellTab.profile => localization.tabProfile,
    };
  }
}
