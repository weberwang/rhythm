# Rhythm 模块拆分索引

## 0. 文档信息

- 文档名称：Rhythm 模块拆分索引
- 对应 PRD：[rhythm-sleep-routine-management-prd-commercial-2026-06-02.md](D:/Projects/Flutter/rhythm/docs/rhythm-sleep-routine-management-prd-commercial-2026-06-02.md)
- 对应全局技术基线：[01-global-technical-baseline.md](D:/Projects/Flutter/rhythm/docs/rd/01-global-technical-baseline.md)
- 输出日期：2026-06-02
- 目的：把项目级 PRD 与全局技术基线拆解为可独立设计、实现、测试和评审的模块级 RD 文档集合

## 1. 模块拆分表

| 模块 | 责任边界 | 核心页面 / 入口 | 数据所有权 | 上游依赖 | 下游依赖 | 发布价值 |
| --- | --- | --- | --- | --- | --- | --- |
| `activation-entry` | 首次激活、启动分发、价值说明、登录/匿名进入、健康权限与首轮配置交接 | 启动页、欢迎页、登录选择页、健康授权页、完成过渡页 | `LaunchState`、`OnboardingDraft`、首轮激活完成态 | 账户同步会员、作息与提醒 | 今日反馈、睡前执行、小组件桥接 | 决定首启转化、授权率和首晚闭环进入率 |
| `schedule-reminders` | 目标作息、熬夜阈值、一天起始时间、时区模式、提醒策略 | 目标设置页、作息设置页、提醒设置页、时区模式页 | `GoalSchedule`、`NotificationSetting`、时区策略 | 无 | 激活入口、睡前执行、今日反馈、历史日历、洞察恢复、小组件桥接 | 决定全局判断基准和提醒触达能力 |
| `sleep-records` | 自动睡眠读取、手动补录、来源可信度、记录修正、晚睡原因标签 | 睡眠记录中心页、手动补录页、记录来源说明、标签选择 | `SleepRecord`、`EffectiveSleepRecord`、`SleepDelayTag` | 作息与提醒 | 今日反馈、历史日历、洞察恢复 | 决定数据闭环是否可信可用 |
| `bedtime-session` | 睡前模式、倒计时、今晚状态、收尾动作建议 | 睡前页、通知唤起进入、夜间执行流 | `BedtimeSession`、`BedtimeStatus`、`BedtimeAction` | 作息与提醒 | 今日反馈、洞察恢复、小组件桥接 | 决定行为干预是否成立 |
| `today-feedback` | 今日首页聚合、昨晚结果、今晚行动、恢复建议摘要、快捷操作 | 今日页 | `TodaySummary`、今日主动作状态 | 睡眠记录、睡前执行、作息与提醒 | 洞察恢复、会员入口、小组件桥接 | 决定日回访留存和下一步行动感 |
| `calendar-history` | 月历热力图、筛选、单日详情、长期历史反馈 | 日历页、单日详情、筛选弹层 | `CalendarMonthSummary`、`CalendarDaySummary`、`CalendarFilter` | 睡眠记录、作息与提醒 | 洞察恢复、会员入口 | 决定长期趋势可视化价值 |
| `insights-recovery` | 周报、稳定度、原因分布、恢复计划、高级洞察入口 | 洞察页、周报详情、报告历史、恢复详情 | `WeeklyReport`、`RecoveryPlan`、`StabilityScore` | 睡眠记录、作息与提醒、今日反馈 | 会员入口 | 决定复盘价值和付费承接强度 |
| `account-sync-membership` | 我的页、账号状态、同步状态、付费墙、会员权益、隐私与数据管理 | 我的页、账号同步页、会员页、付费墙、隐私数据页 | 账号会话、同步队列状态、会员快照、数据访问状态 | 无 | 激活入口、今日反馈、洞察恢复 | 决定信任、恢复、跨设备能力和商业闭环 |
| `widget-bridge` | 小组件快照、桌面入口、组件引导、来源桥接 | 小组件引导页、组件主题页、桌面唤起入口 | `WidgetSnapshot`、`WidgetEntrySource` | 作息与提醒、今日反馈、睡前执行 | 激活入口、账号同步会员 | 决定桌面存在感和睡前快速触达 |

## 2. 文档路径

