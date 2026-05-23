# Rhythm 作息行为管理研发规划文档

> 版本：V1.0
> 日期：2026-05-22
> 输入文档：`docs/rhythm-sleep-routine-management-prd-2026-05-21.md`
> 适用范围：Flutter 跨平台 MVP 从初始工程到 V0.1 内测闭环
> 当前代码状态：Flutter 初始壳应用，`lib/main.dart` 仍为 `Hello World`

## 一、研发目标

### 1.1 一句话目标

在 12 周内交付一个可内测的跨平台作息行为管理 App，优先跑通“目标设置 -> 睡眠记录 -> 睡前模式 -> 次日反馈 -> 原因标签 -> 基础恢复建议 -> 周报”的免费核心闭环。

### 1.2 核心交付标准

- 用户首次打开 App 后，能在 2 分钟内完成登录或匿名进入、健康权限选择、目标作息设置，并看到今日页。
- 健康数据授权失败或暂未接入时，用户仍可通过手动补录完成完整闭环。
- 今日页 3 秒内能读懂昨晚结果、今晚目标和是否需要进入睡前模式。
- 日历热力图围绕用户目标入睡时间和熬夜阈值计算，不使用固定硬编码晚睡标准。
- 睡前模式从入口到状态选择不超过 3 次点击。
- 周报可以基于最近 7 天有效记录生成达标率、稳定度、主要原因和下周建议。

### 1.3 非目标

- 不做医疗诊断、疾病级睡眠建议或医学化睡眠评分。
- 不做 AI 聊天教练、社区内容、复杂勋章、年度人格报告。
- 不在首开或刚授权后强拦付费墙。
- 不为旧版数据结构或历史接口做兼容处理；本阶段从干净模型开始。

## 二、默认研发决策

PRD 中仍有开放问题。为避免研发悬停，本规划采用以下默认决策，后续如产品侧确认不同方向，再按影响范围调整。

| 问题 | 默认决策 | 理由 |
| --- | --- | --- |
| 首发平台 | Flutter 跨平台工程内优先验证 iOS HealthKit，Android Health Connect 保留接口层 | 当前项目已是 Flutter，依赖中已包含 `health`，用跨平台结构承接后续 Android |
| 登录策略 | 支持匿名本地使用，登录用于云同步、换机恢复和会员状态 | 降低首启阻力，保护 2 分钟激活目标 |
| 数据策略 | 本地 Drift 为主，Supabase 负责账号同步和云备份 | 核心闭环不能依赖网络，云能力渐进上线 |
| 会员策略 | V0.1 只做会员能力位与轻量付费墙，不强推转化 | 先验证免费闭环和留存，再强化订阅理由 |
| AI 周复盘 | V0.1 不接外部模型，后续先用规则模板生成建议 | 降低合规、成本和不确定性 |
| 地区语言 | 首轮中文简体体验优先，文案避免医疗化表达 | 与当前 PRD 和团队验证节奏一致 |

## 三、技术架构

### 3.1 总体架构

采用 `轻量 DDD + Clean Architecture + feature-first` 的 Flutter 架构。

本项目不采用重型 DDD，不在 V0.1 引入复杂的聚合根、领域事件、CQRS 或事件溯源。研发重点是把“作息目标、睡眠记录、睡前干预、反馈洞察”这些核心领域规则从 UI 和基础设施中隔离出来，保证 MVP 快速交付的同时，后续可以扩展同步、订阅、Android 和 AI 能力。

技术组合为 Flutter + Riverpod + GoRouter + Drift：

- 表现层：负责页面、组件、交互状态和空态展示。
- 应用层：负责用例编排、页面状态聚合、路由守卫和权限流程。
- 领域层：负责作息目标、睡眠记录、达标判断、稳定度、周报、恢复建议等纯业务规则。
- 数据层：负责 Drift 本地库、HealthKit/Health Connect 适配、通知、小组件、Supabase 同步、订阅状态。
- 基础设施层：负责时间、时区、日志、埋点、错误模型、配置和安全存储。

DDD 落地原则：

- 每个 `features/*` 优先对应一个领域边界，而不是简单按页面或技术类型堆文件。
- `domain/` 只表达业务概念和业务规则，不依赖 Flutter、Drift、Supabase、Health API 或通知插件。
- `application/` 编排用例和状态，把多个领域服务组合成页面可消费的状态。
- `data/` 负责仓储实现、平台适配和远端同步，向内实现领域所需接口。
- `presentation/` 只做 UI 展示和用户交互，不直接写业务判断。
- 领域规则必须可被单元测试直接验证，避免只能通过页面或数据库间接测试。

### 3.2 目录规划

```text
lib/
  main.dart
  app/
    rhythm_app.dart
    router/
    theme/
    bootstrap/
  core/
    analytics/
    errors/
    time/
    utils/
  features/
    onboarding/
    auth/
    goal_schedule/
    sleep_records/
    today/
    bedtime/
    calendar/
    insights/
    profile/
    membership/
    notifications/
    widget_bridge/
    sync/
  data/
    local/
    remote/
    health/
    purchases/
test/
  core/
  features/
  data/
integration_test/
```

### 3.3 领域边界

| 模块 | 责任 | 不负责 |
| --- | --- | --- |
| `onboarding` | 首次激活、权限解释、目标设置引导 | 长期目标编辑、会员转化 |
| `auth` | 匿名身份、Apple/Google 登录、账号会话 | 订阅权益判断 |
| `goal_schedule` | 目标入睡、起床、熬夜阈值、一天起始时间 | 具体睡眠记录同步 |
| `sleep_records` | 自动记录、手动补录、修正、数据来源 | 周报和热力图展示 |
| `today` | 今日面板、昨晚反馈、快捷行动入口 | 复杂趋势分析 |
| `bedtime` | 睡前模式、状态选择、轻量动作建议 | 次日统计报告 |
| `calendar` | 月历热力图、每日详情、筛选 | 深度洞察和付费报告 |
| `insights` | 周报、稳定度摘要、原因分布、恢复效果 | AI 长文复盘 |
| `profile` | 账户、权限、目标入口、隐私、导出入口 | 具体业务计算 |
| `membership` | 权益定义、付费墙、订阅状态 | 支付渠道底层适配 |
| `notifications` | 睡前提醒、周报提醒、本地通知 | 系统健康数据读取 |
| `widget_bridge` | 桌面小组件数据快照和快捷入口 | App 内页面渲染 |
| `sync` | Supabase 同步、冲突策略、换机恢复 | 本地业务规则判断 |

