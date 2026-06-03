# Rhythm 模块拆分索引

## 0. 文档信息

- 文档名称：Rhythm 模块拆分索引
- 对应 PRD：[rhythm-sleep-routine-management-prd-commercial-2026-06-02.md](D:/Projects/Flutter/rhythm/docs/rhythm-sleep-routine-management-prd-commercial-2026-06-02.md)
- 对应全局技术基线：[01-global-technical-baseline.md](D:/Projects/Flutter/rhythm/docs/rd/01-global-technical-baseline.md)
- 输出日期：2026-06-03
- 输出模式：`auto pre-implementation landed`
- 文档目的：把项目级 PRD 与全局技术基线拆解为可独立设计、实现、测试和评审的模块级文档集合，并显式标注依赖关系、并行实施阶段与当前实现前边界成熟度

## 1. 模块总表

| module_name | goal_or_scope | uiux_doc | impl_doc | depends_on | unblocks | parallel_group | recommended_stage | parallelization_notes | blocking_assumptions |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| `activation-entry` | 首次激活、启动分发、价值说明、登录/匿名进入、健康权限与首轮配置交接 | [activation-entry.ui-ux.md](D:/Projects/Flutter/rhythm/docs/rd/modules/activation-entry/activation-entry.ui-ux.md) | [activation-entry.impl.md](D:/Projects/Flutter/rhythm/docs/rd/modules/activation-entry/activation-entry.impl.md) | `schedule-reminders`, `account-sync-membership` | 首启闭环联调、首页可达性验收 | `wave-2A` | `stage-2` | 依赖首轮目标/提醒承接语义与账号入口语义；不建议早于对应上游模块落地 | 匿名策略与登录绑定桥接规则需保持当前技术基线假设 |
| `schedule-reminders` | 目标作息、熬夜阈值、一天起始时间、时区模式、提醒策略 | [schedule-reminders.ui-ux.md](D:/Projects/Flutter/rhythm/docs/rd/modules/schedule-reminders/schedule-reminders.ui-ux.md) | [schedule-reminders.impl.md](D:/Projects/Flutter/rhythm/docs/rd/modules/schedule-reminders/schedule-reminders.impl.md) | `none` | `activation-entry`, `sleep-records`, `bedtime-session`, `today-feedback`, `calendar-history`, `insights-recovery`, `widget-bridge` | `wave-1A` | `stage-1` | 这是全局时间语义源，必须优先冻结规则边界；可与账号模块并行 | 工作日/休息日双目标、轮班、时差高级策略首发范围仍待确认 |
| `sleep-records` | 自动睡眠读取、手动补录、来源可信度、记录修正、晚睡原因标签 | [sleep-records.ui-ux.md](D:/Projects/Flutter/rhythm/docs/rd/modules/sleep-records/sleep-records.ui-ux.md) | [sleep-records.impl.md](D:/Projects/Flutter/rhythm/docs/rd/modules/sleep-records/sleep-records.impl.md) | `schedule-reminders` | `today-feedback`, `calendar-history`, `insights-recovery` | `wave-2B` | `stage-2` | 依赖目标时间语义后即可独立推进；与 `activation-entry`、`bedtime-session` 可并行 | 健康权限空数据与手动补录降级路径必须维持一等状态 |
| `bedtime-session` | 睡前模式、倒计时、今晚状态、收尾动作建议 | [bedtime-session.ui-ux.md](D:/Projects/Flutter/rhythm/docs/rd/modules/bedtime-session/bedtime-session.ui-ux.md) | [bedtime-session.impl.md](D:/Projects/Flutter/rhythm/docs/rd/modules/bedtime-session/bedtime-session.impl.md) | `schedule-reminders` | `today-feedback`, `widget-bridge` | `wave-2C` | `stage-2` | 依赖目标时间与提醒语义；完成后可解锁首页行动摘要和桌面快捷入口 | 夜间路径低刺激和通知唤起上下文需在后续设计阶段细化 |
| `today-feedback` | 今日首页聚合、昨晚结果、今晚行动、恢复建议摘要、快捷操作 | [today-feedback.ui-ux.md](D:/Projects/Flutter/rhythm/docs/rd/modules/today-feedback/today-feedback.ui-ux.md) | [today-feedback.impl.md](D:/Projects/Flutter/rhythm/docs/rd/modules/today-feedback/today-feedback.impl.md) | `schedule-reminders`, `sleep-records`, `bedtime-session` | `insights-recovery`, `widget-bridge` | `wave-3A` | `stage-3` | 属于聚合模块，必须等核心上游摘要契约稳定后再实现；不可与其上游盲并行 | 聚合失败时的局部降级策略需要在实现前冻结 |
| `calendar-history` | 月历热力图、筛选、单日详情、长期历史反馈 | [calendar-history.ui-ux.md](D:/Projects/Flutter/rhythm/docs/rd/modules/calendar-history/calendar-history.ui-ux.md) | [calendar-history.impl.md](D:/Projects/Flutter/rhythm/docs/rd/modules/calendar-history/calendar-history.impl.md) | `schedule-reminders`, `sleep-records` | `insights-recovery` | `wave-3B` | `stage-3` | 与 `today-feedback` 同阶段安全并行，只共享记录与时间语义，不共享首页聚合状态所有权 | 免费历史与付费历史边界仍需结合商业策略确认 |
| `insights-recovery` | 周报、稳定度、原因分布、恢复计划、高级洞察入口 | [insights-recovery.ui-ux.md](D:/Projects/Flutter/rhythm/docs/rd/modules/insights-recovery/insights-recovery.ui-ux.md) | [insights-recovery.impl.md](D:/Projects/Flutter/rhythm/docs/rd/modules/insights-recovery/insights-recovery.impl.md) | `schedule-reminders`, `sleep-records`, `today-feedback`, `calendar-history` | 订阅价值验证、长期复盘闭环 | `wave-4A` | `stage-4` | 需要等待结果聚合与历史视图契约稳定；不建议早于 `today-feedback` 与 `calendar-history` | 稳定度算法、恢复计划深度与付费锁定边界仍需后续设计确认 |
| `account-sync-membership` | 我的页、账号状态、同步状态、付费墙、会员权益、隐私与数据管理 | [account-sync-membership.ui-ux.md](D:/Projects/Flutter/rhythm/docs/rd/modules/account-sync-membership/account-sync-membership.ui-ux.md) | [account-sync-membership.impl.md](D:/Projects/Flutter/rhythm/docs/rd/modules/account-sync-membership/account-sync-membership.impl.md) | `none` | `activation-entry`, `widget-bridge` | `wave-1B` | `stage-1` | 作为账号、同步、会员与隐私边界模块，可与 `schedule-reminders` 并行推进 | 匿名态与购买恢复绑定策略仍受待确认项影响 |
| `widget-bridge` | 小组件快照、桌面入口、组件引导、来源桥接 | [widget-bridge.ui-ux.md](D:/Projects/Flutter/rhythm/docs/rd/modules/widget-bridge/widget-bridge.ui-ux.md) | [widget-bridge.impl.md](D:/Projects/Flutter/rhythm/docs/rd/modules/widget-bridge/widget-bridge.impl.md) | `schedule-reminders`, `bedtime-session`, `today-feedback`, `account-sync-membership` | 桌面入口验收、平台桥接验证 | `wave-4B` | `stage-4` | 只有在首页摘要、睡前入口与账号桥接语义都稳定后才适合落地；不与基础业务并行 | 首发平台范围与桌面能力深度仍待确认 |

