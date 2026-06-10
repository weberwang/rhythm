# App Shell Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** 完成 `app-shell` 的真实可交付实现，使启动分发、根级路由壳层、深链承接、全局 overlay 与国际化测试链路全部落地。

**Architecture:** 以现有 `go_router + hooks_riverpod + freezed` 底座为基础，优先补齐状态模型、显示层拆分、国际化文案和测试覆盖。实现保持壳层职责单一：只处理根级导航、反馈与启动分发，不解释具体 feature 业务。

**Tech Stack:** Flutter, hooks_riverpod, riverpod_generator, go_router, freezed, flutter_localizations, shared_preferences, flutter_secure_storage, flutter_test, integration_test

---

## 文件结构

- 修改：`lib/features/app_shell/domain/app_shell_models.dart`
  - 补齐 overlay、handoff blocked、启动状态等壳层值对象。
- 修改：`lib/features/app_shell/application/app_shell_bootstrap_controller.dart`
  - 收敛启动决策，补齐 blocked / success overlay / 超时恢复语义。
- 修改：`lib/features/app_shell/application/app_shell_tab_controller.dart`
  - 增加重复点击 tab 的回根行为状态。
- 修改：`lib/app/router/app_router.dart`
  - 把根路由、handoff 参数读取和 overlay 宿主挂载收敛到稳定结构。
- 修改：`lib/features/app_shell/presentation/root_shell_page.dart`
  - 拆出 tab bar 与 overlay host，接入国际化文案。
- 修改：`lib/features/app_shell/presentation/startup_gate_page.dart`
  - 补齐 loading / redirect / blocked / error 四类状态。
- 创建：`lib/features/app_shell/presentation/widgets/root_tab_bar.dart`
  - 抽离底部 tab bar 组件，固定视觉契约。
- 创建：`lib/features/app_shell/presentation/widgets/global_overlay_host.dart`
  - 实现 blocking error > success banner > info toast 的统一宿主。
- 修改：`lib/shared/widgets/module_placeholder_page.dart`
  - 接入本地化文案，避免长期硬编码。
- 修改：`lib/l10n/app_en.arb`
  - 新增 `app-shell` 所需文案模板。
- 修改：`lib/l10n/app_localizations.dart`
  - 由 `flutter gen-l10n` 自动更新。
- 创建：`test/features/app_shell/application/app_shell_bootstrap_controller_test.dart`
  - 覆盖启动决策矩阵。
- 创建：`test/features/app_shell/application/app_shell_tab_controller_test.dart`
  - 覆盖 tab 切换与回根状态。
- 创建：`test/features/app_shell/presentation/startup_gate_page_test.dart`
  - 覆盖 loading / error / retry / handoff 视图。
- 创建：`test/features/app_shell/presentation/root_shell_page_test.dart`
  - 覆盖底部 tab active 状态与导航语义。
- 创建：`test/features/app_shell/presentation/global_overlay_host_test.dart`
  - 覆盖 overlay 优先级。
- 创建：`integration_test/app_shell_bootstrap_test.dart`
  - 做最小冷启动路由检查。

### Task 1: 收紧壳层领域模型与启动决策

**Files:**
- Modify: `lib/features/app_shell/domain/app_shell_models.dart`
- Modify: `lib/features/app_shell/application/app_shell_bootstrap_controller.dart`
- Test: `test/features/app_shell/application/app_shell_bootstrap_controller_test.dart`

- [ ] **Step 1: 写启动决策失败测试**

```dart
test('未完成引导时返回 onboarding redirect', () async {
  final container = createBootstrapContainer(
    onboardingCompleted: false,
    deepLink: const AppShellDeepLink.none(),
    sessionToken: null,
  );

  final result = await container.read(appShellBootstrapControllerProvider.future);

  expect(
    result,
    const LaunchDecision.redirect(target: LaunchRouteTarget.onboarding),
  );
});
```

- [ ] **Step 2: 运行单测确认当前矩阵未完整覆盖**

Run: `flutter test test/features/app_shell/application/app_shell_bootstrap_controller_test.dart`
Expected: FAIL，提示测试文件缺失或决策类型不完整。

- [ ] **Step 3: 扩展值对象和控制器最小实现**

```dart
@freezed
class AppShellOverlayEvent with _$AppShellOverlayEvent {
  const factory AppShellOverlayEvent.success({required String message}) =
      _AppShellOverlayEventSuccess;
  const factory AppShellOverlayEvent.info({required String message}) =
      _AppShellOverlayEventInfo;
  const factory AppShellOverlayEvent.blockingError({required String message}) =
      _AppShellOverlayEventBlockingError;
}
```

```dart
if (!onboardingCompleted && deepLink is _AppShellDeepLinkTarget) {
  return LaunchDecision.blocked(
    fallbackTarget: LaunchRouteTarget.onboarding,
    message: 'deepLinkNeedsOnboarding',
  );
}
```

