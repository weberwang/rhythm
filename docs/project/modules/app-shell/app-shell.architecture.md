# app-shell Architecture Pack

## input_summary

- active_module：`app-shell`
- current_workflow_state：`module_design_frozen`
- platform_identifier：`ios_device`
- global_platform_baseline：`ios_hig`
- visual_direction：`ordered_planner`
- target_project_root：`E:/Projects/flutter/rhythm`

## consumed_design_artifacts

- [app-shell.ui-ux.md](/E:/Projects/flutter/rhythm/docs/project/modules/app-shell/app-shell.ui-ux.md)
- [app-shell.impl.md](/E:/Projects/flutter/rhythm/docs/project/modules/app-shell/app-shell.impl.md)
- [app-shell.design-source-packet.md](/E:/Projects/flutter/rhythm/docs/project/modules/app-shell/app-shell.design-source-packet.md)
- [app-shell-design-freeze-decision.md](/E:/Projects/flutter/rhythm/docs/project/modules/app-shell/app-shell-design-freeze-decision.md)
- [app-shell-root-preview.png](/E:/Projects/flutter/rhythm/docs/project/modules/app-shell/app-shell-root-preview.png)
- [global-design-guidelines.md](/E:/Projects/flutter/rhythm/docs/project/rd/global-design-guidelines.md)
- [light-theme-freeze.yaml](/E:/Projects/flutter/rhythm/docs/project/rd/light-theme-freeze.yaml)
- [dark-theme-freeze.yaml](/E:/Projects/flutter/rhythm/docs/project/rd/dark-theme-freeze.yaml)
- [global-technical-baseline.md](/E:/Projects/flutter/rhythm/docs/project/rd/global-technical-baseline.md)

## display_evidence_pack

- main_preview
  - [app-shell-root-preview.png](/E:/Projects/flutter/rhythm/docs/project/modules/app-shell/app-shell-root-preview.png)
  - 用途：判断 `root-shell` 的安全区、底部 tab、卡片视觉世界和大标题节奏
- source_visual_baseline
  - [rhythm-prd-only-option-2-ordered-planner.png](/E:/Projects/flutter/rhythm/docs/project/design/recommendations/rhythm-prd-only-option-2-ordered-planner.png)
  - 用途：判断共享风格、卡片层级、暖白背景与低噪声结构
- state_evidence
  - 当前只有 `app-shell` 的主预览，没有单独的 loading/error/handoff 子状态图
  - 这些状态由 `app-shell.ui-ux.md` 的详细状态矩阵补齐语义
- evidence_sufficiency
  - 对 `app-shell` 足够，因为它是壳层模块，视觉关键点主要是安全区、tab、handoff 和 overlay 语义，而不是复杂业务页细节

## high_fidelity_display_contract

- fidelity_critical_regions
  - `safe-area-header-gap`
    - evidence：`app-shell-root-preview.png`
    - rule：必须保留顶部安全区、标题起始位置和右上圆形副操作按钮的相对留白
    - classification：`preserve_faithfully`
  - `bottom-tab-bar`
    - evidence：`app-shell-root-preview.png`
    - rule：底部 tab bar 的固定位置、active item 对比、图标与文案关系必须保持
    - classification：`preserve_faithfully`
  - `startup-gate-single-focus`
    - evidence：`app-shell.ui-ux.md` + `app-shell.design-source-packet.md`
    - rule：loading / error / retry 必须保持单焦点结构，不能塞入多段辅助内容
    - classification：`flutterize`
  - `deep-link-handoff-state`
    - evidence：`app-shell.ui-ux.md` + `app-shell.design-source-packet.md`
    - rule：承接态必须短暂、中性、不打断主链路
    - classification：`flutterize`
  - `overlay-priority-layer`
    - evidence：`app-shell.impl.md`
    - rule：blocking error > success banner > info toast 的优先级不能被 feature 模块覆写
    - classification：`flutterize`
- locked_details
  - 暖白背景 + 低噪声大圆角浅边框体系
  - 大标题和日期的两级层次
  - tab active 状态的克制强调
- implementation_sensitive_details
  - loading 指示器动画
  - overlay 进出场与队列调度
  - safe area 与 home indicator 留白的精确实现

