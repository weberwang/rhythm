# Today Feedback Implementation RD

## 1. 关联文档

- 配对 UI/UX RD：[today-feedback.ui-ux.md](D:/Projects/Flutter/rhythm/docs/rd/modules/today-feedback/today-feedback.ui-ux.md)
- 全局技术基线：[01-global-technical-baseline.md](D:/Projects/Flutter/rhythm/docs/rd/01-global-technical-baseline.md)

## 2. 业务能力与边界

- 业务能力：今日首页聚合、昨晚结果摘要、今晚行动、恢复建议摘要、快捷入口。
- 有界上下文：这是聚合模块，消费多个上游能力，不拥有底层记录主数据。

## 3. 继承的全局技术栈与模块使用说明

- 状态：`TodayController` 聚合多源 provider
- 路由：作为主导航首页，负责跳向补录、睡前、设置、洞察
- 主题与本地化：严格消费全局 token 与 l10n

## 4. 领域模型与应用状态

- 领域对象：`TodaySummary`、`TodayPrimaryAction`
- 应用状态：首页加载、局部卡片失败、恢复摘要、快捷操作可用性

## 5. 基础设施依赖与表现边界

- 依赖 `sleep-records`、`schedule-reminders`、`bedtime-session`、`insights-recovery` 的摘要输出。
- 表现层不重复实现睡眠聚合和周报计算。

## 6. API / 仓储 / 权限 / 后端协作说明

- 首页聚合必须允许局部失败，不因单一数据源失败导致整页不可用。
- 高级恢复详情锁定只影响跳转或细节，不影响基础首页结果。

## 7. 数据、安全、埋点、监控、发布与测试范围

- 数据：首页摘要快照、关键操作入口状态
- 安全：不在首页日志输出原始敏感健康载荷
- 埋点：首页曝光、快捷动作点击、恢复建议查看、首页付费入口点击
- 监控：聚合失败来源分类、首页空态比例
- 测试：局部失败降级测试、空态测试、明显晚睡优先恢复测试

## 8. 模块约束

- 不允许把首页做成另一个洞察页。
- 不允许让高级锁定遮挡基础结果可见性。
- 实现阶段在设计冻结后不得擅自重排首屏信息优先级。