## 2. 文档路径

| 模块 | UI/UX RD | Implementation RD | 当前成熟度 |
| --- | --- | --- | --- |
| `activation-entry` | [activation-entry.ui-ux.md](D:/Projects/Flutter/rhythm/docs/rd/modules/activation-entry/activation-entry.ui-ux.md) | [activation-entry.impl.md](D:/Projects/Flutter/rhythm/docs/rd/modules/activation-entry/activation-entry.impl.md) | `landed` |
| `schedule-reminders` | [schedule-reminders.ui-ux.md](D:/Projects/Flutter/rhythm/docs/rd/modules/schedule-reminders/schedule-reminders.ui-ux.md) | [schedule-reminders.impl.md](D:/Projects/Flutter/rhythm/docs/rd/modules/schedule-reminders/schedule-reminders.impl.md) | `landed` |
| `sleep-records` | [sleep-records.ui-ux.md](D:/Projects/Flutter/rhythm/docs/rd/modules/sleep-records/sleep-records.ui-ux.md) | [sleep-records.impl.md](D:/Projects/Flutter/rhythm/docs/rd/modules/sleep-records/sleep-records.impl.md) | `landed` |
| `bedtime-session` | [bedtime-session.ui-ux.md](D:/Projects/Flutter/rhythm/docs/rd/modules/bedtime-session/bedtime-session.ui-ux.md) | [bedtime-session.impl.md](D:/Projects/Flutter/rhythm/docs/rd/modules/bedtime-session/bedtime-session.impl.md) | `landed` |
| `today-feedback` | [today-feedback.ui-ux.md](D:/Projects/Flutter/rhythm/docs/rd/modules/today-feedback/today-feedback.ui-ux.md) | [today-feedback.impl.md](D:/Projects/Flutter/rhythm/docs/rd/modules/today-feedback/today-feedback.impl.md) | `landed` |
| `calendar-history` | [calendar-history.ui-ux.md](D:/Projects/Flutter/rhythm/docs/rd/modules/calendar-history/calendar-history.ui-ux.md) | [calendar-history.impl.md](D:/Projects/Flutter/rhythm/docs/rd/modules/calendar-history/calendar-history.impl.md) | `landed` |
| `insights-recovery` | [insights-recovery.ui-ux.md](D:/Projects/Flutter/rhythm/docs/rd/modules/insights-recovery/insights-recovery.ui-ux.md) | [insights-recovery.impl.md](D:/Projects/Flutter/rhythm/docs/rd/modules/insights-recovery/insights-recovery.impl.md) | `landed` |
| `account-sync-membership` | [account-sync-membership.ui-ux.md](D:/Projects/Flutter/rhythm/docs/rd/modules/account-sync-membership/account-sync-membership.ui-ux.md) | [account-sync-membership.impl.md](D:/Projects/Flutter/rhythm/docs/rd/modules/account-sync-membership/account-sync-membership.impl.md) | `landed` |
| `widget-bridge` | [widget-bridge.ui-ux.md](D:/Projects/Flutter/rhythm/docs/rd/modules/widget-bridge/widget-bridge.ui-ux.md) | [widget-bridge.impl.md](D:/Projects/Flutter/rhythm/docs/rd/modules/widget-bridge/widget-bridge.impl.md) | `landed` |

