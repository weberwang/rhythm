# Rhythm 商业级 RD 模块索引

> 日期：2026-06-02
> PRD：`docs/rhythm-sleep-routine-management-prd-commercial-2026-06-02.md`
> 全局技术基线：`docs/rd/2026-06-02-rhythm-commercial-global-rd.md`
> 初始工作流状态：`modules_split`

## 1. 模块拆分原则

本次拆分按稳定责任边界划分，而不是按页面数量划分。模块成立条件包括：

- 有独立用户任务或业务流程。
- 有独立数据生命周期、权限边界或同步边界。
- 能独立完成 UI/UX 设计、Pencil 核对、实现和测试。
- 能独立贡献激活、留存、信任、付费或发布价值。

## 2. 模块总览

| 模块 | 责任 | 页面/状态范围 | 数据 owner | 发布价值 | 状态 |
| --- | --- | --- | --- | --- | --- |
| `app_foundation` | 应用壳、主题、路由、国际化、共享组件 | 启动壳、Shell、全局反馈 | App 配置、偏好、分析网关 | 支撑全部模块 | `pen_ready` |
| `activation_onboarding` | 首次激活和商业级引导漏斗 | 欢迎、登录、健康授权、完成过渡 | onboarding 状态、授权意图 | 提升激活和授权 | `modules_split` |
| `goal_schedule` | 目标作息和全局判断基准 | 目标设置、目标编辑、时区特殊模式 | `GoalSchedule` | 支撑全部反馈口径 | `modules_split` |
| `sleep_records` | 健康数据接入、手动补录、修正 | 数据接入、补录、来源说明 | `SleepRecord`、有效记录 | 跑通数据闭环 | `modules_split` |
| `today_feedback` | 每日状态面板和次日反馈 | 今日页、快捷记录、恢复摘要 | `TodaySummary` | 留存主入口 | `modules_split` |
| `bedtime_notifications` | 睡前模式、本地提醒和通知入口 | 睡前页、提醒设置、通知补救 | `BedtimeSession`、提醒计划 | 北极星行为入口 | `modules_split` |
| `calendar_tags` | 月历热力图、单日详情和原因标签 | 日历、详情弹层、标签弹层 | `CalendarSummary`、`SleepDelayTag` | 免费价值证明 | `modules_split` |
| `insights_recovery` | 周报、稳定度、恢复计划和历史洞察 | 洞察、周报详情、历史洞察 | `WeeklyReport`、`RecoveryPlan` | 留存和付费承接 | `modules_split` |
| `account_sync_privacy` | 账号、云同步、隐私与数据 | 账号同步、隐私、数据导出删除 | `SyncQueue`、用户隐私动作 | 信任和换机恢复 | `modules_split` |
| `membership_paywall` | 会员权益、付费墙、订阅状态 | 轻量付费墙、会员中心、权益说明 | `MembershipEntitlement` | 商业转化 | `modules_split` |
| `widget_presence` | 小组件、桌面入口和快照隐私 | 小组件引导、小组件主题 | `WidgetSnapshot` | 提升睡前入口可达 | `modules_split` |
| `analytics_release` | 埋点字典、发布、监控和灰度 | 无独立业务页，覆盖全链路状态 | 事件、发布清单、质量门槛 | 内测与运营支撑 | `modules_split` |

## 3. 文档路径

| 模块 | UI/UX RD | 实现 RD |
| --- | --- | --- |
| `app_foundation` | `docs/rd/modules/app_foundation/app_foundation.ui-ux.md` | `docs/rd/modules/app_foundation/app_foundation.impl.md` |
| `activation_onboarding` | `docs/rd/modules/activation_onboarding/activation_onboarding.ui-ux.md` | `docs/rd/modules/activation_onboarding/activation_onboarding.impl.md` |
| `goal_schedule` | `docs/rd/modules/goal_schedule/goal_schedule.ui-ux.md` | `docs/rd/modules/goal_schedule/goal_schedule.impl.md` |
| `sleep_records` | `docs/rd/modules/sleep_records/sleep_records.ui-ux.md` | `docs/rd/modules/sleep_records/sleep_records.impl.md` |
| `today_feedback` | `docs/rd/modules/today_feedback/today_feedback.ui-ux.md` | `docs/rd/modules/today_feedback/today_feedback.impl.md` |
| `bedtime_notifications` | `docs/rd/modules/bedtime_notifications/bedtime_notifications.ui-ux.md` | `docs/rd/modules/bedtime_notifications/bedtime_notifications.impl.md` |
| `calendar_tags` | `docs/rd/modules/calendar_tags/calendar_tags.ui-ux.md` | `docs/rd/modules/calendar_tags/calendar_tags.impl.md` |
| `insights_recovery` | `docs/rd/modules/insights_recovery/insights_recovery.ui-ux.md` | `docs/rd/modules/insights_recovery/insights_recovery.impl.md` |
| `account_sync_privacy` | `docs/rd/modules/account_sync_privacy/account_sync_privacy.ui-ux.md` | `docs/rd/modules/account_sync_privacy/account_sync_privacy.impl.md` |
| `membership_paywall` | `docs/rd/modules/membership_paywall/membership_paywall.ui-ux.md` | `docs/rd/modules/membership_paywall/membership_paywall.impl.md` |
| `widget_presence` | `docs/rd/modules/widget_presence/widget_presence.ui-ux.md` | `docs/rd/modules/widget_presence/widget_presence.impl.md` |
| `analytics_release` | `docs/rd/modules/analytics_release/analytics_release.ui-ux.md` | `docs/rd/modules/analytics_release/analytics_release.impl.md` |

## 4. 模块依赖图

```text
app_foundation
  -> activation_onboarding
  -> goal_schedule
  -> sleep_records
  -> today_feedback
  -> bedtime_notifications
  -> calendar_tags
  -> insights_recovery
  -> account_sync_privacy
  -> membership_paywall
  -> widget_presence
  -> analytics_release

goal_schedule -> sleep_records -> today_feedback -> insights_recovery
goal_schedule -> bedtime_notifications -> today_feedback
sleep_records -> calendar_tags -> insights_recovery
calendar_tags -> today_feedback
membership_paywall -> insights_recovery
account_sync_privacy -> sleep_records
widget_presence -> bedtime_notifications
analytics_release -> all modules
```

## 5. 全局继承约束

所有模块必须继承：

- 本地优先架构。
- Riverpod 注解生成。
- GoRouter 单一路由树。
- Drift 结构化业务数据。
- Supabase 作为首发同步底座。
- Purchases 只通过内部会员模型暴露。
- 健康、通知、小组件 SDK 只落在 data/infrastructure 边界。
- 用户可见文案走 ARB。
- 设计冻结前不得进入 Flutter 实现。
- 显示层实现前必须核对 `pen/v3.pen` 设计来源。

## 6. 初始下一步建议

推荐顺序：

1. `activation_onboarding` 进入 `mobile-ui-design-coach`，生成商业级 UI/UX 冻结包。
2. `goal_schedule` 和 `sleep_records` 做实现 RD 校准，确认目标时间与有效记录口径。
3. `today_feedback`、`bedtime_notifications`、`calendar_tags` 按核心闭环依赖顺序进入 UI/UX 设计。
4. `insights_recovery` 和 `membership_paywall` 在付费触点策略确认后进入设计冻结。

## 7. 开放问题

- 是否把匿名本地使用作为正式首发路径。
- 是否在 V0.1 真实接入 Apple / Google 登录。
- 是否在 V0.1 引入 Crash 监控和远程配置。
- 是否将工作日/休息日双目标提前到 V0.2。
