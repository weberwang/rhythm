# Rhythm 模块架构交接总表

## 0. 文档信息

- 文档名称：Rhythm 模块架构交接总表
- 输出日期：2026-06-03
- 对应全局技术基线：[01-global-technical-baseline.md](D:/Projects/Flutter/rhythm/docs/rd/01-global-technical-baseline.md)
- 对应共享冻结合同：[global-design-guidelines.md](D:/Projects/Flutter/rhythm/docs/rd/global-design-guidelines.md)
- 对应共享 taste 方向：[02-shared-taste-direction.md](D:/Projects/Flutter/rhythm/docs/rd/02-shared-taste-direction.md)
- 对应工作流记录：[00-workflow-record.md](D:/Projects/Flutter/rhythm/docs/rd/00-workflow-record.md)
- 文档目的：把已冻结的模块级 UI/UX 与 Implementation RD 统一转换成 Flutter 可消费的架构交接输入，并作为实现前边界的唯一总表

## 1. 共享 Flutter token 映射

- 全局主题 token 直接继承 [light-theme-freeze.yaml](D:/Projects/Flutter/rhythm/docs/rd/light-theme-freeze.yaml) 与 [dark-theme-freeze.yaml](D:/Projects/Flutter/rhythm/docs/rd/dark-theme-freeze.yaml)。
- `color.surface.*`：映射所有主卡、次卡、弹层与小组件预览的表面层级。
- `color.text.*`：映射标题、正文、元信息与风险说明，不允许模块局部自建文本色阶。
- `color.primary.*`：映射主 CTA、主结果高亮和夜间动作强调。
- `color.status.*`：映射成功、警告、错误、锁定和部分数据语义。
- `space.8n`：以 8pt 基础节奏映射卡片内边距、卡片间距、页边距与列表分组。
- `radius.card` / `radius.field`：映射卡片与输入层统一圆角，不在模块内另起语言。
- `border.card` / `border.input`：映射细边框存在感，保证 light / dark 双主题都保留层级。
- `type.display` / `type.headline` / `type.body` / `type.meta`：映射主结果、页面身份、正文说明和元信息层级。

## 2. 共享组件与实现边界

- 全局 primitives：
  - `RhythmSurface`
  - `RhythmBorderCard`
  - `RhythmPrimaryButton`
  - `RhythmSecondaryButton`
  - `RhythmStatusBadge`
  - `RhythmInputField`
- 全局 composites：
  - `ResultSummaryCard`
  - `SupportNoteCard`
  - `LockedExplanationCard`
  - `SectionHeaderRow`
  - `ContextHintBanner`
- 模块私有 business widgets 必须保留在各自 feature `presentation/` 下，不上提到全局共享层。
- 动效策略：
  - 只允许轻确认、卡片状态切换、局部展开/收起。
  - 禁止把炫技动效作为品牌层级表达。

## 3. 实施波次与依赖冻结

- `wave-1`
  - `schedule-reminders`
  - `account-sync-membership`
- `wave-2`
  - `activation-entry`
  - `sleep-records`
  - `bedtime-session`
- `wave-3`
  - `today-feedback`
  - `calendar-history`
- `wave-4`
  - `insights-recovery`
  - `widget-bridge`
- 进入任一波次实现时，不允许重写上游模块已冻结的时间语义、账号语义、记录语义或首页聚合语义。

## 4. 模块架构交接

### `schedule-reminders`

- 输入文档：
  - [schedule-reminders.ui-ux.md](D:/Projects/Flutter/rhythm/docs/rd/modules/schedule-reminders/schedule-reminders.ui-ux.md)
  - [schedule-reminders.impl.md](D:/Projects/Flutter/rhythm/docs/rd/modules/schedule-reminders/schedule-reminders.impl.md)
