# Rhythm 模块拆分索引

## 0. 文档信息

- 文档名称：Rhythm 模块拆分索引
- 对应 PRD：[rhythm-sleep-routine-management-prd-commercial-2026-06-02.md](/E:/Projects/flutter/rhythm/docs/rhythm-sleep-routine-management-prd-commercial-2026-06-02.md)
- 对应全局技术基线：[01-global-technical-baseline.md](/E:/Projects/flutter/rhythm/docs/rd/01-global-technical-baseline.md)
- 对应共享冻结源：
  - [global-design-guidelines.md](/E:/Projects/flutter/rhythm/docs/rd/global-design-guidelines.md)
  - [light-theme-freeze.yaml](/E:/Projects/flutter/rhythm/docs/rd/light-theme-freeze.yaml)
  - [dark-theme-freeze.yaml](/E:/Projects/flutter/rhythm/docs/rd/dark-theme-freeze.yaml)
- 对应共享冻结评估：[shared-freeze-assessment-style-01r-2026-06-03.md](/E:/Projects/flutter/rhythm/docs/rd/reviews/shared-freeze-assessment-style-01r-2026-06-03.md)
- 输出日期：2026-06-03
- 目的：在确认 `style-01r` 共享冻结候选后，把项目保持为可执行的 `modules_split` 结构化起点，并给出可直接用于后续实现准备的依赖与并行计划。

## 1. 模块摘要表

| module_name | goal_or_scope | uiux_doc | impl_doc | depends_on | unblocks | parallel_group | recommended_stage | parallelization_notes |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| `schedule-reminders` | 定义目标作息、熬夜阈值、提醒策略和时区语义 | [schedule-reminders.ui-ux.md](/E:/Projects/flutter/rhythm/docs/rd/modules/schedule-reminders/schedule-reminders.ui-ux.md) | [schedule-reminders.impl.md](/E:/Projects/flutter/rhythm/docs/rd/modules/schedule-reminders/schedule-reminders.impl.md) | `none` | `activation-entry`、`sleep-records`、`bedtime-session`、`today-feedback`、`calendar-history`、`insights-recovery`、`widget-bridge` | `foundation` | `stage_1_foundation` | 全局时间与提醒语义是多个模块的共享前提，应优先落地，但可与账号模块并行。 |
| `account-sync-membership` | 统一账号会话、同步状态、会员权益与隐私数据管理 | [account-sync-membership.ui-ux.md](/E:/Projects/flutter/rhythm/docs/rd/modules/account-sync-membership/account-sync-membership.ui-ux.md) | [account-sync-membership.impl.md](/E:/Projects/flutter/rhythm/docs/rd/modules/account-sync-membership/account-sync-membership.impl.md) | `none` | `activation-entry`、`today-feedback`、`insights-recovery` | `foundation` | `stage_1_foundation` | 与作息设置无直接数据耦合，可并行，但要保持匿名态与付费态迁移约束稳定。 |
| `sleep-records` | 管理自动读取、手动补录、来源可信度与晚睡原因标签 | [sleep-records.ui-ux.md](/E:/Projects/flutter/rhythm/docs/rd/modules/sleep-records/sleep-records.ui-ux.md) | [sleep-records.impl.md](/E:/Projects/flutter/rhythm/docs/rd/modules/sleep-records/sleep-records.impl.md) | `schedule-reminders` | `today-feedback`、`calendar-history`、`insights-recovery` | `data_intake` | `stage_2_data_intake` | 依赖全局时间语义，但和首启激活可并行推进。 |
| `activation-entry` | 完成启动分发、欢迎、登录/匿名进入、健康权限与首轮配置交接 | [activation-entry.ui-ux.md](/E:/Projects/flutter/rhythm/docs/rd/modules/activation-entry/activation-entry.ui-ux.md) | [activation-entry.impl.md](/E:/Projects/flutter/rhythm/docs/rd/modules/activation-entry/activation-entry.impl.md) | `schedule-reminders`、`account-sync-membership` | `today-feedback`、`bedtime-session`、`widget-bridge` | `data_intake` | `stage_2_data_intake` | 与睡眠记录共享“首个可用闭环”，但首启路径不应等待历史聚合能力完成。 |
| `bedtime-session` | 管理睡前模式、倒计时、今晚状态与轻量收尾动作 | [bedtime-session.ui-ux.md](/E:/Projects/flutter/rhythm/docs/rd/modules/bedtime-session/bedtime-session.ui-ux.md) | [bedtime-session.impl.md](/E:/Projects/flutter/rhythm/docs/rd/modules/bedtime-session/bedtime-session.impl.md) | `schedule-reminders` | `today-feedback`、`widget-bridge` | `daily_loop` | `stage_3_daily_loop` | 只依赖作息目标，可在睡眠记录之后或并行进入，但要先于今日聚合与桌面入口定稿。 |
| `calendar-history` | 把长期结果转成热力日历、筛选与单日详情 | [calendar-history.ui-ux.md](/E:/Projects/flutter/rhythm/docs/rd/modules/calendar-history/calendar-history.ui-ux.md) | [calendar-history.impl.md](/E:/Projects/flutter/rhythm/docs/rd/modules/calendar-history/calendar-history.impl.md) | `schedule-reminders`、`sleep-records` | `insights-recovery` | `daily_loop` | `stage_3_daily_loop` | 与睡前执行解耦，可在同一波次并行，但热力语义必须锁死在全局目标基准上。 |
| `today-feedback` | 聚合昨晚结果、今晚行动与恢复建议摘要 | [today-feedback.ui-ux.md](/E:/Projects/flutter/rhythm/docs/rd/modules/today-feedback/today-feedback.ui-ux.md) | [today-feedback.impl.md](/E:/Projects/flutter/rhythm/docs/rd/modules/today-feedback/today-feedback.impl.md) | `schedule-reminders`、`sleep-records`、`bedtime-session` | `insights-recovery`、`widget-bridge` | `aggregation` | `stage_4_aggregation` | 需要等昨晚记录与今晚会话语义都稳定后再落地，否则首页主焦点容易反复改写。 |
| `insights-recovery` | 输出周报、稳定度、恢复计划与高级洞察入口 | [insights-recovery.ui-ux.md](/E:/Projects/flutter/rhythm/docs/rd/modules/insights-recovery/insights-recovery.ui-ux.md) | [insights-recovery.impl.md](/E:/Projects/flutter/rhythm/docs/rd/modules/insights-recovery/insights-recovery.impl.md) | `schedule-reminders`、`sleep-records`、`today-feedback`、`calendar-history` | `account-sync-membership` | `retention_growth` | `stage_5_retention_growth` | 依赖聚合结果与历史解释，适合在首页与日历语义稳定后推进。 |
| `widget-bridge` | 管理桌面小组件快照、入口来源与唤起桥接 | [widget-bridge.ui-ux.md](/E:/Projects/flutter/rhythm/docs/rd/modules/widget-bridge/widget-bridge.ui-ux.md) | [widget-bridge.impl.md](/E:/Projects/flutter/rhythm/docs/rd/modules/widget-bridge/widget-bridge.impl.md) | `schedule-reminders`、`bedtime-session`、`today-feedback` | `activation-entry` | `retention_growth` | `stage_5_retention_growth` | 依赖首页摘要与睡前动作语义稳定后再做，避免桌面快照字段反复变化。 |

