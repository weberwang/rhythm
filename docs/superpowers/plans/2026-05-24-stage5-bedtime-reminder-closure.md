# Stage Five Bedtime Reminder Closure Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** 收口阶段五“睡前模式与提醒”，打通真实提醒调度、通知冷启动入口、提醒设置编辑闭环，并把当前 `bedtime` 与 `notifications` 的半成品能力推进到稳定可交付状态。

**Architecture:** 以现有 `bedtime` feature 为核心，补齐 `notifications` 的真实网关接线、启动入口协调和提醒设置回写。显示层继续以 `pen/app.pen` 的 `10 睡前页`、`17 提醒设置页`、`24 弹层与对话框总览`、`25 补充弹层与反馈组件` 为唯一设计基线。任务按“共享契约冻结 -> 可并行子轨道 -> 集成收口 -> 回归验收”组织，但是否并行由执行时根据冲突面和改动耦合度决定。

**Tech Stack:** Flutter, hooks_riverpod, flutter_riverpod, go_router, flutter_local_notifications, flutter_timezone, timezone, home_widget, flutter_test

---

## 文件结构

### 新建文件

- `test/features/notifications/bedtime_notification_gateway_integration_test.dart`
作用：验证真实通知网关与提醒计划对象的映射边界，避免调度层继续依赖占位实现。

- `test/app/bootstrap_launch_entry_test.dart`
作用：验证通知冷启动、小组件冷启动和默认启动分流行为。

### 修改文件

- `lib/features/notifications/application/bedtime_reminder_scheduler.dart`
作用：把默认通知网关从占位实现切到真实插件网关注入点，并补齐权限状态与调度返回口径。

- `lib/features/notifications/data/local_notification_gateway.dart`
作用：从“默认 Noop”边界调整为“接口 + fake/测试用实现”，不再让应用层默认误接空实现。

- `lib/features/notifications/data/plugin_local_notification_gateway.dart`
作用：补齐真实通知网关调度、权限申请、payload 读取与 channel 配置边界。

- `lib/features/notifications/presentation/reminder_setup_page.dart`
作用：完成引导时使用真实调度结果，并处理权限与调度失败的轻反馈。

- `lib/features/notifications/application/reminder_settings_controller.dart`
作用：扩展提醒设置编辑页所需状态入口，保证阶段五之后可复用到“提醒设置页”。

- `lib/features/notifications/domain/reminder_settings_state.dart`
作用：如有必要补齐阶段五真实调度所需字段，但保持字段集收敛，不提前做阶段八泛化。

- `lib/app/bootstrap/app_bootstrap.dart`
作用：统一注入真实通知网关和冷启动入口解析依赖。

- `lib/app/bootstrap/bootstrap_launch_entry.dart`
作用：统一启动入口决策逻辑，避免通知、小组件入口和默认分流散落。

- `lib/app/bootstrap/launch_gate.dart`
作用：确保冷启动睡前入口优先级与首次激活分流兼容。

- `lib/features/bedtime/presentation/bedtime_page.dart`
作用：补齐睡前页空态 CTA、权限缺失态和交互反馈。

- `lib/app/router/app_router.dart`
作用：如需补充提醒设置编辑入口或睡前页辅助路径，由集成任务统一调整。

- `lib/l10n/app_en.arb`
- `lib/l10n/app_zh.arb`
作用：补齐阶段五收口新增文案。

- `test/features/notifications/reminder_setup_test.dart`
- `test/features/notifications/bedtime_reminder_scheduler_test.dart`
- `test/features/notifications/notification_open_route_test.dart`
- `test/features/bedtime/bedtime_page_test.dart`
作用：更新既有测试，锁定真实调度与页面反馈行为。

---

## 共享契约冻结

执行任何实现前，先冻结以下契约，避免显示层、调度层和启动层互相拉扯：

- `BedtimeReminderPlan`
- `ReminderSettingsState`
- `NotificationRouteEntry`
- `BootstrapLaunchEntry`
- `BedtimeViewStatus`
- 提醒调度结果是否允许为空计划
- 通知 payload 仅接受：
  - `rhythm://bedtime?source=soft_reminder`
  - `rhythm://bedtime?source=target_reminder`

冻结后，若字段或签名需要变化，必须先更新测试夹具和契约说明，再继续实现。

---

## Pencil 对照要求

- 睡前页实现前，先用 Pencil MCP 读取 `fUty7`，核对倒计时区、状态选择区、动作建议区和底部导航层级。
- 提醒设置编辑行为相关显示层，先读取 `Vd5Ou`，核对主设置卡、建议卡、完成按钮和错误/说明承载位。
- 如果通知权限缺失、调度失败、保存失败等状态在当前节点中未完整展开，执行前先读取 `Q2xhiP` 与 `ZQBCz`，决定复用哪类反馈组件。

