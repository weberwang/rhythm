# Onboarding And Goal Schedule Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** 构建首批 `onboarding + goal_schedule` 模块，实现从首次打开到目标作息设置完成并进入今日页的最小可用闭环，同时严格遵守“先判断是否必须改 UI/UX，再决定是否改 Pencil”的执行规则。

**Architecture:** 在现有 `RhythmApp + GoRouter + ProviderScope` 壳上新增首启分发、引导页、目标设置页与提醒策略页。路由层只负责页面切换，表单状态与首次激活完成标记放入独立状态层。现阶段不接入真实健康权限和云同步，只保留可扩展接口与明确降级路径。

**Tech Stack:** Flutter, Material 3, flutter_riverpod, go_router, shared_preferences, flutter_test

---

## 文件结构

### 新建文件

- `lib/app/bootstrap/launch_state_repository.dart`
作用：读写首次激活完成状态，封装 `SharedPreferences`。

- `lib/app/bootstrap/launch_state_provider.dart`
作用：提供启动分发所需状态读取接口，供路由和页面判断使用。

- `lib/app/bootstrap/launch_gate.dart`
作用：实现启动分发页，根据首次激活状态跳转到引导流或首页。

- `lib/features/onboarding/application/onboarding_flow_controller.dart`
作用：管理首次激活流程的步骤切换、表单草稿和完成动作。

- `lib/features/onboarding/domain/onboarding_draft.dart`
作用：承载首次激活期间的轻量草稿数据。

- `lib/features/onboarding/presentation/onboarding_flow_page.dart`
作用：组合欢迎、登录选择、健康权限说明三个步骤页面。

- `lib/features/onboarding/presentation/widgets/onboarding_step_scaffold.dart`
作用：统一首次激活步骤页的结构骨架与操作区。

- `lib/features/onboarding/presentation/widgets/onboarding_welcome_step.dart`
作用：欢迎价值页 UI。

- `lib/features/onboarding/presentation/widgets/auth_entry_step.dart`
作用：登录选择页 UI。

- `lib/features/onboarding/presentation/widgets/health_permission_step.dart`
作用：健康权限说明页 UI。

- `lib/features/goal_schedule/application/goal_schedule_form_controller.dart`
作用：管理目标作息设置表单与校验。

- `lib/features/goal_schedule/domain/goal_schedule_form_state.dart`
作用：定义目标作息表单状态、校验错误和默认值。

- `lib/features/goal_schedule/presentation/goal_setup_page.dart`
作用：实现 onboarding 中的目标作息设置页。

- `lib/features/goal_schedule/presentation/widgets/goal_schedule_form_section.dart`
作用：目标作息表单分组 UI。

- `lib/features/notifications/application/reminder_settings_controller.dart`
作用：管理首次激活中的提醒策略表单。

- `lib/features/notifications/domain/reminder_settings_state.dart`
作用：定义提醒策略默认值与可提交状态。

- `lib/features/notifications/presentation/reminder_setup_page.dart`
作用：实现 onboarding 中的提醒策略设置页。

- `lib/features/notifications/presentation/widgets/reminder_strategy_form_section.dart`
作用：提醒策略表单分组 UI。

- `lib/core/presentation/widgets/rhythm_primary_button.dart`
作用：统一主按钮样式，避免在多个 onboarding 页面重复写样式。

- `lib/core/presentation/widgets/rhythm_secondary_button.dart`
作用：统一次按钮样式。

- `test/features/onboarding/onboarding_flow_test.dart`
作用：覆盖首次激活主流程与跳过路径。

- `test/features/goal_schedule/goal_schedule_form_test.dart`
作用：覆盖目标作息表单校验与默认值。

- `test/features/notifications/reminder_setup_test.dart`
作用：覆盖提醒策略默认状态与提交流程。

- `test/app/launch_gate_test.dart`
作用：覆盖首次打开和已完成 onboarding 两种启动分发行为。

### 修改文件