- [ ] **Step 4: 补齐 bootstrap 决策测试集**

```dart
test('已完成引导且无 deep link 时返回 today redirect', () async { /* ... */ });
test('deep link 目标可进入时返回 handoff', () async { /* ... */ });
test('deep link 缺少前置条件时返回 blocked fallback', () async { /* ... */ });
test('读取异常时返回 failure', () async { /* ... */ });
```

- [ ] **Step 5: 运行测试验证通过**

Run: `flutter test test/features/app_shell/application/app_shell_bootstrap_controller_test.dart`
Expected: PASS

- [ ] **Step 6: 提交**

```bash
git add lib/features/app_shell/domain/app_shell_models.dart lib/features/app_shell/application/app_shell_bootstrap_controller.dart test/features/app_shell/application/app_shell_bootstrap_controller_test.dart
git commit -m "feat: tighten app shell bootstrap decisions"
```

### Task 2: 落地 tab 状态与根壳层组件拆分

**Files:**
- Modify: `lib/features/app_shell/application/app_shell_tab_controller.dart`
- Modify: `lib/features/app_shell/presentation/root_shell_page.dart`
- Create: `lib/features/app_shell/presentation/widgets/root_tab_bar.dart`
- Test: `test/features/app_shell/application/app_shell_tab_controller_test.dart`
- Test: `test/features/app_shell/presentation/root_shell_page_test.dart`

- [ ] **Step 1: 写 tab 控制器失败测试**

```dart
test('重复点击已激活 tab 时发出回根请求', () {
  final container = ProviderContainer();
  final notifier = container.read(appShellTabControllerProvider.notifier);

  notifier.setTab(AppShellTab.today);
  notifier.reselectCurrentTab();

  expect(
    container.read(appShellTabControllerProvider).reselectRequested,
    isTrue,
  );
});
```

- [ ] **Step 2: 运行相关测试确认失败**

Run: `flutter test test/features/app_shell/application/app_shell_tab_controller_test.dart`
Expected: FAIL，提示状态结构尚未支持回根语义。

- [ ] **Step 3: 实现 tab 结构与独立 tab bar**

```dart
@freezed
class AppShellTabState with _$AppShellTabState {
  const factory AppShellTabState({
    required AppShellTab currentTab,
    @Default(false) bool reselectRequested,
  }) = _AppShellTabState;
}
```

```dart
class RootTabBar extends StatelessWidget {
  const RootTabBar({
    required this.currentIndex,
    required this.onSelect,
    super.key,
  });
}
```

- [ ] **Step 4: 写 root shell widget 测试**

```dart
testWidgets('当前 tab 高亮并保留五个一级入口', (tester) async {
  await tester.pumpWidget(buildRootShellTestApp(currentIndex: 2));

  expect(find.text('Bedtime'), findsOneWidget);
  expect(find.text('Today'), findsOneWidget);
  expect(selectedTabLabel(tester), 'Bedtime');
});
```

- [ ] **Step 5: 运行测试验证通过**

Run: `flutter test test/features/app_shell/application/app_shell_tab_controller_test.dart test/features/app_shell/presentation/root_shell_page_test.dart`
Expected: PASS

- [ ] **Step 6: 提交**

```bash
git add lib/features/app_shell/application/app_shell_tab_controller.dart lib/features/app_shell/presentation/root_shell_page.dart lib/features/app_shell/presentation/widgets/root_tab_bar.dart test/features/app_shell/application/app_shell_tab_controller_test.dart test/features/app_shell/presentation/root_shell_page_test.dart
git commit -m "feat: stabilize app shell tab state"
```

### Task 3: 补齐 startup gate、handoff blocked 与 overlay host

**Files:**
- Modify: `lib/features/app_shell/presentation/startup_gate_page.dart`
- Create: `lib/features/app_shell/presentation/widgets/global_overlay_host.dart`
- Modify: `lib/app/router/app_router.dart`
- Test: `test/features/app_shell/presentation/startup_gate_page_test.dart`
- Test: `test/features/app_shell/presentation/global_overlay_host_test.dart`

- [ ] **Step 1: 写 startup gate 失败测试**

```dart
testWidgets('启动失败时展示重试主动作', (tester) async {
  await tester.pumpWidget(
    buildStartupGateTestApp(
      const AsyncData(LaunchDecision.failure(message: 'startupFailed')),
    ),
  );

  expect(find.text('Retry'), findsOneWidget);
});
```

- [ ] **Step 2: 运行 widget 测试确认失败**

Run: `flutter test test/features/app_shell/presentation/startup_gate_page_test.dart`
Expected: FAIL，提示文案或 blocked 视图未完整落地。

- [ ] **Step 3: 实现启动态、blocked 态与 overlay 宿主**

