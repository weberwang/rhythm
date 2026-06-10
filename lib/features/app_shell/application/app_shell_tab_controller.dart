import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:rhythm/features/app_shell/domain/app_shell_models.dart';

part 'app_shell_tab_controller.g.dart';

/// 管理 root shell 当前选中 tab。
@Riverpod(keepAlive: true)
class AppShellTabController extends _$AppShellTabController {
  @override
  AppShellTabState build() {
    return const AppShellTabState(currentTab: AppShellTab.today);
  }

  /// 根据路由分支同步当前 tab，不触发回根语义。
  void syncBranch(AppShellTab tab) {
    if (state.currentTab == tab && !state.reselectRequested) {
      return;
    }

    state = AppShellTabState(currentTab: tab);
  }

  /// 处理用户点击 tab 的行为。
  void requestTabSelection(AppShellTab tab) {
    if (state.currentTab == tab) {
      state = state.copyWith(reselectRequested: true);
      return;
    }

    state = AppShellTabState(currentTab: tab);
  }

  /// 清除回根请求，避免重复消费。
  void clearReselectRequest() {
    if (!state.reselectRequested) {
      return;
    }

    state = state.copyWith(reselectRequested: false);
  }
}