- `lib/app/router/app_router.dart`
作用：加入 `/launch`、`/onboarding/*` 路由，并将初始路由切到启动分发。

- `lib/app/rhythm_app.dart`
作用：保留当前主题能力，确保路由切换到启动分发页后仍可启动；若已有 `darkTheme`，保持不回退。

- `lib/app/bootstrap/app_bootstrap.dart`
作用：增加 `SharedPreferences` 初始化与仓储注入。

- `test/app/rhythm_app_test.dart`
作用：将默认首页断言调整为启动分发后可达引导流，并验证完成后进入今日页。

---

## UI/UX 变更前置判断

### 当前结论

`onboarding + goal_schedule` **必须最小化改 UI/UX**。

### 原因

- 当前 `pen/app.pen` 已有欢迎页、登录选择页、健康权限页、目标作息设置页、提醒策略设置页，对应本次模块主要承载界面。
- 但当前代码层完全没有这些页面与路由，且现有今日页壳是直接默认进入 `/`，无法体现首次打开先进入引导流。
- 本次所需的 UI/UX 最小改动仅限于：把启动入口从“默认今日页”切换为“启动分发页 -> onboarding -> 今日页”，不新增 Pencil 页面，不重画现有 UI。

### 本次不改

- 不修改 Pencil 页面结构。
- 不新增新的 onboarding 步骤。
- 不加入真实 Apple/Google 登录弹窗。
- 不加入真实健康权限系统弹窗。

---

## Task 1: 启动分发与首次激活状态

**Files:**
- Create: `lib/app/bootstrap/launch_state_repository.dart`
- Create: `lib/app/bootstrap/launch_state_provider.dart`
- Create: `lib/app/bootstrap/launch_gate.dart`
- Modify: `lib/app/bootstrap/app_bootstrap.dart`
- Modify: `lib/app/router/app_router.dart`
- Test: `test/app/launch_gate_test.dart`

- [ ] **Step 1: 写失败测试，定义首次打开进入引导流**

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:rhythm/app/rhythm_app.dart';

void main() {
  testWidgets('首次打开时进入欢迎引导页', (tester) async {
    await tester.pumpWidget(const RhythmApp());
    await tester.pumpAndSettle();

    expect(find.text('用更温和的方式，帮你把作息慢慢拨正。'), findsOneWidget);
  });
}
```

- [ ] **Step 2: 运行测试，确认它因缺少启动分发而失败**

Run: `flutter test test/app/launch_gate_test.dart -r expanded`
Expected: FAIL，找不到欢迎引导文案，或当前仍落在今日页。

- [ ] **Step 3: 实现首次激活状态仓储**

```dart
import 'package:shared_preferences/shared_preferences.dart';

/// 持久化首次激活完成状态，避免每次启动都重新进入 onboarding。
class LaunchStateRepository {
  LaunchStateRepository(this._preferences);

  static const _onboardingCompletedKey = 'onboarding_completed';

  final SharedPreferences _preferences;

  /// 判断用户是否已经完成首次激活闭环。
  bool isOnboardingCompleted() {
    return _preferences.getBool(_onboardingCompletedKey) ?? false;
  }

  /// 标记首次激活已完成，后续启动直接进入主流程。
  Future<void> markOnboardingCompleted() async {
    await _preferences.setBool(_onboardingCompletedKey, true);
  }
}
```

- [ ] **Step 4: 实现启动分发 Provider**

```dart
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'launch_state_repository.dart';

final launchStateRepositoryProvider = Provider<LaunchStateRepository>((ref) {
  throw UnimplementedError('需要在 bootstrap 中覆盖 launchStateRepositoryProvider');
});

final onboardingCompletedProvider = Provider<bool>((ref) {
  return ref.watch(launchStateRepositoryProvider).isOnboardingCompleted();
});
```

- [ ] **Step 5: 实现启动分发页**

```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'launch_state_provider.dart';

