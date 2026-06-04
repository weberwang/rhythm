# insights UI/UX RD

> 本文件对应 `flutter-workflow-orchestrator --auto` 的 `module_uiux_refinement` 阶段，按 `flutter-rd-module-splitter` 的细化契约由 `@superpowers` 收敛到实现前粒度；本文记录的是该阶段完成后的冻结输入。

## 模块目标与目标用户

- 模块目标：冻结“复盘、解释、付费承接”的层级，让用户先获得行动解释，再看到升级价值。
- 目标用户：已经形成回访习惯、开始关心稳定度、恢复效果和长期趋势的用户。

## 页面范围与导航入口

- 洞察 tab 主页面
- 周报入口
- 稳定度解释区
- 恢复效果区
- 原因分布区
- 月报/高级报告入口

## 核心用户路径

1. 用户先看到本周达标率与一句结论。
2. 再看稳定度解释与主要原因。
3. 需要时查看恢复效果或打开周报/月报。
4. 在高意图点进入付费墙。

## 状态矩阵

| 状态 | 处理 |
| --- | --- |
| not_enough_data | 解释为什么暂时无法给出稳定度 |
| partial_data | 继续展示已有摘要 |
| recovery_locked | 显示可获得的改善 |
| history_locked | 展示高级报告边界 |
| weekly_report_ready | 高亮报告入口 |

## 结构语义

- `scroll_model`: whole-page scroll
- `list_model`: mixed
- `overlay_model`: none
- `layout_model`: linear
- `sticky_model`: none
- `component_repeatability`:
  - 周摘要卡
  - 稳定度解释卡
  - 原因分布块
  - 恢复效果卡
  - 报告入口卡

## 模块级组件骨架

- `WeeklyAdherenceCard`
- `StabilityExplanationCard`
- `DelayReasonDistributionBlock`
- `RecoveryOutcomeCard`
- `ReportEntryCard`

## 设计源

- 共享设计包：`docs/rd/02-shared-design-packet.md`
- 共享冻结：`docs/rd/global-design-guidelines.md`
- 模块视觉证据：`docs/rd/modules/insights/insights-weekly-report.png`
- 本模块冻结包：本文 + `insights.impl.md` + 共享冻结产物 + 模块预览图

## 设计冻结卡

- 已冻结：
  - 图表/数字旁必须有一句可执行结论
  - 付费触点只能出现在高意图区块
  - 页面不做复杂 BI dashboard
- 允许工程调整：
  - 分布图的图形形式
  - 周报入口的 CTA 文案细节

## 验收门槛

- 洞察页主任务必须是“理解与下一步”，不是“观看报表”。
- 高级能力锁定态必须先展示价值，再展示升级。
- 稳定度、恢复效果、原因分布三者不能同时争夺首屏主焦点。
