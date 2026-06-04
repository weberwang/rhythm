# bedtime UI/UX RD

> 本文件对应 `flutter-workflow-orchestrator --auto` 的 `module_uiux_refinement` 阶段，按 `flutter-rd-module-splitter` 的细化契约由 `@superpowers` 收敛到实现前粒度；本文记录的是该阶段完成后的冻结输入。

## 模块目标与目标用户

- 模块目标：冻结“今晚执行页”的单任务焦点，让用户在最少操作内完成状态选择与轻收尾动作。
- 目标用户：到点后被提醒进入、想尽快做出今晚决策的用户。

## 页面范围与导航入口

- 睡前模式主页
- 今晚状态选择
- 轻收尾动作卡

## 核心用户路径

1. 用户从通知、小组件或今日页进入。
2. 首屏看到距离目标还有多久。
3. 选择今晚状态。
4. 执行一个轻收尾动作或延后。

## 状态矩阵

| 状态 | 处理 |
| --- | --- |
| before_target | 展示倒计时与收尾建议 |
| likely_delay | 显示恢复前置提示 |
| notification_off | 轻提示去开启 |
| session_completed | 展示明日期待结果 |
| interrupted | 保留当前选择草稿 |

## 结构语义

- `scroll_model`: whole-page scroll
- `list_model`: static block
- `overlay_model`: bottom action area
- `layout_model`: linear
- `sticky_model`: sticky footer
- `component_repeatability`:
  - 倒计时环
  - 状态选择卡
  - 轻动作建议卡

## 模块级组件骨架

- `BedtimeCountdownRing`
- `BedtimeStatusChoiceGrid`
- `WindDownActionCard`
- `ReminderAdjustmentChip`

## 设计源

- 共享设计包：`docs/rd/02-shared-design-packet.md`
- 共享冻结：`docs/rd/global-design-guidelines.md`
- 模块视觉证据：`docs/rd/modules/bedtime/bedtime-mode.png`
- 本模块冻结包：本文 + `bedtime.impl.md` + 共享冻结产物 + 模块预览图

## 设计冻结卡

- 已冻结：
  - 首屏必须以时间与决策为主，而不是说明文案
  - 状态选择不超过三类
  - 页面低刺激但 CTA 必须清楚
- 允许工程调整：
  - 倒计时环具体实现
  - 背景装饰层简化

## 验收门槛

- 从通知进入后，关键路径不超过 3 次点击。
- 用户必须能在首屏完成“判断 -> 选择 -> 执行”。
- 页面不能退化成复杂习惯追踪仪表盘。