## 3. 模块详情卡

### `activation-entry`

- 用户任务：在 2 分钟内理解产品价值并进入可用状态。
- 页面范围：启动分发、欢迎页、登录/匿名入口、权限说明、首轮完成过渡。
- 非页面级组件骨架：登录方式按钮组、匿名继续次入口、权限收益卡、读取范围说明卡、完成交接轻确认卡。
- 领域责任：管理首启草稿、激活完成状态和进入主应用前的最低信任链路。
- 应用状态：首开判断、登录选择态、权限引导态、完成交接态。
- 基础设施/API 边界：只编排账号入口和健康权限桥接，不拥有长期规则写入。
- 埋点与测试重点：激活漏斗、授权拒绝降级、匿名继续路径、启动守卫。
- 发布价值：决定授权率、激活完成率和主闭环进入率。

### `schedule-reminders`

- 用户任务：建立全局时间基准，并配置尽量不打扰但有效的提醒策略。
- 页面范围：目标作息设置、提醒设置、时区模式、后续设置页。
- 非页面级组件骨架：时间选择行、熬夜阈值选择器、提醒策略卡、时区说明卡、提醒开关行。
- 领域责任：统一维护 `GoalSchedule`、阈值、提醒方案和时区解释。
- 应用状态：目标表单草稿、提醒策略草稿、时区模式选择、保存与回填态。
- 基础设施/API 边界：通知调度、小组件时间语义、后续统计语义都以本模块输出为准。
- 埋点与测试重点：目标设置完成率、提醒开启率、时区变化处理。
- 发布价值：决定全局判断基准和提醒触达能力。