/// 启动分发页只负责根据首次激活状态跳转，不承载业务展示。
class LaunchGate extends ConsumerStatefulWidget {
  const LaunchGate({super.key});

  @override
  ConsumerState<LaunchGate> createState() => _LaunchGateState();
}

class _LaunchGateState extends ConsumerState<LaunchGate> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final completed = ref.read(onboardingCompletedProvider);
      context.go(completed ? '/' : '/onboarding/welcome');
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
```

- [ ] **Step 6: 在 bootstrap 中初始化 SharedPreferences 并覆盖仓储**

```dart
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../rhythm_app.dart';
import 'launch_state_provider.dart';
import 'launch_state_repository.dart';

/// 启动入口集中初始化轻量本地依赖，避免页面层直接感知存储细节。
Future<void> bootstrapApp() async {
  WidgetsFlutterBinding.ensureInitialized();
  final preferences = await SharedPreferences.getInstance();

  runApp(
    ProviderScope(
      overrides: [
        launchStateRepositoryProvider.overrideWithValue(
          LaunchStateRepository(preferences),
        ),
      ],
      child: const RhythmApp(),
    ),
  );
}
```

- [ ] **Step 7: 调整路由初始入口为 `/launch`**

```dart
GoRouter createAppRouter() {
  return GoRouter(
    initialLocation: '/launch',
    routes: [
      GoRoute(
        path: '/launch',
        builder: (context, state) => const LaunchGate(),
      ),
      // 其他路由保持不变
    ],
  );
}
```

- [ ] **Step 8: 运行测试，确认首次打开会进入引导流**

Run: `flutter test test/app/launch_gate_test.dart -r expanded`
Expected: PASS

- [ ] **Step 9: 提交该任务**

```bash
git add lib/app/bootstrap/launch_state_repository.dart lib/app/bootstrap/launch_state_provider.dart lib/app/bootstrap/launch_gate.dart lib/app/bootstrap/app_bootstrap.dart lib/app/router/app_router.dart test/app/launch_gate_test.dart
git commit -m "feat: add launch gate for onboarding flow"
```

## Task 2: 实现 onboarding 三步引导流

**Files:**
- Create: `lib/features/onboarding/domain/onboarding_draft.dart`
- Create: `lib/features/onboarding/application/onboarding_flow_controller.dart`
- Create: `lib/features/onboarding/presentation/onboarding_flow_page.dart`
- Create: `lib/features/onboarding/presentation/widgets/onboarding_step_scaffold.dart`
- Create: `lib/features/onboarding/presentation/widgets/onboarding_welcome_step.dart`
- Create: `lib/features/onboarding/presentation/widgets/auth_entry_step.dart`
- Create: `lib/features/onboarding/presentation/widgets/health_permission_step.dart`
- Create: `lib/core/presentation/widgets/rhythm_primary_button.dart`
- Create: `lib/core/presentation/widgets/rhythm_secondary_button.dart`
- Modify: `lib/app/router/app_router.dart`
- Test: `test/features/onboarding/onboarding_flow_test.dart`

- [ ] **Step 1: 写失败测试，定义 onboarding 主流程**

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:rhythm/app/rhythm_app.dart';

void main() {
  testWidgets('引导流可以从欢迎页进入权限说明页', (tester) async {
    await tester.pumpWidget(const RhythmApp());
    await tester.pumpAndSettle();

    await tester.tap(find.text('开始建立我的作息目标'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('匿名进入'));
    await tester.pumpAndSettle();

    expect(find.text('读取睡眠数据'), findsOneWidget);
  });
}
```

- [ ] **Step 2: 运行测试，确认当前缺少 onboarding 页面导致失败**

Run: `flutter test test/features/onboarding/onboarding_flow_test.dart -r expanded`
Expected: FAIL，找不到 onboarding 页面文案。

- [ ] **Step 3: 定义 onboarding 草稿模型**

