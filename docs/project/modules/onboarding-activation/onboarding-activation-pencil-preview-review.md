# onboarding-activation Pencil Preview Review

## request_summary

- 将 `onboarding-activation` 的模块设计冻结从 `stitch` 切换到 `pencil`
- 强制先走 preview 效果图，再继续后续 Pencil 结构化重建
- 重新启动本模块设计稿流程，从代表页方向选择重新开始

## design_brief

- 设计目标：重建一个 calm、practical、single-path 的首次激活流，不是营销 onboarding，也不是系统设置页拼贴
- 平台基线：`iOS HIG / 390 x 844 px`
- 页面范围：本轮只生成代表页 `welcome-entry`
- 目标平台：`mobile`
- 目标用户与场景：首次进入 Rhythm 的晚睡用户，需要快速完成激活并进入今晚计划
- 商业目标：`activation + trust + habit`
- 艺术指导：warm porcelain 背景、sage CTA、低噪声卡片、强单列阅读秩序、quiet premium
- 状态范围：本轮代表 ideal + selected choice + sticky CTA 结构
- 禁止项：紫色渐变、梦幻疗愈风、营销插画、仪表盘密度、夸张庆祝反馈
- 验收标准：3 秒内看清步骤、主任务、主 CTA；选择卡与 footer 关系明确；适合作为后续 Pencil 重建基准

## platform_baseline

- `HIG`
- `390 x 844 px`
- safe area、touch target、bottom sticky action、单列滚动阅读不可偏离

## preview_options_summary

- `preview-v1`：[preview-v1-welcome-entry.png](/E:/Projects/flutter/rhythm/docs/project/modules/onboarding-activation/previews/preview-v1-welcome-entry.png)
  - 方向：最接近当前全局主线的系统化引导页
- `preview-v2`：[preview-v2-welcome-entry.png](/E:/Projects/flutter/rhythm/docs/project/modules/onboarding-activation/previews/preview-v2-welcome-entry.png)
  - 方向：更柔和、更具 hospitality 感，但仍保持产品感
- `preview-v3`：[preview-v3-welcome-entry.png](/E:/Projects/flutter/rhythm/docs/project/modules/onboarding-activation/previews/preview-v3-welcome-entry.png)
  - 方向：更偏 implementation-ready 的结构化系统稿

## approved_direction

- 采用版本：`preview-v2`
- 代表页基线：[preview-v2-welcome-entry.png](/E:/Projects/flutter/rhythm/docs/project/modules/onboarding-activation/previews/preview-v2-welcome-entry.png)
- 扩展页面：
  - [preview-v2-step-2-health-access.png](/E:/Projects/flutter/rhythm/docs/project/modules/onboarding-activation/previews/preview-v2-step-2-health-access.png)
  - [preview-v2-step-3-sleep-window.png](/E:/Projects/flutter/rhythm/docs/project/modules/onboarding-activation/previews/preview-v2-step-3-sleep-window.png)
  - [preview-v2-step-4-reminder-strategy.png](/E:/Projects/flutter/rhythm/docs/project/modules/onboarding-activation/previews/preview-v2-step-4-reminder-strategy.png)

## design_critique

- `preview-v1`
  - 保留价值：与现有 `Rhythm Rail` 主线最一致，切换成本最低
  - 主要风险：如果层次处理过稳，首步欢迎感可能偏保守
  - 与简报差异：基本一致
  - 平台风险：低
  - 推荐动作：可直接作为保守主推方向
- `preview-v2`
  - 保留价值：情绪更温和，首次进入的心理门槛更低
  - 主要风险：稍不克制就会滑向“疗愈产品”而弱化任务导向
  - 与简报差异：比 brief 更柔软
  - 平台风险：低
  - 推荐动作：若你希望 onboarding 更有陪伴感，可选它
- `preview-v3`
  - 保留价值：层级最清楚，最适合后续 Pencil 结构化和 Flutter 恢复
  - 主要风险：如果后续文案和卡片细节不补温度，可能略显硬朗
  - 与简报差异：比 brief 更“系统稿”
  - 平台风险：低
  - 推荐动作：推荐作为当前主推方向

## freeze_card

- 采用版本：`preview-v2`
- 必须一致项：
  - warm porcelain + moss-sage 的温和引导气质
  - 顶部 step counter 与细进度轨
  - 单列阅读顺序
  - 双 choice card 的安静选中态
  - 底部 sticky footer 的稳定承接
