# Insights Recovery Implementation RD

## 1. 关联文档

- 配对 UI/UX RD：[insights-recovery.ui-ux.md](D:/Projects/Flutter/rhythm/docs/rd/modules/insights-recovery/insights-recovery.ui-ux.md)
- 全局技术基线：[01-global-technical-baseline.md](D:/Projects/Flutter/rhythm/docs/rd/01-global-technical-baseline.md)

## 2. 业务能力与边界

- 业务能力：周报聚合、稳定度、原因分布、恢复计划详情、高级历史洞察。
- 有界上下文：拥有复盘与解释逻辑，不拥有底层记录采集和账号结算。

## 3. 继承的全局技术栈与模块使用说明

- 数据：规则驱动的周报与恢复计算，后续可被更高级算法替换
- 图表：使用现有图表栈承载轻量可解释图形
- 商业化：只消费 `account-sync-membership` 提供的权益状态

## 4. 领域模型与应用状态

- 领域对象：`WeeklyReport`、`RecoveryPlan`、`StabilityScoreRules` 相关结果
- 应用状态：摘要加载、周报详情、锁定内容、恢复详情打开状态

## 5. 基础设施依赖与表现边界

- 依赖 `sleep-records` 的有效记录与标签数据。
- 依赖 `schedule-reminders` 的时间基准。
- 表现层负责解释，不负责重新定义所有底层规则。

## 6. API / 仓储 / 权限 / 后端协作说明

- 周报和恢复建议首发可本地生成，必要时再叠加云端增强。
- 锁定内容需保持“可见边界 + 升级理由”，不做硬黑盒。

## 7. 数据、安全、埋点、监控、发布与测试范围

- 数据：周报快照、恢复计划、历史报告索引
- 安全：解释文本与聚合结果不携带不必要个人明细
- 埋点：`weekly_report_viewed`、`recovery_plan_viewed`、稳定度解释点击、洞察付费入口点击
- 监控：周报生成失败、报告历史加载失败、锁定逻辑异常
- 测试：周报规则测试、恢复计划测试、锁定态测试、摘要与详情一致性测试

## 8. 模块约束

- 不允许把洞察页做成无解释的数据仪表盘。
- 不允许在本模块内重写会员权益判断。
- 实现阶段在设计冻结后不得擅自改变免费/付费信息层级。