领域边界执行约束：

- 跨领域调用必须通过 `application/` 用例或领域服务接口完成，不允许页面直接拼接多个 Repository。
- 领域对象命名优先使用 PRD 里的业务语言，例如 `GoalSchedule`、`SleepRecord`、`BedtimeSession`、`RecoveryPlan`。
- 基础设施能力只通过接口进入领域，例如健康数据读取、通知调度、云同步和订阅状态。
- 当一个文件开始同时处理 UI、数据库、业务判断和网络请求时，必须拆分到对应层。

### 3.4 状态管理

- 使用 Riverpod 管理页面状态、用例依赖和异步加载。
- 页面只读取 ViewModel 或 Provider 聚合后的 UI 状态，不直接访问数据库、Health API 或 Supabase。
- 领域计算保持纯 Dart 函数或服务类，便于单元测试覆盖。
- 路由使用 GoRouter，一级模块采用底部导航 Shell，首次激活和付费墙作为独立路径。

### 3.5 数据流

```text
HealthKit / Health Connect / 手动补录
  -> SleepRecordRepository
  -> Drift 本地库
  -> 领域计算服务
  -> Riverpod UI 状态
  -> 今日页 / 日历 / 洞察 / 小组件
```

同步数据流：

```text
Drift 本地变更
  -> SyncQueue
  -> Supabase
  -> 远端版本回写
  -> 冲突合并
  -> 本地状态刷新
```

提醒数据流：

```text
GoalSchedule + NotificationSetting
  -> ReminderScheduler
  -> flutter_local_notifications
  -> notification_opened 埋点
  -> 睡前模式路由
```

## 四、核心数据模型

### 4.1 本地实体

| 实体 | 关键字段 | 说明 |
| --- | --- | --- |
| `users` | `id`、`anonymousId`、`timezone`、`locale`、`membershipTier` | 本地用户与云端用户统一抽象 |
| `goal_schedules` | `targetBedtimeMinutes`、`targetWakeMinutes`、`lateThresholdMinutes`、`dayStartMinutes`、`workdayMask` | 所有达标判断的全局基准 |
| `sleep_records` | `recordDate`、`fellAsleepAt`、`wokeUpAt`、`durationMinutes`、`source`、`timezone`、`isUserEdited`、`confidence` | 保留数据来源和可信度 |
| `bedtime_sessions` | `startedAt`、`entryPoint`、`minutesToTarget`、`status`、`suggestedAction`、`completedAt` | 记录睡前模式行为 |
| `sleep_delay_tags` | `recordDate`、`tagType`、`label`、`isSuggested`、`createdAt` | 支持默认标签和自定义标签 |
| `recovery_plans` | `recordDate`、`triggerReason`、`planDays`、`contentJson`、`viewedAt`、`completedAt` | V0.1 可用规则模板生成 |
| `reports` | `periodType`、`periodStart`、`periodEnd`、`summaryJson`、`generatedAt` | 周报优先落地 |
| `notification_settings` | `softReminderEnabled`、`targetReminderEnabled`、`weeklyReportEnabled`、`leadMinutes` | 默认柔性提醒 |
| `sync_queue` | `entityType`、`entityId`、`operation`、`payloadJson`、`status`、`retryCount` | 云同步渐进上线 |

### 4.2 枚举约定

| 枚举 | 值 |
| --- | --- |
| `SleepRecordSource` | `healthKit`、`healthConnect`、`manual`、`imported` |
| `SleepRecordConfidence` | `high`、`medium`、`low`、`unknown` |
| `BedtimeEntryPoint` | `notification`、`widget`、`todayCard`、`bottomTab` |
| `BedtimeStatus` | `readyToSleep`、`needMoreTime`、`likelyLate` |
| `MembershipTier` | `free`、`trial`、`monthly`、`yearly`、`lifetime` |
| `SyncStatus` | `pending`、`syncing`、`synced`、`failed` |

### 4.3 计算口径

- 达标：`fellAsleepAt <= targetBedtime + lateThresholdMinutes`。
- 晚睡分钟数：`fellAsleepAt - targetBedtime`，早于目标时可显示为提前分钟数。
- 有效记录天：存在系统记录或用户手动补录的自然日。
- 周达标率：最近 7 天达标天数 / 最近 7 天有效记录天数。
- 稳定度：V0.1 使用最近 7 天入睡时间偏差的简化模型，输出 `0-100` 分和一句解释。
- 恢复触发：晚睡分钟数大于熬夜阈值，且该日为有效记录天。
- 恢复成功：触发后 3 天内至少 2 天回到阈值内。

### 4.4 时间与时区规则

- 所有记录必须保存事件发生时的时区。
- `recordDate` 按用户设置的“一天起始时间”归属，不直接使用系统自然日零点。
- 时区变化时，新记录按新时区入库，旧记录不重算归属日。
- 轮班和跨时区模式不进入 V0.1 正式范围，但模型保留字段，不实现复杂判断。

## 五、功能研发拆分

### 5.1 阶段一：基础底座，第 1-2 周

目标：让工程具备可扩展架构、路由、主题、本地库、基础身份和核心模型。

