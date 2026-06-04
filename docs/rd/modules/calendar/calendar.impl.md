# calendar 实现 RD

> 本文件对应 `flutter-workflow-orchestrator --auto` 的 `module_uiux_refinement` 阶段，按 `flutter-rd-module-splitter` 的细化契约由 `@superpowers` 收敛到实现前粒度；本文记录的是该阶段完成后的冻结输入。

## 文档关系

- 配对 UI/UX 文档：`docs/rd/modules/calendar/calendar.ui-ux.md`
- 继承全局基线：`docs/rd/01-global-technical-baseline.md`

## 业务能力与边界

- 负责：
  - 月度记录聚合
  - 热力图筛选与渲染
  - 单日详情入口
- 不负责：
  - 周报深度解释

## 继承的全局包栈

- `hooks_riverpod`
- `collection`
- `intl`

## 领域模型与应用状态

- `CalendarOverview`
- `CalendarFilterMode`
- `DayDetailSnapshot`
- `HistoryAccessState`

## 数据/服务/插件边界

- 从 `SleepRecordRepository` 拉月视图数据
- 从 `GoalScheduleRepository` 获取目标基准
- 从 `SleepDelayTagRepository` 获取单日标签

## 导航契约与交互规则

- 单日详情为当前模块内部跳转，不跳离全局 shell
- 历史锁定点击可进入洞察/会员说明

## 埋点、安全、监控

- 埋点：
  - `calendar_viewed`
  - `calendar_filter_changed`
  - `day_detail_opened`

## 测试范围

- 目标偏移色阶映射测试
- 月度聚合边界测试
- 历史锁定态测试

## 设计冻结消费规则

- 不得把热力图改造成普通数字表格。
- 不得省略单日来源与修正标识。

## 实施顺序

1. 定义 calendar overview 聚合。
2. 落热力图与筛选状态。
3. 落单日详情与锁定态。
4. 接入真实历史边界与跳转。