| 模块 | UI/UX RD | Implementation RD |
| --- | --- | --- |
| `activation-entry` | [activation-entry.ui-ux.md](D:/Projects/Flutter/rhythm/docs/rd/modules/activation-entry/activation-entry.ui-ux.md) | [activation-entry.impl.md](D:/Projects/Flutter/rhythm/docs/rd/modules/activation-entry/activation-entry.impl.md) |
| `schedule-reminders` | [schedule-reminders.ui-ux.md](D:/Projects/Flutter/rhythm/docs/rd/modules/schedule-reminders/schedule-reminders.ui-ux.md) | [schedule-reminders.impl.md](D:/Projects/Flutter/rhythm/docs/rd/modules/schedule-reminders/schedule-reminders.impl.md) |
| `sleep-records` | [sleep-records.ui-ux.md](D:/Projects/Flutter/rhythm/docs/rd/modules/sleep-records/sleep-records.ui-ux.md) | [sleep-records.impl.md](D:/Projects/Flutter/rhythm/docs/rd/modules/sleep-records/sleep-records.impl.md) |
| `bedtime-session` | [bedtime-session.ui-ux.md](D:/Projects/Flutter/rhythm/docs/rd/modules/bedtime-session/bedtime-session.ui-ux.md) | [bedtime-session.impl.md](D:/Projects/Flutter/rhythm/docs/rd/modules/bedtime-session/bedtime-session.impl.md) |
| `today-feedback` | [today-feedback.ui-ux.md](D:/Projects/Flutter/rhythm/docs/rd/modules/today-feedback/today-feedback.ui-ux.md) | [today-feedback.impl.md](D:/Projects/Flutter/rhythm/docs/rd/modules/today-feedback/today-feedback.impl.md) |
| `calendar-history` | [calendar-history.ui-ux.md](D:/Projects/Flutter/rhythm/docs/rd/modules/calendar-history/calendar-history.ui-ux.md) | [calendar-history.impl.md](D:/Projects/Flutter/rhythm/docs/rd/modules/calendar-history/calendar-history.impl.md) |
| `insights-recovery` | [insights-recovery.ui-ux.md](D:/Projects/Flutter/rhythm/docs/rd/modules/insights-recovery/insights-recovery.ui-ux.md) | [insights-recovery.impl.md](D:/Projects/Flutter/rhythm/docs/rd/modules/insights-recovery/insights-recovery.impl.md) |
| `account-sync-membership` | [account-sync-membership.ui-ux.md](D:/Projects/Flutter/rhythm/docs/rd/modules/account-sync-membership/account-sync-membership.ui-ux.md) | [account-sync-membership.impl.md](D:/Projects/Flutter/rhythm/docs/rd/modules/account-sync-membership/account-sync-membership.impl.md) |
| `widget-bridge` | [widget-bridge.ui-ux.md](D:/Projects/Flutter/rhythm/docs/rd/modules/widget-bridge/widget-bridge.ui-ux.md) | [widget-bridge.impl.md](D:/Projects/Flutter/rhythm/docs/rd/modules/widget-bridge/widget-bridge.impl.md) |

## 3. 模块详情卡

### `activation-entry`

- 用户任务：在 2 分钟内理解产品价值并进入可用状态。
- 页面范围：启动分发、欢迎页、登录/匿名入口、权限说明、首轮完成过渡。
- 领域责任：管理首启草稿、激活完成状态和进入主应用前的最低信任链路。
- 技术约束：不拥有长期作息规则和提醒规则，只编排其首轮输入。
- 发布价值：决定授权率、激活完成率和主闭环进入率。

### `schedule-reminders`

- 用户任务：建立全局时间基准，并配置尽量不打扰但有效的提醒策略。
- 页面范围：目标作息设置、提醒设置、时区模式、后续设置页。
- 领域责任：统一维护 `GoalSchedule`、阈值、提醒方案和时区解释。
- 技术约束：这是多个模块的上游依赖，模块设计不得把目标时间语义散落到别处。
- 发布价值：决定所有反馈、热力图颜色、通知时间和恢复规则的计算基准。

### `sleep-records`

- 用户任务：让昨晚结果可信、可修正、可解释。
- 页面范围：自动同步状态、手动补录、来源说明、标签选择、记录中心。
- 领域责任：统一管理睡眠记录来源、可信度、修正语义和晚睡原因标签。
- 技术约束：必须先本地可用，再向今日、日历、洞察提供聚合数据。
- 发布价值：决定产品是否会退化成“不可信的睡眠看板”。

### `bedtime-session`