- 搭建 `RhythmApp`、GoRouter、底部导航壳和基础主题。
- 引入 Riverpod 根容器，统一 Provider 注入方式。
- 建立 Drift 数据库、迁移入口和实体表。
- 建立领域模型、错误模型、时间工具和基础日志。
- 建立匿名用户与本地身份，预留 Apple/Google 登录入口。
- 建立埋点服务接口，先输出到调试日志，后续接入真实分析平台。
- 建立单元测试、Widget 测试和集成测试目录。

验收：

- App 可启动并进入底部五个一级模块。
- Drift 数据库可创建、读写并通过测试。
- 匿名身份首次启动可生成并持久保存。
- `flutter test` 通过。

### 5.2 阶段二：首次激活与目标设置，第 3 周

目标：用户能完成 2 分钟内可用状态。

- 当前首批实现已落地欢迎页、登录选择、健康权限说明、目标作息设置、提醒策略设置，并完成首次打开到今日页的基础闭环；真实健康权限与登录 SDK 仍保留为后续接入项。

- 设计首次激活流程：价值说明、登录选择、健康权限说明、目标作息设置、提醒策略。
- 支持跳过健康授权并进入手动模式。
- 建立目标作息表单校验：入睡时间、起床时间、熬夜阈值、一天起始时间。
- 完成 `goal_setup_started`、`goal_setup_completed`、`health_permission_requested` 埋点。
- 首次激活完成后进入今日页。

验收：

- 新用户可完成或跳过每一步，不出现死路。
- 目标作息保存后，今日页能读取并展示。
- 健康权限失败时，用户仍能进入手动记录路径。

### 5.3 阶段三：睡眠记录与手动补录，第 3-5 周

目标：建立可用的数据闭环基础。

- 封装 HealthKit / Health Connect 读取适配器，先完成 iOS 技术验证。
- 实现最近 30 天睡眠记录同步。
- 支持同步失败提示、重试和降级到手动补录。
- 实现手动新增、编辑入睡时间和起床时间。
- 保留原始系统记录和用户修正状态，避免手动修正破坏来源数据。
- 完成 `sleep_record_synced`、`sleep_record_sync_failed`、`sleep_record_manual_created`、`sleep_record_manual_edited` 埋点。

验收：

- 授权成功时可读取睡眠记录并写入本地库。
- 授权失败或无数据时可手动补录。
- 修改记录后日历和今日页读取的是用户确认后的结果。

### 5.4 阶段四：今日页，第 4-5 周

目标：让用户一眼看懂昨晚结果和今晚行动。

- 实现顶部状态卡：昨晚结果、是否达标、晚睡或提前分钟数、连续表现。
- 实现行动卡：今晚目标、距离目标剩余时间、进入睡前模式入口。
- 实现恢复建议卡：仅在明显晚睡后展示。
- 实现快捷记录卡：原因标签、手动补录、修改昨晚记录。
- 实现最近 7 天微趋势卡。
- 缺失数据时展示温和空态，引导补录或授权。

验收：

- 有数据、无数据、授权失败、手动记录四类状态都有清晰展示。
- 晚睡后优先展示恢复路径，不使用羞辱性文案。
- 今日页核心信息 3 秒内可读懂。

### 5.5 阶段五：睡前模式与提醒，第 6 周

目标：让用户在目标时间前进入“准备睡了”的行为干预流程。

- 实现睡前页：当前时间、目标时间差、倒计时条、今晚状态选择。
- 支持三种状态：准备睡觉、还想拖一会儿、今晚大概率会晚睡。
- 根据状态展示轻量动作建议。
- 实现睡前柔性提醒和目标到点提醒。
- 点击通知或小组件进入睡前模式。
- 完成 `bedtime_mode_entered`、`bedtime_status_selected`、`bedtime_action_clicked`、`notification_opened` 埋点。

验收：

- 睡前模式入口不超过 3 次点击。
- 提醒默认温和，不连续强打扰。
- 状态选择后生成 `BedtimeSession` 记录。

### 5.6 阶段六：日历热力图与原因标签，第 6-7 周

目标：建立视觉反馈和晚睡原因解释。

- 实现月历热力图，颜色基于目标时间偏差计算。
- 支持每日详情展开：实际睡眠、偏差、来源、可信度、标签、备注。
- 支持筛选：入睡时间、稳定度、晚睡次数。
- 实现默认不超过 8 个原因标签：刷手机、加班、游戏、追剧、情绪、聚会、时差、其他。
- 支持自定义标签，但入口弱化，避免输入负担。
- 完成 `calendar_viewed`、`day_detail_viewed`、`delay_tag_added` 埋点。

验收：

- 热力图不使用固定 23:00 或 24:00 判断，必须基于用户目标。
- 点击某天能看到可解释详情。
- 标签添加路径足够轻，不强制输入长文本。

### 5.7 阶段七：洞察周报与基础恢复建议，第 7-8 周

目标：用周报强化“持续变好”的感知。

- 实现最近 7 天周报生成：达标率、稳定度、最晚入睡日、主要原因、下周建议。
- 实现规则化恢复建议：轻量、短周期、非医疗化。
- 支持恢复计划查看状态和完成状态。
- 洞察页展示周报摘要、原因分布和恢复效果入口。
- 完成 `recovery_plan_viewed`、`recovery_plan_completed`、`weekly_report_viewed` 埋点。

验收：

- 至少 3 天有效记录即可生成基础周报。
- 明显晚睡后可以看到 1-3 天恢复建议。
- 文案不出现“治疗”“诊断”“治愈”等医疗化表达。

### 5.8 阶段八：账户、同步与隐私，第 9-10 周

目标：为换机恢复、会员和长期留存打基础。

- 接入 Supabase 初始化、用户表和基础同步表。
- 支持匿名数据绑定到登录账号。
- 实现睡眠记录、目标设置、标签、周报摘要的最小同步。
- 实现同步队列、失败重试和冲突策略。
- 提供隐私入口、数据导出入口、账号删除入口的基础页面。
- 完成登录、同步状态和权限状态展示。

验收：

