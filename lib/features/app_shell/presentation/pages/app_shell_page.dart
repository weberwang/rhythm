import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rhythm/l10n/app_localizations.dart';

import '../../application/providers/app_shell_global_feedback_provider.dart';
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
    final globalFeedback = ref.watch(appShellGlobalFeedbackProvider);
    final dismissedFeedback = useState<AppShellGlobalFeedbackKind?>(null);
    final destinations = ShellTab.values
        .map(
          (tab) => NavigationDestination(
            icon: Icon(_iconForTab(tab)),
            label: _labelForTab(localization, tab),
          ),
        )
        .toList(growable: false);
    final visibleFeedback = globalFeedback == dismissedFeedback.value
        ? null
        : globalFeedback;

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(child: navigationShell),
          if (visibleFeedback != null)
            Align(
              alignment: Alignment.topCenter,
              child: SafeArea(
                bottom: false,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
                  child: _GlobalFeedbackHost(
                    feedbackKind: visibleFeedback,
                    onDismiss: () => dismissedFeedback.value = visibleFeedback,
                  ),
                ),
              ),
            ),
        ],
      ),
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

/// 在主壳顶部统一承载跨页面反馈，避免同步与时区提示散落到各个业务页。
class _GlobalFeedbackHost extends StatelessWidget {
  /// 创建全局反馈容器。
  const _GlobalFeedbackHost({
    required this.feedbackKind,
    required this.onDismiss,
  });

  /// 当前需要展示的反馈类型。
  final AppShellGlobalFeedbackKind feedbackKind;

  /// 用户暂时收起提示时的回调。
  final VoidCallback onDismiss;

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context);
    final theme = Theme.of(context);

    return Card(
      clipBehavior: Clip.antiAlias,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              _iconForFeedback(feedbackKind),
              color: theme.colorScheme.primary,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    _titleForFeedback(localization, feedbackKind),
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    _bodyForFeedback(localization, feedbackKind),
                    style: theme.textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            TextButton(
              onPressed: onDismiss,
              child: Text(localization.globalFeedbackDismiss),
            ),
          ],
        ),
      ),
    );
  }

  /// 根据反馈类型选择对应图标，保证全局提示具有稳定识别性。
  IconData _iconForFeedback(AppShellGlobalFeedbackKind feedbackKind) {
    return switch (feedbackKind) {
      AppShellGlobalFeedbackKind.syncFailedRecoverable =>
        Icons.sync_problem_outlined,
      AppShellGlobalFeedbackKind.timezoneShiftPending =>
        Icons.public_outlined,
    };
  }

  /// 从本地化资源读取反馈标题，避免业务语义散落到应用层 provider。
  String _titleForFeedback(
    AppLocalizations localization,
    AppShellGlobalFeedbackKind feedbackKind,
  ) {
    return switch (feedbackKind) {
      AppShellGlobalFeedbackKind.syncFailedRecoverable =>
        localization.globalFeedbackSyncFailedTitle,
      AppShellGlobalFeedbackKind.timezoneShiftPending =>
        localization.globalFeedbackTimezoneShiftTitle,
    };
  }

  /// 从本地化资源读取反馈正文，保持共享状态与展示文案边界分离。
  String _bodyForFeedback(
    AppLocalizations localization,
    AppShellGlobalFeedbackKind feedbackKind,
  ) {
    return switch (feedbackKind) {
      AppShellGlobalFeedbackKind.syncFailedRecoverable =>
        localization.globalFeedbackSyncFailedBody,
      AppShellGlobalFeedbackKind.timezoneShiftPending =>
        localization.globalFeedbackTimezoneShiftBody,
    };
  }
}