## 2. 依赖摘要

- `schedule-reminders` 是全局上游模块。目标时间、提醒窗口、时区语义和晚睡阈值必须先固定，否则后续热力图、倒计时和周报解释都会漂移。
- `account-sync-membership` 是账号与商业前提模块。它不决定主业务语义，但决定首启登录、换机恢复、订阅承接和隐私管理边界。
- `sleep-records` 是数据可信度前提模块。没有它，`today-feedback`、`calendar-history`、`insights-recovery` 只能展示空容器或弱结论。
- `bedtime-session` 是行为干预前提模块。它为 `today-feedback` 和 `widget-bridge` 提供今晚状态与夜间行动语义。
- `today-feedback` 是聚合层模块。它依赖记录、计划与夜间会话，反过来为 `insights-recovery` 与 `widget-bridge` 提供“今日可执行摘要”。
- `calendar-history` 和 `insights-recovery` 都消费历史趋势，但前者是长期可视化入口，后者是解释与恢复承接入口，不应互相吞并职责。
- `widget-bridge` 只消费主业务摘要，不反向拥有主规则；桌面能力必须跟随主应用语义，而不是自创字段。

## 3. 并行执行计划

### `stage_1_foundation`

- 可并行模块：`schedule-reminders`、`account-sync-membership`
- 原因：一个定义全局时间/提醒语义，一个定义账号/同步/会员边界，职责独立且互不等待。
- 交付目标：确认全局时间基准、提醒策略框架、匿名与登录态切换、付费与同步语义。

### `stage_2_data_intake`

- 可并行模块：`sleep-records`、`activation-entry`
- 前置条件：`stage_1_foundation` 已确认。
- 原因：两者共享“首个可用闭环”目标，但数据生命周期与首启编排边界不同。
- 交付目标：首启转化链路稳定、睡眠记录可信并可修正。

### `stage_3_daily_loop`

