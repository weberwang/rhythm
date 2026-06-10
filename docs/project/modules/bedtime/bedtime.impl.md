# bedtime Implementation RD

## 文档状态

- impl_status：`split_draft`
- superpowers_refinement_status：`not_executed`

## 关联文档

- 配对 UI/UX：[bedtime.ui-ux.md](/E:/Projects/flutter/rhythm/docs/project/modules/bedtime/bedtime.ui-ux.md)
- 全局技术基线：[global-technical-baseline.md](/E:/Projects/flutter/rhythm/docs/project/rd/global-technical-baseline.md)

## 业务能力与边界

`bedtime` 拥有晚间执行流编排、当前步骤状态推进与原因/恢复入口承接，不拥有底层睡眠记录持久化规则本身。

## 包栈与模块说明

- `hooks_riverpod`：当前步骤、执行状态、交互反馈
- `go_router`：通知深链与返回 today / insights
- 依赖 `sleep-data-core` 获取晚间计划和提交状态结果
- 依赖通知桥接提供 deep link context

## 分层边界

- domain：晚间步骤、状态选择、执行结果值对象
- application：步骤推进、跳步、完成和回流编排
- data：读取计划、写入状态、通知入口解析
- presentation：执行页、状态选择、底部动作区

## 数据、埋点、测试

- 埋点：`bedtime_mode_entered`、`bedtime_step_completed`、`bedtime_status_selected`
- 测试：
  - 深链进入 bedtime
  - 当前步骤推进
  - 状态提交失败重试
  - 返回 today 的一致性

## 模块约束

- bedtime 不得自行定义新的主导航壳层
- bedtime 不得将通知调度逻辑直接放在页面层
- 实现必须为后续 design freeze 保留当前步骤 hero 与底部动作区的稳定结构

## 风险与开放问题

- 深链进入时如果 today 数据尚未完成刷新，bedtime 的计划来源如何回退
- 步骤完成与睡眠记录入库的事务边界如何设计