---

## 执行方式建议

### 推荐方式

- 若执行时共享文件改动较少，建议并行拆成 3 条子代理轨道：
  - 轨道 A：调度与通知网关
  - 轨道 B：启动入口与冷启动分流
  - 轨道 C：提醒设置页与睡前页反馈

### 回退方式

- 如果执行时发现 `app_bootstrap.dart`、`launch_gate.dart`、`app_router.dart` 同时强耦合且频繁冲突，可以改为串行执行：
  1. 先完成调度层
  2. 再接启动层
  3. 最后收口页面反馈

---

### Task 1: 冻结阶段五共享契约

**Files:**
- Modify: `docs/rhythm-remaining-stages-parallel-implementation-plan-2026-05-24.md`
- Test: `test/features/notifications/bedtime_reminder_scheduler_test.dart`

- [ ] **Step 1: 复核当前提醒计划测试夹具**

确认以下测试仍代表真实期望：

```dart
expect(plans.first.type, BedtimeReminderType.soft);
expect(plans.first.scheduledAt, DateTime(2026, 5, 24, 22, 45));
```

Expected: 软提醒、到点提醒、过近合并、跨午夜四类规则均有效，不需要再加新的计划类型。

- [ ] **Step 2: 明确调度结果边界**

把阶段五范围锁成：
- 允许返回空计划列表
- 不在阶段五引入周报提醒持久化
- 不在阶段五引入通知撤销历史

Expected: 后续任务只收口当前缺口，不提前做阶段八泛化。

- [ ] **Step 3: 运行现有调度规则测试**

Run: `flutter test test/features/notifications/bedtime_reminder_scheduler_test.dart -r expanded`
Expected: PASS

---

### Task 2: 收口真实通知网关注入

**Files:**
- Modify: `lib/features/notifications/application/bedtime_reminder_scheduler.dart`
- Modify: `lib/features/notifications/data/local_notification_gateway.dart`
- Modify: `lib/features/notifications/data/plugin_local_notification_gateway.dart`
- Create: `test/features/notifications/bedtime_notification_gateway_integration_test.dart`

- [ ] **Step 1: 写失败测试，锁定调度器默认不能再走 Noop 网关**

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:rhythm/features/notifications/data/local_notification_gateway.dart';

void main() {
  test('默认通知网关不应再是 Noop 实现', () {
    final gateway = createDefaultLocalNotificationGatewayForTest();
    expect(gateway, isNot(isA<NoopLocalNotificationGateway>()));
  });
}
```

- [ ] **Step 2: 运行测试，确认当前默认实现不符合预期**

Run: `flutter test test/features/notifications/bedtime_notification_gateway_integration_test.dart -r expanded`
Expected: FAIL，当前仍是 `NoopLocalNotificationGateway`

- [ ] **Step 3: 把应用层 Provider 改成显式真实网关注入**

在 `bedtime_reminder_scheduler.dart` 中将默认 provider 改为真实实现：

```dart
final localNotificationGatewayProvider = Provider<LocalNotificationGateway>((ref) {
  return PluginLocalNotificationGateway(
    plugin: FlutterLocalNotificationsPlugin(),
    timezoneGateway: ref.watch(timezoneGatewayProvider),
  );
});
```

Expected: 应用层默认接真实网关，测试通过 override 替换 fake。

- [ ] **Step 4: 保留 fake/测试网关，不再把 Noop 当默认运行时**

把 `local_notification_gateway.dart` 调整为“接口 + 测试实现”，例如：

```dart
class FakeLocalNotificationGateway implements LocalNotificationGateway {
  final List<BedtimeReminderPlan> scheduledPlans = <BedtimeReminderPlan>[];

  @override
  Future<void> cancelBedtimeReminders() async {
    scheduledPlans.clear();
  }

  @override
  Future<void> initialize({
    required void Function(String? payload) onOpened,
  }) async {}

  @override
  Future<bool> requestPermission() async => true;