```dart
/// 承载首次激活过程中未提交的轻量选择结果。
class OnboardingDraft {
  const OnboardingDraft({
    this.loginMode = LoginMode.anonymous,
    this.healthPermissionSkipped = false,
  });

  final LoginMode loginMode;
  final bool healthPermissionSkipped;

  OnboardingDraft copyWith({
    LoginMode? loginMode,
    bool? healthPermissionSkipped,
  }) {
    return OnboardingDraft(
      loginMode: loginMode ?? this.loginMode,
      healthPermissionSkipped: healthPermissionSkipped ?? this.healthPermissionSkipped,
    );
  }
}

enum LoginMode { anonymous, apple, google }
```

- [ ] **Step 4: 实现 onboarding 流程控制器**

```dart
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/onboarding_draft.dart';

final onboardingFlowControllerProvider = StateNotifierProvider<
    OnboardingFlowController, OnboardingFlowState>((ref) {
  return OnboardingFlowController();
});

class OnboardingFlowState {
  const OnboardingFlowState({
    this.step = OnboardingStep.welcome,
    this.draft = const OnboardingDraft(),
  });

  final OnboardingStep step;
  final OnboardingDraft draft;

  OnboardingFlowState copyWith({
    OnboardingStep? step,
    OnboardingDraft? draft,
  }) {
    return OnboardingFlowState(
      step: step ?? this.step,
      draft: draft ?? this.draft,
    );
  }
}

enum OnboardingStep { welcome, authEntry, healthPermission }

/// 管理首次激活前三步切换，保持页面层只负责展示。
class OnboardingFlowController extends StateNotifier<OnboardingFlowState> {
  OnboardingFlowController() : super(const OnboardingFlowState());

  void nextFromWelcome() {
    state = state.copyWith(step: OnboardingStep.authEntry);
  }

  void selectLoginMode(LoginMode mode) {
    state = state.copyWith(
      step: OnboardingStep.healthPermission,
      draft: state.draft.copyWith(loginMode: mode),
    );
  }

  void skipHealthPermission() {
    state = state.copyWith(
      draft: state.draft.copyWith(healthPermissionSkipped: true),
    );
  }
}
```

- [ ] **Step 5: 实现统一步骤骨架和按钮组件**

```dart
import 'package:flutter/material.dart';

/// 统一 onboarding 页面结构，避免多个步骤页重复拼装标题与底部操作区。
class OnboardingStepScaffold extends StatelessWidget {
  const OnboardingStepScaffold({
    super.key,
    required this.header,
    required this.body,
    required this.actions,
  });

  final Widget header;
  final Widget body;
  final Widget actions;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              header,
              const SizedBox(height: 24),
              Expanded(child: body),
              actions,
            ],
          ),
        ),
      ),
    );
  }
}
```

- [ ] **Step 6: 实现三步页面 UI 并注册路由**

```dart
GoRoute(
  path: '/onboarding/welcome',
  builder: (context, state) => const OnboardingFlowPage(),
),
```

```dart
class OnboardingFlowPage extends ConsumerWidget {
  const OnboardingFlowPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(onboardingFlowControllerProvider);

    return switch (state.step) {
      OnboardingStep.welcome => OnboardingWelcomeStep(
          onNext: () => ref.read(onboardingFlowControllerProvider.notifier).nextFromWelcome(),
        ),
      OnboardingStep.authEntry => AuthEntryStep(
          onSelectMode: (mode) => ref.read(onboardingFlowControllerProvider.notifier).selectLoginMode(mode),
        ),
      OnboardingStep.healthPermission => HealthPermissionStep(
          onSkip: () => context.go('/onboarding/goal-setup'),
          onGrant: () => context.go('/onboarding/goal-setup'),
        ),
    };
  }
}
```

- [ ] **Step 7: 运行测试，确认引导流基础跳转通过**

Run: `flutter test test/features/onboarding/onboarding_flow_test.dart -r expanded`
Expected: PASS

