# Calendar History Implementation RD

## 1. 关联文档

- 配对 UI/UX RD：[calendar-history.ui-ux.md](D:/Projects/Flutter/rhythm/docs/rd/modules/calendar-history/calendar-history.ui-ux.md)
- 全局技术基线：[01-global-technical-baseline.md](D:/Projects/Flutter/rhythm/docs/rd/01-global-technical-baseline.md)

## 2. 业务能力与边界

- 业务能力：长期历史聚合、热力图、筛选、单日详情。
- 有界上下文：拥有历史可视化聚合和筛选语义，不拥有原始记录写入。

## 3. 继承的全局技术栈与模块使用说明

- 状态：历史筛选与月度聚合 provider
- 图表：`fl_chart` 或既有热力图组件实现趋势可视化
- 数据：完全依赖 `sleep-records` 提供的记录与 `schedule-reminders` 的目标语义

## 4. 领域模型与应用状态

- 领域对象：`CalendarMonthSummary`、`CalendarDaySummary`、`CalendarFilter`
- 应用状态：月度加载、筛选切换、单日详情展示、历史锁定边界

## 5. 基础设施依赖与表现边界

- 依赖记录仓储聚合查询。
- 表现层不自行推断绝对“好/坏”，必须按目标偏移语义展示。

## 6. API / 仓储 / 权限 / 后端协作说明

- 历史数据分页或更长时间段若需要云端拉取，必须保留本地优先策略。
- 锁定历史范围时，只锁扩展查询与细节，不锁基础月视图可用性。

## 7. 数据、安全、埋点、监控、发布与测试范围

- 数据：月度摘要、日度详情、筛选结果
- 安全：历史详情不输出敏感载荷日志
- 埋点：日历页浏览、筛选切换、单日详情打开、历史锁定点击
- 监控：聚合失败、筛选异常、超长范围性能问题
- 测试：热力图颜色规则、筛选测试、单日详情解释测试

## 8. 模块约束

- 不允许把热力图颜色脱离目标时间基准。
- 不允许用会员锁定破坏基础历史趋势可读性。
- 实现阶段在设计冻结后不得擅自简化单日详情解释层级。
