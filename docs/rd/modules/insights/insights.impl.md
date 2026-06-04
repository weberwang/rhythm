# insights 实现 RD

> 本文件对应 `flutter-workflow-orchestrator --auto` 的 `module_uiux_refinement` 阶段，按 `flutter-rd-module-splitter` 的细化契约由 `@superpowers` 收敛到实现前粒度；本文记录的是该阶段完成后的冻结输入。

## 文档关系

- 配对 UI/UX 文档：`docs/rd/modules/insights/insights.ui-ux.md`
- 继承全局基线：`docs/rd/01-global-technical-baseline.md`

## 业务能力与边界

- 负责：
  - 周/阶段性摘要
  - 稳定度解释
  - 原因分布
  - 恢复效果
  - 高意图升级入口
- 不负责：
  - 每日首页聚合

## 继承的全局包栈

- `hooks_riverpod`
- `fl_chart`
- `intl`
- `purchases_flutter`

## 领域模型与应用状态

- `InsightsOverview`
- `StabilitySummary`
- `DelayReasonSummary`
- `RecoveryOutcomeSummary`
- `PremiumAccessState`

## 数据/服务/插件边界

- 从 `ReportComposer` 读取周报摘要
- 从 `RecoveryPlanEngine` 读取恢复效果
- 从会员 gateway 读取锁定态

## 导航契约与交互规则

- 点击周报/月报入口进入报告详情
- 点击锁定区进入 paywall，但保留返回路径

## 埋点、安全、监控

- 埋点：
  - `weekly_report_viewed`
  - `paywall_viewed`
  - `paywall_source_clicked`

## 测试范围

- 数据不足态测试
- 付费锁定态测试
- 报告入口与恢复入口映射测试

## 设计冻结消费规则

- 不得把洞察页实施成通用商业 dashboard。
- 不得在尚未产生价值感之前弹出付费墙。

## 实施顺序

1. 定义 insights overview 聚合。
2. 落稳定度与原因分布显示层。
3. 落恢复与报告入口。
4. 接入付费锁定与 paywall 触点。