- 用户任务：在睡前少做一个拖延行为并完成轻量收尾。
- 页面范围：睡前页、倒计时、今晚状态选择、建议动作。
- 领域责任：管理夜间执行会话、进入来源和动作完成结果。
- 技术约束：夜间路径必须低刺激、低步骤，不把复杂表单带入该模块。
- 发布价值：决定北极星指标中的“睡前模式参与”是否成立。

### `today-feedback`

- 用户任务：今天打开后立刻知道昨晚如何、今晚做什么、现在下一步是什么。
- 页面范围：今日首页及其摘要卡区块。
- 领域责任：聚合记录、计划、睡前状态和恢复建议摘要。
- 技术约束：以聚合展示为主，不重复拥有底层记录或计划规则。
- 发布价值：决定日回访留存和用户的“产品有用感”。

### `calendar-history`

- 用户任务：看见长期趋势，并能回到某一天理解原因。
- 页面范围：月历页、筛选、单日详情。
- 领域责任：把记录转成长期可视化反馈和历史解释入口。
- 技术约束：颜色和判定必须继承全局目标时间语义。
- 发布价值：建立免费层长期价值证明和历史付费边界。

### `insights-recovery`

- 用户任务：周期性复盘，理解稳定度，并获得恢复方向。
- 页面范围：洞察首页、周报详情、报告历史、恢复计划详情。
- 领域责任：周报聚合、稳定度、原因分布、恢复效果与高级说明。
- 技术约束：解释必须可行动，不能退化成纯图表堆叠。
- 发布价值：承担复盘留存与订阅转化主入口。

### `account-sync-membership`

- 用户任务：建立对账号、同步、隐私和付费的信任。
- 页面范围：我的页、账号同步、付费墙、会员页、隐私数据页。
- 领域责任：统一管理账号会话、同步状态、权益快照和数据访问路径。
- 技术约束：必须与匿名态、本地优先和购买恢复策略保持一致。
- 发布价值：决定换机恢复、跨设备同步和商业化闭环质量。

### `widget-bridge`

- 用户任务：在桌面上快速看到今晚目标并一键进入关键动作。
- 页面范围：小组件引导、组件主题/说明、桌面入口唤起。
- 领域责任：管理桌面快照、入口来源和组件显示语义。
- 技术约束：作为平台桥接模块，不应反向拥有业务主规则。
- 发布价值：提高桌面存在感和睡前模式入口可达性。

## 4. 模块依赖

- `activation-entry` 依赖 `account-sync-membership` 提供账号入口语义，依赖 `schedule-reminders` 提供首轮目标/提醒表单能力。
- `today-feedback` 依赖 `sleep-records` 提供昨晚结果，依赖 `schedule-reminders` 提供目标基准，依赖 `bedtime-session` 提供今晚状态摘要。
- `calendar-history` 与 `insights-recovery` 都以 `sleep-records` 为主数据源，并继承 `schedule-reminders` 的时间语义。
- `account-sync-membership` 与 `widget-bridge` 是平台能力边界模块，但不能篡改主业务规则，只能消费上游聚合结果。
- `insights-recovery` 可以消费 `today-feedback` 的摘要语义，但不应反向拥有今日页的入口职责。

## 5. 初始工作流状态

| 模块 | 初始工作流状态 |
| --- | --- |
| `activation-entry` | `modules_split` |
| `schedule-reminders` | `modules_split` |
| `sleep-records` | `modules_split` |
| `bedtime-session` | `modules_split` |
| `today-feedback` | `modules_split` |
| `calendar-history` | `modules_split` |
| `insights-recovery` | `modules_split` |
| `account-sync-membership` | `modules_split` |
| `widget-bridge` | `modules_split` |

## 6. open_questions

- 匿名用户与购买权益的绑定策略是否要求首发就支持完整恢复购买链路。
- 中国区与英语区是否同步首发，这会影响模块文案、洞察解释和会员承接的默认配置。
- 轮班 / 时差高级策略是否前移到首发模块设计；若前移，`schedule-reminders` 与 `insights-recovery` 的边界需要再细化。
- 小组件是否首发同时覆盖 Android 与 iOS，还是先做单平台正式交付。
- 远程配置 / AB 是否首发接入；若接入，`account-sync-membership` 与 `insights-recovery` 的埋点/实验边界要补充。

## 7. next_skill_recommendation

- 推荐下一技能：`mobile-ui-design-coach`
- 原因：模块边界和配对文档已建立，但各模块仍缺少模块级 UI/UX 方向、页面层级和商业视觉决策，应先进入 UI/UX 设计阶段，而不是直接冻结全局设计或开始实现。