- 允许工程化调整项：
  - picker 的具体控件实现
  - chip 的点击反馈动画
  - 非关键柔光和极轻阴影简化
- 模块组件冻结清单：
  - `activation-step-header`
  - `choice-card`
  - `sleep-window-picker-row`
  - `reminder-lead-chip-group`
  - `sticky-footer-actions`
- 模块组件冻结状态与变体：
  - header：step_1 / step_2 / step_3 / step_4
  - choice-card：default / selected / helper / disabled
  - picker-row：default / focused / invalid
  - chip-group：default / selected / disabled
  - footer：continue_disabled / continue_enabled / finish_ready / submitting
- 模块组件不可偏离项：
  - 不得把四步流压成高密度设置页
  - 不得弱化 sticky CTA 为次级按钮
  - 不得把 selected state 只做成颜色变化
- 平台不可偏离项：`HIG safe area / sticky footer / touch targets / readable type hierarchy`
- 图标处理策略：优先 Pencil 可编辑结构，后续实现期允许更换 glyph，不允许改交互语义
- 插图处理策略：当前默认无插图，不引入新角色或营销图形
- 状态范围：`step_1 ~ step_4 ideal path + selection + submitting/degraded permission hints`
- 是否允许局部重构：允许把 preview-only 视觉处理翻译成可维护 Pencil 结构，但不得改变信息层级
- 验收标准：
  - 3 秒内看清步骤、主任务、主 CTA
  - Step 2-4 与 Step 1 属于同一视觉世界
  - Flutter 后续恢复无需猜测 footer、choice card、picker row 结构
- 备注：当前方向已冻结，等待 Pencil MCP 可写链路恢复后进入结构化重建

## module_component_freeze

- 当前仅冻结候选组件清单，不冻结最终样式
- 候选组件：
  - `activation-step-header`
  - `choice-card`
  - `sticky-footer-actions`

## consumed_global_freeze_artifacts

- [DESIGN.md](/E:/Projects/flutter/rhythm/DESIGN.md)
- [global-design-guidelines.md](/E:/Projects/flutter/rhythm/docs/project/rd/global-design-guidelines.md)
- [light-theme-freeze.yaml](/E:/Projects/flutter/rhythm/docs/project/rd/light-theme-freeze.yaml)
- [dark-theme-freeze.yaml](/E:/Projects/flutter/rhythm/docs/project/rd/dark-theme-freeze.yaml)
- [shared-design-freeze-decision.md](/E:/Projects/flutter/rhythm/docs/project/rd/shared-design-freeze-decision.md)

## asset_manifest

- 当前 4 张 preview 仅作为 Pencil 重建的视觉证据，不直接作为最终可编辑页面
- 本轮未生成独立 icon / illustration 资产
- 后续进入 Pencil 前，如需独立图形资产，再按 `text/layout`、`icon`、`texture` 分类补充

## pencil_rebuild_progress

- Pencil 来源引用已切换到 [app.pen](/E:/Projects/flutter/rhythm/docs/project/design/app.pen)
- 当前未进入 Pencil 写入
- 原因：代表页方向已批准，但当前会话未暴露 Pencil MCP 可写工具

## component_design_progress

- 已识别代表页会复用的非页面级组件
- 已识别 Step 2-4 追加复用的 picker row 与 chip group
- 尚未进入 Pencil 组件化重建

## scroll_expression

- 代表页采用 `single viewport + sticky footer`
- 当前无需连续长页表达

## visual_design_review

- aligned_items
  - 已确认 `preview-v2` 作为全模块视觉基线
  - Step 1-4 都遵守 warm / sage / single-column / no dark mode / no marketing splash 的约束
  - 四个步骤都保留了步骤头、选择卡/选择行、底部 sticky CTA 的核心结构
- remaining_gaps
  - 还未进入 Pencil 结构化重建与 parity review
  - 当前会话缺少 Pencil MCP 可写工具
- ready_for_handoff
  - `false`
- next_actions
  - 在 Pencil 可写链路恢复后，按 `app.pen` 进入结构化重建
  - 重建完成后，再进入 `flutter-design-freeze-gate`
  - 若 Pencil MCP 继续不可用，则当前保持 prepared state

## parity_gap_list

- `pencil_mcp_not_available_in_current_session`