### `sleep-records`

- 用户任务：让昨晚结果可信、可修正、可解释。
- 页面范围：自动同步状态、手动补录、来源说明、标签选择、记录中心。
- 非页面级组件骨架：来源状态 badge、记录卡、补录表单段、晚睡原因 chip 组、可信度说明条。
- 领域责任：统一管理睡眠记录来源、可信度、修正语义和晚睡原因标签。
- 应用状态：同步中、同步失败、手动补录中、标签待补、记录已修正。
- 基础设施/API 边界：健康数据读取与本地持久化在此落边界，对外只暴露标准化记录。
- 埋点与测试重点：同步成功率、补录完成率、修正链路、空数据降级。
- 发布价值：决定产品是否会退化成“不可信的睡眠看板”。

### `bedtime-session`

- 用户任务：在睡前少做一个拖延行为并完成轻量收尾。
- 页面范围：睡前页、倒计时、今晚状态选择、建议动作。
- 非页面级组件骨架：倒计时主卡、今晚状态卡组、轻行动按钮、低刺激提示条、退出确认弹层。
- 领域责任：管理夜间执行会话、进入来源和动作完成结果。
- 应用状态：会话待开始、进行中、已选择今晚状态、建议动作已触发、退出中断。
- 基础设施/API 边界：接收提醒/桌面入口上下文，不反向拥有目标规则。
- 埋点与测试重点：睡前模式进入率、状态选择率、通知/小组件回流成功率。
- 发布价值：决定北极星指标中的“睡前模式参与”是否成立。

### `today-feedback`

- 用户任务：今天打开后立刻知道昨晚如何、今晚做什么、现在下一步是什么。
- 页面范围：今日首页及其摘要区块、与今日页直接绑定的快捷动作区。
- 非页面级组件骨架：昨晚结果主卡、今晚行动次卡、恢复摘要卡、趋势微摘要卡、快捷入口条。
- 领域责任：聚合记录、计划、睡前状态和恢复建议摘要。
- 应用状态：首页聚合中、局部卡片失败、恢复建议存在/不存在、快捷入口可用性变化。
- 基础设施/API 边界：只消费上游摘要结果，不重复拥有底层记录或周报计算。
- 埋点与测试重点：首页曝光、主动作点击、局部失败降级、明显晚睡优先恢复。
- 发布价值：决定日回访留存和用户的“产品有用感”。

### `calendar-history`

- 用户任务：看见长期趋势，并能回到某一天理解原因。
- 页面范围：月历页、筛选、单日详情。
- 非页面级组件骨架：热力图月格、筛选 chip 组、单日详情卡、历史锁定说明卡。
- 领域责任：把记录转成长期可视化反馈和历史解释入口。
- 应用状态：月视图加载、筛选切换、单日详情展开、历史锁定/解锁。
- 基础设施/API 边界：颜色和判定必须继承全局目标时间语义，历史读取依赖记录仓储。
- 埋点与测试重点：热力图切换、单日详情打开、缺失记录说明、历史锁定触点。
- 发布价值：建立免费层长期价值证明和历史付费边界。

### `insights-recovery`

