# app-shell Design Parity Review

## review_decision

- `blocked`

## design_source

- 主设计源：[app-shell.design-source-packet.md](/E:/Projects/flutter/rhythm/docs/project/modules/app-shell/app-shell.design-source-packet.md)
- 共享设计指南：[global-design-guidelines.md](/E:/Projects/flutter/rhythm/docs/project/rd/global-design-guidelines.md)
- 主题冻结：[light-theme-freeze.yaml](/E:/Projects/flutter/rhythm/docs/project/rd/light-theme-freeze.yaml)、[dark-theme-freeze.yaml](/E:/Projects/flutter/rhythm/docs/project/rd/dark-theme-freeze.yaml)
- UI/UX RD：[app-shell.ui-ux.md](/E:/Projects/flutter/rhythm/docs/project/modules/app-shell/app-shell.ui-ux.md)
- 架构产物：[app-shell.architecture.md](/E:/Projects/flutter/rhythm/docs/project/modules/app-shell/app-shell.architecture.md)

## contract_artifacts_used

- [app-shell.design-source-packet.md](/E:/Projects/flutter/rhythm/docs/project/modules/app-shell/app-shell.design-source-packet.md)
- [app-shell.ui-ux.md](/E:/Projects/flutter/rhythm/docs/project/modules/app-shell/app-shell.ui-ux.md)
- [app-shell.impl.md](/E:/Projects/flutter/rhythm/docs/project/modules/app-shell/app-shell.impl.md)
- [app-shell.architecture.md](/E:/Projects/flutter/rhythm/docs/project/modules/app-shell/app-shell.architecture.md)
- [app-shell-root-preview.png](/E:/Projects/flutter/rhythm/docs/project/modules/app-shell/app-shell-root-preview.png)
- [app-shell-runtime-onboarding-web-390x844.png](/E:/Projects/flutter/rhythm/docs/project/modules/app-shell/app-shell-runtime-onboarding-web-390x844.png)

## implementation_evidence

- 代码入口：[root_shell_page.dart](/E:/Projects/flutter/rhythm/lib/features/app_shell/presentation/root_shell_page.dart)、[startup_gate_page.dart](/E:/Projects/flutter/rhythm/lib/features/app_shell/presentation/startup_gate_page.dart)、[global_overlay_host.dart](/E:/Projects/flutter/rhythm/lib/features/app_shell/presentation/widgets/global_overlay_host.dart)
- 运行态截图：仅补到 onboarding 路径的 Web 390x844 截图；尚未补到 root-shell、deep-link handoff、overlay 成功态的真实运行证据
- 自动校验：`flutter analyze` 通过，`flutter test` 通过

## review_dimensions

### structure

- `startup-gate` 的单焦点结构基本成立。
- `root-shell`、`bottom-tab-bar`、`overlay host` 缺少同尺度真实运行截图，当前无法完成结构级验收。

### visual

- 已落地主题、圆角、边框和暖白背景语义与冻结方向一致。
- onboarding 运行图可见大标题、留白和卡片世界基本贴近冻结风格。
- `root-shell` 的 safe-area header gap 与底部 tab 锚定缺少真实运行画面对照，仍不能判定通过。

### state

- `startup_loading`、`startup_failed`、`blocked handoff` 已有测试证据，但 `deep_link_blocked` 的实现行为与冻结状态不一致。
- `overlay_success`、`overlay_warning`、`overlay_error` 缺少真正接线，当前只是宿主组件存在。

### motion

- `deep-link-handoff` 仍采用统一自动跳转，未区分 blocked fallback 的人工回退动作。
- overlay 进出场与优先级调度缺少真实运行证据。

## gap_list

1. `P0` [startup_gate_page.dart](/E:/Projects/flutter/rhythm/lib/features/app_shell/presentation/startup_gate_page.dart)
   `DeepLinkHandoffPage` 对 blocked fallback 仍然在 450ms 后自动 `go()`，没有实现 UI/UX RD 要求的“回退说明 + 单一主动作”。这会改变冻结的交互意图。
2. `P1` [root_shell_page.dart](/E:/Projects/flutter/rhythm/lib/features/app_shell/presentation/root_shell_page.dart)
   `GlobalOverlayHost` 被固定传入空事件队列，导致 `overlay_success / warning / error` 三类冻结状态没有真正接入运行链路。
3. `P1` [startup_gate_page.dart](/E:/Projects/flutter/rhythm/lib/features/app_shell/presentation/startup_gate_page.dart)
   `LaunchDecision.redirect.successMessage` 在启动分发路径中没有被消费，`sessionRestored` 的成功反馈无法进入全局 overlay。
4. `P2` [startup_gate_page.dart](/E:/Projects/flutter/rhythm/lib/features/app_shell/presentation/startup_gate_page.dart)
   `error` 分支仍有硬编码英文文案 `Unable to finish startup. Please try again.`，不符合当前项目的国际化约束。
5. `P1`
   当前只有 [app-shell-runtime-onboarding-web-390x844.png](/E:/Projects/flutter/rhythm/docs/project/modules/app-shell/app-shell-runtime-onboarding-web-390x844.png) 一张运行态截图，缺少 root-shell、tab active、deep-link handoff、overlay 成功态的同尺度证据，按审查规则不能直接通过模块验收。

## severity

- 总体结论：`未通过`
- 最高严重级别：`P0`

## fix_owner

- 代码修复：`flutter-dev`
- 若后续发现冻结文档与实现目标冲突，再回 `flutter-design-source-control`

## needs_design_workflow_rollback

- `false`

## review_notes

- 当前发现的是实现缺口和运行证据缺口，不是设计源本身冲突。
- 在补齐 blocked handoff、overlay 接线和运行截图前，不应把 `app-shell` 记为最终验收通过。