## theme_token_mapping

- color
  - `AppColors.backgroundPrimary` -> `surface_roles.background`
  - `AppColors.surfaceCard` -> `surface_roles.surface`
  - `AppColors.surfaceElevated` -> `surface_roles.surface_elevated`
  - `AppColors.textPrimary` -> `text_roles.text_primary`
  - `AppColors.textSecondary` -> `text_roles.text_secondary`
  - `AppColors.brandPrimary` -> `color_roles.primary`
  - `AppColors.brandAccent` -> `color_roles.accent`
  - `AppColors.borderSubtle` -> `border_roles.border_subtle`
  - `AppColors.focusRing` -> `shadow_or_overlay_roles.focus_ring`
- typography
  - `AppTextStyles.pageTitle` -> 大标题层级，来自 `visual_system_rules` 第一层
  - `AppTextStyles.pageMeta` -> 日期和次级说明
  - `AppTextStyles.tabLabel` -> 底部 tab 文案
  - `AppTextStyles.overlayTitle` / `overlayBody` -> overlay host
- spacing
  - `AppSpacing.xs/s/m/l/xl/xxl` 对应全局 8pt 系列
  - `AppInsets.pageHorizontal = 20~24`
  - `AppInsets.cardPadding = 20~24`
- radius
  - `AppRadius.card = 24`
  - `AppRadius.pill = 9999`
  - `AppRadius.control = 16`
- motion
  - `AppMotion.overlayEnter`
  - `AppMotion.overlayExit`
  - `AppMotion.handoffFade`

## module_token_overlay

- `AppShellTokens.tabBarHeight`
  - 语义：仅 `app-shell` 使用的底部 tab 视觉高度
  - 来源：模块预览证据 + safe area 需求
- `AppShellTokens.startupGateMaxWidth`
  - 语义：启动分发内容最大宽度
  - 来源：单焦点结构约束
- `AppShellTokens.overlayTopOffset`
  - 语义：全局 overlay 与安全区的距离
  - 来源：iOS 顶部安全区

这些 token 只能作为模块内 overlay，不可重写全局 theme 角色。

## asset_strategy

- `native_flutter`
  - 顶部安全区留白
  - 页面标题与日期
  - 底部 tab bar
  - 圆角卡片与浅边框
  - loading/error/handoff 页面结构
- `existing_asset_reuse`
  - 当前无必须复用的 bitmap 资产
- `project_bitmap_asset`
  - `none`

结论：`app-shell` 不需要额外位图资产，全部视觉关键点可由 Flutter 原生布局稳定实现。

## component_decomposition

- global primitives
  - `RhythmColorScheme`
  - `RhythmTextStyles`
  - `RhythmSpacing`
  - `RhythmRadius`
- shared shell widgets
  - `RootShellPage`
  - `RootTabBar`
  - `RootTabItem`
  - `GlobalOverlayHost`
  - `StartupGatePage`
  - `DeepLinkHandoffPage`
- app-shell business widgets
  - `StartupGateBody`
  - `StartupRetryAction`
  - `DeepLinkBlockedPanel`
  - `OverlayBannerItem`
- controller / state units
  - `AppShellBootstrapController`
  - `AppShellTabController`
  - `AppShellLaunchStateStore`
  - `AppShellDeepLinkGateway`

## screen_architecture

- route_entry
  - `startup-gate` 作为唯一冷启动入口
  - 完成后 redirect 到 `root-shell/<feature>`
- page_scaffold
  - `StartupGatePage`
    - `Scaffold` + 中心内容区
  - `RootShellPage`
    - `Scaffold` / `SafeArea` + body slot + bottomNavigationBar
  - `DeepLinkHandoffPage`
    - 轻量中间态页，可作为过渡 route 或 overlay-like page
- content_slots
  - `root-shell` 不拥有业务滚动区，仅承载 feature 内容
  - `bottomNavigationBar` 始终由 app-shell 控制
- navigation_contract
  - feature branch 只能注册内容页，不可接管 root shell

## state_architecture

- shell_owned_state
  - onboarding completion
  - session existence
  - selected tab
  - incoming deep link target
  - overlay queue
- feature_owned_state
  - today / calendar / bedtime / insights / profile-settings 的业务状态
