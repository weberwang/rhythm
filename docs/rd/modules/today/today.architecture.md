# today Flutter 架构输出包

> 产物类型：`module_flutter_architecture_pack`
> 模块：`today`
> 日期：`2026-06-09`
> 上游阶段：`module_design_frozen`
> 目标阶段：`architecture_ready` 候选
> 当前状态：`generated_from_confirmed_preview_feedback_revision`

## input_summary

`today` 模块当前已经完成：

- 修订后的模块 UI/UX 合同
- 修订后的模块实现合同
- 经确认的模块级 Pencil 设计源包
- 模块冻结决议
- 共享设计指南与双主题冻结

本次架构输出的目标不是写页面代码，而是把修订后的 `today` 冻结设计意图映射成 Flutter 侧可消费的：

- 主题 token 映射
- 组件拆解
- 页面结构
- 状态与滚动决策
- fidelity / flutterize / simplify 边界

## consumed_design_artifacts

- `docs/rd/modules/today/today.ui-ux.md`
- `docs/rd/modules/today/today.impl.md`
- `docs/rd/modules/today/today.pencil-design-source-packet.md`
- `docs/rd/modules/today/today-design-freeze-decision.md`
- `docs/rd/modules/today/pencil-exports/MCgNV.png`
- `docs/rd/modules/today/today-module-preview.png`
- `docs/rd/global-design-guidelines.md`
- `docs/rd/light-theme-freeze.yaml`
- `docs/rd/dark-theme-freeze.yaml`
- `docs/rd/global-technical-baseline.md`

## display_evidence_pack

- 主证据：
  - `docs/rd/modules/today/pencil-exports/MCgNV.png`
- 补充证据：
  - `docs/rd/modules/today/today-module-preview.png`

证据优先级：

1. `today.pencil-design-source-packet.md`
2. `MCgNV.png`
3. `today-module-preview.png`

说明：

- `today-module-preview.png` 只作为补充视觉证据
- 不可用它替代冻结设计源
- 它只参与信息组织、张力和 CTA 姿态判断
- 它不参与底部导航语义和文案判断

## high_fidelity_display_contract

### fidelity-critical 区域

- `result_card`
  - 结果主卡
  - 必须保持首屏第一视觉重心
- `target_card`
  - 今晚目标卡
  - 必须承接结果卡，不可与 CTA 混层
- `action_card`
  - 下一步动作卡
  - CTA 必须清晰但不能压过结果
- `bottom_tab_bar`
  - 共享底部导航
  - 必须沿用共享冻结语义

### 证据源

- `result_card`: `today.pencil-design-source-packet.md` + `MCgNV.png`
- `target_card`: `today.pencil-design-source-packet.md` + `MCgNV.png`
- `action_card`: `today.pencil-design-source-packet.md` + `MCgNV.png`
- `bottom_tab_bar`: `global-design-guidelines.md` + `MCgNV.png`

### region classification

- `preserve_faithfully`
  - `result_card`
  - `target_card`
  - `action_card`
  - `bottom_tab_bar`
- `flutterize`
  - `trend_preview`
  - `subtle_surface_depth`
- `simplify`
  - `none`

### 锁定细节

- 结果主卡必须保留 serif headline 的阅读压强
- 结果卡顶部的眉题与日期必须形成弱对位，不得抢 headline
- 结果卡底部双列支持信息必须保持第二层解释姿态，不得长成仪表盘
- 目标卡的状态 chip 只能做今晚姿态标记，不得替代目标时间
- 动作卡默认维持左文案右按钮构图
- 趋势区必须处于第四层级，不得升级

## theme_token_mapping

### 全局主题到 Flutter ThemeExtension / Token 的映射

- `color.primary` -> `RhythmColorTokens.primary`
- `color.onPrimary` -> `RhythmColorTokens.onPrimary`
- `color.surfaceBackground` -> `RhythmColorTokens.pageBackground`
- `color.surfaceContainer` -> `RhythmColorTokens.cardBackground`
- `color.outline` -> `RhythmColorTokens.cardBorder`
- `color.warning` -> `RhythmColorTokens.warning`
- `color.error` -> `RhythmColorTokens.error`
- `text.primary` -> `RhythmTextTokens.primary`
- `text.secondary` -> `RhythmTextTokens.secondary`
- `text.tertiary` -> `RhythmTextTokens.tertiary`
- `radius.md` -> `RhythmShapeTokens.medium`
- `radius.lg` -> `RhythmShapeTokens.large`
- `spacing.md` -> `RhythmSpacingTokens.md`
- `spacing.lg` -> `RhythmSpacingTokens.lg`
- `spacing.xl` -> `RhythmSpacingTokens.xl`