- 匿名用户登录后，本地数据不会丢失。
- 无网络时本地闭环仍可用。
- 恢复登录后能拉取云端关键数据。

### 5.9 阶段九：小组件与桌面存在感，第 9-10 周

目标：让睡前行动入口在桌面可见。

- 输出小组件数据快照：今晚目标、距离目标、昨晚状态。
- 支持点击小组件进入今日页或睡前模式。
- 处理无目标、无数据、未授权三类小组件空态。
- 完成 `widget_opened` 埋点。

验收：

- 小组件内容与 App 内目标一致。
- 小组件不会展示敏感过多的睡眠细节。
- 点击路径稳定进入预期页面。

### 5.10 阶段十：会员基础版与付费墙，第 11 周

目标：建立商业化能力位，但不破坏激活和核心闭环。

- 接入 RevenueCat 或等价订阅状态读取。
- 定义免费版和会员版权益。
- 在高意图场景展示轻量付费墙：历史 30 天前、稳定度解释、恢复计划详情、月报入口。
- 年付为主推方案，月付和永久会员作为备选。
- 完成 `paywall_viewed`、`trial_started`、`subscription_purchased`、`subscription_renewed`、`subscription_canceled` 埋点。

验收：

- 首开、授权后、目标设置后不弹强付费墙。
- 免费用户仍能完成核心闭环。
- 订阅状态能跨启动保持一致。

### 5.11 阶段十一：灰度发布与数据看板，第 12 周

目标：完成内测前质量收口。

- 建立基础数据看板口径：激活、授权、目标设置、首晚记录、睡前模式、标签、周报、付费墙。
- 补齐崩溃日志、错误上报和关键失败埋点。
- 完成 TestFlight / 内测包配置。
- 执行回归测试、权限测试、时区测试、弱网测试。
- 形成内测问题反馈模板。

验收：

- 关键路径无 P0/P1 阻塞问题。
- 数据看板能回答 MVP 成功标准中的核心指标。
- 内测用户可以完成从激活到周报的完整链路。

### 5.12 页面实现矩阵

按 V0.1 MVP 范围，客户端需要明确落地 `24 个页面形态`：`8 个全局/引导页`、`5 个一级模块页`、`11 个二级详情与设置页`。页面实现统一遵守以下约束：

- 一级模块统一挂在底部导航 Shell 下，避免今日、日历、睡前、洞察、我的出现多套平级导航。
- 首次激活、手动补录、周报详情、付费墙使用独立全屏路由，避免把长流程塞进弹层。
- 页面只负责结构编排；卡片、图表、表单分组、空态、入口按钮拆到 `presentation/widgets/`。
- 任何页面出现 `3 个以上核心区块 + 复杂状态分支` 时，必须拆 `sections/` 子组件，避免单页持续膨胀。

#### 5.12.1 全局与首次激活页面

| 页面 | 路由建议 | 页面形态 | 核心内容 | 建议文件拆分 |
| --- | --- | --- | --- | --- |
| 启动分发页 | `/launch` | 启动页 | 判断匿名身份、是否完成 onboarding、是否需要登录恢复、是否直达 Shell | `lib/app/bootstrap/launch_gate.dart` + `lib/app/bootstrap/app_bootstrap.dart` |
| 欢迎价值页 | `/onboarding/welcome` | 全屏引导页 | 一句话价值、主收益、匿名进入/登录入口 | `lib/features/onboarding/presentation/onboarding_flow_page.dart` + `widgets/steps/onboarding_welcome_step.dart` |
| 登录选择页 | `/onboarding/sign-in` | 全屏引导页 | Apple/Google/匿名进入、登录收益说明、跳过路径 | `lib/features/auth/presentation/auth_entry_page.dart` 或 `onboarding_flow_page.dart` 内步骤组件 |
| 健康权限说明页 | `/onboarding/health-permission` | 全屏引导页 | 权限收益、授权按钮、跳过后手动补录说明 | `lib/features/onboarding/presentation/onboarding_flow_page.dart` + `widgets/steps/health_permission_step.dart` |
| 目标作息设置页 | `/onboarding/goal-setup` | 全屏表单页 | 目标入睡、起床、熬夜阈值、一天起始时间 | `lib/features/goal_schedule/presentation/goal_setup_page.dart` + `widgets/goal_schedule_form.dart` |
| 提醒策略设置页 | `/onboarding/reminder-setup` | 全屏表单页 | 柔性提醒、到点提醒、周报提醒、提前量 | `lib/features/notifications/presentation/reminder_setup_page.dart` + `widgets/reminder_strategy_form.dart` |
| 小组件引导页 | `/onboarding/widget-guide` | 全屏引导页 | 小组件价值说明、添加步骤、暂不添加入口 | `lib/features/widget_bridge/presentation/widget_guide_page.dart` |
| 轻量付费墙页 | `/membership/paywall` | 全屏模态页 | 权益对比、价格卡、试用/购买入口、关闭返回 | `lib/features/membership/presentation/paywall_page.dart` + `widgets/paywall_plan_selector.dart` |

#### 5.12.2 一级模块页面

| 页面 | 路由建议 | 页面形态 | 核心内容 | 建议文件拆分 |
| --- | --- | --- | --- | --- |
| 今日页 | `/today` 或 `/` | 一级主页面 | 顶部状态卡、行动卡、恢复建议卡、快捷记录卡、7 日微趋势 | `lib/features/today/presentation/today_page.dart` + `widgets/sections/*` |
| 日历页 | `/calendar` | 一级主页面 | 月历热力图、筛选栏、达标连续区间、日详情触发入口 | `lib/features/calendar/presentation/calendar_page.dart` + `widgets/calendar_heatmap.dart` |
| 睡前页 | `/bedtime` | 一级主页面 | 当前时间与目标差、倒计时条、状态选择、动作建议、轻标签入口 | `lib/features/bedtime/presentation/bedtime_page.dart` + `widgets/sections/*` |
| 洞察页 | `/insights` | 一级主页面 | 本周达标率、稳定度、原因分布、恢复效果、历史入口 | `lib/features/insights/presentation/insights_page.dart` + `widgets/sections/*` |
| 我的页 | `/profile` | 一级主页面 | 账户卡、会员卡、目标入口、提醒入口、隐私与同步入口 | `lib/features/profile/presentation/profile_page.dart` + `widgets/profile_entry_list.dart` |

