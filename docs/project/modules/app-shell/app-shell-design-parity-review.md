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
- 自动校验：`dart analyze lib test integration_test` 通过；`flutter test` 相关 widget tests 通过；`integration_test/app_shell_bootstrap_test.dart` 已在 Android 模拟器 `emulator-5554 / API 35` 上通过

## review_dimensions

### structure

- `startup-gate` 的单焦点结构基本成立。
- `root-shell`、`bottom-tab-bar`、`overlay host` 缺少同尺度真实运行截图，当前无法完成结构级验收。

### visual

- 已落地主题、圆角、边框和暖白背景语义与冻结方向一致。
- onboarding 运行图可见大标题、留白和卡片世界基本贴近冻结风格。
- `root-shell` 的 safe-area header gap 与底部 tab 锚定缺少真实运行画面对照，仍不能判定通过。

### state

- `startup_loading`、`startup_failed`、`blocked handoff` 已有测试证据，且 blocked fallback 已改为“说明 + 单一主动作”，与冻结状态一致。
- `overlay_success` 已接入启动恢复链路，`root-shell` 会消费全局 overlay 队列；`overlay_warning`、`overlay_error` 仍缺真实运行截图。

### motion

- `deep-link-handoff` 已区分 blocked fallback 的人工回退动作，非 blocked handoff 仍保持自动过渡。
- overlay 进出场与优先级调度已有自动测试，但仍缺真实运行截图佐证。

## gap_list

1. `P1`
   当前只有 [app-shell-runtime-onboarding-web-390x844.png](/E:/Projects/flutter/rhythm/docs/project/modules/app-shell/app-shell-runtime-onboarding-web-390x844.png) 一张运行态截图，缺少 root-shell、tab active、deep-link handoff、overlay 成功态的同尺度证据，按审查规则不能直接通过模块验收。
2. `P1` [integration_test/app_shell_runtime_capture_test.dart](/E:/Projects/flutter/rhythm/integration_test/app_shell_runtime_capture_test.dart)
   运行态截图采集链路在 Windows 集成测试环境下依赖 `integration_test` 的原生截图通道，当前会抛出 `MissingPluginException(captureScreenshot)`；需要改为 Android 模拟器可稳定执行的截图方式，或转为 adb / 原生截图采集方案。
3. `P2`
   Android 模拟器人工截图出现过仅显示底部 tab、主体内容空白的中间态画面；自动 bootstrap 集成测试未复现该问题，后续补正式运行证据时仍需复核截图时机与冷启动状态是否一致。

## severity

- 总体结论：`未通过`
- 最高严重级别：`P1`

## fix_owner

- 代码修复：`flutter-dev`
- 若后续发现冻结文档与实现目标冲突，再回 `flutter-design-source-control`

## needs_design_workflow_rollback

- `false`

## review_notes

- 当前剩余问题以运行证据缺口和截图链路不稳定为主，不再是设计源与实现逻辑冲突。
- Android 模拟器上的启动链路已经过自动验证，但在补齐 root-shell、handoff、overlay 成功态截图前，仍不应把 `app-shell` 记为最终验收通过。
