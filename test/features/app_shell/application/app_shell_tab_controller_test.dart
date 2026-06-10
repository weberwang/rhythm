import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rhythm/features/app_shell/application/app_shell_tab_controller.dart';
import 'package:rhythm/features/app_shell/domain/app_shell_models.dart';

void main() {
  test('首次构建默认选中 today', () {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    final state = container.read(appShellTabControllerProvider);

    expect(state.currentTab, AppShellTab.today);
    expect(state.reselectRequested, isFalse);
  });

  test('切换到新 tab 时更新 currentTab 且不请求回根', () {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    final notifier = container.read(appShellTabControllerProvider.notifier);
    notifier.requestTabSelection(AppShellTab.calendar);

    final state = container.read(appShellTabControllerProvider);
    expect(state.currentTab, AppShellTab.calendar);
    expect(state.reselectRequested, isFalse);
  });

  test('重复点击已激活 tab 时发出回根请求', () {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    final notifier = container.read(appShellTabControllerProvider.notifier);
    notifier.requestTabSelection(AppShellTab.today);

    final state = container.read(appShellTabControllerProvider);
    expect(state.currentTab, AppShellTab.today);
    expect(state.reselectRequested, isTrue);
  });

  test('清除回根请求后恢复空闲状态', () {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    final notifier = container.read(appShellTabControllerProvider.notifier);
    notifier.requestTabSelection(AppShellTab.today);
    notifier.clearReselectRequest();

    final state = container.read(appShellTabControllerProvider);
    expect(state.currentTab, AppShellTab.today);
    expect(state.reselectRequested, isFalse);
  });
}