#### 5.12.3 二级详情与设置页面

| 页面 | 路由建议 | 页面形态 | 核心内容 | 建议文件拆分 |
| --- | --- | --- | --- | --- |
| 手动补录/编辑页 | `/records/edit/:recordDate` | 全屏表单页 | 入睡时间、起床时间、来源说明、保存与放弃修改 | `lib/features/sleep_records/presentation/manual_sleep_record_page.dart` + `widgets/manual_record_form.dart` |
| 周报详情页 | `/insights/report/:periodStart` | 全屏详情页 | 达标率、稳定度解释、最晚入睡日、主要原因、建议摘要 | `lib/features/insights/presentation/weekly_report_detail_page.dart` |
| 历史洞察页 | `/insights/history` | 全屏列表页 | 历史周报列表、30 天前历史、付费拦截承接 | `lib/features/insights/presentation/report_history_page.dart` |
| 目标作息编辑页 | `/profile/goal-schedule` | 二级设置页 | 修改入睡时间、起床时间、阈值、工作日规则 | `lib/features/goal_schedule/presentation/goal_schedule_settings_page.dart` |
| 提醒设置页 | `/profile/notifications` | 二级设置页 | 柔性提醒、到点提醒、周报提醒、提前量、降级说明 | `lib/features/notifications/presentation/notification_settings_page.dart` |
| 数据接入与权限页 | `/profile/data-access` | 二级设置页 | HealthKit/Health Connect 状态、最近同步、重新授权、手动模式说明 | `lib/features/profile/presentation/data_access_page.dart` |
| 账号与同步页 | `/profile/account-sync` | 二级设置页 | 匿名身份、登录绑定、同步状态、失败重试、冲突说明 | `lib/features/sync/presentation/account_sync_page.dart` |
| 会员中心页 | `/profile/membership` | 二级详情页 | 当前权益、价格方案、恢复购买、常见问题 | `lib/features/membership/presentation/membership_page.dart` |
| 隐私与数据页 | `/profile/privacy` | 二级设置页 | 隐私协议、数据导出、账号删除、敏感数据说明 | `lib/features/profile/presentation/privacy_data_page.dart` |
| 小组件与主题页 | `/profile/widget-theme` | 二级设置页 | 小组件样式、桌面入口说明、主题预留位 | `lib/features/widget_bridge/presentation/widget_theme_page.dart` |
| 时区与特殊模式页 | `/profile/timezone-mode` | 二级设置页 | 当前时区、跨时区提示、轮班/时差模式占位与说明 | `lib/features/goal_schedule/presentation/timezone_mode_page.dart` |

### 5.13 弹出组件实现矩阵

弹出组件只承担 `轻决策、轻输入、轻反馈`。凡是包含长表单、长说明、复杂图表的内容，一律升级成独立页面。实现约束如下：

- 与当前页面强相关、最多 `3 个主操作` 的交互，优先使用底部弹层。
- 不可逆操作、权限失败补救、离开未保存表单，优先使用确认对话框。
- 保存成功、同步失败、轻提示统一走 Snackbar 或顶部轻提示，不单独弹居中框。
- 同一时刻只允许一个主弹层存在，禁止“底部弹层上再叠对话框”的双层打断。

#### 5.13.1 底部弹层与半屏卡片

| 组件 | 类型 | 触发页面 | 触发时机 | 承载内容 | 建议文件 |
| --- | --- | --- | --- | --- | --- |
| 目标时间选择弹层 | 底部弹层 | 目标作息设置页、目标作息编辑页 | 点击目标入睡/起床时间 | 时间选择器、推荐区间、确认按钮 | `lib/features/goal_schedule/presentation/widgets/sheets/goal_time_picker_sheet.dart` |
| 阈值与提前量设置弹层 | 底部弹层 | 目标作息设置页、提醒设置页 | 点击熬夜阈值或提醒提前量 | 分钟步进、说明文案、保存按钮 | `lib/features/goal_schedule/presentation/widgets/sheets/minutes_setting_sheet.dart` |
| 今日快捷记录操作弹层 | 底部弹层 | 今日页 | 点击快捷记录卡或更多按钮 | 补原因标签、手动补录、修改昨晚记录 | `lib/features/today/presentation/widgets/sheets/today_quick_actions_sheet.dart` |
| 晚睡原因标签弹层 | 底部弹层 | 今日页、睡前页、日历日详情 | 点击“补原因”或“添加标签” | 默认标签、自定义入口、保存状态 | `lib/features/sleep_records/presentation/widgets/sheets/sleep_delay_tag_picker_sheet.dart` |
| 日历单日详情弹层 | 半屏详情卡 | 日历页 | 点击某一天 | 实际睡眠、偏差、来源、可信度、标签、备注、编辑入口 | `lib/features/calendar/presentation/widgets/sheets/calendar_day_detail_sheet.dart` |
| 日历筛选弹层 | 底部弹层 | 日历页 | 点击筛选按钮 | 入睡时间/稳定度/晚睡次数筛选、重置、应用 | `lib/features/calendar/presentation/widgets/sheets/calendar_filter_sheet.dart` |
| 自定义标签输入弹层 | 底部弹层 | 标签弹层内部 | 选择“自定义标签” | 单字段输入、字符限制、保存 | `lib/features/sleep_records/presentation/widgets/sheets/custom_delay_tag_sheet.dart` |
| 睡前拖延原因弹层 | 底部弹层 | 睡前页 | 选择“还想拖一会儿”或“今晚大概率会晚睡”后 | 轻量原因标签、建议动作切换 | `lib/features/bedtime/presentation/widgets/sheets/bedtime_delay_reason_sheet.dart` |
| 恢复计划详情弹层 | 半屏详情卡 | 今日页、洞察页 | 点击恢复建议卡 | 1-3 天建议、完成状态、延期入口 | `lib/features/insights/presentation/widgets/sheets/recovery_plan_detail_sheet.dart` |
| 稳定度说明弹层 | 底部弹层 | 洞察页 | 点击稳定度说明入口 | 评分口径、近 7 天样本、解释文案 | `lib/features/insights/presentation/widgets/sheets/stability_explainer_sheet.dart` |
| 会员权益对比弹层 | 底部弹层 | 我的页、洞察页 | 点击权益说明或受限入口 | 免费/会员差异、升级入口、关闭 | `lib/features/membership/presentation/widgets/sheets/membership_benefits_sheet.dart` |
| 数据来源说明弹层 | 底部弹层 | 日历日详情、手动补录页 | 点击来源/可信度信息 | 来源定义、手动修正说明、最近同步时间 | `lib/features/sleep_records/presentation/widgets/sheets/record_source_explainer_sheet.dart` |

