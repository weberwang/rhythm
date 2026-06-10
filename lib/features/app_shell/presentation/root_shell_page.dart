import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rhythm/features/app_shell/application/app_shell_overlay_controller.dart';
import 'package:rhythm/features/app_shell/application/app_shell_tab_controller.dart';
import 'package:rhythm/features/app_shell/domain/app_shell_models.dart';
import 'package:rhythm/features/app_shell/presentation/widgets/global_overlay_host.dart';
import 'package:rhythm/features/app_shell/presentation/widgets/root_tab_bar.dart';

/// 承载底部导航和当前 feature 内容的根壳层页面。
class RootShellPage extends HookConsumerWidget {
  /// 创建根壳层页面。
  const RootShellPage({required this.navigationShell, super.key});

  /// go_router 注入的 shell。
  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tabState = ref.watch(appShellTabControllerProvider);
    final overlayEvents = ref.watch(appShellOverlayControllerProvider);

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ref
            .read(appShellTabControllerProvider.notifier)
            .syncBranch(_tabFromIndex(navigationShell.currentIndex));
      });
      return null;
    }, [navigationShell.currentIndex]);

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(child: navigationShell),
          GlobalOverlayHost(
            events: overlayEvents,
            onDismiss: ref
                .read(appShellOverlayControllerProvider.notifier)
                .dismiss,
          ),
        ],
      ),
      bottomNavigationBar: RootTabBar(
        currentTab: tabState.currentTab,
        onSelect: (tab) {
          final nextIndex = _indexFromTab(tab);
          final isActive = nextIndex == navigationShell.currentIndex;

          ref
              .read(appShellTabControllerProvider.notifier)
              .requestTabSelection(tab);
          navigationShell.goBranch(nextIndex, initialLocation: isActive);

          if (isActive) {
            ref
                .read(appShellTabControllerProvider.notifier)
                .clearReselectRequest();
          }
        },
      ),
    );
  }

  /// 将分支索引映射到 tab 枚举。
  AppShellTab _tabFromIndex(int index) {
    switch (index) {
      case 0:
        return AppShellTab.today;
      case 1:
        return AppShellTab.calendar;
      case 2:
        return AppShellTab.bedtime;
      case 3:
        return AppShellTab.insights;
      case 4:
        return AppShellTab.profile;
      default:
        return AppShellTab.today;
    }
  }

  /// 将 tab 枚举映射回导航分支索引。
  int _indexFromTab(AppShellTab tab) {
    switch (tab) {
      case AppShellTab.today:
        return 0;
      case AppShellTab.calendar:
        return 1;
      case AppShellTab.bedtime:
        return 2;
      case AppShellTab.insights:
        return 3;
      case AppShellTab.profile:
        return 4;
    }
  }
}