```dart
value.when(
  redirect: (_, __) => context.go(target.path),
  handoff: (target, reason) => context.goNamed(/* ... */),
  blocked: (fallbackTarget, message) => context.goNamed(
    DeepLinkHandoffPage.routeName,
    extra: DeepLinkHandoffArgs.blocked(
      fallbackTarget: fallbackTarget,
      message: message,
    ),
  ),
  failure: (_) {},
);
```

```dart
final ordered = events.sortedBy<num>((event) => switch (event) {
      AppShellOverlayEventBlockingError() => 0,
      AppShellOverlayEventSuccess() => 1,
      AppShellOverlayEventInfo() => 2,
    });
```

- [ ] **Step 4: 写 overlay 优先级测试**

```dart
testWidgets('blocking error 优先于 success 和 info', (tester) async {
  await tester.pumpWidget(
    buildOverlayHostTestApp([
      const AppShellOverlayEvent.info(message: 'info'),
      const AppShellOverlayEvent.success(message: 'ok'),
      const AppShellOverlayEvent.blockingError(message: 'fatal'),
    ]),
  );

  expect(find.text('fatal'), findsOneWidget);
  expect(find.text('ok'), findsNothing);
});
```

- [ ] **Step 5: 运行测试验证通过**

Run: `flutter test test/features/app_shell/presentation/startup_gate_page_test.dart test/features/app_shell/presentation/global_overlay_host_test.dart`
Expected: PASS

- [ ] **Step 6: 提交**

```bash
git add lib/features/app_shell/presentation/startup_gate_page.dart lib/features/app_shell/presentation/widgets/global_overlay_host.dart lib/app/router/app_router.dart test/features/app_shell/presentation/startup_gate_page_test.dart test/features/app_shell/presentation/global_overlay_host_test.dart
git commit -m "feat: finish app shell startup and overlay states"
```

### Task 4: 接入国际化并补最小集成验证

**Files:**
- Modify: `lib/l10n/app_en.arb`
- Modify: `lib/shared/widgets/module_placeholder_page.dart`
- Modify: `lib/features/app_shell/presentation/root_shell_page.dart`
- Modify: `lib/features/app_shell/presentation/startup_gate_page.dart`
- Create: `integration_test/app_shell_bootstrap_test.dart`

- [ ] **Step 1: 写本地化存在性测试**

```dart
testWidgets('应用标题和 startup 文案来自本地化资源', (tester) async {
  await tester.pumpWidget(const RhythmBootstrapApp());
  await tester.pump();

  expect(find.text('Rhythm'), findsWidgets);
});
```

- [ ] **Step 2: 运行测试确认当前存在硬编码**

Run: `flutter test test/features/app_shell/presentation/root_shell_page_test.dart`
Expected: FAIL，存在 `Today`、`Retry` 等硬编码文案。

- [ ] **Step 3: 更新 ARB 与显示层读取**

```json
{
  "appShellTabToday": "Today",
  "appShellTabCalendar": "Calendar",
  "appShellTabBedtime": "Bedtime",
  "appShellTabInsights": "Insights",
  "appShellTabProfile": "You",
  "appShellRetry": "Retry"
}
```

```dart
final l10n = AppLocalizations.of(context);
Text(l10n.appShellTabToday);
```

- [ ] **Step 4: 生成本地化代码并运行全量验证**

Run: `flutter gen-l10n`
Expected: 生成 `lib/l10n/app_localizations*.dart`

Run: `dart run build_runner build --delete-conflicting-outputs`
Expected: PASS

Run: `flutter analyze`
Expected: PASS

Run: `flutter test`
Expected: PASS

Run: `flutter test integration_test/app_shell_bootstrap_test.dart`
Expected: PASS

- [ ] **Step 5: 提交**

```bash
git add lib/l10n/app_en.arb lib/l10n/app_localizations.dart lib/shared/widgets/module_placeholder_page.dart lib/features/app_shell/presentation/root_shell_page.dart lib/features/app_shell/presentation/startup_gate_page.dart integration_test/app_shell_bootstrap_test.dart
git commit -m "feat: localize and verify app shell flow"
```

## 自检

- Spec coverage：已覆盖启动分发、底部 tab、handoff、overlay、国际化、测试与集成校验。
- Placeholder scan：计划中无 `TODO`、`TBD` 或“后续补齐”语句。
- Type consistency：统一使用 `LaunchDecision`、`AppShellOverlayEvent`、`AppShellTabState`、`DeepLinkHandoffArgs` 作为计划内名称。

Plan complete and saved to `docs/superpowers/plans/2026-06-10-app-shell-implementation-plan.md`. Two execution options:

**1. Subagent-Driven (recommended)** - I dispatch a fresh subagent per task, review between tasks, fast iteration

**2. Inline Execution** - Execute tasks in this session using executing-plans, batch execution with checkpoints

**Which approach?**