- 用户任务：周期性复盘，理解稳定度，并获得恢复方向。
- 页面范围：洞察首页、周报详情、报告历史、恢复计划详情。
- 非页面级组件骨架：周摘要卡、稳定度解释块、原因分布图例卡、恢复计划卡、锁定说明卡。
- 领域责任：周报聚合、稳定度、原因分布、恢复效果与高级说明。
- 应用状态：周报待生成、摘要可用、高级解释锁定、恢复计划可读/已读。
- 基础设施/API 边界：消费记录、计划和首页摘要，不反向拥有今日页首页聚合。
- 埋点与测试重点：周报打开率、恢复计划查看、锁定转化触点、解释可读性状态。
- 发布价值：承担复盘留存与订阅转化主入口。

### `account-sync-membership`

- 用户任务：建立对账号、同步、隐私和付费的信任。
- 页面范围：我的页、账号同步页、付费墙、会员页、隐私数据页。
- 非页面级组件骨架：账号状态卡、同步状态行、权益比较卡、隐私操作项、付费墙套餐卡。
- 领域责任：统一管理账号会话、同步状态、权益快照和数据访问路径。
- 应用状态：登录中、同步排队、会员状态刷新、隐私操作确认、恢复购买。
- 基础设施/API 边界：账号、会员、同步与隐私边界在此集中，不向其他模块泄露三方 SDK 类型。
- 埋点与测试重点：登录成功率、同步状态可读性、付费入口点击、恢复购买链路。
- 发布价值：决定换机恢复、跨设备同步和商业化闭环质量。

### `widget-bridge`

- 用户任务：在桌面上快速看到今晚目标并一键进入关键动作。
- 页面范围：小组件引导、组件主题/说明、桌面入口唤起。
- 非页面级组件骨架：小组件预览卡、添加引导步骤块、桌面入口说明卡、来源桥接标记。
- 领域责任：管理桌面快照、入口来源和组件显示语义。
- 应用状态：平台支持/不支持、预览可用/不可用、跳转来源标记、桌面快照刷新。
- 基础设施/API 边界：作为平台桥接模块，只消费上游摘要与账号语义，不拥有主业务规则。
- 埋点与测试重点：小组件引导打开、桌面唤起成功、平台降级说明、快照刷新。
- 发布价值：提高桌面存在感和睡前模式入口可达性。

## 4. 模块依赖摘要

- `schedule-reminders` 是全局时间语义上游，所有以“目标时间偏移”为判断基础的模块都依赖它。
- `account-sync-membership` 是账号、同步、隐私与付费语义上游，至少先于 `activation-entry` 和 `widget-bridge` 的真实联调。
- `sleep-records` 是昨晚结果、历史视图与周报洞察的主数据源，先于 `today-feedback`、`calendar-history`、`insights-recovery`。
- `bedtime-session` 产出今晚执行上下文，先于 `today-feedback` 的行动摘要与 `widget-bridge` 的快捷入口语义。
- `today-feedback` 是首页聚合结果上游，先于 `insights-recovery` 的部分摘要继承与 `widget-bridge` 的桌面快照摘要。
- `calendar-history` 为长期历史解释能力，先于 `insights-recovery` 的高阶趋势承接。

## 5. 并行实施计划

### `stage-1` 基础规则与账户边界

- 可并行模块：
  - `schedule-reminders`
  - `account-sync-membership`
- 原因：
  - 两者共享的只是全局技术基线和平台接入原则，不共享直接状态所有权。
  - `schedule-reminders` 冻结时间语义，`account-sync-membership` 冻结账号/同步/会员边界，互不阻塞内部细化。

### `stage-2` 激活、记录与夜间执行

- 可并行模块：
  - `activation-entry`
  - `sleep-records`
  - `bedtime-session`
- 进入前置条件：
  - `schedule-reminders` 的时间语义与提醒契约已明确。
  - `account-sync-membership` 的账号入口语义已明确。
- 原因：
  - 三者分别拥有首启、记录、夜间执行的稳定边界。
  - 它们不共享同一表现层聚合控制器，可在上游契约稳定后并行推进。

### `stage-3` 首页聚合与历史可视化

