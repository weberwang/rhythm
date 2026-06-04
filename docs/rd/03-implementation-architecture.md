# Rhythm 实现前架构摘要

## 0. 文档信息

- 文档目标：把已冻结的共享设计包与模块文档翻译成 Flutter 可实施架构
- 上游输入：
  - `docs/rd/01-global-technical-baseline.md`
  - `docs/rd/02-shared-design-packet.md`
  - `docs/rd/global-design-guidelines.md`
  - `docs/rd/light-theme-freeze.yaml`
  - `docs/rd/dark-theme-freeze.yaml`
  - `docs/rd/modules/*/*.ui-ux.md`
  - `docs/rd/modules/*/*.impl.md`

## 1. input_summary

- 共享技术路线已冻结为：`DDD by feature + local-first + optional cloud sync`
- 共享设计路线已冻结为：`light-mode editorial wellness + calm operational hierarchy`
- 模块级设计源已明确：
  - 共享组件由全局冻结文档约束
  - 模块私有组件由各模块 `ui-ux.md` 的组件骨架与冻结卡约束
- 当前目标不是写页面代码，而是确定显示层决策、状态边界、组件分解与初始化输入

## 2. consumed_design_artifacts

- `docs/rd/global-design-guidelines.md`
- `docs/rd/light-theme-freeze.yaml`
- `docs/rd/dark-theme-freeze.yaml`
- `docs/rd/today-dashboard.png`
- `docs/rd/modules/onboarding-activation/onboarding-welcome.png`
- `docs/rd/modules/bedtime/bedtime-mode.png`
- `docs/rd/modules/calendar/calendar-heatmap.png`
- `docs/rd/modules/insights/insights-weekly-report.png`
- `docs/rd/modules/profile-settings/profile-settings.png`

## 3. theme_token_mapping

- 全局 token 建议映射：
  - `AppColors.primary` ← `color_roles.primary`
  - `AppColors.accent` ← `color_roles.accent`
  - `AppSurfaces.background/surface/surfaceSubtle/surfaceElevated`
  - `AppText.primary/secondary/tertiary/inverse`
  - `AppBorders.subtle/strong/divider`
  - `AppStatus.success/warning/error/info`
- 组件状态 token 建议单独保存在 `AppComponentStates`
- 主题值由 YAML 单向映射进 Flutter，不允许代码侧重新发明语义

## 4. module_token_overlay

- `today` / `insights`：允许额外定义“结果偏移带”和“趋势高亮带”，但只能 alias 全局主色/状态色。
- `bedtime`：允许定义更安静的 surface 强度，不允许重建独立暗色体系。
- `calendar`：允许定义热力图 4 档偏移色阶，但必须以全局成功/警示/错误温度带为边界。
- `profile-settings`：允许定义 grouped cell 间距与 section gap，不允许改写主按钮或会员卡 CTA 语义。

## 5. asset_strategy

- `native_flutter`
  - 渐变背景
  - 轻雾纹理的简化层
  - 卡片、描边、阴影、底部导航
  - 结果环、趋势线、状态 chip
- `existing_asset_reuse`
  - 预览图仅作为冻结证据使用，不进入运行时
- `project_bitmap_asset`
  - 当前无强制新增项

## 6. component_decomposition

### 全局 primitives

- `AppScaffoldSurface`
- `AppSectionHeader`
- `AppPrimaryButton`
- `AppSecondaryButton`
- `AppGroupedCell`
- `AppStatusBadge`
- `AppEmptyStateBlock`
- `AppPremiumLockCard`

### 全局 composites

- `SleepResultCard`
- `GoalScheduleCard`
- `RecoverySuggestionCard`
- `MiniTrendCard`
- `PermissionHelpBlock`

### 模块 business widgets

- `BedtimeStatusSelector`
- `BedtimeCountdownRing`
- `CalendarOffsetHeatmap`
- `InsightsStabilityCard`
- `WeeklyReportSummaryCard`
- `ProfileMembershipCard`
- `SyncHealthStatusTile`

## 7. screen_architecture

### app-shell

- 路由入口：`launch -> onboarding | tab-shell`
- 主壳：底部导航 + 全局 overlay host
- 状态边界：启动加载、身份恢复、引导完成检查、通知/深链跳转分发

### onboarding-activation

- 页面链路：欢迎 -> 登录选择 -> 健康授权 -> 目标设置 -> 提醒设置 -> 小组件引导 -> 完成页
- 表单状态按步骤独立管理，避免单个巨型表单 provider

### sleep-data-core

- 无独立主页面
- 通过全局 sheet / banner / source badge 暴露数据可信度、手动修正、同步错误

### today

- Page scaffold：纵向滚动单页
- 区块顺序：昨晚结果 -> 今晚目标 -> 恢复建议 -> 快捷记录 -> 7 日趋势

### bedtime

- 首屏固定任务焦点
- 倒计时环 + 状态选择 + 单个轻收尾动作

