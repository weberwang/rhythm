# calendar UI/UX RD

## 文档状态

- uiux_status：`split_draft`
- 当前阶段：`modules_split`

## 模块目标与目标用户

`calendar` 帮用户按日期回看节律表现、单日详情与趋势变化，是 history 查询模块，而不是主任务入口模块。

## 页面范围与导航入口

- 热力图 / 日历总览
- 单日详情
- 趋势过滤与范围浏览

导航入口：底部 tab、today 周视图点击、insights 详情跳转。

## 核心用户路径

1. 用户进入 calendar。
2. 看到按日聚合的节律状态。
3. 点击某一天查看单日详情。
4. 在趋势查询中理解近期波动。

## 状态矩阵

| 状态 | 表现 |
| --- | --- |
| ideal | 热力图、日期详情、趋势切换完整 |
| loading | 热力图骨架、详情骨架 |
| empty | 还没有足够历史数据 |
| error | 查询失败或明细缺失 |
| permission | 健康授权未给，展示手动记录导向 |
| partial_data | 某些日期只有部分字段 |
| disabled | 日期不可点击或过滤条件不可用 |
| success | 某次补录成功后刷新完成 |
| locked_or_premium | 某些高级趋势分析可锁定 |

## 结构语义

- scroll_model：`whole-page scroll`
- list_model：`mixed`
- overlay_model：`modal layer`
- layout_model：`mixed`
- sticky_model：`sticky tab/filter`
- component_repeatability：
  - 日历单元
  - 单日摘要卡
  - 趋势过滤 chip
  - 记录来源行

## 模块级非页面组件骨架

- `calendar-day-cell`
- `day-detail-summary-card`
- `trend-filter-chip`
- `record-source-row`

## 设计源

- 继承共享冻结，但密度会比 today 稍高
- 不能因为是数据页就退化成冷硬仪表盘
- 模块预览默认不生成

## 设计冻结卡

- 待冻结项：日历单元状态规则、详情层级、趋势筛选区结构、sticky filter 行为

## 验收门槛

- UI/UX：查看单天和近期趋势都足够清晰
- 模块设计冻结：日期状态、详情卡与筛选区语义明确
- 代码交接：与 sleep-data-core 的查询契约足够清晰

## 开放问题

- 热力图是按睡眠完成度上色还是按窗口偏离程度上色？
- 单日详情是否需要直接展示原始来源冲突信息？