#### 5.13.2 对话框、确认框与轻反馈

| 组件 | 类型 | 触发页面 | 触发时机 | 承载内容 | 建议文件 |
| --- | --- | --- | --- | --- | --- |
| 权限被拒绝补救框 | 对话框 | 健康权限说明页、数据接入与权限页 | 用户拒绝权限或权限永久关闭 | 去系统设置、继续手动模式、稍后再说 | `lib/features/onboarding/presentation/widgets/dialogs/permission_recovery_dialog.dart` |
| 放弃未保存修改确认框 | 对话框 | 目标设置页、提醒设置页、手动补录页 | 返回时表单已修改未保存 | 放弃、继续编辑、保存后离开 | `lib/core/presentation/dialogs/discard_changes_dialog.dart` |
| 同步失败重试框 | 对话框 | 账号与同步页、数据接入与权限页 | 同步失败且用户主动重试 | 错误摘要、重试、稍后再试 | `lib/features/sync/presentation/widgets/dialogs/sync_retry_dialog.dart` |
| 删除账号确认框 | 危险对话框 | 隐私与数据页 | 点击删除账号 | 删除影响、二次确认、取消 | `lib/features/profile/presentation/widgets/dialogs/delete_account_dialog.dart` |
| 数据导出确认框 | 对话框 | 隐私与数据页 | 点击导出数据 | 导出范围、格式、耗时提示 | `lib/features/profile/presentation/widgets/dialogs/export_data_dialog.dart` |
| 保存成功提示 | Snackbar | 全局复用 | 目标设置、标签保存、记录编辑成功后 | 短文案 + 可选撤销 | `lib/core/presentation/feedback/app_snackbar.dart` |
| 同步失败轻提示 | Snackbar | 全局复用 | 后台同步失败但不阻塞主流程 | 简短错误 + 查看详情入口 | `lib/core/presentation/feedback/app_snackbar.dart` |
| 付费拦截轻提示 | 顶部轻提示或 Snackbar | 历史洞察页、恢复计划详情、稳定度说明 | 免费用户点击会员能力位 | 能力说明 + 升级入口 | `lib/features/membership/presentation/widgets/paywall_entry_banner.dart` |

### 5.14 页面与弹层的路由、状态和测试落地原则

- GoRouter 层只声明页面路由；底部弹层、Dialog、Snackbar 由页面内的 `controller/provider` 驱动显示状态，不在路由层注册伪页面。
- 页面级状态统一落在各自模块的 `application/*_controller.dart`；弹层只消费已经聚合好的 ViewState，不直接拼 Repository。
- 需要跨页面复用的弹层，只复用 `UI 容器 + 参数对象`，不复用业务判断，避免一个弹层承担多个模块规则。
- Widget 测试至少覆盖：今日快捷记录弹层、日历单日详情弹层、权限拒绝对话框、同步失败对话框、付费拦截提示。
- 集成测试至少覆盖：首次激活 -> 今日页、授权失败 -> 手动补录、今日页补标签、日历看详情、洞察触发付费拦截。

## 六、测试策略

### 6.1 单元测试

优先覆盖纯业务规则：

- 目标时间和熬夜阈值计算。
- 一天起始时间下的 `recordDate` 归属。
- 达标、晚睡分钟数、周达标率。
- 稳定度评分。
- 恢复计划触发和恢复成功判断。
- 同步冲突合并策略。

### 6.2 Widget 测试

优先覆盖关键 UI 状态：

- 今日页有数据、无数据、授权失败、晚睡后四类状态。
- 目标设置表单校验。
- 手动补录表单。
- 睡前状态选择。
- 日历每日详情。
- 付费墙展示条件。

### 6.3 集成测试

优先覆盖端到端闭环：

- 新用户首次激活到今日页。
- 健康授权失败后手动补录。
- 进入睡前模式并选择状态。
- 次日补原因标签并查看恢复建议。
- 生成并查看周报。
- 匿名用户登录后同步数据。

### 6.4 人工验收场景

- iOS 健康权限首次授权、拒绝、再次打开设置。
- Android Health Connect 不可用、未安装、授权失败。
- 时区切换前后记录归属日。
- 夜间 23:00 至次日 03:00 的跨日记录。
- 推送权限关闭后的降级提示。
- 无网络状态下的核心闭环。
- 订阅购买失败、取消、恢复购买。

## 七、埋点与数据看板

### 7.1 首发事件分组