- [ ] **Step 8: 提交该任务**

```bash
git add lib/features/onboarding lib/core/presentation/widgets lib/app/router/app_router.dart test/features/onboarding/onboarding_flow_test.dart
git commit -m "feat: add onboarding flow screens"
```

## Task 3: 实现目标作息设置表单

**Files:**
- Create: `lib/features/goal_schedule/domain/goal_schedule_form_state.dart`
- Create: `lib/features/goal_schedule/application/goal_schedule_form_controller.dart`
- Create: `lib/features/goal_schedule/presentation/goal_setup_page.dart`
- Create: `lib/features/goal_schedule/presentation/widgets/goal_schedule_form_section.dart`
- Modify: `lib/app/router/app_router.dart`
- Test: `test/features/goal_schedule/goal_schedule_form_test.dart`

- [ ] **Step 1: 写失败测试，定义目标作息表单校验**

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:rhythm/features/goal_schedule/domain/goal_schedule_form_state.dart';

void main() {
  test('当起床时间与入睡时间相同时时校验失败', () {
    const state = GoalScheduleFormState(
      bedtimeHour: 23,
      bedtimeMinute: 30,
      wakeHour: 23,
      wakeMinute: 30,
    );

    expect(state.validate().wakeTimeError, isNotNull);
  });
}
```

- [ ] **Step 2: 运行测试，确认表单模型不存在导致失败**

Run: `flutter test test/features/goal_schedule/goal_schedule_form_test.dart -r expanded`
Expected: FAIL，缺少 `GoalScheduleFormState`。

- [ ] **Step 3: 实现目标作息表单状态**

```dart
/// 首次激活中的目标作息表单状态，当前只承载 MVP 需要的基础字段。
class GoalScheduleFormState {
  const GoalScheduleFormState({
    this.bedtimeHour = 23,
    this.bedtimeMinute = 30,
    this.wakeHour = 7,
    this.wakeMinute = 30,
    this.lateThresholdMinutes = 30,
    this.dayStartHour = 4,
    this.dayStartMinute = 0,
    this.wakeTimeError,
  });

  final int bedtimeHour;
  final int bedtimeMinute;
  final int wakeHour;
  final int wakeMinute;
  final int lateThresholdMinutes;
  final int dayStartHour;
  final int dayStartMinute;
  final String? wakeTimeError;

  GoalScheduleFormState validate() {
    final sameWakeAndBedtime =
        bedtimeHour == wakeHour && bedtimeMinute == wakeMinute;

    return GoalScheduleFormState(
      bedtimeHour: bedtimeHour,
      bedtimeMinute: bedtimeMinute,
      wakeHour: wakeHour,
      wakeMinute: wakeMinute,
      lateThresholdMinutes: lateThresholdMinutes,
      dayStartHour: dayStartHour,
      dayStartMinute: dayStartMinute,
      wakeTimeError: sameWakeAndBedtime ? '起床时间不能与目标入睡时间相同' : null,
    );
  }
}
```

- [ ] **Step 4: 实现表单控制器**

```dart
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/goal_schedule_form_state.dart';

final goalScheduleFormControllerProvider = StateNotifierProvider<
    GoalScheduleFormController, GoalScheduleFormState>((ref) {
  return GoalScheduleFormController();
});

/// 管理目标作息表单与校验，避免页面直接处理字段联动。
class GoalScheduleFormController extends StateNotifier<GoalScheduleFormState> {
  GoalScheduleFormController() : super(const GoalScheduleFormState());

  void updateLateThreshold(int minutes) {
    state = GoalScheduleFormState(
      bedtimeHour: state.bedtimeHour,
      bedtimeMinute: state.bedtimeMinute,
      wakeHour: state.wakeHour,
      wakeMinute: state.wakeMinute,
      lateThresholdMinutes: minutes,
      dayStartHour: state.dayStartHour,
      dayStartMinute: state.dayStartMinute,
    );
  }