- 可并行模块：`bedtime-session`、`calendar-history`
- 前置条件：`schedule-reminders` 已确认，`sleep-records` 对日历可视化所需聚合已可用。
- 原因：睡前干预与长期回看属于不同使用时刻，可以并行，但都必须继承同一套共享冻结与时间语义。
- 交付目标：夜间行动闭环稳定、历史趋势可解释。

### `stage_4_aggregation`

- 可并行模块：`today-feedback`
- 前置条件：`sleep-records`、`bedtime-session`、`schedule-reminders` 已确认。
- 原因：今日首页是多源聚合面，主焦点和 CTA 语义不能在上游仍变动时提前冻结。
- 交付目标：形成“昨晚如何 -> 今晚做什么 -> 现在下一步是什么”的稳定首页结构。

### `stage_5_retention_growth`

- 可并行模块：`insights-recovery`、`widget-bridge`
- 前置条件：`today-feedback` 已确认；`calendar-history` 对洞察所需历史聚合已可用。
- 原因：一个承接长期复盘与付费解释，一个承接桌面触达与快捷回流；两者都依赖已有摘要语义，但彼此实现面相对独立。
- 交付目标：完成长期留存入口、订阅承接与桌面快照能力。

## 4. 模块详情卡

### `schedule-reminders`

- 用户任务：建立可信的目标作息基准，并配置柔性但有效的提醒策略。
- 页面与状态范围：目标设置、提醒设置、时区模式、通知权限说明、保存成功/失败、部分保存、锁定高级模式。
- 领域责任：拥有 `GoalSchedule`、提醒策略、阈值、一日开始时间与时区策略。
- 应用状态：表单草稿、保存中、保存失败、通知权限缺失、时区变化提示。
- 基础设施边界：本地持久化、通知调度、时区读取；不拥有昨晚结果与周报解释。
- 发布价值：为后续所有作息判断、热力色义和提醒调度提供唯一基准。

### `account-sync-membership`

- 用户任务：建立对账号、同步、隐私和付费的信任。
- 页面与状态范围：我的页、账号同步页、会员页、付费墙、隐私数据页、恢复购买与会话失效状态。
- 领域责任：拥有账号会话、同步状态、会员快照和数据访问路径。
- 应用状态：匿名态、登录态、同步中、同步失败、未订阅、已订阅、恢复中。
- 基础设施边界：`supabase_flutter`、`google_sign_in`、`sign_in_with_apple`、`purchases_flutter`、安全存储。
- 发布价值：决定跨设备恢复与商业闭环是否可信。

### `sleep-records`

- 用户任务：让昨晚结果可信、可修正、可解释。
- 页面与状态范围：自动同步状态、手动补录、来源说明、标签选择、记录中心、来源冲突与权限缺失。
- 领域责任：拥有 `SleepRecord`、`EffectiveSleepRecord`、`SleepDelayTag` 与来源可信度。
- 应用状态：同步中、同步失败、无健康权限、部分同步成功、手动补录完成。
- 基础设施边界：`health`、本地数据库、手动录入与标签持久化。
- 发布价值：决定产品是否会退化成不可信的睡眠看板。

### `activation-entry`

- 用户任务：在 2 分钟内理解产品价值并进入可用状态。
- 页面与状态范围：启动分发、欢迎页、登录/匿名入口、健康授权页、首轮完成过渡、拒绝权限后的降级路径。
- 领域责任：拥有首启草稿、激活完成状态与主应用前置编排。
- 应用状态：首次打开、已激活、匿名进入、登录进入、权限同意、权限拒绝、恢复会话。
- 基础设施边界：导航分发、权限触发、与账号/作息设置模块的首轮交接。
- 发布价值：决定授权率、激活完成率和首晚闭环进入率。

### `bedtime-session`

- 用户任务：在睡前完成一个最轻的收尾动作。
- 页面与状态范围：睡前页、倒计时区、今晚状态选择区、建议动作区、白天降级态、保存失败态。
- 领域责任：拥有 `BedtimeSession`、`BedtimeStatus`、`BedtimeAction` 与进入来源。
- 应用状态：可执行、白天降级、动作完成、动作跳过、通知进入、手动进入。
- 基础设施边界：基于作息目标和通知入口组织会话，不拥有睡眠记录本体。
- 发布价值：决定行为干预是否成立。

### `calendar-history`

- 用户任务：看见长期趋势，并能回到某一天理解原因。
- 页面与状态范围：月历热力图、筛选、单日详情、无数据日、历史锁定边界、聚合失败重试。
- 领域责任：拥有 `CalendarMonthSummary`、`CalendarDaySummary`、`CalendarFilter` 的展示与解释边界。
- 应用状态：月度加载、筛选切换、无记录、部分记录、单日详情展开。
- 基础设施边界：消费记录聚合与目标时间语义，不改写底层记录。
- 发布价值：建立免费层长期价值与高级历史边界。