- 激活：`app_install`、`app_open`、`signup_started`、`signup_completed`、`health_permission_requested`、`health_permission_granted`、`goal_setup_started`、`goal_setup_completed`
- 睡眠记录：`sleep_record_synced`、`sleep_record_sync_failed`、`sleep_record_manual_created`、`sleep_record_manual_edited`
- 行为干预：`bedtime_mode_entered`、`bedtime_status_selected`、`bedtime_action_clicked`、`notification_opened`、`widget_opened`
- 反馈闭环：`calendar_viewed`、`day_detail_viewed`、`delay_tag_added`、`recovery_plan_viewed`、`recovery_plan_completed`、`weekly_report_viewed`
- 商业化：`paywall_viewed`、`trial_started`、`subscription_purchased`、`subscription_renewed`、`subscription_canceled`

### 7.2 看板优先级

P0 看板：

- 注册完成率。
- 健康数据授权率。
- 目标设置完成率。
- 首晚记录生成率。
- 睡前模式周使用率。
- 原因标签补录率。
- 周报打开率。
- D1、D7、D30 留存。

P1 看板：

- 小组件添加率。
- 付费墙曝光率。
- 试用开启率。
- 订阅转化率。
- 洞察页到付费页转化率。

## 八、质量与合规要求

### 8.1 文案合规

- 禁止使用“治疗”“诊断”“治愈”“改善失眠”等医疗化承诺。
- 使用“作息调整”“睡前习惯”“行为改善”“恢复节奏”等表达。
- 晚睡反馈优先给恢复路径，不给惩罚式评价。

### 8.2 隐私与安全

- 睡眠记录属于敏感健康相关数据，默认本地优先。
- 云同步必须由用户登录或明确开启后发生。
- 隐私协议、数据导出、账号删除路径 V0.1 即具备入口。
- 安全存储用于保存会话、匿名身份和敏感令牌。

### 8.3 文件规模

- 单个 Dart 文件不得超过 800 行。
- 页面文件只负责 UI 组合，复杂状态和业务规则必须下沉到 Provider、UseCase 或领域服务。
- 修改接近 800 行的文件时，优先拆分组件或服务，不继续堆叠。

## 九、风险与应对

| 风险 | 表现 | 应对 |
| --- | --- | --- |
| 健康数据质量不稳定 | 缺失、延迟、入睡时间和用户感受不一致 | 允许手动修正，显示数据来源和可信度 |
| 激活流程过重 | 用户未完成授权或目标设置就流失 | 支持跳过授权、匿名进入和稍后补全 |
| 提醒过度打扰 | 用户关闭通知或卸载 | 默认柔性提醒，关闭连续强提醒 |
| 反馈让用户挫败 | 晚睡后产生羞耻感 | 优先展示恢复建议和下一步行动 |
| 免费层与付费层边界模糊 | 免费太弱影响留存，太强影响转化 | 免费给结果，付费给改善 |
| 跨平台能力差异 | iOS 和 Android 健康能力不一致 | 用 Health Adapter 层隔离平台差异 |
| 同步冲突 | 多设备编辑同一记录 | 以用户编辑优先，保留来源和更新时间 |

## 十、研发里程碑

| 周期 | 里程碑 | 可验收产物 |
| --- | --- | --- |
| 第 1-2 周 | 基础底座 | 应用架构、路由、本地库、匿名身份、测试框架 |
| 第 3 周 | 首次激活 | Onboarding、权限说明、目标设置、提醒策略 |
| 第 3-5 周 | 数据闭环 | Health 读取、手动补录、记录修正、同步失败降级 |
| 第 4-5 周 | 今日页 | 昨晚结果、今晚目标、恢复卡、快捷记录、7 日趋势 |
| 第 6 周 | 睡前模式 | 提醒、倒计时、状态选择、动作建议 |
| 第 6-7 周 | 日历反馈 | 热力图、每日详情、筛选、原因标签 |
| 第 7-8 周 | 洞察周报 | 周报、稳定度、恢复建议、原因分布 |
| 第 9-10 周 | 同步与小组件 | Supabase 同步、隐私入口、小组件快捷入口 |
| 第 11 周 | 会员基础版 | 权益定义、付费墙、订阅状态 |
| 第 12 周 | 内测收口 | 数据看板、回归测试、TestFlight / 内测包 |

## 十一、开发执行顺序

### 任务 1：建立应用底座

**文件：**

- 修改：`lib/main.dart`
- 创建：`lib/app/rhythm_app.dart`
- 创建：`lib/app/router/app_router.dart`
- 创建：`lib/app/theme/app_theme.dart`
- 创建：`lib/app/bootstrap/app_bootstrap.dart`

**步骤：**

- 编写 `RhythmApp`，接入 `MaterialApp.router`。
- 创建五个一级模块入口页，先保证导航结构稳定。
- 接入 Riverpod 根容器。
- 编写基础 Widget 测试，验证 App 能启动并显示今日页。
- 运行 `flutter test`。

### 任务 2：建立领域模型与本地库

**文件：**

- 创建：`lib/data/local/rhythm_database.dart`
- 创建：`lib/features/goal_schedule/domain/goal_schedule.dart`
- 创建：`lib/features/sleep_records/domain/sleep_record.dart`
- 创建：`lib/features/bedtime/domain/bedtime_session.dart`
- 创建：`test/features/sleep_records/sleep_record_rules_test.dart`

**步骤：**

- 定义目标作息、睡眠记录、睡前会话、原因标签、恢复计划、报告实体。
- 建立 Drift 表和 Repository 接口。
- 写达标、晚睡分钟数、有效记录天测试。
- 实现最小规则让测试通过。
- 运行 `flutter test test/features/sleep_records/sleep_record_rules_test.dart`。

### 任务 3：实现首次激活

**文件：**

- 创建：`lib/features/onboarding/presentation/onboarding_flow_page.dart`
- 创建：`lib/features/goal_schedule/presentation/goal_setup_page.dart`
- 创建：`lib/features/notifications/presentation/reminder_setup_page.dart`
- 创建：`test/features/onboarding/onboarding_flow_test.dart`

**步骤：**

