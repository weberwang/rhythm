# calendar Implementation RD

## 文档状态

- impl_status：`split_draft`
- superpowers_refinement_status：`not_executed`

## 关联文档

- 配对 UI/UX：[calendar.ui-ux.md](/E:/Projects/flutter/rhythm/docs/project/modules/calendar/calendar.ui-ux.md)
- 全局技术基线：[global-technical-baseline.md](/E:/Projects/flutter/rhythm/docs/project/rd/global-technical-baseline.md)

## 业务能力与边界

`calendar` 负责历史睡眠记录查询、按日聚合、单日详情与趋势过滤，不定义核心睡眠记录模型，只消费查询结果。

## 包栈与模块说明

- `fl_chart`：若后续趋势图采用图表方式
- `hooks_riverpod`：日期选择、过滤条件、异步查询状态
- 依赖 `sleep-data-core` 的聚合查询接口

## 分层边界

- domain：日期范围、趋势过滤值对象
- application：查询状态、日期选择与详情切换
- data：调用 sleep-data-core 查询 facade
- presentation：热力图、筛选区、单日详情页

## 埋点与测试

- 埋点：`calendar_viewed`、`calendar_day_opened`、`calendar_filter_changed`
- 测试：
  - 日期选择与详情联动
  - 空历史 fallback
  - partial data 展示

## 模块约束

- 不得让 calendar 自己重新计算另一套稳定度语义
- 不得将付费深层洞察混入基础历史浏览
- sticky filter 行为必须在后续 refinement 中显式冻结

## 风险与开放问题

- fl_chart 与热力图的职责边界
- 趋势筛选是周/月二段切换还是更多复杂过滤
