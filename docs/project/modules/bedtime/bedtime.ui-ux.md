# bedtime UI/UX RD

## 文档状态

- uiux_status：`split_draft`
- 当前阶段：`modules_split`

## 模块目标与目标用户

`bedtime` 负责晚间执行场景，让用户在接近睡前时进入一个更聚焦、更低干扰的执行路径。

## 页面范围与导航入口

- 睡前模式首页
- 当前步骤详情
- 晚间状态选择 / 标记

导航入口：today 首页、通知深链、底部 tab、桌面小组件。

## 核心用户路径

1. 用户从 today 或通知进入 bedtime。
2. 查看当前步骤与剩余时间。
3. 选择状态、完成动作或跳到下一步。
4. 必要时记录原因标签或恢复线索。

## 状态矩阵

| 状态 | 表现 |
| --- | --- |
| ideal | 当前步骤与下一步清晰可执行 |
| loading | 当前任务与状态按钮骨架 |
| empty | 尚未生成晚间步骤 |
| error | 任务读取或状态提交失败 |
| permission | 通知/健康相关增强能力受限 |
| partial_data | 部分步骤不可用，但主动作可继续 |
| disabled | 当前步骤不可跳转或不可完成 |
| success | 步骤完成、状态更新成功 |
| locked_or_premium | 某些高级恢复建议可锁定 |

## 结构语义

- scroll_model：`whole-page scroll`
- list_model：`static block`
- overlay_model：`mixed`
- layout_model：`layered`
- sticky_model：`sticky footer`
- component_repeatability：
  - current-step hero
  - action chip row
  - bedtime status selector
  - next-step queue item

## 模块级非页面组件骨架

- `current-step-card`
- `status-choice-chip`
- `next-step-queue-row`
- `completion-footer-action`

## 设计源

- 继承共享冻结的 warm planner 体系
- 视觉语气应比 today 更聚焦、更低干扰，但不能跳成完全不同的暗黑或疗愈插画风
- 模块预览默认不生成

## 设计冻结卡

- 待冻结项：当前步骤主卡、底部执行区、状态选择区、通知进入后的首屏层级

## 验收门槛

- UI/UX：进入 bedtime 后 1 屏内能立刻执行当前步骤
- 模块设计冻结：当前步骤、状态选择、完成动作三者层级清晰
- 代码交接：today / bedtime / sleep-data-core 的状态流边界明确

## 开放问题

- bedtime 是否需要专属更沉浸的色温变化，还是完全沿用 today light theme？
- 原因标签属于 bedtime 内部，还是提交后交给 sleep-data-core 详情流程？