  bool submit() {
    final validated = state.validate();
    state = validated;
    return validated.wakeTimeError == null;
  }
}
```

- [ ] **Step 5: 实现目标设置页并接到提醒策略页**

```dart
GoRoute(
  path: '/onboarding/goal-setup',
  builder: (context, state) => const GoalSetupPage(),
),
```

```dart
class GoalSetupPage extends ConsumerWidget {
  const GoalSetupPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final form = ref.watch(goalScheduleFormControllerProvider);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              GoalScheduleFormSection(form: form),
              const Spacer(),
              FilledButton(
                onPressed: () {
                  final success =
                      ref.read(goalScheduleFormControllerProvider.notifier).submit();
                  if (success) {
                    context.go('/onboarding/reminder-setup');
                  }
                },
                child: const Text('保存目标，继续下一步'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
```

- [ ] **Step 6: 运行测试，确认表单规则与页面流转通过**

Run: `flutter test test/features/goal_schedule/goal_schedule_form_test.dart -r expanded`
Expected: PASS

- [ ] **Step 7: 提交该任务**

```bash
git add lib/features/goal_schedule lib/app/router/app_router.dart test/features/goal_schedule/goal_schedule_form_test.dart
git commit -m "feat: add goal schedule setup form"
```

## Task 4: 实现提醒策略设置并完成引导闭环

**Files:**
- Create: `lib/features/notifications/domain/reminder_settings_state.dart`
- Create: `lib/features/notifications/application/reminder_settings_controller.dart`
- Create: `lib/features/notifications/presentation/reminder_setup_page.dart`
- Create: `lib/features/notifications/presentation/widgets/reminder_strategy_form_section.dart`
- Modify: `lib/app/router/app_router.dart`
- Modify: `test/app/rhythm_app_test.dart`
- Test: `test/features/notifications/reminder_setup_test.dart`

- [ ] **Step 1: 写失败测试，定义提醒策略完成后进入今日页**

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:rhythm/app/rhythm_app.dart';

void main() {
  testWidgets('提醒策略保存后进入今日页', (tester) async {
    await tester.pumpWidget(const RhythmApp());
    await tester.pumpAndSettle();

    await tester.tap(find.text('开始建立我的作息目标'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('匿名进入'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('先用手动模式'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('保存目标，继续下一步'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('完成设置，进入今日页'));
    await tester.pumpAndSettle();

    expect(find.text('今晚先轻一点'), findsOneWidget);
  });
}
```

- [ ] **Step 2: 运行测试，确认提醒策略页缺失导致失败**

Run: `flutter test test/features/notifications/reminder_setup_test.dart -r expanded`
Expected: FAIL，找不到提醒策略页按钮。

- [ ] **Step 3: 实现提醒策略状态和控制器**

```dart
class ReminderSettingsState {
  const ReminderSettingsState({
    this.softReminderEnabled = true,
    this.targetReminderEnabled = false,
    this.weeklyReportEnabled = true,
    this.leadMinutes = 45,
  });

  final bool softReminderEnabled;
  final bool targetReminderEnabled;
  final bool weeklyReportEnabled;
  final int leadMinutes;
}
```

```dart
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/reminder_settings_state.dart';

final reminderSettingsControllerProvider = StateNotifierProvider<
    ReminderSettingsController, ReminderSettingsState>((ref) {
  return ReminderSettingsController();
});

/// 管理首次激活中的提醒策略默认值，后续可平滑接入持久化。
class ReminderSettingsController extends StateNotifier<ReminderSettingsState> {
  ReminderSettingsController() : super(const ReminderSettingsState());
}
```

- [ ] **Step 4: 实现提醒策略页面，并在完成时标记 onboarding 已完成**

```dart
GoRoute(
  path: '/onboarding/reminder-setup',
  builder: (context, state) => const ReminderSetupPage(),
),
```

```dart
class ReminderSetupPage extends ConsumerWidget {
  const ReminderSetupPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              const ReminderStrategyFormSection(),
              const Spacer(),
              FilledButton(
                onPressed: () async {
                  await ref.read(launchStateRepositoryProvider).markOnboardingCompleted();
                  if (context.mounted) {
                    context.go('/');
                  }
                },
                child: const Text('完成设置，进入今日页'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
```

- [ ] **Step 5: 更新应用测试，验证默认流已变为启动分发 + 首次激活**

```dart
testWidgets('首次打开默认进入引导流，完成后进入今日页', (tester) async {
  await tester.pumpWidget(const RhythmApp());
  await tester.pumpAndSettle();

  expect(find.text('用更温和的方式，帮你把作息慢慢拨正。'), findsOneWidget);
});
```

- [ ] **Step 6: 运行本批所有测试**

Run: `flutter test test/app/launch_gate_test.dart test/features/onboarding/onboarding_flow_test.dart test/features/goal_schedule/goal_schedule_form_test.dart test/features/notifications/reminder_setup_test.dart test/app/rhythm_app_test.dart -r expanded`
Expected: PASS

- [ ] **Step 7: 提交该任务**

```bash
git add lib/features/notifications lib/app/router/app_router.dart test/features/notifications/reminder_setup_test.dart test/app/rhythm_app_test.dart
git commit -m "feat: complete onboarding reminder flow"
```

## Task 5: 整体验证与文档回写

**Files:**
- Modify: `docs/rhythm-sleep-routine-management-dev-plan-2026-05-22.md`
- Modify: `docs/superpowers/specs/2026-05-22-rhythm-module-implementation-workflow-design.md`

- [ ] **Step 1: 运行全量当前测试**

Run: `flutter test -r expanded`
Expected: PASS

- [ ] **Step 2: 手工核对 UI/UX 变更门槛是否被遵守**

检查项：
- 本次未修改 `pen/app.pen`
- 新增页面均能被现有 Pencil 设计解释
- 未引入计划外的新页面、新弹层、新步骤

Expected: 三项都成立

- [ ] **Step 3: 回写计划状态**

在 `docs/rhythm-sleep-routine-management-dev-plan-2026-05-22.md` 的阶段二条目下补一句实际实现状态，例如：

```md
- 当前首批实现限定为欢迎页、登录选择、健康权限说明、目标作息设置、提醒策略设置，不接入真实健康权限与登录服务。
```

- [ ] **Step 4: 提交该任务**

```bash
git add docs/rhythm-sleep-routine-management-dev-plan-2026-05-22.md docs/superpowers/specs/2026-05-22-rhythm-module-implementation-workflow-design.md
git commit -m "docs: record onboarding implementation scope"
```

---

## Self-Review

- Spec coverage:
  - 已覆盖第一批模块：启动分发、欢迎页、登录选择、健康权限说明、目标作息设置、提醒策略设置、完成后进入今日页。
  - 已覆盖 UI/UX 变更门槛：明确“本次不改 Pencil，只按既有设计实现”。
  - 已覆盖测试：启动分发、引导流、目标设置、提醒策略、应用入口。

- Placeholder scan:
  - 无 `TBD`、`TODO`、`稍后实现` 之类占位。
  - 每个任务都给了明确文件、测试与命令。

- Type consistency:
  - `LaunchStateRepository`、`OnboardingFlowController`、`GoalScheduleFormController`、`ReminderSettingsController` 命名在任务内保持一致。
  - 路由统一使用 `/launch`、`/onboarding/welcome`、`/onboarding/goal-setup`、`/onboarding/reminder-setup`。

## Execution Handoff

Plan complete and saved to `docs/superpowers/plans/2026-05-22-onboarding-goal-schedule-implementation.md`. Two execution options:

1. Subagent-Driven (recommended) - I dispatch a fresh subagent per task, review between tasks, fast iteration
2. Inline Execution - Execute tasks in this session using executing-plans, batch execution with checkpoints

Which approach?
