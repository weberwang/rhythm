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

## 9. 页面级状态与路由合同

- 路由入口：
  - 主导航日历页是稳定入口，今日页和洞察页只可深链到特定日期或筛选视角。
  - 单日详情弹层与历史锁定说明属于模块内部状态，不外泄到底层记录模块。
- 页面状态所有权：
  - 月历页拥有热力图视角、筛选方式与月摘要状态。
  - 单日详情拥有来源、偏移、原因与记录跳转状态。
  - 锁定说明卡拥有免费/高级历史边界和升级说明状态。
- 返回行为：
  - 关闭单日详情后必须回到原月历滚动位置和筛选状态。
  - 从日历进入记录修正或洞察后返回时必须保留当前日期上下文。

## 10. 设计源消费与实现边界

- 实现必须直接消费 [calendar-history.ui-ux.md](D:/Projects/Flutter/rhythm/docs/rd/modules/calendar-history/calendar-history.ui-ux.md) 中定义的 `monthly_heatmap_panel`、`history_filter_chip_bar`、`day_detail_summary_card`、`history_lock_note_card` 组件边界。
- 月历热力图必须保持相对目标偏移语义和纸感轻层级，不能在实现中变成厚重财务图表或多列 dashboard。
- `fl_chart` 或同类热力可视化能力只作为绘制层实现；颜色语义、免费边界和单日解释规则由应用层统一提供。