- 组件分解：`GoalTimePairCard`、`ReminderStrategyOptionCard`、`TimezoneExplainerCard`、`ScheduleSupportNote`
- 屏幕骨架：目标时间页、提醒策略页、时区模式页
- 状态边界：`GoalScheduleFormController`、`ReminderSettingsController`、`TimezoneModeController`
- 插件与数据边界：`flutter_local_notifications`、`flutter_timezone`、`timezone`、设置仓储 / 调度网关
- 还原策略：`preserve_faithfully`

### `account-sync-membership`

- 输入文档：
  - [account-sync-membership.ui-ux.md](D:/Projects/Flutter/rhythm/docs/rd/modules/account-sync-membership/account-sync-membership.ui-ux.md)
  - [account-sync-membership.impl.md](D:/Projects/Flutter/rhythm/docs/rd/modules/account-sync-membership/account-sync-membership.impl.md)
- 组件分解：`AccountStatusSummaryCard`、`SyncStatusDetailCard`、`MembershipValueCard`、`PrivacyActionGroup`
- 屏幕骨架：我的页、会员页 / 付费墙、隐私与数据管理页
- 状态边界：`AccountSummaryController`、`SyncStatusController`、`MembershipSnapshotController`、`PrivacyActionController`
- 插件与数据边界：`supabase_flutter`、`purchases_flutter`、`flutter_secure_storage`
- 还原策略：`flutterize`

### `activation-entry`

- 输入文档：
  - [activation-entry.ui-ux.md](D:/Projects/Flutter/rhythm/docs/rd/modules/activation-entry/activation-entry.ui-ux.md)
  - [activation-entry.impl.md](D:/Projects/Flutter/rhythm/docs/rd/modules/activation-entry/activation-entry.impl.md)
- 组件分解：`OnboardingValueHeroCard`、`SignInMethodStack`、`PermissionBenefitCard`、`ActivationHandoffNote`
- 屏幕骨架：启动分发页、欢迎页、登录选择页、权限说明页、完成交接页
- 状态边界：`LaunchGuardController`、`OnboardingDraftController`、`PermissionBridgeController`
- 插件与数据边界：登录网关、健康权限网关、首启持久化仓储
- 还原策略：`preserve_faithfully`

### `sleep-records`

- 输入文档：
  - [sleep-records.ui-ux.md](D:/Projects/Flutter/rhythm/docs/rd/modules/sleep-records/sleep-records.ui-ux.md)
  - [sleep-records.impl.md](D:/Projects/Flutter/rhythm/docs/rd/modules/sleep-records/sleep-records.impl.md)
- 组件分解：`RecordResultSummaryCard`、`SourceTrustBadgeRow`、`ManualRecordFormSheet`、`LateReasonChipGroup`
- 屏幕骨架：记录中心页、手动补录页、记录修正页、标签弹层
- 状态边界：`SleepRecordListController`、`ManualRecordFormController`、`RecordCorrectionController`、`LateReasonController`
- 插件与数据边界：`health`、Drift 记录仓储、来源可信度适配器
- 还原策略：`preserve_faithfully`

### `bedtime-session`

- 输入文档：
  - [bedtime-session.ui-ux.md](D:/Projects/Flutter/rhythm/docs/rd/modules/bedtime-session/bedtime-session.ui-ux.md)
  - [bedtime-session.impl.md](D:/Projects/Flutter/rhythm/docs/rd/modules/bedtime-session/bedtime-session.impl.md)
- 组件分解：`BedtimeCountdownHeroCard`、`TonightStateChoiceStrip`、`BedtimeActionCard`、`BedtimeExitConfirmSheet`
- 屏幕骨架：睡前页、退出确认层、次级设置深链入口
- 状态边界：`BedtimeSessionController`、`TonightStateController`、`BedtimeActionController`
- 插件与数据边界：通知来源桥接、小组件来源桥接、夜间会话持久化
- 还原策略：`preserve_faithfully`

### `today-feedback`