  @override
  Future<void> schedule(BedtimeReminderPlan plan) async {
    scheduledPlans.add(plan);
  }
}
```

- [ ] **Step 5: 为插件网关补一条集成边界测试**

测试至少断言：
- `schedule()` 不抛异常地接受 `BedtimeReminderPlan`
- `cancelBedtimeReminders()` 会按固定 ID 取消
- `readLaunchPayload()` 返回 nullable payload

- [ ] **Step 6: 运行通知相关测试**

Run: `flutter test test/features/notifications/bedtime_reminder_scheduler_test.dart test/features/notifications/bedtime_notification_gateway_integration_test.dart -r expanded`
Expected: PASS

---

### Task 3: 收口引导完成后的真实调度反馈

**Files:**
- Modify: `lib/features/notifications/presentation/reminder_setup_page.dart`
- Modify: `lib/features/notifications/application/reminder_settings_controller.dart`
- Modify: `lib/features/notifications/domain/reminder_settings_state.dart`
- Modify: `test/features/notifications/reminder_setup_test.dart`

- [ ] **Step 1: 写失败测试，锁定完成引导后会触发真实调度结果反馈**

```dart
testWidgets('提醒策略保存后会调用调度器并继续进入今日页', (tester) async {
  var scheduled = false;
  final scheduler = _FakeScheduler(onSchedule: () => scheduled = true);

  await pumpReminderSetupPage(tester, scheduler: scheduler);
  await tester.tap(find.text('完成设置'));
  await tester.pumpAndSettle();

  expect(scheduled, isTrue);
});
```

- [ ] **Step 2: 运行测试，确认当前只调度但没有稳定反馈约束**

Run: `flutter test test/features/notifications/reminder_setup_test.dart -r expanded`
Expected: FAIL 或缺少断言覆盖

- [ ] **Step 3: 补齐提醒设置状态的最小真实字段**

若当前字段足够，保持不扩展；若确实需要，最多只补：

```dart
@Default(false) bool notificationPermissionRequested,
```

Expected: 不提前引入阶段八设置泛化字段。

- [ ] **Step 4: 在完成引导时先申请权限再调度**

在 `_completeOnboarding` 中补权限申请顺序：

```dart
final permissionGranted = await ref
    .read(localNotificationGatewayProvider)
    .requestPermission();

if (!permissionGranted && context.mounted) {
  // 允许继续完成引导，但要展示轻提示或保留后续设置入口
}
```

Expected: 调度链路不再默认假设权限已授予。

- [ ] **Step 5: 调度完成后保持引导可继续，但记录失败路径**

如果计划为空或权限未授予：
- 仍允许完成引导
- 不阻断进入今日页
- 通过页面轻提示或后续设置页承接补救

- [ ] **Step 6: 运行提醒设置测试**

Run: `flutter test test/features/notifications/reminder_setup_test.dart -r expanded`
Expected: PASS

---

### Task 4: 收口冷启动入口与启动分流

**Files:**
- Modify: `lib/app/bootstrap/app_bootstrap.dart`
- Modify: `lib/app/bootstrap/bootstrap_launch_entry.dart`
- Modify: `lib/app/bootstrap/launch_gate.dart`
- Create: `test/app/bootstrap_launch_entry_test.dart`

- [ ] **Step 1: 写失败测试，锁定通知和小组件冷启动优先级**

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:rhythm/app/bootstrap/bootstrap_launch_entry.dart';

void main() {
  test('通知睡前入口优先于默认启动流', () async {
    final entry = await resolveBootstrapLaunchEntry(
      notificationGateway: _NotificationGateway(payload: 'rhythm://bedtime?source=soft_reminder'),
      widgetLaunchGateway: _WidgetGateway(null),
    );

    expect(entry.target, BootstrapEntryTarget.bedtime);
  });
}
```

- [ ] **Step 2: 运行测试，确认当前启动分流覆盖不足**

Run: `flutter test test/app/bootstrap_launch_entry_test.dart -r expanded`
Expected: FAIL 或缺少对应测试文件

- [ ] **Step 3: 保持 `app_bootstrap.dart` 只初始化一次真实通知网关**

避免同时在 bootstrap 和 provider 里重复初始化同一个插件实例。  
若需要，提取一个共享实例装配点，例如：

```dart
final notificationGateway = PluginLocalNotificationGateway(
  plugin: FlutterLocalNotificationsPlugin(),
  timezoneGateway: DeviceTimezoneGateway(),
);
```

Expected: 启动层和应用层使用同一初始化策略，不再一个真实、一个 Noop。

- [ ] **Step 4: 固化冷启动解析顺序**

顺序固定为：
1. 通知 payload
2. 小组件入口
3. 默认分流

Expected: 不出现小组件覆盖通知入口的非确定性行为。

- [ ] **Step 5: 运行启动分流测试**

Run: `flutter test test/app/bootstrap_launch_entry_test.dart test/features/notifications/notification_open_route_test.dart test/features/widget_bridge/widget_entry_controller_test.dart -r expanded`
Expected: PASS

---

### Task 5: 收口睡前页空态与交互反馈

