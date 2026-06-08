# calendar 实现 RD

> 产物类型：`module_impl_rd`
> 模块：`calendar`
> 文档成熟度：`split_draft`
> 日期：`2026-06-08`

## 1. 关联引用

- 配对 UI/UX RD：`docs/rd/modules/calendar/calendar.ui-ux.md`
- 全局技术基线：`docs/rd/global-technical-baseline.md`

## 2. 业务能力与边界上下文

`calendar` 负责历史趋势可视化与单日解释。  
它不生成原始记录，也不负责稳定度模型定义，只消费统一历史口径并放大解释。

## 3. 继承的全局包栈与模块用法

- `hooks_riverpod` / `riverpod_annotation`：历史聚合状态与筛选装配
- `fl_chart`：若需要趋势辅助图
- `intl`：日期与本地化格式
- `collection`：分组与聚合辅助

## 4. 领域模型与应用状态

- 视图模型：
  - `CalendarViewState`
  - `CalendarHeatmapCell`
  - `CalendarFilterMode`
  - `DayDetailSummary`
- 应用状态：
  - 当前月份
  - 当前筛选模式
  - 选中日期
  - 历史锁定状态

## 5. 基础设施依赖与展示边界

- 依赖：
  - `sleep-data-core` 的日级记录与目标偏移口径
  - 会员/锁定边界模型
- 展示边界：
  - 不直接计算原始记录可信度
  - 不直接操作修正写入，只提供入口

## 6. 模块级组件实现说明

- 热力图颜色表达必须围绕“相对目标偏移”而不是简单时长。
- 单日详情卡应复用 Today 的结果语义，不得自行发明另一套解释语言。

## 7. API、存储、权限与后端协作

- 无独立 API
- 读取历史聚合数据与锁定边界
- 若未来引入高级历史同步，本模块只消费归一结果

## 8. 数据、安全、埋点、监控、测试范围

- 埋点：
  - `calendar_viewed`
  - `calendar_day_opened`
  - `paywall_source_clicked`
- 监控：
  - 历史聚合失败
  - 热力图渲染性能
- 测试：
  - 月度聚合测试
  - 热力图状态测试
  - 历史锁定边界测试

## 9. 实现顺序与依赖说明

- 依赖 `app-shell`、`sleep-data-core`、`onboarding-activation`
- 与 `today`、`bedtime` 同属 `stage-3`
- 为 `insights` 提供长期历史语义补充

## 10. 模块特定实现约束

- 不得将 Calendar 做成纯技术图表页。
- 不得混淆“无数据”和“会员锁定”。
- 不得在 UI 层手写复杂历史聚合逻辑。

## 11. 细化执行溯源

- `superpowers_refinement_status`: `not_executed`
- `superpowers_refinement_notes`: `当前文档为初始模块拆分草案，尚未经过模块级 @superpowers 细化执行`

## 12. 开放问题

- 历史锁定的精确阈值、月报关系和升级时机仍需确认。
