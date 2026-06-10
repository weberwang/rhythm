# today UI/UX RD

## 文档状态

- uiux_status：`split_draft`
- 当前阶段：`modules_split`

## 模块目标与目标用户

`today` 是 Rhythm 的主任务首页，帮助用户快速看清今晚睡眠窗口、睡前步骤、偏离恢复入口与本周节律摘要。

## 页面范围与导航入口

- 今日首页
- 恢复计划快捷入口
- 本周摘要内的次级查看入口

导航入口：底部 tab、冷启动默认落点、完成 onboarding 后落点、通知返回落点。

## 核心用户路径

1. 用户进入今日首页。
2. 先看睡眠窗口与时长目标。
3. 再看 wind-down 列表和当前开始时间。
4. 若偏离目标，进入 recovery。
5. 最后浏览本周状态摘要。

## 状态矩阵

| 状态 | 表现 |
| --- | --- |
| ideal | 全部卡片与步骤完整展示 |
| loading | 卡片骨架、行项目骨架 |
| empty | 无昨晚数据，但仍有今晚窗口和计划入口 |
| error | 读取失败或关键区块不可用 |
| permission | 健康数据未授权，显示手动路径提示 |
| partial_data | 昨晚结果缺失，但今天计划仍可继续 |
| disabled | 某些动作不可点击 |
| success | 今日完成、恢复计划采用成功等反馈 |
| locked_or_premium | 周报或深层洞察入口可锁定 |

## 结构语义

- scroll_model：`whole-page scroll`
- list_model：`grouped list`
- overlay_model：`bottom action area`
- layout_model：`linear`
- sticky_model：`none`
- component_repeatability：
  - summary card
  - wind-down row item
  - recovery card
  - weekly status dot row

## 模块级非页面组件骨架

- `sleep-window-card`
- `wind-down-item-row`
- `recovery-summary-card`
- `weekly-status-strip`
- `metric-summary-pair`

## 设计源

- 最终确认视觉基线：[rhythm-prd-only-option-2-ordered-planner.png](/E:/Projects/flutter/rhythm/docs/project/design/recommendations/rhythm-prd-only-option-2-ordered-planner.png)
- 共享设计规则：单列长页、大圆角浅边框卡片、时间信息优先
- 模块预览：默认不生成；未来若需要对 today 做模块级视觉冻结，必须显式 `--perviewer`

## 设计冻结卡

- 待冻结项：睡眠窗口卡信息分栏、wind-down 行项目层级、recovery CTA 姿态、周视图摘要结构

## 验收门槛

- UI/UX：3 秒内看清今晚窗口、当前步骤和恢复入口
- 模块设计冻结：四个主卡区块都具备 ideal / partial / warning 语义
- 代码交接：today 消费 sleep-data-core 的读取边界明确

## 开放问题

- `Use recovery plan` 是否进入独立 recovery 页面，还是拉起底部 sheet？
- 周视图卡点击是否进入 insights，还是先进入 calendar 的当周视图？