### calendar

- 月度摘要 + 热力图主体 + 筛选模式 + 单日详情入口
- 单日详情建议用 bottom sheet / pushed detail page 二选一冻结

### insights

- 本周达标率 -> 稳定度解释 -> 原因分布 -> 恢复效果 -> 报告入口
- 付费触点只出现在高意图区块，不抢首页主任务

### profile-settings

- 会员状态卡 + grouped settings sections
- 账户、同步、目标、提醒、隐私、小组件分组明确

## 8. state_architecture

- 所有页面必须覆盖：
  - loading
  - empty
  - permission
  - partial data
  - error
  - locked/premium（相关页面）
- `sleep-data-core` 负责统一产出：
  - `recordAvailability`
  - `syncStatus`
  - `sourceConfidence`
  - `timezoneContext`
- `today`、`calendar`、`insights` 只消费统一状态，不自己发明“无数据”和“错误”的业务定义

## 9. scroll_and_motion_architecture

- 全局动效策略：轻淡入、轻位移、轻状态切换
- 页面动效不得超过 250ms 的感知主动作
- 睡前页动效最克制，今日页次之，洞察页允许轻图表进入
- 不做大面积 parallax 或复杂浮层编排

## 10. display_layer_decision_table

| 模块 | page_or_region | scroll_decision | list_decision | layout_decision | sticky_decision | asset_decision | fidelity_mode |
| --- | --- | --- | --- | --- | --- | --- | --- |
| app-shell | launch + tab shell | fixed layout | not-a-list | mixed | fixed footer | native_flutter | preserve_faithfully |
| onboarding-activation | step flow | PageView or stepped flow | not-a-list | Column/Stack mixed | no sticky behavior | native_flutter | preserve_faithfully |
| sleep-data-core | source/sync surfaces | mixed | not-a-list | Column + sheet | mixed | native_flutter | flutterize |
| today | dashboard page | CustomScrollView | SliverList | sliver composition | pinned lightweight top region optional | native_flutter | preserve_faithfully |
| bedtime | bedtime focus page | SingleChildScrollView | not-a-list | Column | fixed footer optional | native_flutter | preserve_faithfully |
| calendar | calendar review page | CustomScrollView | mixed | Column + custom calendar grid | sticky filter optional | native_flutter | preserve_faithfully |
| insights | reports page | CustomScrollView | SliverList | sliver composition | no sticky behavior | native_flutter | flutterize |
| profile-settings | settings page | CustomScrollView | grouped list | Column/List mixed | no sticky behavior | native_flutter | preserve_faithfully |

## 11. non_native_visual_fallbacks

- 当前未冻结任何“必须改走 `$imagegen` 运行时位图资产”的视觉效果。
- 若后续设计希望保留高保真插画、纸张纹理或复杂场景背景，再通过设计控制链路补充资产需求。

## 12. taste_implementation_guardrails

- 页面必须保留大层级留白与一屏一重心，不得把所有区块压成同密度列表。
- 标题层级与说明文案的对比必须保留，不能统一降成 Material 默认文字体系。
- 付费触点必须“像建议升级”，不能“像强制拦截”。
- 图表和热力图的可读性优先于炫技动画。

## 13. fidelity_vs_flutterization

- `preserve_faithfully`
  - CTA 对比
  - 结果卡的主副层级
  - 睡前页的焦点任务结构
  - 引导页的首屏单重心
- `flutterize`
  - 轻纹理背景
  - 图表样式细节
  - 设置页轻装饰元素
- `simplify`
  - 过于写实的插图物件
  - 仅用于情绪表达的小自然装饰

## 14. implementation_boundaries

- `sleep-data-core` 先定义最小数据契约，再让 Today / Calendar / Insights 接入。
- `app-shell` 必须先承接 route host、root redirect、provider scope 与通知入口。
- `onboarding-activation` 不直接持有健康插件与登录插件实例，只触发应用层意图。
- 任何页面都不得直接消费 `health`、`purchases_flutter`、`supabase_flutter`、`home_widget`。

## 15. flutter_init_inputs

- 路由宿主：`app-shell`
- 公共 provider scope：基于 Riverpod 注解生成
- 本地存储基线：`drift + secure_storage + shared_preferences`
- 通知与时区基线：`flutter_local_notifications + timezone`
- 同步与账号基线：`supabase_flutter`
- 会员基线：`purchases_flutter`
- 国际化与主题基线：`l10n + theme freeze YAML mapping`

## 16. risks_and_open_questions

- 当前 `lib/` 目录为空，意味着初始化前架构只停留在文档层，还没有真实消费点；这正是 `flutter-init` 的执行目标。
- 匿名模式策略在本轮不阻塞 `flutter-init`：按“匿名本地优先、后续可绑定账号与同步”的当前假设初始化即可。
- 轮班/时差策略若进入首发，会额外影响 `GoalSchedule` 与 `Report` 结构设计。
