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

## 9. 页面级状态与路由合同

- 路由入口：
  - 主导航首页、启动完成默认落点、通知回流和小组件回流都进入今日页。
  - 快捷动作只可深链到睡前、补录、日历详情或洞察，不重新定义底层模块路由。
- 页面状态所有权：
  - 今日页拥有昨晚结果主卡、今晚动作次卡与恢复摘要的聚合状态。
  - 快捷动作区拥有来源上下文和局部可用性状态，不拥有业务规则。
  - 趋势与会员承接只拥有次级解释态，不拥有首焦点。
- 返回行为：
  - 从快捷动作进入子模块返回后，今日页必须保留回流上下文并刷新局部卡片。
  - 通知或小组件回流时必须把主结果卡与当前主动作恢复到首屏可见区域。

## 10. 设计源消费与实现边界

- 实现必须直接消费 [today-feedback.ui-ux.md](D:/Projects/Flutter/rhythm/docs/rd/modules/today-feedback/today-feedback.ui-ux.md) 中定义的 `last_night_result_card`、`tonight_plan_card`、`recovery_summary_card`、`quick_action_strip` 组件边界。
- 首页只能保留一个主结果焦点；趋势、会员和管理入口只能作为 secondary/support 层，不能在实现中并列升格。
- 聚合计算、恢复建议规则和快捷动作可用性判断只能在应用层或服务层完成；显示层只消费已归一化的首页 view state。