### `today-feedback`

- 用户任务：今天打开后立刻知道昨晚如何、今晚做什么、现在下一步是什么。
- 页面与状态范围：今日首页摘要卡流、昨晚结果、今晚行动、恢复建议摘要、快捷入口。
- 领域责任：拥有 `TodaySummary` 与首页主动作状态聚合，不拥有底层数据规则。
- 应用状态：聚合加载、部分数据、无记录、可恢复建议、快捷操作完成确认。
- 基础设施边界：消费记录、计划、夜间会话摘要，向下游提供今日主语义。
- 发布价值：决定日回访留存和产品有用感。

### `insights-recovery`

- 用户任务：周期性复盘，理解稳定度，并获得恢复方向。
- 页面与状态范围：洞察首页、周报详情、报告历史、恢复计划详情、锁定高级解释、记录不足态。
- 领域责任：拥有 `WeeklyReport`、`RecoveryPlan`、`StabilityScore` 的解释层与商业承接层。
- 应用状态：周报生成中、数据不足、恢复建议可用、历史锁定、升级承接。
- 基础设施边界：消费记录与首页摘要，不回写首页主焦点。
- 发布价值：承担复盘留存与订阅转化主入口。

### `widget-bridge`

- 用户任务：在桌面上快速看到今晚目标并一键进入关键动作。
- 页面与状态范围：小组件引导、组件主题/说明、桌面入口唤起、快照无数据态、权限缺失态。
- 领域责任：拥有 `WidgetSnapshot` 与 `WidgetEntrySource`。
- 应用状态：未配置组件、已配置、快照更新中、快照缺失、入口回流。
- 基础设施边界：`home_widget`、本地快照同步与入口路由，不拥有主业务规则。
- 发布价值：提高桌面存在感和睡前模式入口可达性。

## 5. 初始工作流状态建议

| 模块 | current_state | uiux_status | impl_status | 说明 |
| --- | --- | --- | --- | --- |
| `schedule-reminders` | `modules_split` | `split_draft` | `split_draft` | 共享冻结已确认后，可作为优先精修候选。 |
| `account-sync-membership` | `modules_split` | `split_draft` | `split_draft` | 与作息设置并列为基础波次。 |
| `sleep-records` | `modules_split` | `split_draft` | `split_draft` | 依赖 `schedule-reminders` 的时间语义。 |
| `activation-entry` | `modules_split` | `split_draft` | `split_draft` | 依赖账号与作息设置的首轮交接。 |
| `bedtime-session` | `modules_split` | `split_draft` | `split_draft` | 日常闭环模块，后于基础波次。 |
| `calendar-history` | `modules_split` | `split_draft` | `split_draft` | 依赖记录数据与时间语义。 |
| `today-feedback` | `modules_split` | `split_draft` | `split_draft` | 依赖多源聚合，不宜过早精修。 |
| `insights-recovery` | `modules_split` | `split_draft` | `split_draft` | 后置于首页与历史语义稳定后。 |
| `widget-bridge` | `modules_split` | `split_draft` | `split_draft` | 后置于首页与睡前主语义稳定后。 |

## 6. open_questions

- 匿名用户与购买权益的绑定策略是否要求首发就支持完整恢复购买链路。
- 中国区与英语区是否同步首发，这会影响模块文案、洞察解释和会员承接的默认配置。
- 轮班 / 时差高级策略是否前移到首发模块设计；若前移，`schedule-reminders` 与 `insights-recovery` 的边界需要再细化。
- 小组件是否首发同时覆盖 Android 与 iOS，还是先做单平台正式交付。
- 远程配置 / AB 是否首发接入；若接入，`account-sync-membership` 与 `insights-recovery` 的埋点/实验边界要补充。

## 7. next_skill_recommendation

- 推荐下一技能：`none`
- 原因：本轮模块拆分重跑的目标是把共享冻结后的模块边界重新对齐，并把项目推进回 `modules_split`；确认之后，需要先选定一个活动模块，再进入 `flutter-rd-module-splitter` 的 implementation refinement mode。
- 推荐首个活动模块：`schedule-reminders`
- 推荐原因：
  - 它是最多模块的上游依赖。
  - 它能最快把共享冻结后的时间语义、CTA 语义和状态表达转成实现准备文档。
  - 它确认后，`sleep-records`、`bedtime-session`、`today-feedback`、`calendar-history` 的后续精修都会更稳定。
