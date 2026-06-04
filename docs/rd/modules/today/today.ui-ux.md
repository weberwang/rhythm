# today UI/UX RD

> 本文件对应 `flutter-workflow-orchestrator --auto` 的 `module_uiux_refinement` 阶段，按 `flutter-rd-module-splitter` 的细化契约由 `@superpowers` 收敛到实现前粒度；本文记录的是该阶段完成后的冻结输入。

## 模块目标与目标用户

- 模块目标：冻结“每日回访首页”的信息优先级，让用户一眼看到昨晚结果、今晚目标和下一步。
- 目标用户：每天打开 App 想快速判断自己状态与今晚行动的用户。

## 页面范围与导航入口

- 今日 tab 首页
- 快捷记录入口
- 7 日趋势区块

## 核心用户路径

1. 用户打开首页，先看到昨晚结果。
2. 立即看到今晚目标与提醒状态。
3. 若昨晚偏移明显，优先看到恢复建议。
4. 需要时进入快捷记录或转入睡前页。

## 状态矩阵

| 状态 | 处理 |
| --- | --- |
| permission_missing | 权限价值解释 + 手动路径 |
| no_data | 解释数据为空 + 补录入口 |
| on_target | 正向但克制反馈 |
| slight_delay | 温和提示 |
| major_delay | 恢复建议优先 |
| sync_failed | 轻提示 + 重试 |
| manual_adjusted | 显示修正来源 |
| recovery_locked | 展示升级价值 |

## 结构语义

- `scroll_model`: whole-page scroll
- `list_model`: static block
- `overlay_model`: bottom action area
- `layout_model`: linear
- `sticky_model`: none
- `component_repeatability`:
  - 昨晚结果卡
  - 今晚目标卡
  - 恢复建议卡
  - 快捷记录卡
  - 趋势卡

## 模块级组件骨架

- `LastNightResultCard`
- `TonightGoalCard`
- `RecoverySuggestionCard`
- `QuickRecordCard`
- `SevenDayTrendCard`

## 设计源

- 共享设计包：`docs/rd/02-shared-design-packet.md`
- 共享冻结：`docs/rd/global-design-guidelines.md`
- 模块视觉证据：`docs/rd/modules/today/today-dashboard.png`
- 本模块冻结包：本文 + `today.impl.md` + 共享冻结产物 + 模块预览图

## 设计冻结卡

- 已冻结：
  - 首屏顺序必须是结果 -> 目标 -> 恢复/记录
  - 趋势区块只做解释，不得抢首屏
  - 免费用户也必须能读懂昨晚结果
- 允许工程调整：
  - 趋势图具体绘制方式
  - 恢复建议卡内部插图简化

## 验收门槛

- 首屏 3 秒内必须回答“昨晚怎么样 / 今晚做什么”。
- 明显晚睡场景必须让恢复建议进入主路径。
- 今日页不可退化成多组件拼盘式 dashboard。