### 字体映射

- 页面标题 / 结果 headline / 目标时间 / 次级强调 serif -> `TodayDisplayTextStyle`
- sans 页面正文与支持说明 -> `TodayBodyTextStyle`
- mono eyebrow / chip / trend label -> `TodayCaptionTextStyle`

## module_token_overlay

`today` 不新增新的全局主题值，只允许模块局部语义 alias：

- `todayResultCardBackground` -> alias `cardBackground`
- `todayResultMetricDivider` -> alias `cardBorder`
- `todayTargetCardBackground` -> alias `surfaceSubtle`
- `todayTargetStatusChipBackground` -> alias `warningSurface`
- `todayActionButtonBackground` -> alias `primary`
- `todayTrendOnPlanDot` -> alias `success`
- `todayTrendWatchDot` -> alias `warning`
- `todayTrendLateDot` -> alias `error`

禁止：

- 覆盖全局 primary / surface / outline 命名
- 在模块内重新定义全局 CTA 色义
- 为 `today` 单独发明跨模块的“rhythm score”视觉 token

## asset_strategy

当前 `today` 不需要强制生成新的位图资产。

### native_flutter

- 结果卡、目标卡、动作卡
- 结果卡的分隔线与双列支持信息
- 目标状态 chip
- 趋势状态点阵与 legend
- 页面背景与卡片层次
- 按钮、标签、分隔线

### existing_asset_reuse

- `docs/rd/modules/today/pencil-exports/MCgNV.png`
  - 仅作为实现对照证据
  - 不作为运行时资产

### project_bitmap_asset

- `none`

## component_decomposition

### primitives

- `RhythmPageScaffold`
- `RhythmCardSurface`
- `RhythmPrimaryButton`
- `RhythmCaptionLabel`
- `RhythmDivider`
- `RhythmStatusChip`
- `RhythmStatusDot`

### composite widgets

- `TodayResultCard`
- `TodayResultMetricRow`
- `TodayTargetCard`
- `TodayNextStepCard`
- `TodayTrendPreview`
- `TodayTrendLegend`
- `TodayQuickEntryRow`

### business widgets

- `TodayContentSliver`
- `TodayStateSurface`
- `TodayRecoverySummaryEntry`

### page sections

- `TodayHeaderSection`
- `TodayResultSection`
- `TodayTargetSection`
- `TodayActionSection`
- `TodayTrendSection`

### shell integration

- `TodayTabPage`
- `TodayRouteEntry`

## screen_architecture

### route entry

- 顶层路由宿主：`/today`
- 由 `app-shell` 承载
- `today` 自身不拥有根级分发逻辑

### page scaffold

- 使用 `Scaffold`
- body 使用 `CustomScrollView`
- 不使用嵌套滚动

### section order

1. header
2. result card
3. target card
4. action card
5. trend preview
6. optional secondary entries

### section ownership

- header：展示层
- result / target / action：由 `TodayViewState` 聚合驱动
- trend：轻量衍生摘要
- 次级入口：由业务条件显示

## state_architecture

### state owner

- `todayViewModelProvider`
- 由 `@riverpod` 生成

### state model

- `TodayViewState`
  - `loadState`
  - `lastNightSummary`
  - `tonightGoalSummary`
  - `nextActionSummary`
  - `trendPreview`
  - `permissionState`
  - `syncState`
  - `lockState`

### loading / empty / error boundaries

- 页面级外壳不闪烁
- 结果卡、目标卡、动作卡分别可骨架化
- 错误态不替换整个页面，只替换对应业务区块
- 结果卡缺失时保留目标卡与动作卡

## scroll_and_motion_architecture

### scroll architecture

- 主容器：`CustomScrollView`
- 内容组织：`SliverToBoxAdapter` + `SliverPadding`
- 无 sticky header
- 底部导航由 shell 负责，不在本页内实现 sticky footer

### motion architecture

- 仅允许轻量状态切换
- 不做戏剧化页面转场
- CTA、卡片状态和 skeleton 到内容的过渡保持低刺激

## display_layer_decision_table

