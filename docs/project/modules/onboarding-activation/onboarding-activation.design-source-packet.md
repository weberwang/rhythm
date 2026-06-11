# onboarding-activation Design Source Packet

## packet_metadata

- module_name：`onboarding-activation`
- packet_scope：`module_design_review`
- source_adapter：`pencil`
- pencil_source_ref：[app.pen](/E:/Projects/flutter/rhythm/docs/project/design/app.pen)
- source_project_mode：`preview_to_pencil_rebuild`
- global_design_packet：[stitch-design-source-packet.md](/E:/Projects/flutter/rhythm/docs/project/rd/stitch-design-source-packet.md)
- uiux_doc：[onboarding-activation.ui-ux.md](/E:/Projects/flutter/rhythm/docs/project/modules/onboarding-activation/onboarding-activation.ui-ux.md)
- impl_doc：[onboarding-activation.impl.md](/E:/Projects/flutter/rhythm/docs/project/modules/onboarding-activation/onboarding-activation.impl.md)
- representative_preview_v1：[preview-v1-welcome-entry.png](/E:/Projects/flutter/rhythm/docs/project/modules/onboarding-activation/previews/preview-v1-welcome-entry.png)
- representative_preview_v2：[preview-v2-welcome-entry.png](/E:/Projects/flutter/rhythm/docs/project/modules/onboarding-activation/previews/preview-v2-welcome-entry.png)
- representative_preview_v3：[preview-v3-welcome-entry.png](/E:/Projects/flutter/rhythm/docs/project/modules/onboarding-activation/previews/preview-v3-welcome-entry.png)
- approved_preview_step_1：[preview-v2-welcome-entry.png](/E:/Projects/flutter/rhythm/docs/project/modules/onboarding-activation/previews/preview-v2-welcome-entry.png)
- approved_preview_step_2：[preview-v2-step-2-health-access.png](/E:/Projects/flutter/rhythm/docs/project/modules/onboarding-activation/previews/preview-v2-step-2-health-access.png)
- approved_preview_step_3：[preview-v2-step-3-sleep-window.png](/E:/Projects/flutter/rhythm/docs/project/modules/onboarding-activation/previews/preview-v2-step-3-sleep-window.png)
- approved_preview_step_4：[preview-v2-step-4-reminder-strategy.png](/E:/Projects/flutter/rhythm/docs/project/modules/onboarding-activation/previews/preview-v2-step-4-reminder-strategy.png)

## preview_round

- preview_policy：`required_before_pencil_rebuild`
- preview_model：`gpt-image-2`
- preview_status：`approved_direction_expanded_waiting_pencil_rebuild`
- preview_scope：`step_1_to_step_4`
- current_cycle_visual_baseline：`preview-v2`

## page_scope

- `welcome-entry-mode`
- `health-access-choice`
- `sleep-window-setup`
- `reminder-strategy`

## high_fidelity_visual_contract

- 保持 `390 x 844 px` 视口下的单列引导式阅读顺序，不压缩首屏留白换取信息堆叠。
- 保持 warm paper 背景、sage 主动作色、低噪声描边卡片和安静的层级关系。
- 保持顶部步骤计数与细进度轨的稳定位置，让四步流在视觉上形成同一条激活轨道。
- 保持底部 sticky footer 的固定承接角色，主动作始终明确、克制且可预期。
- 保持选择卡、时间选择行、提醒 chips 的“轻交互、强可读”质感，不演变成营销 onboarding 或系统设置页拼盘。

## shared_dependencies

- [global-design-guidelines.md](/E:/Projects/flutter/rhythm/docs/project/rd/global-design-guidelines.md)
- [light-theme-freeze.yaml](/E:/Projects/flutter/rhythm/docs/project/rd/light-theme-freeze.yaml)
- [dark-theme-freeze.yaml](/E:/Projects/flutter/rhythm/docs/project/rd/dark-theme-freeze.yaml)
- [shared-design-freeze-decision.md](/E:/Projects/flutter/rhythm/docs/project/rd/shared-design-freeze-decision.md)

## component_freeze

- `activation-step-header`
  - frozen_states：step_1 / step_2 / step_3 / step_4
  - immutable_parts：顶部 step counter、细进度轨、当前步骤显色策略
  - allowed_adjustments：步骤文案措辞、微小垂直间距
- `choice-card`
  - frozen_states：default / selected / disabled / helper
  - immutable_parts：左文案右选择标识、柔和描边、选中态 outline 与 icon 联合表达
  - allowed_adjustments：图标 glyph、正文长短
- `sleep-window-picker-row`
  - frozen_states：default / focused / helper / invalid
  - immutable_parts：标签与时间值层级、原生感选择行结构、两行纵向编排
  - allowed_adjustments：具体控件实现、时间格式化细节
- `reminder-lead-chip-group`
  - frozen_states：default / selected / disabled
  - immutable_parts：pill 形 chips、低噪声表面、选中后主色强调
  - allowed_adjustments：chip 尺寸、点击反馈动画
- `sticky-footer-actions`
  - frozen_states：continue_disabled / continue_enabled / finish_ready / submitting
  - immutable_parts：底部固定承接、主次按钮顺序、主按钮宽度优先级
  - allowed_adjustments：loading 指示器样式、按钮文案长度

## structure_semantics

- scroll_model：`whole-page scroll`
- list_model：`static block`
- overlay_model：`modal layer`
- layout_model：`linear`
- sticky_model：`sticky footer`

## fidelity_critical_regions

- 顶部步骤计数与四段进度轨的相对位置
- 欢迎/权限/提醒步骤中的双 choice cards 选中表达
- sleep window 步骤中时间值的字号层级与点击 affordance
- reminders 步骤中 chips 与底部 Finish 的完成态关系
- 底部 sticky footer 与 safe area 的贴合方式

## region_classification

- preserve_faithfully
  - 步骤头部结构
  - sticky footer 锚定与按钮层级
  - choice card 的选中态表达
- flutterize
  - dropdown / picker 的具体控件实现
  - chips 点击反馈和 loading 动画
- simplify
  - 极轻背景层次噪声
  - 非关键柔光或阴影

## state_matrix

- welcome_default
- welcome_selected
- health_connect_selected
- health_manual_selected
- sleep_window_ready
- sleep_window_invalid
- reminder_enabled
- reminder_disabled
- reminder_lead_selected
- submit_loading
- submit_degraded_permission

## freeze_readiness

- 共享设计冻结依赖已齐备。
- `onboarding-activation.impl.md` 已明确四步路径、权限策略、目标设置与提醒设置边界。
- 已确认 `preview-v2` 为当前设计周期唯一视觉基线，并已按同方向扩展出 Step 1-4 全套 preview。
- 当前模块已切换到 Pencil 分支，后续结构化设计源必须以 [app.pen](/E:/Projects/flutter/rhythm/docs/project/design/app.pen) 为项目级来源引用。
- 在 Pencil MCP 可写链路恢复前，不得重建 Pencil 页面、不得进入 `flutter-design-freeze-gate`、不得进入架构、Spec、Plan 或实现。