- 实现价值说明、登录选择、健康权限说明、目标作息设置、提醒策略。
- 支持跳过健康授权。
- 保存目标作息后进入今日页。
- 覆盖目标设置表单校验测试。
- 运行 `flutter test test/features/onboarding/onboarding_flow_test.dart`。

### 任务 4：实现睡眠记录能力

**文件：**

- 创建：`lib/data/health/health_sleep_data_source.dart`
- 创建：`lib/features/sleep_records/data/sleep_record_repository.dart`
- 创建：`lib/features/sleep_records/presentation/manual_sleep_record_page.dart`
- 创建：`test/features/sleep_records/manual_sleep_record_test.dart`

**步骤：**

- 封装健康数据读取接口和失败结果。
- 实现手动补录、编辑和数据来源标记。
- 授权失败时引导手动补录。
- 覆盖补录和编辑测试。
- 运行 `flutter test test/features/sleep_records/manual_sleep_record_test.dart`。

### 任务 5：实现今日页

**文件：**

- 创建：`lib/features/today/presentation/today_page.dart`
- 创建：`lib/features/today/application/today_controller.dart`
- 创建：`lib/features/today/domain/today_summary.dart`
- 创建：`test/features/today/today_summary_test.dart`

**步骤：**

- 聚合昨晚结果、今晚目标、恢复建议、快捷入口和 7 日趋势。
- 处理有数据、无数据、授权失败、晚睡后四类状态。
- 晚睡后展示恢复建议而不是失败惩罚。
- 覆盖 Summary 计算测试。
- 运行 `flutter test test/features/today/today_summary_test.dart`。

### 任务 6：实现睡前模式

**文件：**

- 创建：`lib/features/bedtime/presentation/bedtime_page.dart`
- 创建：`lib/features/bedtime/application/bedtime_controller.dart`
- 创建：`lib/features/bedtime/domain/bedtime_action_rules.dart`
- 创建：`test/features/bedtime/bedtime_action_rules_test.dart`

**步骤：**

- 实现倒计时、状态选择和轻量动作建议。
- 状态选择后保存 `BedtimeSession`。
- 接入通知和小组件入口参数。
- 覆盖三种状态的动作建议测试。
- 运行 `flutter test test/features/bedtime/bedtime_action_rules_test.dart`。

### 任务 7：实现日历和标签

**文件：**

- 创建：`lib/features/calendar/presentation/calendar_page.dart`
- 创建：`lib/features/calendar/domain/calendar_day_summary.dart`
- 创建：`lib/features/sleep_records/presentation/sleep_delay_tag_picker.dart`
- 创建：`test/features/calendar/calendar_heatmap_test.dart`

**步骤：**

- 实现按目标时间偏差着色的月历热力图。
- 实现每日详情和筛选模式。
- 实现默认原因标签和自定义标签。
- 覆盖热力图颜色规则测试。
- 运行 `flutter test test/features/calendar/calendar_heatmap_test.dart`。

### 任务 8：实现洞察周报

**文件：**

- 创建：`lib/features/insights/presentation/insights_page.dart`
- 创建：`lib/features/insights/domain/weekly_report_generator.dart`
- 创建：`lib/features/insights/domain/recovery_plan_rules.dart`
- 创建：`test/features/insights/weekly_report_generator_test.dart`

**步骤：**

- 生成最近 7 天达标率、稳定度、主要原因和下周建议。
- 明显晚睡后生成 1-3 天恢复建议。
- 避免医疗化表达。
- 覆盖周报生成和恢复触发测试。
- 运行 `flutter test test/features/insights/weekly_report_generator_test.dart`。

### 任务 9：实现同步、会员和小组件

**文件：**

- 创建：`lib/features/sync/application/sync_service.dart`
- 创建：`lib/features/membership/application/membership_service.dart`
- 创建：`lib/features/widget_bridge/application/widget_snapshot_service.dart`
- 创建：`test/features/sync/sync_service_test.dart`

**步骤：**

- 实现最小同步队列和失败重试。
- 实现会员权益状态读取和付费墙展示条件。
- 实现小组件快照输出。
- 覆盖同步冲突和付费墙展示条件测试。
- 运行 `flutter test test/features/sync/sync_service_test.dart`。

### 任务 10：内测收口

**文件：**

- 创建：`integration_test/activation_to_weekly_report_test.dart`
- 修改：`README.md`
- 创建：`docs/rhythm-sleep-routine-management-test-checklist-2026-05-22.md`

**步骤：**

- 编写首次激活到周报的集成测试。
- 补齐 README 的本地运行、测试、构建说明。
- 输出人工验收清单。
- 运行 `flutter test` 和 `flutter test integration_test`。
- 打包内测版本并记录已知风险。

## 十二、完成定义

### 12.1 V0.1 内测完成定义

- 核心闭环完整可用：目标设置、记录、今日反馈、睡前模式、标签、恢复建议、周报。
- 健康授权失败时仍可手动完成闭环。
- 关键计算有单元测试。
- 关键页面有 Widget 测试。
- 首次激活到周报有集成测试。
- 关键埋点事件已接入统一接口。
- 隐私、导出、删除入口具备基础页面。
- 无 P0/P1 阻塞缺陷。

### 12.2 暂缓到 V0.2 或 V1.0

- Android Health Connect 深度适配和设备差异专项。
- 工作日 / 休息日双目标。
- 轮班 / 时差模式。
- 月报、年度报告。
- AI 周复盘。
- 高级小组件和主题商店。
- 海外本地化。

## 十三、研发注意事项

- 所有新增类、函数、实体定义必须有简体中文注释，解释业务意图或边界。
- 对复杂计算、时区归属、同步冲突、健康数据降级等逻辑必须补充中文注释。
- 单文件超过 800 行前必须拆分。
- 改动函数、类或方法前必须先跑 GitNexus impact 分析。
- 提交前必须跑 GitNexus detect changes，确认影响范围符合预期。
- 每个阶段优先写测试，再实现最小代码通过测试。
- 不为旧版行为做兼容，除非需求明确要求。