**Files:**
- Modify: `lib/features/bedtime/presentation/bedtime_page.dart`
- Modify: `test/features/bedtime/bedtime_page_test.dart`

- [ ] **Step 1: 用 Pencil MCP 核对 `fUty7`、`Q2xhiP`、`ZQBCz`**

核对项：
- 空态按钮层级
- 权限缺失或目标缺失反馈的承载形态
- 是否应复用现有对话框/轻提示结构

Expected: 空态和反馈不脱离设计稿自由发挥。

- [ ] **Step 2: 写失败测试，锁定 goalMissing CTA 不是空回调**

```dart
testWidgets('goalMissing 状态点击按钮后会触发目标设置入口', (tester) async {
  var tapped = false;
  await pumpGoalMissingPage(tester, onOpenGoalSetup: () => tapped = true);

  await tester.tap(find.text('去设置目标作息'));
  await tester.pumpAndSettle();

  expect(tapped, isTrue);
});
```

- [ ] **Step 3: 运行页面测试，确认当前 CTA 仍为空实现**

Run: `flutter test test/features/bedtime/bedtime_page_test.dart -r expanded`
Expected: FAIL，当前 `onPressed: () {}` 不满足要求

- [ ] **Step 4: 给 `BedtimePage` 注入空态动作回调**

将 `_BedtimeGoalMissingState` 改为接收回调：

```dart
class _BedtimeGoalMissingState extends StatelessWidget {
  const _BedtimeGoalMissingState({
    required this.l10n,
    required this.onPressed,
  });

  final AppLocalizations l10n;
  final VoidCallback onPressed;
}
```

Expected: 页面不再把关键 CTA 留空。

- [ ] **Step 5: 运行睡前页测试**

Run: `flutter test test/features/bedtime/bedtime_page_test.dart -r expanded`
Expected: PASS

---

### Task 6: 集成收口与回归

**Files:**
- Modify: `lib/app/router/app_router.dart`
- Modify: `lib/l10n/app_en.arb`
- Modify: `lib/l10n/app_zh.arb`
- Modify: `lib/l10n/app_localizations.dart`
- Modify: `lib/l10n/app_localizations_en.dart`
- Modify: `lib/l10n/app_localizations_zh.dart`

- [ ] **Step 1: 统一补阶段五新增文案**

至少检查并补齐：
- 提醒权限未打开时的轻提示
- 调度失败或未授予权限时的说明文案
- 睡前页空态 CTA 文案

- [ ] **Step 2: 运行本地化生成**

Run: `flutter gen-l10n`
Expected: 生成文件更新成功，无手工修改生成文件

- [ ] **Step 3: 跑阶段五专项测试**

Run:

```bash
flutter test test/features/bedtime test/features/notifications test/app/bootstrap_launch_entry_test.dart -r expanded
```

Expected: PASS

- [ ] **Step 4: 跑全量测试**

Run: `flutter test`
Expected: PASS

- [ ] **Step 5: 运行 GitNexus 变更检测**

Run: `npx gitnexus detect_changes`
Expected: 影响范围集中在 `bedtime`、`notifications`、`bootstrap`、`router`、`l10n` 和对应测试

- [ ] **Step 6: 提交该任务**

```bash
git add lib/features/bedtime lib/features/notifications lib/app/bootstrap lib/app/router lib/l10n test/features/bedtime test/features/notifications test/app/bootstrap_launch_entry_test.dart
git commit -m "feat: close stage five bedtime reminders"
```

---

## Self-Review

- Spec coverage:
  - 已覆盖阶段五真实缺口：默认 Noop 网关、权限未显式处理、冷启动入口测试不足、睡前页空态 CTA 未接通。
  - 已覆盖显示层设计约束：`fUty7`、`Vd5Ou`、`Q2xhiP`、`ZQBCz`。
  - 已覆盖集成收口：本地化、专项测试、全量测试、GitNexus 检测。

- Placeholder scan:
  - 无 `TODO`、`TBD`、`后续再说` 类占位步骤。
  - 每个任务都给了明确文件、命令和预期。

- Type consistency:
  - 使用的类型名与现有代码一致：`BedtimeReminderScheduler`、`LocalNotificationGateway`、`BootstrapLaunchEntry`、`BedtimeViewState`、`ReminderSettingsState`。
  - 未引入与现有代码冲突的新命名体系。

## Execution Handoff

Plan complete and saved to `docs/superpowers/plans/2026-05-24-stage5-bedtime-reminder-closure.md`. Two execution options:

1. Subagent-Driven (recommended) - I dispatch a fresh subagent per task, review between tasks, fast iteration

2. Inline Execution - Execute tasks in this session using executing-plans, batch execution with checkpoints

Which approach?
