# insights 实现 RD

> 产物类型：`module_impl_rd`
> 模块：`insights`
> 文档成熟度：`split_draft`
> 日期：`2026-06-08`

## 1. 关联引用

- 配对 UI/UX RD：`docs/rd/modules/insights/insights.ui-ux.md`
- 全局技术基线：`docs/rd/global-technical-baseline.md`

## 2. 业务能力与边界上下文

`insights` 负责周级/阶段性解释与付费承接。  
它消费既有结果与行为线索，不拥有底层记录，也不独立定义数据来源可信规则。

## 3. 继承的全局包栈与模块用法

- `hooks_riverpod` / `riverpod_annotation`：报告状态与付费入口装配
- `fl_chart`：如需要图表表达
- `purchases_flutter`：会员锁定态与升级入口语义
- `intl`：周报与日期格式化

## 4. 领域模型与应用状态

- 视图模型：
  - `WeeklyReportSummary`
  - `StabilityInsight`
  - `DelayReasonDistribution`
  - `RecoveryPlanPreview`
  - `PremiumInsightLockState`
- 应用状态：
  - 周报生成状态
  - 恢复计划摘要状态
  - 高级锁定状态

## 5. 基础设施依赖与展示边界

- 依赖：
  - `sleep-data-core` 的记录、恢复与标签数据
  - 会员权益模型
- 展示边界：
  - 只展示解释与入口
  - 不在 UI 层定义商业规则

## 6. 模块级组件实现说明

- 恢复计划卡必须复用 Today 的恢复语义，只在深度和上下文上扩展。
- 会员锁定区要消费统一权益模型，而不是靠页面写死布尔值。

## 7. API、存储、权限与后端协作

- 无强制独立 API
- 可依赖本地聚合或后续云报告结果
- 若未来引入高级报告远端生成，本模块只消费归一报告 DTO

## 8. 数据、安全、埋点、监控、测试范围

- 埋点：
  - `weekly_report_viewed`
  - `recovery_plan_viewed`
  - `paywall_viewed`
  - `trial_started`
  - `subscription_purchased`
- 监控：
  - 周报生成失败
  - 高级入口点击但转化低
- 测试：
  - 周报聚合展示测试
  - 锁定边界测试
  - 付费承接来源测试

## 9. 实现顺序与依赖说明

- 依赖 `today`、`bedtime`、`calendar` 已有稳定上游口径
- 与 `profile-settings` 同属 `stage-4`
- 不建议早于主闭环模块落地

## 10. 模块特定实现约束

- 不得把 Insights 做成医学评分页。
- 不得在本模块自行定义与其他模块冲突的会员边界。
- 不得用强打断方式强推付费。

## 11. 细化执行溯源

- `superpowers_refinement_status`: `not_executed`
- `superpowers_refinement_notes`: `当前文档为初始模块拆分草案，尚未经过模块级 @superpowers 细化执行`

## 12. 开放问题

- 高级报告是否首发完整上线，仍需业务确认。