- failure_boundaries
  - startup failure 归 app-shell
  - deep link blocked 归 app-shell
  - feature data failure 归对应 feature

## scroll_and_motion_architecture

- scroll
  - `root-shell`：fixed layout
  - feature pages：各自处理滚动
- sticky
  - `bottomNavigationBar`：全局 sticky
- motion
  - `startup-gate`：轻量 fade / progress
  - `deep-link-handoff`：短暂 fade / scale
  - `overlay`：slide/fade 即可，禁止重装饰弹跳

## display_layer_decision_table

| region_id | visual_priority | scroll_decision | list_decision | layout_decision | sticky_decision | layout_anchor | spacing_lock_rule | text_overflow_rule | responsive_break_rule | z_axis_rule | animation_source_of_truth | pixel_tolerance | asset_decision | must_use_asset | must_not_flutterize |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| `startup-gate-main` | high | fixed layout | not-a-list | `Column` | no sticky behavior | safe-area top + centered body | 标题、状态、主动作垂直关系锁定 | wrap | 手机宽度内不改布局 | 单层 | frozen motion intent | tight | native drawing/composition | none | no |
| `root-shell-body-slot` | supporting | mixed | not-a-list | `Column/slot` | mixed | body 填满除 tab 外剩余区域 | body 与 tab bar 间距锁定 | feature-owned | 仅允许 safe area 调整 | body below overlays | explicit no-motion | moderate | native drawing/composition | none | no |
| `root-tab-bar` | fidelity_critical | fixed layout | static block | `Row` | fixed footer | bottom safe area + full width | item 内 icon-text gap 锁定 | ellipsis blocked, redesign if overflow | 手机宽度只允许均分 | above body | frozen motion intent | strict | native drawing/composition | none | yes |
| `deep-link-handoff` | high | fixed layout | not-a-list | `Column` | no sticky behavior | centered body | 图标、说明、回退动作节奏锁定 | wrap | 手机宽度不改骨架 | above body, below blocking overlay | frozen motion intent | tight | native drawing/composition | none | no |
| `global-overlay-host` | high | overlay | not-a-list | `Overlay` | mixed | top safe area anchored | banner 间距和优先级锁定 | fade or wrap | 手机宽度下保持单列 | topmost except blocking error | frozen motion intent | tight | native drawing/composition | none | no |

## non_native_visual_fallbacks

- `none`

## taste_implementation_guardrails

- 保持页面留白和层级克制，不要为了“更完整”而把启动页和 handoff 页塞满说明文案。
- tab active 强调只能通过色彩、图标和字重微调实现，不要做粗暴背景块或高亮条。
- overlay 不得做成营销气泡或沉浸弹窗。
- 所有壳层文本都要短，重在分流与反馈，不重在教育。
- 保持 iOS 真机安全区的呼吸感和底部 home indicator 空间。

## fidelity_vs_flutterization

- preserve_faithfully
  - safe area spacing
  - bottom tab anchoring
  - active/inactive tab hierarchy
- flutterize
  - loading animation
  - overlay enter/exit motion
  - handoff transition
- simplify
  - 极轻柔光和背景暖雾感
  - 非关键边缘阴影

## implementation_boundaries

- architecture stops here:
  - token categories
  - component decomposition
  - route and state ownership
  - display-layer decision table
- not in scope:
  - real page code
  - provider wiring code
  - startup runtime implementation
  - feature branch implementation

## flutter_init_inputs

- project_root：`E:/Projects/flutter/rhythm`
- `lib/` 当前不存在，需要 `flutter-init`
- `skills/flutter-dev/` 当前不存在，需要 `flutter-init`
- 初始化只应建立目录、最小依赖基线、feature skeleton 与 project-local `flutter-dev`
- bootstrap code 仍应在后续单独阶段处理，不应在 `flutter-init` 中实现

## risks_and_open_questions

- 匿名升级登录后的 tab 栈恢复策略仍未冻结
- 通知深链进入 bedtime 时的 tab 高亮策略仍需最终决策
- app-shell 是否需要全局 banner 队列策略而不是单条覆盖仍未完全定稿
- 若后续 feature 分支页面的 header 高度不一致，需验证是否会破坏 root shell 的稳定感