- 可并行模块：
  - `today-feedback`
  - `calendar-history`
- 进入前置条件：
  - `sleep-records` 输出标准化记录摘要。
  - `bedtime-session` 输出今晚状态摘要。
  - `schedule-reminders` 输出目标时间语义。
- 原因：
  - `today-feedback` 负责即时聚合，`calendar-history` 负责长期趋势，两者共享记录与时间语义但不共享页面状态所有权。

### `stage-4` 高阶洞察与桌面桥接

- 可并行模块：
  - `insights-recovery`
  - `widget-bridge`
- 进入前置条件：
  - `today-feedback`、`calendar-history`、`bedtime-session`、`account-sync-membership` 已稳定输出必要摘要与桥接语义。
- 原因：
  - `insights-recovery` 依赖多源复盘摘要。
  - `widget-bridge` 依赖首页与夜间入口语义以及账号桥接，但二者彼此不共享核心状态所有权。

## 6. 实施顺序说明

- 不建议让 `today-feedback` 早于 `sleep-records` 或 `bedtime-session` 实现，否则首页聚合会被迫持有临时假契约。
- 不建议让 `widget-bridge` 提前到 `stage-2`，因为桌面快照与唤起来源会反复受首页和睡前入口语义变动影响。
- `insights-recovery` 虽然也依赖 `schedule-reminders` 和 `sleep-records`，但若没有 `today-feedback` 与 `calendar-history` 的稳定摘要，解释层很容易重复造轮子。
- `activation-entry` 可以在 `stage-2` 与记录、夜间执行并行，因为它只需要明确上游规则和账号入口语义，不要求所有下游功能已完成。

## 7. 当前实现前边界状态

| 模块 | current_state | uiux_status | impl_status | 说明 |
| --- | --- | --- | --- | --- |
| `activation-entry` | `architecture_ready` | `landed` | `landed` | 已完成模块冻结与实现边界交接，等待代码实现 |
| `schedule-reminders` | `architecture_ready` | `landed` | `landed` | 已完成模块冻结、模块预览固化与架构交接 |
| `sleep-records` | `architecture_ready` | `landed` | `landed` | 已完成记录可信度组件冻结与实现边界交接 |
| `bedtime-session` | `architecture_ready` | `landed` | `landed` | 已完成夜间单焦点冻结与实现边界交接 |
| `today-feedback` | `architecture_ready` | `landed` | `landed` | 已完成首页主焦点冻结与聚合边界交接 |
| `calendar-history` | `architecture_ready` | `landed` | `landed` | 已完成热力图语义冻结与实现边界交接 |
| `insights-recovery` | `architecture_ready` | `landed` | `landed` | 已完成洞察层级冻结与实现边界交接 |
| `account-sync-membership` | `architecture_ready` | `landed` | `landed` | 已完成账号/同步/会员边界冻结与实现边界交接 |
| `widget-bridge` | `architecture_ready` | `landed` | `landed` | 已完成桌面桥接冻结与实现边界交接 |

## 8. open_questions

- 匿名用户与购买权益的绑定策略是否要求首发就支持完整恢复购买链路。
- 中国区与英语区是否同步首发，这会影响模块文案、洞察解释和会员承接的默认配置。
- 轮班 / 时差高级策略是否前移到首发模块设计；若前移，`schedule-reminders` 与 `insights-recovery` 的边界需要再细化。
- 小组件是否首发同时覆盖 Android 与 iOS，还是先做单平台正式交付。
- 远程配置 / AB 是否首发接入；若接入，`account-sync-membership` 与 `insights-recovery` 的埋点/实验边界要补充。

## 9. next_skill_recommendation

- 推荐下一技能：`flutter-dev`
- 原因：共享冻结、模块冻结、架构交接和依赖顺序都已落定；当前项目处于 `implementation_ready_waiting` 边界，应由 `flutter-dev` 按波次开始代码实现，而不是再次回到设计前置技能。
