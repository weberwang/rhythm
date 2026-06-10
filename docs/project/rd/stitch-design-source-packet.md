# Rhythm Stitch Design Source Packet

## 基本信息

- packet_scope：`shared_global_only`
- design_source_adapter：`stitch`
- stitch_project_mode：`existing`
- stitch_project_id：`7107477570523131437`
- stitch_design_system_asset：`assets/f3ea82f0764442039cbf2a516710dd77`
- source_design_md：[DESIGN.md](/E:/Projects/flutter/rhythm/DESIGN.md)
- source_visual_evidence：[rhythm-prd-only-option-2-ordered-planner.png](/E:/Projects/flutter/rhythm/docs/project/design/recommendations/rhythm-prd-only-option-2-ordered-planner.png)
- shared_design_master：[stitch-shared-design-master.md](/E:/Projects/flutter/rhythm/docs/project/rd/stitch-shared-design-master.md)
- global_guidelines：[global-design-guidelines.md](/E:/Projects/flutter/rhythm/docs/project/rd/global-design-guidelines.md)
- light_theme：[light-theme-freeze.yaml](/E:/Projects/flutter/rhythm/docs/project/rd/light-theme-freeze.yaml)
- dark_theme：[dark-theme-freeze.yaml](/E:/Projects/flutter/rhythm/docs/project/rd/dark-theme-freeze.yaml)

## 冻结设计源结论

- 视觉证据以 `ordered-planner` 单页效果图为唯一最终确认图。
- Stitch 已成功接收 [DESIGN.md](/E:/Projects/flutter/rhythm/DESIGN.md) 并生成项目级设计系统资产。
- 当前 packet 仅覆盖共享设计语言，不覆盖模块级页面拆分或模块私有组件。

## 共享结构契约

- shared shell：顶部页头、大卡片串联的单列长页、稳定的垂直滚动节奏。
- hierarchy：标题和时间信息最强，步骤列表其次，恢复说明和周视图摘要随后。
- component families：
  - summary/schedule cards
  - wind-down row items
  - status chips
  - recovery prompt card
  - weekly status dots
  - bottom metric summary row
- interaction posture：主任务优先、文本 CTA 克制、辅助按钮弱化。

## fidelity_critical_regions

- 睡眠窗口卡中的目标时间、时长与区间条关系
- Wind-down 卡中的开始时间胶囊、行项目层级与右侧时间
- Recovery 卡中的左文案右状态图标构图
- This week 卡中的状态点序列与底部双指标摘要

## region_classifications

- preserve_faithfully
  - 睡眠窗口双栏主信息
  - Wind-down 行项目结构
  - 周视图状态点与双指标摘要
- flutterize
  - 区间条内部细纹理
  - 图标底座的极浅层次变化
  - 极轻投影与边缘柔化
- simplify
  - 细微环境光感
  - 纯装饰性的背景柔雾感

## approved_reductions

- 若 Flutter 端难以稳定还原极轻暖雾感，可退化为纯净暖白背景，不视为设计偏离。
- 若 Stitch 后续页面恢复中出现非关键微阴影差异，可保留浅边框层级作为主依据。

## unresolved_visual_mismatches

- `none`

## next_gate

- 下一流程技能：`flutter-design-freeze-gate`
- 目标：`shared_pre_split`
- 预期决策：`frozen_shared_for_split`
