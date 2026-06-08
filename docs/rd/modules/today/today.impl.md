# today 实现 RD

> 产物类型：`module_impl_rd`
> 模块：`today`
> 文档成熟度：`split_draft`
> 日期：`2026-06-08`

## 1. 关联引用

- 配对 UI/UX RD：`docs/rd/modules/today/today.ui-ux.md`
- 全局技术基线：`docs/rd/global-technical-baseline.md`

## 2. 业务能力与边界上下文

`today` 负责把多个基础数据口径收敛成“今日可行动的结果页”。  
它不拥有原始睡眠数据，也不拥有睡前行为写入逻辑，只负责日级聚合展示与入口组织。

## 3. 继承的全局包栈与模块用法

- `hooks_riverpod` / `riverpod_annotation`：Today ViewState 与装配
- `go_router`：跳转到 Bedtime、Calendar 详情、Profile 设置等
- `collection`：轻量聚合辅助
- `intl`：时间与偏移文案格式化

## 4. 领域模型与应用状态

- 核心视图模型：
  - `TodayViewState`
  - `LastNightSummary`
  - `TonightGoalSummary`
  - `RecoveryPreview`
  - `TodayTrendPreview`
- 应用状态：
  - 页面加载状态
  - 补录/修正入口状态
  - 恢复建议锁定状态

## 5. 基础设施依赖与展示边界

- 依赖：
  - `sleep-data-core` 的日级记录、目标与恢复基础结果
  - `bedtime` 的进入入口
- 展示边界：
  - Today 负责主卡排序与入口暴露
  - 不直接操作底层存储或插件

## 6. 模块级组件实现说明

- 今晚行动卡和结果卡要消费统一内部模型，不允许页面自己算偏移分钟。
- 恢复卡展示免费摘要时，应与 `insights` 使用同一恢复计划语义。

## 7. API、存储、权限与后端协作

- 无独立 API
- 仅读取基础 repository 输出
- 对权限与同步只展示状态，不直接处理原生请求

## 8. 数据、安全、埋点、监控、测试范围

- 埋点：
  - `app_open`
  - `bedtime_mode_entered`
  - `recovery_plan_viewed`
- 监控：
  - Today 聚合失败
  - 关键卡片缺失率
- 测试：
  - ViewState 聚合测试
  - 空态/权限态/部分数据态 widget 测试

## 9. 实现顺序与依赖说明

- 依赖 `app-shell`、`sleep-data-core`、`onboarding-activation`
- 与 `bedtime`、`calendar` 同属主闭环阶段
- 解锁 `insights` 的更强消费场景

## 10. 模块特定实现约束

- 不得把 Today 做成结果报告页或仪表盘。
- 不得让付费入口压过首屏主任务。
- 不得自己发明新的“晚睡评分”口径。

## 11. 细化执行溯源

- `superpowers_refinement_status`: `not_executed`
- `superpowers_refinement_notes`: `当前文档为初始模块拆分草案，尚未经过模块级 @superpowers 细化执行`

## 12. 开放问题

- 趋势摘要块的免费边界与互动深度仍需后续精细化。
