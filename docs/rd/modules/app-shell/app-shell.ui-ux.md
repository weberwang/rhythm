# app-shell UI/UX RD

> 本文件对应 `flutter-workflow-orchestrator --auto` 的 `module_uiux_refinement` 阶段，按 `flutter-rd-module-splitter` 的细化契约由 `@superpowers` 收敛到实现前粒度；本文记录的是该阶段完成后的冻结输入。

## 模块目标与目标用户

- 模块目标：冻结应用启动、根跳转、底部导航壳、全局覆盖层与多入口唤起规则。
- 目标用户：首次打开用户、已完成引导用户、从通知/小组件/深链返回的回访用户。

## 页面范围与导航入口

- 启动等待态
- 引导/正式主壳分发态
- 五标签主壳：`今日 / 日历 / 睡前 / 洞察 / 我的`
- 全局 banner / snackbar / bottom sheet host

## 核心用户路径

1. App 启动后恢复身份与本地配置。
2. 判断是否需要进入 onboarding。
3. 若从通知或小组件进入，则在完成 guard 后直达对应目标页。
4. 若进入主壳，保留底部标签位置与最近访问上下文。

## 状态矩阵

| 状态 | 处理 |
| --- | --- |
| loading | 品牌等待态，不出现空白 |
| onboarding_required | 直接切入引导漏斗 |
| shell_ready | 展示正式主壳 |
| restore_failed | 显示轻错误说明并提供继续本地模式 |
| redirect_pending | 完成 guard 后再跳目标页 |

## 结构语义

- `scroll_model`: mixed
- `list_model`: static block
- `overlay_model`: modal layer
- `layout_model`: layered
- `sticky_model`: sticky footer
- `component_repeatability`:
  - 底部导航容器
  - 全局轻提示条
  - 权限修复入口条

## 模块级组件骨架

- `RootLaunchSurface`
- `RootRedirectGate`
- `MainTabShell`
- `GlobalFeedbackBanner`
- `GlobalBottomSheetHost`

## 设计源

- 共享设计包：`docs/rd/02-shared-design-packet.md`
- 共享冻结：`docs/rd/global-design-guidelines.md`
- 主题冻结：`docs/rd/light-theme-freeze.yaml`, `docs/rd/dark-theme-freeze.yaml`
- 说明：该模块没有独立页面预览图，导航标签文案与层级以本文和共享冻结为准，不以任一预览图里的示意标签为准。

## 设计冻结卡

- 已冻结：
  - 五标签主壳结构
  - 启动 guard 顺序
  - 底部导航作为全局 sticky 区
- 允许工程调整：
  - iOS / Android 容器高度适配
  - snackbar 与 banner 具体呈现组件

## 验收门槛

- 任何入口都必须先经过 root guard，再决定目标页。
- 底部导航不得喧宾夺主，不可抢占主页面首屏焦点。
- 启动等待态、恢复失败态、本地继续路径都必须可见可继续。