| region_id | visual_priority | scroll_decision | list_decision | layout_decision | sticky_decision | layout_anchor | spacing_lock_rule | text_overflow_rule | responsive_break_rule | z_axis_rule | animation_source_of_truth | pixel_tolerance | asset_decision | must_use_asset | must_not_flutterize |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| `today_header` | `high` | `CustomScrollView` | `not-a-list` | `Column/Row` | `no sticky behavior` | 顶部安全区与结果卡之间的垂直节奏 | 标题到轻说明的间距锁定 | `wrap` | 仅允许更宽容器，不允许重排语义 | header 在最上层，无覆盖 | `explicit no-motion` | `tight` | `native_flutter` | `none` | `no` |
| `result_card` | `fidelity_critical` | `CustomScrollView` | `not-a-list` | `Column/Row + nested metric row` | `no sticky behavior` | 首屏第一块 | headline、说明、分隔线、双列支持信息之间的层级节奏锁定 | `wrap` | 不允许跨宽度改变其优先级；窄屏只允许双列支持信息在保持语义下软换行 | 高于目标卡与动作卡 | `frozen motion intent` | `strict` | `native_flutter` | `none` | `yes` |
| `target_card` | `fidelity_critical` | `CustomScrollView` | `not-a-list` | `Column/Row with status chip` | `no sticky behavior` | 结果卡之后、动作卡之前 | 眉题、chip、目标时间与说明的相对距离锁定 | `wrap` | 不允许上移或并入结果卡 | 低于结果卡，高于动作卡 | `explicit no-motion` | `tight` | `native_flutter` | `none` | `yes` |
| `action_card` | `fidelity_critical` | `CustomScrollView` | `not-a-list` | `Row + nested column` | `no sticky behavior` | 目标卡之后 | 左文案块与右按钮的构图关系锁定 | `wrap` | 允许在极窄宽度下退化为纵向堆叠，但不得让按钮先于文案 | 低于结果卡，高于趋势块 | `frozen motion intent` | `tight` | `native_flutter` | `none` | `yes` |
| `trend_preview` | `supporting` | `CustomScrollView` | `static block` | `Column/Row` | `no sticky behavior` | 页面第四区块 | 与动作卡的区隔锁定 | `clip` | 允许轻度压缩；不允许升级成复杂图表 | 低于前三卡 | `explicit no-motion` | `moderate` | `native_flutter` | `none` | `no` |
| `secondary_entries` | `normal` | `CustomScrollView` | `static block` | `Column/Row` | `no sticky behavior` | 趋势区之后 | 只能后置 | `wrap` | 可在长页面下折叠 | 低于主任务区 | `explicit no-motion` | `flexible` | `native_flutter` | `none` | `no` |

## non_native_visual_fallbacks

- `none`

当前 `today` 页没有必须用 `$imagegen` 产出的运行时位图资产。

## taste_implementation_guardrails

- 保持结果卡的阅读优先权，不为“更像产品”而额外塞入仪表盘模块
- 让留白承担层级工作，不靠卡片堆叠制造复杂感
- 结果卡 serif 大字与正文 sans 的反差不可丢失
- 结果卡底部双列支持信息要克制，不能长成 dashboard
- CTA 可以更稳，但不能更吵
- 趋势区必须保持轻量，不可为了“数据感”拔高

## fidelity_vs_flutterization

- `preserve_faithfully`
  - 结果主卡
  - 今晚目标卡
  - 下一步动作卡
  - 共享底部导航语义
- `flutterize`
  - 趋势摘要块
  - 极浅阴影与表面层次
  - 结果卡分隔线与双列支持信息的具体布局实现
- `simplify`
  - `none`

## implementation_boundaries

- 本阶段只定义 Flutter 侧结构与边界
- 不写页面代码
- 不重开设计决策
- 不改共享主题值
- 不允许把 `today-module-preview.png` 误当成新的设计源真相

## flutter_init_inputs

为后续实现 Today 页面，项目初始化 / bootstrap 至少需要具备：

- root app shell
- `go_router` 路由宿主
- `hooks_riverpod` ProviderScope
- 全局 token / theme extension 基线
- 本地存储与 drift baseline
- `sleep-data-core` 的聚合查询接口

## risks_and_open_questions

- `today` 依赖 `sleep-data-core` 的聚合口径，如果其输出模型变化，Today 架构需要同步收口
- 结果卡双列支持信息在极窄宽度上的排布策略需要实现时严格守住层级，不得演化为统计面板
- 趋势摘要块后续若被要求增加交互，可能需要从 supporting block 升级为独立业务区
- 恢复详情锁定与免费摘要边界仍需商业侧确认
