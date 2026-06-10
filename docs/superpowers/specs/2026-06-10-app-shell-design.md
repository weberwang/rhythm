# App Shell Implementation Spec

## Goal

让 Rhythm 具备一个稳定、可运行、可继续扩展的根级壳层。这个壳层必须负责：

- 冷启动分发
- 根级路由宿主
- 底部 tab 壳层
- 通知 / 小组件 deep link 承接
- 全局 overlay 反馈

并且不能侵入 feature 业务规则。

## Success Criteria

- 应用可通过真实 `main.dart` 启动，并进入 `MaterialApp.router`
- 冷启动能稳定落到 onboarding、today 或 handoff 过渡态
- 根级 tab shell 能保持 5 个一级入口并在切换时保留 branch 状态
- 全局 overlay host 有统一入口和优先级规则
- `app-shell` 之外的 feature 仍保持占位，不把业务逻辑倒灌回壳层
- `flutter analyze`、`flutter test`、`build_runner` 通过

## In Scope

- `main.dart`
- app entry 容器
- root router host
- startup gate
- deep-link handoff page
- root shell page
- root tab bar
- app-shell 启动状态聚合
- app-shell tab 状态聚合
- shared_preferences / secure_storage 最小读取基线
- 全局 logger / error mapper / placeholder page

## Out Of Scope

- onboarding 真实业务流程
- today / bedtime / calendar / insights / profile-settings 真正页面
- drift / supabase / purchases / health 真实运行时接线
- 深链 payload 的真实平台解析
- 全局 overlay 的复杂动画系统

## Approved Design Constraints

- 共享视觉基线仍然是 [rhythm-prd-only-option-2-ordered-planner.png](/E:/Projects/flutter/rhythm/docs/project/design/recommendations/rhythm-prd-only-option-2-ordered-planner.png)
- `app-shell` 模块预览证据是 [app-shell-root-preview.png](/E:/Projects/flutter/rhythm/docs/project/modules/app-shell/app-shell-root-preview.png)
- 顶部安全区留白、底部 tab 锚定、active/inactive 层级必须忠实保留
- startup gate 必须保持单焦点 loading / error / retry 结构
- deep-link handoff 必须是短暂、中性、不打断主链路的过渡

## Runtime Behavior

### Cold Start

输入：

- onboarding completion flag
- secure session existence
- initial deep link payload

输出：

- redirect -> onboarding
- redirect -> today
- handoff -> target feature
- failure -> startup error shell

### Root Shell

- `root-shell` 是唯一 bottom-tab 宿主
- body 区域只承载当前 feature branch
- tab bar 永远固定在底部安全区上方
- 点击已激活 tab 时默认回到该 branch 根栈顶

### Deep Link Handoff

- 先显示过渡态
- 满足条件则进入目标模块
- 条件不足时回 onboarding 或 today
- 不允许直接让 feature 页面各自解释 root deep link

### Global Overlay

优先级：

1. blocking error
2. success banner
3. info toast

feature 只能上报事件，不能各自接管显示容器。

## State Ownership

### app-shell owns

- `startup_gate_state`
- `root_redirect_state`
- `current_tab_state`
- `global_overlay_queue`
- `incoming_deep_link_state`

### feature owns

- today / bedtime / calendar / insights / profile-settings 业务状态
- feature 内部 loading / error / permission / empty 细节

## File Responsibilities

- [main.dart](/E:/Projects/flutter/rhythm/lib/main.dart)
  - 唯一应用主入口
- [rhythm_bootstrap_app.dart](/E:/Projects/flutter/rhythm/lib/app/entry/rhythm_bootstrap_app.dart)
  - ProviderScope、ScreenUtil、MaterialApp.router 容器
- [app_router.dart](/E:/Projects/flutter/rhythm/lib/app/router/app_router.dart)
  - 根路由树、shell route、bootstrap 阶段的 feature 占位 branch
- [rhythm_theme.dart](/E:/Projects/flutter/rhythm/lib/app/theme/rhythm_theme.dart)
  - 全局 theme token 映射
- [app_shell_bootstrap_controller.dart](/E:/Projects/flutter/rhythm/lib/features/app_shell/application/app_shell_bootstrap_controller.dart)
  - 冷启动状态聚合与 LaunchDecision 输出
- [app_shell_tab_controller.dart](/E:/Projects/flutter/rhythm/lib/features/app_shell/application/app_shell_tab_controller.dart)
  - 当前 tab 聚合
- [root_shell_page.dart](/E:/Projects/flutter/rhythm/lib/features/app_shell/presentation/root_shell_page.dart)
  - 根壳层布局与 tab bar
- [startup_gate_page.dart](/E:/Projects/flutter/rhythm/lib/features/app_shell/presentation/startup_gate_page.dart)
  - 冷启动分发与 handoff UI

## Acceptance Checks

- 启动路径可以稳定进入路由目标
- tab 结构与预览图中的底部壳层语义一致
- handoff 路由存在并能跳转
- 占位 feature 页面可以被根壳层承接
- provider / freezed / riverpod 生成代码通过

## Test Strategy

- 单元测试
  - onboarding flag -> route target
  - deep link -> target / fallback
  - tab selection state
- Widget 测试
  - startup gate loading / error
  - root tab bar active state
- 集成级最小检查
  - 应用能完成 bootstrap 构建与进入 router

## Risks

- 匿名升级登录后的 tab 栈恢复策略尚未冻结
- deep link 进入 bedtime 时的 tab 高亮策略仍待确认
- overlay 队列未来可能需要从单条升级为真正队列模型

## Next Step

在这个 Spec 基础上进入 `@superpowers Plan`，把 `app-shell` 拆成可执行的任务批次，再继续真实 feature 实现。
