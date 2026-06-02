# insights_recovery 实现 RD

> 配对 UI/UX RD：`docs/rd/modules/insights_recovery/insights_recovery.ui-ux.md`
> 全局基线：`docs/rd/2026-06-02-rhythm-commercial-global-rd.md`
> 工作流状态：`modules_split`

## 1. 业务能力与边界

负责周报生成、稳定度规则、原因分布、恢复计划和洞察页面状态。不负责底层记录读取、标签保存或会员购买。

## 2. 继承包栈

- `collection`
- `freezed_annotation`
- `riverpod_annotation`
- `fl_chart`

## 3. 领域模型

- `WeeklyReport`
- `WeeklyReportDaySnapshot`
- `WeeklyReportSummary`
- `ReasonDistributionItem`
- `StabilityScore`
- `RecoveryPlan`
- `RecoveryPlanStep`
- `RecoveryPlanStatus`

## 4. 应用状态

- 无记录
- 数据不足
- 周报可生成
- 恢复计划可用
- 高级解释锁定
- 历史入口锁定

## 5. 基础设施与数据依赖

依赖：

- `sleep_records` 有效记录
- `calendar_tags` 原因标签
- `goal_schedule` 目标基准
- `membership_paywall` 付费策略

周报和恢复计划可先本地规则生成，后续再同步摘要。

## 6. 数据与安全

周报摘要可同步；原始健康时间不进入埋点。恢复建议必须避免医疗化表达。

## 7. 埋点

- `weekly_report_viewed`
- `recovery_plan_viewed`
- `recovery_plan_completed`
- `stability_explainer_opened`
- `insights_history_viewed`

## 8. 测试范围

- 周报窗口
- 样本不足
- 达标率
- 原因分布
- 稳定度评分
- 恢复计划触发和完成
- 付费锁定策略

## 9. 实现约束

领域层不得写最终展示文案，只输出可被本地化解析的类型、等级或文案 key。
