# calendar UI/UX RD

> 本文件对应 `flutter-workflow-orchestrator --auto` 的 `module_uiux_refinement` 阶段，按 `flutter-rd-module-splitter` 的细化契约由 `@superpowers` 收敛到实现前粒度；本文记录的是该阶段完成后的冻结输入。

## 模块目标与目标用户

- 模块目标：冻结长期趋势与单日解释的结构，让用户看到“相对目标偏移”而不是原始数字堆砌。
- 目标用户：想理解最近一月作息波动和单日偏离原因的用户。

## 页面范围与导航入口

- 日历 tab 主页面
- 月度摘要
- 热力图
- 筛选模式
- 单日详情入口

## 核心用户路径

1. 用户进入日历页，先看到月度摘要。
2. 在热力图中按目标偏移理解整体节奏。
3. 切换筛选模式。
4. 点进单日，理解来源、偏移和标签。

## 状态矩阵

| 状态 | 处理 |
| --- | --- |
| no_data | 解释未记录/待补录 |
| partial_data | 标明部分数据 |
| manual_adjusted | 单日详情标识修正 |
| history_locked | 展示免费边界与升级价值 |
| timezone_shift | 单日解释暂停普通判断 |

## 结构语义

- `scroll_model`: whole-page scroll
- `list_model`: mixed
- `overlay_model`: modal layer
- `layout_model`: mixed
- `sticky_model`: sticky tab/filter
- `component_repeatability`:
  - 月度摘要卡
  - 热力图网格
  - 筛选 segmented control
  - 单日详情 row

## 模块级组件骨架

- `MonthlySummaryCard`
- `SleepOffsetHeatmap`
- `CalendarFilterSwitcher`
- `DayDetailSheet`

## 设计源

- 共享设计包：`docs/rd/02-shared-design-packet.md`
- 共享冻结：`docs/rd/global-design-guidelines.md`
- 模块视觉证据：`docs/rd/modules/calendar/calendar-heatmap.png`
- 本模块冻结包：本文 + `calendar.impl.md` + 共享冻结产物 + 模块预览图

## 设计冻结卡

- 已冻结：
  - 热力图颜色表达“相对目标偏移”
  - 单日点击后必须有解释，不只展示数字
  - 历史锁定应先显示边界，再给升级入口
- 允许工程调整：
  - 热力图绘制方案
  - 单日详情是 bottom sheet 还是 pushed detail

## 验收门槛

- 热力图必须能在视觉上区分接近目标、轻微偏离、明显偏离、缺失。
- 筛选切换不能破坏热力图主体的可读性。
- 单日详情必须携带来源与修正状态。