- 输入文档：
  - [today-feedback.ui-ux.md](D:/Projects/Flutter/rhythm/docs/rd/modules/today-feedback/today-feedback.ui-ux.md)
  - [today-feedback.impl.md](D:/Projects/Flutter/rhythm/docs/rd/modules/today-feedback/today-feedback.impl.md)
- 组件分解：`LastNightResultCard`、`TonightPlanCard`、`RecoverySummaryCard`、`QuickActionStrip`
- 屏幕骨架：今日页主屏、局部趋势摘要区、快捷动作区
- 状态边界：`TodayFeedbackController`、`RecoverySummaryController`、`QuickActionAvailabilityController`
- 插件与数据边界：首页聚合服务、回流来源控制器、记录 / 作息 / 睡前摘要适配器
- 还原策略：`preserve_faithfully`

### `calendar-history`

- 输入文档：
  - [calendar-history.ui-ux.md](D:/Projects/Flutter/rhythm/docs/rd/modules/calendar-history/calendar-history.ui-ux.md)
  - [calendar-history.impl.md](D:/Projects/Flutter/rhythm/docs/rd/modules/calendar-history/calendar-history.impl.md)
- 组件分解：`MonthlyHeatmapPanel`、`HistoryFilterChipBar`、`DayDetailSummaryCard`、`HistoryLockNoteCard`
- 屏幕骨架：月历主屏、单日详情弹层、高级历史锁定说明
- 状态边界：`CalendarHistoryController`、`HistoryFilterController`、`DayDetailController`
- 插件与数据边界：`fl_chart`、记录仓储、目标语义映射服务
- 还原策略：`flutterize`

### `insights-recovery`

- 输入文档：
  - [insights-recovery.ui-ux.md](D:/Projects/Flutter/rhythm/docs/rd/modules/insights-recovery/insights-recovery.ui-ux.md)
  - [insights-recovery.impl.md](D:/Projects/Flutter/rhythm/docs/rd/modules/insights-recovery/insights-recovery.impl.md)
- 组件分解：`WeeklyInsightHeroCard`、`StabilityExplainerPanel`、`CauseDistributionCard`、`RecoveryPlanCard`
- 屏幕骨架：洞察首页、周报详情、恢复计划详情、历史报告页
- 状态边界：`InsightsRecoveryController`、`WeeklyReportController`、`RecoveryPlanController`、`PremiumInsightGateController`
- 插件与数据边界：周报聚合服务、稳定度算法服务、会员状态适配器
- 还原策略：`preserve_faithfully`

### `widget-bridge`

- 输入文档：
  - [widget-bridge.ui-ux.md](D:/Projects/Flutter/rhythm/docs/rd/modules/widget-bridge/widget-bridge.ui-ux.md)
  - [widget-bridge.impl.md](D:/Projects/Flutter/rhythm/docs/rd/modules/widget-bridge/widget-bridge.impl.md)
- 组件分解：`WidgetValuePreviewCard`、`AddWidgetStepGroup`、`WidgetContextBadge`、`WidgetUpgradePreviewCard`
- 屏幕骨架：小组件引导页、小组件预览页、桌面回流上下文恢复层
- 状态边界：`WidgetBridgeController`、`WidgetSupportController`、`WidgetSnapshotController`、`WidgetEntryContextController`
- 插件与数据边界：`home_widget`、快照生成服务、平台支持网关
- 还原策略：`flutterize`

## 5. 实现护栏

- 代码实现只能消费本文件与各模块冻结 RD，不得在实现阶段重新发明新的页面层级。
- 若真实插件能力与冻结交接冲突，必须回到 `flutter-design-source-control`，不能在实现侧静默改设计。
- `hooks_riverpod` + `@riverpod` 作为显示层默认组织方式；页面与业务组件分离，避免控制器回流到 widget 树深处。
- 每个模块的 business widget 只在本模块内复用，除非全局冻结合同已明确上升为共享公共组件。
