# app-shell Design Source Packet

## packet_metadata

- module_name：`app-shell`
- packet_scope：`module_impl_prep`
- source_adapter：`stitch`
- source_project_mode：`existing`
- source_project_id：`7107477570523131437`
- global_design_packet：[stitch-design-source-packet.md](/E:/Projects/flutter/rhythm/docs/project/rd/stitch-design-source-packet.md)
- uiux_doc：[app-shell.ui-ux.md](/E:/Projects/flutter/rhythm/docs/project/modules/app-shell/app-shell.ui-ux.md)
- impl_doc：[app-shell.impl.md](/E:/Projects/flutter/rhythm/docs/project/modules/app-shell/app-shell.impl.md)
- module_preview：[app-shell-root-preview.png](/E:/Projects/flutter/rhythm/docs/project/modules/app-shell/app-shell-root-preview.png)

## page_scope

- `startup-gate`
- `root-shell`
- `deep-link-handoff`

## high_fidelity_visual_contract

- 保持 iPhone 安全区顶部留白与底部 home indicator 空间
- 保持 warm off-white 背景与低噪声浅边框卡片视觉世界
- 保持 tab bar 固定在底部，active item 明显但克制
- 保持大标题、高留白和轻交互按钮的根级节奏

## shared_dependencies

- [global-design-guidelines.md](/E:/Projects/flutter/rhythm/docs/project/rd/global-design-guidelines.md)
- [light-theme-freeze.yaml](/E:/Projects/flutter/rhythm/docs/project/rd/light-theme-freeze.yaml)
- [dark-theme-freeze.yaml](/E:/Projects/flutter/rhythm/docs/project/rd/dark-theme-freeze.yaml)
- [shared-design-freeze-decision.md](/E:/Projects/flutter/rhythm/docs/project/rd/shared-design-freeze-decision.md)

## component_freeze

- `shell-tab-item`
  - frozen_states：active / inactive / disabled / badge
  - immutable_parts：icon-text vertical relation, bottom anchoring, active emphasis style
  - allowed_adjustments：icon asset source, exact micro-animation
- `startup-gate-view`
  - frozen_states：loading / redirecting / failed
  - immutable_parts：single focal state, one primary recovery action
  - allowed_adjustments：loading indicator animation
- `global-overlay-host`
  - frozen_states：info / success / warning / error
  - immutable_parts：priority ordering and non-blocking default behavior
  - allowed_adjustments：entry/exit animation duration
- `deep-link-handoff-state`
  - frozen_states：resolving / ready / blocked
  - immutable_parts：short-lived handoff semantics and fallback messaging
  - allowed_adjustments：icon choice and copy length

## structure_semantics

- scroll_model：shell itself does not scroll
- list_model：no business list owned by app-shell
- overlay_model：mixed
- layout_model：layered
- sticky_model：bottom tab only

## fidelity_critical_regions

- 顶部大标题与副操作圆形按钮的相对位置
- 底部 tab bar 的 active state
- startup gate 的 loading/error 单焦点结构
- deep-link handoff 的过渡层级

## region_classification

- preserve_faithfully
  - safe-area spacing
  - tab bar anchoring
  - active/inactive tab contrast
- flutterize
  - loading indicator rendering
  - overlay animation
- simplify
  - 极轻柔光感
  - 非关键环境阴影

## state_matrix

- startup_loading
- startup_redirecting
- startup_failed
- tab_idle
- deep_link_resolving
- deep_link_blocked
- overlay_success
- overlay_warning
- overlay_error

## acceptance_for_freeze

- `app-shell.ui-ux.md` 与 `app-shell.impl.md` 已达到 implementation-final granularity
- 模块预览证据已存在
- 高保真关键区域已分类
- 共享设计冻结依赖已齐备
