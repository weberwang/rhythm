# app-shell 实现 RD

> 本文件对应 `flutter-workflow-orchestrator --auto` 的 `module_uiux_refinement` 阶段，按 `flutter-rd-module-splitter` 的细化契约由 `@superpowers` 收敛到实现前粒度；本文记录的是该阶段完成后的冻结输入。

## 文档关系

- 配对 UI/UX 文档：`docs/rd/modules/app-shell/app-shell.ui-ux.md`
- 继承全局基线：`docs/rd/01-global-technical-baseline.md`

## 业务能力与边界

- 负责：
  - App 启动分发
  - 根路由与 redirect
  - 主壳底部标签
  - 全局 overlay host
  - 通知/小组件/深链统一入口
- 不负责：
  - 任一业务 tab 的具体数据查询与页面内容

## 继承的全局包栈

- `go_router`
- `hooks_riverpod`
- `riverpod_annotation`

## 领域模型与应用状态

- `LaunchStatus`
- `OnboardingProgress`
- `EntryIntent`
- `ShellTab`

## 数据/服务/插件边界

- 读取匿名/登录身份、目标作息完成度、通知入口参数
- 不直接访问健康、购买、图表插件
- 所有平台入口先转成 `EntryIntent`

## 导航契约与交互规则

- 根 redirect 顺序：
  - 启动恢复
  - onboarding 完成度
  - 入口意图分发
  - tab shell 选中
- 从通知进入 `bedtime` 时允许隐藏非必要全局反馈条

## 埋点、安全、监控

- 埋点：
  - `app_open`
  - `onboarding_started`
  - `entry_intent_consumed`
- 不记录敏感 token 与深链原始参数明文

## 测试范围

- redirect 顺序测试
- 首开 vs 回访路径测试
- 通知/小组件入口映射测试

## 设计冻结消费规则

- 不得更改五标签主壳的业务信息架构。
- 允许平台级容器替换，但不允许改变 guard 链顺序。

## 实施顺序

1. 定义 root router 与 shell routes。
2. 建立 launch provider 与 entry intent provider。
3. 挂接 onboarding gate。
4. 接入全局 overlay host。
