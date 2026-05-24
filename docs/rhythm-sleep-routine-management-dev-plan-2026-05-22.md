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
| 首发平台 | Flutter 跨平台工程内同时支持 iOS HealthKit 与 Android Health Connect 主链路；阶段三完成双端权限申请、最近 30 天睡眠记录读取、失败降级与手动补录 | 当前项目已是 Flutter，依赖中已包含 `health`，应在 MVP 阶段直接验证双端核心闭环，设备差异专项后置 |
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

- 同时封装 iOS HealthKit 与 Android Health Connect 双端读取适配器，完成主链路接入。
- 支持 Android Health Connect 可用性检测、安装引导、权限申请、权限恢复和无数据降级。
- 实现双端最近 30 天睡眠记录同步。
- 支持同步失败提示、重试和降级到手动补录。
- 实现手动新增、编辑入睡时间和起床时间。
- 保留原始系统记录和用户修正状态，避免手动修正破坏来源数据。
- 完成 `sleep_record_synced`、`sleep_record_sync_failed`、`sleep_record_manual_created`、`sleep_record_manual_edited` 埋点。

阶段依赖：

- 输入依赖：阶段二的目标作息、提醒设置、健康权限说明和首次激活完成状态必须已可读。
- 数据依赖：目标作息中的 `targetBedtimeMinutes`、`lateThresholdMinutes`、`dayStartMinutes` 需要可被睡眠记录模块直接消费。
- 平台依赖：iOS 侧需要 HealthKit 权限链路，Android 侧需要 Health Connect 可用性、安装状态和权限状态探测能力。
- 路由依赖：需要具备从今日页占位入口、权限失败状态和同步失败状态跳转到手动补录页的统一入口约定。

功能任务包拆解：

#### 5.3.1 任务包 A：睡眠记录领域模型与有效记录口径

- 定义 `SleepRecord`、`EffectiveSleepRecord`、`SleepRecordSource`、`SleepRecordConfidence` 等核心模型，明确“原始系统记录”“用户手动补录”“用户修正后的有效记录”三层语义。
- 抽离 `recordDate` 归属、一日开始时间、跨午夜睡眠、时区保存等规则，避免页面、仓储和同步链路各写一套时间判断。
- 统一有效记录优先级：用户修正或手动补录优先于系统原始记录，下游页面只消费有效记录，不直接消费底层来源表。
- 在模型层显式保留来源、可信度、时区和是否用户确认，避免阶段四和阶段六再补字段。

#### 5.3.2 任务包 B：本地存储与查询层

- 建立睡眠记录表、用户修正表或等价覆盖结构，保证原始来源可追溯，且用户编辑不会直接覆盖系统原始记录。
- 为记录表补齐 `recordDate`、`fellAsleepAt`、`wokeUpAt`、`durationMinutes`、`source`、`timezone`、`confidence`、`isUserEdited`、`lastSyncedAt` 等字段。
- 建立统一 Repository 与查询层，对上暴露“写入原始记录”“写入手动记录”“查询有效记录”“查询最近 7/30 天记录”等能力。
- 去重策略优先按平台来源、时间范围和归属日综合判断，避免重复同步产生多条看似不同但语义相同的记录。

#### 5.3.3 任务包 C：iOS HealthKit 主链路

- 完成 HealthKit 权限申请、最近 30 天睡眠记录读取、标准化映射和本地入库。
- 权限拒绝、用户稍后处理、读取无数据、系统异常四类结果必须映射成统一业务状态，不向上层暴露插件原始错误。
- iOS 侧读取结果必须带入来源和可信度，后续日历详情页可以解释“记录来自系统同步还是用户修正”。
- 同步完成后输出摘要结果，为今日页、管理页和埋点提供“读取了多少条记录、最后一次同步时间、是否存在失败”的稳定口径。

#### 5.3.4 任务包 D：Android Health Connect 主链路

- Android 侧必须完成 Health Connect 可用性检测，区分“设备不可用”“未安装”“已安装但未授权”“已授权但无数据”“读取异常”五类状态。
- 未安装时提供安装引导入口；不可用时提供说明和手动补录降级路径；已安装但未授权时提供重新申请权限入口。
- 完成 Android 最近 30 天睡眠记录读取、标准化映射和本地入库，保证与 iOS 共用同一套领域模型和查询层。
- Android 平台差异只在适配层和状态建模层收口，不把安装引导、版本判断和权限恢复逻辑散落到页面或控制器。
- 本阶段只要求完成 Android 主链路，不在阶段三内展开厂商设备差异、异常机型和多版本兼容专项。

#### 5.3.5 任务包 E：双端同步、失败降级与重试

- 建立统一同步用例：权限检查 -> 平台读取 -> 标准化 -> 去重 -> 入库 -> 产出同步结果摘要。
- 同步失败时必须区分“权限失败”“平台不可用”“无数据”“读取异常”，确保 UI 能展示不同补救动作，而不是一律给出泛化报错。
- 失败场景下优先提供两类补救路径：立即重试、进入手动补录；避免用户卡在无出口的错误页。
- 双端都需要支持重复同步且结果稳定，不允许多次同步后制造重复记录或覆盖用户修正结果。

#### 5.3.6 任务包 F：手动补录、编辑与阶段性管理入口

- 实现手动补录页，支持新增入睡时间、起床时间、记录日期，并复用同一表单完成编辑昨晚记录场景。
- 手动补录和编辑必须通过统一表单状态与校验层实现，不把跨字段校验直接写在页面中。
- 补录页要明确展示来源说明，例如“手动补录会作为当前展示基准，但不会删除系统原始记录”。
- 在今日页正式完成前，提供阶段性的睡眠记录管理入口页，承接同步状态、最近记录列表、重试和手动补录入口，保证阶段三能力可独立验收。

#### 5.3.7 任务包 G：国际化、埋点与测试

- 所有新增用户文案接入 `l10n`，覆盖 Android 安装引导、平台不可用、权限恢复、无数据提示、同步失败、手动补录和编辑成功反馈。
- 补齐睡眠记录相关埋点，并保证双端都能区分成功同步、失败同步、手动创建和手动编辑四类关键事件。
- 单元测试优先覆盖记录归属、有效记录优先级、去重策略、平台状态映射和同步结果分类。
- Widget 测试至少覆盖手动补录页、同步失败状态、Android 未安装引导状态和阶段性管理入口页。
- 集成测试至少覆盖“iOS 或 Android 主链路成功同步”与“Android 不可用或权限失败后进入手动补录”两条最小闭环。

验收：

- iOS HealthKit 授权成功时可读取睡眠记录并写入本地库。
- Android Health Connect 可用且授权成功时可读取睡眠记录并写入本地库。
- Android Health Connect 未安装、不可用、授权失败或无数据时，用户仍可通过引导进入手动补录。
- 双端同步失败后都支持重试和降级补录。
- 修改记录后日历和今日页读取的是用户确认后的结果。

### 5.4 阶段四：今日页，第 4-5 周

目标：让用户一眼看懂昨晚结果和今晚行动。

- 实现顶部状态卡：昨晚结果、是否达标、晚睡或提前分钟数、连续表现。
- 实现行动卡：今晚目标、距离目标剩余时间、进入睡前模式入口。
- 实现恢复建议卡：仅在明显晚睡后展示。
- 实现快捷记录卡：原因标签、手动补录、修改昨晚记录。
- 实现最近 7 天微趋势卡。
- 缺失数据时展示温和空态，引导补录或授权。

阶段依赖：

- 输入依赖：阶段二的目标作息、提醒设置和首次激活完成状态必须已可读。
- 数据依赖：阶段三的睡眠记录读取、手动补录、用户修正结果和数据来源标记必须已落库。
- 路由依赖：今日页需要已经具备跳转睡前模式、手动补录页、标签弹层的路由与入口约定。
- 规则依赖：达标判断、晚睡分钟数、连续表现、恢复触发条件必须已有统一领域口径。

功能任务包拆解：

#### 5.4.1 任务包 A：今日页状态聚合

- 输出一个稳定的 `TodayViewState`，统一承接页面所需全部数据，避免页面层直接拼多个 Repository。
- 基于 `GoalSchedule`、最近睡眠记录、恢复建议和通知设置生成 `TodaySummary`。
- 明确四类主状态：有数据、无数据、授权失败、仅手动记录。
- 明确页面级派生字段：昨晚结果文案、是否达标、偏差分钟数、连续表现、今晚目标、距目标剩余时间、推荐主行动。
- 对“无昨晚记录但已有目标”“有昨晚记录但无恢复建议”“目标缺失”三类边界场景给出明确降级结果。

#### 5.4.2 任务包 B：顶部状态卡与行动卡

- 顶部状态卡只承载昨晚结果，不混入设置入口、解释性长文案或复杂图表。
- 状态卡优先展示用户最关心的结论：达标、晚睡多少分钟、提前多少分钟、连续表现是否延续。
- 行动卡只回答今晚怎么做：今晚目标时间、当前距离目标时间、是否建议现在进入睡前模式。
- 若距离目标较远，行动卡文案强调“今晚目标”；若距离目标较近，文案强调“准备进入睡前模式”。
- 两张卡需要为后续埋点预留点击位：进入睡前模式、查看说明、查看更多趋势。

#### 5.4.3 任务包 C：恢复建议卡

- 恢复建议卡只在“明显晚睡且存在有效恢复建议”时出现，不在轻微偏差时过度打扰。
- 恢复建议卡优先输出 1 个主建议，不在今日页堆叠多条规则说明。
- 卡片内容包含：触发原因摘要、恢复周期天数、今日建议动作、查看详情入口。
- 恢复建议文案必须非医疗化，强调“恢复节奏”“今晚先做一步”，不使用失败或羞辱式表达。
- 恢复建议卡需要支持“稍后查看”和“查看详情”两类后续路径，避免今日页信息过重。

#### 5.4.4 任务包 D：快捷记录与补救入口

- 快捷记录卡承接三类高频补救动作：补原因标签、手动补录、修改昨晚记录。
- 今日页只负责展示入口，不直接承载长表单；复杂输入统一下沉到弹层或独立页面。
- 原因标签入口优先命中“昨晚已晚睡且尚未补标签”的场景，减少用户搜索成本。
- 手动补录入口在“无记录”或“授权失败”时提升优先级，作为主补救路径。
- 修改昨晚记录入口在已有记录时可见，并明确提示“会以用户确认结果作为今日展示基准”。

#### 5.4.5 任务包 E：7 日微趋势与空态体系

- 7 日微趋势卡只做轻量反馈，不承担完整洞察页职责。
- 微趋势默认展示最近 7 天的入睡偏差或达标结果，强调“是否变稳”而不是展示复杂统计。
- 数据不足时展示低压空态，例如“再积累几天就能看到趋势”，而不是直接隐藏整个区块。
- 无数据、权限失败、目标缺失三类空态必须区分处理，分别给出补录、授权、去设置目标的行动按钮。
- 空态文案遵守温和语气，不把“没数据”表达成用户失败。

#### 5.4.6 任务包 F：埋点、性能与测试

- 补齐今日页相关埋点：`today_viewed`、`today_primary_action_clicked`、`today_quick_action_clicked`、`today_recovery_card_viewed`。
- Widget 测试覆盖四类状态和主要 CTA 显示逻辑，避免页面只在单一路径下可用。
- 单元测试覆盖 `TodaySummary` 计算，确保达标、偏差、连续表现和恢复卡出现条件口径稳定。
- 今日页首屏信息应在一次进入后快速可读，避免把说明文本、历史统计和设置入口堆在首屏。
- 页面结构遵守拆分规则：`today_page.dart` 负责编排，区块拆到 `presentation/widgets/sections/`，避免单文件膨胀。

建议交付顺序：

1. 先完成 `TodaySummary` 和 `TodayViewState` 的领域与应用层聚合。
2. 再落地顶部状态卡和行动卡，保证主信息链路先可用。
3. 然后接入恢复建议卡和快捷记录卡，打通补救路径。
4. 最后补齐 7 日微趋势、空态体系、埋点和 Widget 测试。

阶段测试清单：

- 单元测试：达标、偏差分钟数、连续表现、恢复卡出现条件、主行动按钮选择。
- Widget 测试：有数据、无数据、授权失败、仅手动记录四类页面状态。
- 路由测试：从今日页进入睡前模式、手动补录、修改昨晚记录、补标签路径正确。
- 文案验收：晚睡反馈不出现羞辱式表达，空态不出现强命令式文案。

验收：

- 有数据、无数据、授权失败、手动记录四类状态都有清晰展示。
- 晚睡后优先展示恢复路径，不使用羞辱性文案。
- 今日页核心信息 3 秒内可读懂。

### 5.5 阶段五：睡前模式与提醒，第 6 周

目标：让用户在目标时间前进入“准备睡了”的行为干预流程。

- 从阶段五开始直到阶段十一，实施计划统一以 `docs/rhythm-remaining-stages-parallel-implementation-plan-2026-05-24.md` 为准。
- 这些剩余阶段根据实际情况决定采用串行或并行；对于可拆分的复杂任务，优先采用“共享契约冻结 -> 子代理并行轨道 -> 集成收口 -> 验收回归”的执行模式。
- 所有显示层实现默认以 `pen/app.pen` 为唯一设计源；若设计稿与现有代码冲突，以 Pencil 设计稿为准。

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

阶段依赖：

- 输入依赖：阶段二的目标作息、阶段三的有效睡眠记录、阶段四的补标签入口、阶段五的睡前拖延状态必须已形成稳定数据口径。
- 数据依赖：日历只消费“有效记录”和“用户确认后的原因标签”，不直接读取 Health 原始记录，避免热力图与今日页口径不一致。
- 路由依赖：需要具备从日历单日详情跳转到手动补录/编辑页、打开标签弹层和查看数据来源说明的入口。
- 国际化依赖：日历筛选、来源说明、标签保存反馈、自定义标签校验和空态文案必须接入 `l10n`。

功能任务包拆解：

#### 5.6.1 任务包 A：日历领域模型与热力图规则

- 定义 `CalendarDaySummary`、`CalendarMonthSummary`、`CalendarHeatmapLevel` 和 `CalendarFilter`，明确日历页只展示聚合后的天级状态。
- 热力图颜色必须基于 `targetBedtimeMinutes`、`lateThresholdMinutes` 和有效记录的入睡偏差计算，不允许使用固定 23:00、24:00 或自然日零点作为晚睡判断。
- 对无记录、提前入睡、阈值内、轻度晚睡、明显晚睡、用户修正记录分别建模，保证 UI 能展示不同颜色、说明和操作入口。
- 月维度聚合需要输出达标天数、有效记录天数、连续达标区间和最晚入睡日，为日历顶部摘要和后续周报复用。

#### 5.6.2 任务包 B：日历状态聚合与查询边界

- 建立 `CalendarController` 与 `CalendarViewState`，由应用层统一读取目标作息、有效睡眠记录、标签和筛选条件。
- 日历页面不直接访问 Repository；筛选、月份切换、单日选择、详情弹层打开状态都由 Controller 聚合。
- 查询范围按当前月份向前后补齐可见周，避免月历首尾日期缺数据导致网格跳动。
- 当目标作息缺失、记录缺失或权限失败时，输出可操作空态：去设置目标、补录记录、查看数据接入状态。

#### 5.6.3 任务包 C：月历热力图页面

- 实现 `CalendarPage`，使用 `HookConsumerWidget` 组织月份切换、筛选栏、热力图网格、图例和月摘要。
- 热力图单元格保持稳定尺寸，颜色、图标、选中态和今日态不改变网格布局。
- 首屏只展示月视图、筛选入口和必要摘要；详细来源、备注、标签编辑下沉到单日详情弹层。
- 接入 `calendar_viewed` 埋点，事件参数至少包含月份、有效记录天数、是否启用筛选和是否存在目标作息。

#### 5.6.4 任务包 D：单日详情弹层与数据来源说明

- 实现 `CalendarDayDetailSheet`，展示实际睡眠区间、入睡偏差、达标状态、来源、可信度、标签、备注和编辑入口。
- 详情弹层只承载轻量查看和 3 个以内主操作：补原因、编辑记录、查看来源说明。
- 数据来源说明通过 `RecordSourceExplainerSheet` 统一解释系统同步、手动补录、用户修正和可信度，不在日历页重复拼长说明。
- 接入 `day_detail_viewed` 埋点，事件参数至少包含记录日期、是否有有效记录、来源、是否用户编辑、是否已补标签。

#### 5.6.5 任务包 E：筛选模式与月内反馈

- 实现 `CalendarFilterSheet`，支持按入睡时间偏差、稳定度区间和晚睡次数进行筛选，并提供重置与应用。
- 筛选结果只影响当前日历展示与摘要，不修改底层记录或标签数据。
- 筛选后需要保留图例与空结果提示，空结果提供“一键清除筛选”动作。
- 筛选状态进入 `CalendarViewState`，方便 Widget 测试覆盖不同筛选组合。

#### 5.6.6 任务包 F：默认标签、自定义标签与保存反馈

- 定义默认不超过 8 个原因标签：刷手机、加班、游戏、追剧、情绪、聚会、时差、其他，默认标签顺序稳定。
- 实现 `SleepDelayTagPickerSheet`，支持多选默认标签、打开自定义标签输入、保存、取消和保存中状态。
- 自定义标签限制为 1-12 个字符，去除前后空白，禁止保存空值；重复标签按已有标签合并，不制造重复记录。
- 标签保存后立即刷新今日页、日历详情和后续洞察原因分布所依赖的数据，并展示统一 Snackbar 成功反馈。
- 接入 `delay_tag_added` 埋点，事件参数至少包含记录日期、标签数量、是否包含自定义标签和入口来源。

#### 5.6.7 任务包 G：国际化、测试与验收闭环

- 所有新增用户文案接入 `lib/l10n/app_en.arb` 和 `lib/l10n/app_zh.arb`，修改后运行 `flutter gen-l10n`。
- 单元测试覆盖热力图等级、月摘要、筛选规则、默认标签、自定义标签校验和重复标签合并。
- Widget 测试覆盖日历页有数据、无数据、筛选空结果、单日详情弹层、标签弹层和自定义标签弹层。
- 集成测试覆盖“日历点击某天 -> 补原因标签 -> 返回详情看到标签”和“筛选晚睡天 -> 清除筛选恢复月视图”两条最小闭环。

并行开发组织方式：

- 串行前置只做共享契约冻结：统一领域模型字段、ViewState 字段、路由参数、埋点参数、国际化 key 命名和测试夹具命名。
- 前置契约冻结后，领域规则、标签规则、页面组件、弹层组件必须由独立子代理并行开发；每个子代理只接收自己轨道所需上下文，不继承主线程完整上下文。
- `app_router.dart`、`app_en.arb`、`app_zh.arb`、生成本地化文件和最终 `CalendarController` 装配由集成负责人统一修改，避免多人同时改共享文件。
- UI 轨道先使用固定 `CalendarViewState` 测试夹具开发，不等待真实 Repository；集成轨道在领域规则和标签规则合入后替换为真实数据流。
- 每个子代理必须独立跑自己的最小测试，并在返回结果中列出修改文件、测试命令、测试结果、未处理风险和是否触碰共享文件；合流阶段再跑日历专项测试、全量 `flutter test` 和 GitNexus 变更检测。
- 主线程只负责子代理分派、结果审查、冲突检查和最终合流，不在子代理负责的轨道内手写补丁，除非子代理返回 `BLOCKED` 且需要重新拆分任务。

| 子代理轨道 | 分派时机 | 负责范围 | 主要文件 | 返回要求 |
| --- | --- | --- | --- | --- |
| 子代理 A：日历领域规则 | 共享契约已冻结后立即分派 | 热力图等级、月摘要、筛选规则、有效记录口径 | `calendar_day_summary.dart`、`calendar_month_summary.dart`、`calendar_heatmap_rules.dart`、`calendar_filter.dart` | `calendar_heatmap_test.dart` 通过，说明热力图不依赖固定晚睡时间 |
| 子代理 B：标签领域与保存 | 与子代理 A 同批并行分派 | 默认标签、自定义标签校验、重复合并、标签保存状态 | `sleep_delay_tag.dart`、`sleep_delay_tag_rules.dart`、`sleep_delay_tag_controller.dart` | `sleep_delay_tag_rules_test.dart` 通过，说明标签合并和自定义限制 |
| 子代理 C：日历页面组件 | `CalendarViewState` 字段冻结后并行分派 | 月份头、热力图、图例、月摘要、页面骨架 | `calendar_page.dart`、`calendar_month_header.dart`、`calendar_heatmap.dart`、`calendar_legend.dart`、`calendar_month_summary_section.dart` | 页面 Widget 测试可用固定状态渲染，说明未接真实 Repository |
| 子代理 D：弹层组件 | 单日详情 DTO 和标签回调契约冻结后并行分派 | 日详情、筛选、来源说明、标签选择、自定义标签输入 | `calendar_day_detail_sheet.dart`、`calendar_filter_sheet.dart`、`record_source_explainer_sheet.dart`、`sleep_delay_tag_picker_sheet.dart`、`custom_delay_tag_sheet.dart` | 弹层 Widget 测试覆盖打开、选择、保存、关闭，说明未改共享本地化生成文件 |
| 集成负责人 E：应用集成 | 子代理 A-D 返回并通过审查后执行 | Controller 聚合、路由、埋点、本地化、真实数据流接线 | `calendar_controller.dart`、`calendar_view_state.dart`、`app_router.dart`、`app_en.arb`、`app_zh.arb` | Controller 测试和页面集成测试通过，说明冲突处理结果 |
| 集成负责人 F：合流验收 | 所有轨道已合入后执行 | 生成本地化、专项测试、全量回归、人工闭环、GitNexus 变更检测 | 测试命令与验收清单 | 专项测试、`flutter test`、人工走查和 `detect_changes` 通过 |

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

阶段依赖：

- 输入依赖：阶段二的目标作息、阶段三的有效睡眠记录、阶段六的原因标签和日历统计口径必须已可读。
- 数据依赖：最近 7 天有效记录、每日达标结果、晚睡偏差分钟数、原因标签、恢复计划状态需要有统一查询入口。
- 规则依赖：达标率、稳定度、主要原因、恢复触发和恢复成功必须落在领域层，避免洞察页、今日页和周报详情页各算一套。
- 路由依赖：需要具备 `/insights`、`/insights/report/:periodStart`、`/insights/history` 的页面路由，以及恢复计划详情和稳定度说明弹层触发入口。
- 商业化依赖：历史洞察页需要能读取会员权益状态，免费用户访问 30 天前历史时进入轻量付费拦截，不影响本周免费周报。

功能任务包拆解：

#### 5.7.1 任务包 A：周报领域模型与统计口径

- 定义 `WeeklyReport`、`WeeklyReportDaySnapshot`、`WeeklyReportSummary`、`ReasonDistributionItem` 等领域模型，明确周报只消费“有效记录”和“有效标签”，不直接读取原始系统记录。
- 统一最近 7 天窗口计算：以用户设置的 `dayStartMinutes` 和本地时区确定统计周期，保证跨午夜记录和自然日边界一致。
- 达标率使用“达标天数 / 有效记录天数”，当有效记录少于 3 天时不生成正式周报，只输出积累数据空态。
- 稳定度使用最近 7 天入睡偏差的简化模型，输出 `0-100` 分、等级和一句非医疗化解释。
- 主要原因只统计用户主动补录或选择的原因标签，不把缺失标签自动归因，避免误导用户。

#### 5.7.2 任务包 B：恢复计划规则与状态模型

- 定义 `RecoveryPlan`、`RecoveryPlanStep`、`RecoveryPlanStatus`、`RecoveryTriggerReason`，支持 1-3 天轻量恢复建议。
- 恢复触发条件沿用全局口径：晚睡分钟数大于目标熬夜阈值，且该日为有效记录天。
- 恢复建议必须是行为建议，例如“今晚把准备动作提前 15 分钟”，不使用“治疗”“诊断”“治愈”“改善失眠”等医疗化表达。
- 恢复计划状态支持未查看、已查看、已完成、已延期，便于今日页和洞察页共享同一份状态。
- 恢复成功判断使用“触发后 3 天内至少 2 天回到阈值内”，不足样本时展示进行中，不提前判定失败。

#### 5.7.3 任务包 C：洞察页状态聚合

- 建立 `InsightsViewState` 和 `InsightsController`，由应用层聚合周报摘要、原因分布、恢复计划、历史入口和会员限制状态。
- 洞察页只读取 `InsightsViewState`，不直接拼接睡眠记录 Repository、标签 Repository、会员 Service 和恢复计划规则。
- 明确四类页面状态：可生成周报、数据不足、无有效记录、周报生成异常。
- 页面状态需要给出可执行补救动作：去手动补录、查看日历详情、继续积累、重试生成。
- 周报生成结果需要可缓存到本地 `reports` 或等价存储，避免每次进入洞察页都重复计算并造成展示抖动。

#### 5.7.4 任务包 D：洞察页与周报详情页

- 洞察页首屏展示本周达标率、稳定度、主要原因和恢复效果入口，避免堆叠复杂长报告。
- 原因分布优先展示前 3 个主要原因，其余原因合并为“其他”，降低首屏认知负担。
- 恢复效果入口只展示当前最相关的计划状态：有进行中计划则展示计划，有已完成计划则展示结果摘要。
- 周报详情页承载完整周报：统计周期、达标率、稳定度解释、最晚入睡日、原因分布、下周建议。
- 历史洞察页先支持周报列表和 30 天前历史的会员拦截，不在 V0.1 扩展月报和年度报告。

#### 5.7.5 任务包 E：弹层、国际化与合规文案

- 实现恢复计划详情弹层，展示 1-3 天建议、当前完成状态、完成按钮和延期入口。
- 实现稳定度说明弹层，解释评分样本、偏差口径和“数据不足”边界，不暴露复杂公式。
- 所有洞察页、周报详情页、历史页、恢复计划弹层和稳定度说明弹层的用户文案必须接入 `l10n`。
- 文案验收必须扫描医疗化禁词，禁止出现“治疗”“诊断”“治愈”“改善失眠”等表达。
- 空态文案以“继续积累”“今晚先做一步”“可以补录昨晚记录”为主，不使用惩罚式或羞辱式评价。

#### 5.7.6 任务包 F：埋点、测试与验收闭环

- 补齐洞察相关埋点：`weekly_report_viewed`、`recovery_plan_viewed`、`recovery_plan_completed`、`insights_history_viewed`、`stability_explainer_opened`。
- 单元测试覆盖周报窗口、达标率、稳定度、原因分布、恢复触发、恢复成功和数据不足降级。
- Controller 测试覆盖可生成周报、数据不足、无记录、生成异常和会员历史限制五类状态。
- Widget 测试覆盖洞察页、周报详情页、恢复计划详情弹层、稳定度说明弹层和历史洞察页付费拦截。
- 集成测试覆盖“有 7 天记录 -> 生成周报 -> 打开详情 -> 查看恢复计划 -> 标记完成”的最小闭环。

并行开发组织：

| 批次 | 可并行泳道 | 负责范围 | 汇合条件 |
| --- | --- | --- | --- |
| 第 0 批：契约对齐 | 单泳道先行 | 冻结 `WeeklyReport`、`RecoveryPlan`、`InsightsViewState`、文案 key、埋点参数和测试夹具 | 契约文件、Fake 数据和接口命名确认后再放开并行 |
| 第 1 批：领域规则并行 | 周报统计、稳定度、恢复计划 | 三组分别实现 `weekly_report_generator`、`stability_score_rules`、`recovery_plan_rules` 和对应单元测试 | 三组单元测试独立通过，且都只依赖第 0 批契约 |
| 第 2 批：应用与界面并行 | 状态聚合、洞察首页、详情/历史页、弹层/文案 | 应用组聚合 ViewState，页面组用 Fake ViewState 搭 UI，文案组合并 ARB 与生成文件 | Controller 测试、页面冒烟测试、`flutter gen-l10n` 都通过 |
| 第 3 批：集成收口 | 路由、埋点、Widget 测试、合规扫描 | 统一处理共享文件、跨页面跳转、埋点接入、完整 Widget 覆盖和医疗化禁词扫描 | 洞察相关测试和全量回归通过 |

并行边界：

- 领域规则组只改 `lib/features/insights/domain/` 和 `test/features/insights/*_rules_test.dart`，不修改页面、路由和本地化生成文件。
- 应用聚合组只改 `lib/features/insights/application/` 和 `insights_controller_test.dart`，通过 Fake Repository/Fake Service 消费领域规则。
- 页面组只改 `lib/features/insights/presentation/`，在集成前使用 Fake `InsightsViewState` 驱动 UI，不直接接 Repository。
- 文案与合规组统一负责 `lib/l10n/*.arb`、`flutter gen-l10n` 生成文件和医疗化禁词扫描，其他泳道不并行修改本地化文件。
- 路由、埋点和共享测试夹具作为汇合点处理，避免多个开发者同时改 `app_router.dart`、埋点入口和测试公共 Fake。

阶段测试清单：

- 单元测试：达标率、稳定度评分、最晚入睡日、原因分布、恢复触发、恢复成功、数据不足降级。
- Controller 测试：可生成周报、少于 3 天有效记录、无有效记录、生成异常、免费用户历史限制。
- Widget 测试：洞察页首屏、周报详情页、历史洞察页、恢复计划详情弹层、稳定度说明弹层。
- 文案验收：扫描医疗化禁词，确认晚睡反馈只给恢复路径，不输出诊断或惩罚式评价。

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
- Android 首次进入时检测 Health Connect 可用性。
- Android Health Connect 未安装时进入安装引导。
- Android Health Connect 不可用时展示说明并降级手动补录。
- Android Health Connect 已安装但未授权时重新发起权限申请。
- Android Health Connect 授权成功后同步最近 30 天睡眠记录。
- Android Health Connect 授权成功但无睡眠数据时进入手动补录。
- Android 同步异常时执行重试或降级补录。
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
- 创建：`lib/data/health/health_permission_gateway.dart`
- 创建：`lib/features/sleep_records/data/sleep_record_repository.dart`
- 创建：`lib/features/sleep_records/application/sleep_record_sync_controller.dart`
- 创建：`lib/features/sleep_records/presentation/sleep_records_hub_page.dart`
- 创建：`lib/features/sleep_records/presentation/manual_sleep_record_page.dart`
- 创建：`test/features/sleep_records/manual_sleep_record_test.dart`
- 创建：`test/features/sleep_records/health_sleep_data_source_test.dart`

**步骤：**

- 封装 iOS HealthKit 与 Android Health Connect 的统一读取接口、权限状态和失败结果。
- 实现 Android Health Connect 可用性检测、安装引导状态、权限申请和权限恢复分支。
- 实现最近 30 天睡眠记录同步、去重入库和同步结果摘要。
- 实现阶段性睡眠记录管理页，承接同步状态、最近记录、重试和手动补录入口。
- 实现手动补录、编辑和数据来源标记，确保用户修正优先于系统原始记录参与展示。
- 在 Health Connect 不可用、未安装、权限失败或无数据时引导进入手动补录。
- 覆盖双端读取状态、补录和编辑测试。
- 运行 `flutter test test/features/sleep_records/manual_sleep_record_test.dart test/features/sleep_records/health_sleep_data_source_test.dart`。

### 任务 5：实现今日页

**文件：**

- 创建：`lib/features/today/presentation/today_page.dart`
- 创建：`lib/features/today/application/today_controller.dart`
- 创建：`lib/features/today/application/today_view_state.dart`
- 创建：`lib/features/today/domain/today_summary.dart`
- 创建：`lib/features/today/domain/today_primary_action.dart`
- 创建：`lib/features/today/presentation/widgets/sections/today_status_section.dart`
- 创建：`lib/features/today/presentation/widgets/sections/today_action_section.dart`
- 创建：`lib/features/today/presentation/widgets/sections/today_recovery_section.dart`
- 创建：`lib/features/today/presentation/widgets/sections/today_quick_actions_section.dart`
- 创建：`lib/features/today/presentation/widgets/sections/today_trend_section.dart`
- 创建：`lib/features/today/presentation/widgets/states/today_empty_state.dart`
- 创建：`lib/features/today/presentation/widgets/sheets/today_quick_actions_sheet.dart`
- 创建：`test/features/today/today_summary_test.dart`
- 创建：`test/features/today/today_controller_test.dart`
- 创建：`test/features/today/presentation/today_page_test.dart`

**步骤：**

1. 先定义 `TodaySummary`、`TodayPrimaryAction` 和 `TodayViewState`，明确今日页展示字段、主行动类型和四类页面状态。
2. 先写 `today_summary_test.dart`，覆盖达标、晚睡、提前入睡、连续表现、恢复建议显示条件和无记录降级规则。
3. 实现 `today_controller.dart`，从目标作息、最近睡眠记录、恢复建议和通知设置聚合页面状态，不让页面层直接读多个数据源。
4. 编写 `today_controller_test.dart`，覆盖“有记录”“无记录”“授权失败”“仅手动记录”四类状态映射。
5. 在 `today_page.dart` 中搭建页面骨架，使用 `HookConsumerWidget` 组织显示层，并把区块拆到 `widgets/sections/`。
6. 实现 `today_status_section.dart` 和 `today_action_section.dart`，先让昨晚结果和今晚行动链路稳定可读。
7. 实现 `today_recovery_section.dart`、`today_quick_actions_section.dart` 和 `today_quick_actions_sheet.dart`，接入补标签、手动补录、修改昨晚记录入口。
8. 实现 `today_trend_section.dart` 和 `today_empty_state.dart`，补齐 7 日微趋势、无数据、权限失败、目标缺失的温和空态。
9. 接入今日页埋点，至少覆盖页面曝光、主行动点击、快捷动作点击和恢复建议曝光。
10. 编写 `today_page_test.dart`，覆盖四类主状态下的首屏区块可见性和关键按钮文案。
11. 运行 `flutter test test/features/today/today_summary_test.dart test/features/today/today_controller_test.dart test/features/today/presentation/today_page_test.dart`。
12. 完成一次人工走查：验证“3 秒看懂首屏”“晚睡优先给恢复路径”“无数据优先给补救动作”三项体验目标。

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

**实施任务单：**

- 独立文档：`docs/rhythm-remaining-stages-parallel-implementation-plan-2026-05-24.md`

**执行要求：**

- 任务 7 及其后的剩余阶段，详细文件清单、子代理分派轨道、返回格式、合流顺序、测试命令和验收清单统一以新的并行实施计划文档为准。
- 实施时必须先冻结共享契约，再并行分派子代理处理各业务轨道。
- 主线程只负责子代理分派、结果审查、冲突检查和最终合流；不得直接代写子代理轨道内的实现。
- 合流后必须运行专项测试、全量 `flutter test` 和 `npx gitnexus detect_changes`，确认影响范围符合预期阶段边界。

### 任务 8：实现洞察周报

**文件：**

- 创建：`lib/features/insights/domain/weekly_report.dart`
- 创建：`lib/features/insights/presentation/insights_page.dart`
- 创建：`lib/features/insights/domain/weekly_report_generator.dart`
- 创建：`lib/features/insights/domain/stability_score_rules.dart`
- 创建：`lib/features/insights/domain/reason_distribution_rules.dart`
- 创建：`lib/features/insights/domain/recovery_plan.dart`
- 创建：`lib/features/insights/domain/recovery_plan_rules.dart`
- 创建：`lib/features/insights/application/insights_controller.dart`
- 创建：`lib/features/insights/application/insights_view_state.dart`
- 创建：`lib/features/insights/presentation/weekly_report_detail_page.dart`
- 创建：`lib/features/insights/presentation/report_history_page.dart`
- 创建：`lib/features/insights/presentation/widgets/sections/weekly_report_summary_section.dart`
- 创建：`lib/features/insights/presentation/widgets/sections/stability_section.dart`
- 创建：`lib/features/insights/presentation/widgets/sections/reason_distribution_section.dart`
- 创建：`lib/features/insights/presentation/widgets/sections/recovery_effect_section.dart`
- 创建：`lib/features/insights/presentation/widgets/states/insights_empty_state.dart`
- 创建：`lib/features/insights/presentation/widgets/sheets/recovery_plan_detail_sheet.dart`
- 创建：`lib/features/insights/presentation/widgets/sheets/stability_explainer_sheet.dart`
- 创建：`test/features/insights/stability_score_rules_test.dart`
- 创建：`test/features/insights/recovery_plan_rules_test.dart`
- 创建：`test/features/insights/weekly_report_generator_test.dart`
- 创建：`test/features/insights/insights_controller_test.dart`
- 创建：`test/features/insights/presentation/insights_page_test.dart`

**步骤：**

**并行开发批次：**

1. 第 0 批：契约与夹具先行。
   - 运行 GitNexus 影响分析，分别检查 `appRouter`、有效睡眠记录查询入口、原因标签查询入口、会员状态入口、本地化生成类和埋点服务入口；如任一结果为 HIGH 或 CRITICAL，先记录风险并暂停确认。
   - 定义 `WeeklyReport`、`WeeklyReportDaySnapshot`、`WeeklyReportSummary`、`ReasonDistributionItem`、`RecoveryPlan`、`RecoveryPlanStep`、`RecoveryPlanStatus`、`InsightsViewState` 的字段和命名。
   - 建立测试夹具约定：最近 7 天有效记录、少于 3 天记录、无记录、明显晚睡、标签分布、免费用户历史限制。
   - 冻结洞察文案 key 和埋点事件参数，文案值可由文案泳道补齐，但 key 不再由各功能泳道临时新增。

2. 第 1 批 A 泳道：周报统计规则。
   - 编写 `weekly_report_generator_test.dart`，覆盖最近 7 天窗口、至少 3 天有效记录、达标率、最晚入睡日、主要原因和下周建议。
   - 实现 `weekly_report_generator.dart` 和 `reason_distribution_rules.dart`，只消费有效睡眠记录、目标作息和原因标签，不直接读取原始健康数据。
   - 运行 `flutter test test/features/insights/weekly_report_generator_test.dart`。

3. 第 1 批 B 泳道：稳定度规则。
   - 编写 `stability_score_rules_test.dart`，覆盖稳定、轻微波动、明显波动、样本不足四类评分结果。
   - 实现 `stability_score_rules.dart`，输出 `0-100` 稳定度、等级和非医疗化解释文案 key。
   - 运行 `flutter test test/features/insights/stability_score_rules_test.dart`。

4. 第 1 批 C 泳道：恢复计划规则。
   - 编写 `recovery_plan_rules_test.dart`，覆盖明显晚睡触发、轻微偏差不触发、1-3 天建议、恢复成功和样本不足进行中状态。
   - 实现 `recovery_plan_rules.dart`，确保建议内容使用国际化 key，而不是在领域层写死展示文案。
   - 运行 `flutter test test/features/insights/recovery_plan_rules_test.dart`。

5. 第 2 批 A 泳道：应用状态聚合。
   - 在第 1 批三个领域泳道测试通过后，编写 `insights_controller_test.dart`，覆盖可生成周报、少于 3 天有效记录、无有效记录、生成异常和免费用户历史限制状态。
   - 实现 `InsightsController`，从睡眠记录、标签、目标作息、恢复计划和会员状态聚合 `InsightsViewState`。
   - 运行 `flutter test test/features/insights/insights_controller_test.dart`。

6. 第 2 批 B 泳道：洞察首页。
   - 使用 Fake `InsightsViewState` 搭建 `insights_page.dart`，并拆分 `weekly_report_summary_section.dart`、`stability_section.dart`、`reason_distribution_section.dart`、`recovery_effect_section.dart` 和 `insights_empty_state.dart`。
   - 页面使用 `HookConsumerWidget`，不直接调用 Repository，不在页面层计算达标率、稳定度或恢复触发。
   - 编写首页 Widget 测试，覆盖周报可见、数据不足空态和无记录空态。

7. 第 2 批 C 泳道：详情页、历史页与弹层。
   - 实现 `weekly_report_detail_page.dart`、`report_history_page.dart`、`recovery_plan_detail_sheet.dart` 和 `stability_explainer_sheet.dart`。
   - 详情页展示完整周报，历史页承接列表和 30 天前历史的付费拦截；弹层只消费聚合状态，不直接调用 Repository。
   - 编写 Widget 测试，覆盖周报详情、历史付费拦截、恢复计划弹层和稳定度说明弹层。

8. 第 2 批 D 泳道：国际化与合规文案。
   - 更新 `lib/l10n/app_en.arb` 和 `lib/l10n/app_zh.arb`，补齐洞察页、周报详情、历史页、恢复计划、稳定度说明、空态和付费拦截文案。
   - 运行 `flutter gen-l10n`，确认生成的 `app_localizations*.dart` 包含第 0 批冻结的文案 key。
   - 扫描新增 ARB 和洞察相关 Dart 文件，确认不出现“治疗”“诊断”“治愈”“改善失眠”等医疗化表达。

9. 第 3 批：集成汇合。
   - 合并第 2 批各泳道后，接入洞察埋点：`weekly_report_viewed`、`recovery_plan_viewed`、`recovery_plan_completed`、`insights_history_viewed` 和 `stability_explainer_opened`。
   - 在 `app_router.dart` 挂载 `/insights`、`/insights/report/:periodStart`、`/insights/history`，并确认底部导航与详情返回路径稳定。
   - 汇总 `insights_page_test.dart`，覆盖首页、详情页、历史页、恢复计划弹层、稳定度说明弹层和主要 CTA。
   - 运行 `flutter test test/features/insights/weekly_report_generator_test.dart test/features/insights/stability_score_rules_test.dart test/features/insights/recovery_plan_rules_test.dart test/features/insights/insights_controller_test.dart test/features/insights/presentation/insights_page_test.dart`。
   - 运行 `flutter test` 做全量回归，确认今日页、日历标签、恢复建议入口和会员拦截未被洞察改动破坏。
   - 提交前运行 `npx gitnexus detect_changes`，确认影响范围只覆盖洞察、路由、本地化、埋点和预期测试。

**并行约束：**

- 第 0 批完成前不得启动第 1、2 批，避免模型字段、文案 key 和测试夹具反复改名。
- 第 1 批 A/B/C 三个领域泳道可以同时开发，互相不得修改对方测试文件。
- 第 2 批 B/C 页面泳道可以在 Controller 未完成时用 Fake ViewState 先行，但最终必须回接真实 `InsightsController`。
- `lib/l10n/*.arb`、生成的 `app_localizations*.dart`、`app_router.dart` 和埋点入口只在第 2 批 D 或第 3 批统一修改。

### 任务 9：实现同步、会员和小组件

**并行开发原则：**

- 任务 9 拆成“共享契约准备 -> 三条业务轨道并行 -> 集成收口”三段执行。
- 共享文件只由契约轨道和集成轨道修改：`lib/app/router/app_router.dart`、`lib/data/local/rhythm_database.dart`、`lib/l10n/app_en.arb`、`lib/l10n/app_zh.arb`。
- 同步、会员、小组件三条业务轨道不得直接互相依赖；需要跨模块读取时只依赖共享契约、Provider 接口或 Fake 实现。
- 每条业务轨道必须能独立运行自己的单元测试和 Widget 测试；集成轨道只负责合并路由、国际化、埋点和端到端走查。
- 并行分支建议使用 `codex/task9-contracts`、`codex/task9-sync`、`codex/task9-membership`、`codex/task9-widget`、`codex/task9-integration`。

**共享契约轨道（先完成，其他轨道基于它开工）：**

**文件：**

- 创建：`lib/features/sync/domain/sync_queue_item.dart`
- 创建：`lib/features/sync/domain/sync_conflict_policy.dart`
- 创建：`lib/features/membership/domain/membership_entitlement.dart`
- 创建：`lib/features/membership/domain/membership_paywall_policy.dart`
- 创建：`lib/features/widget_bridge/domain/widget_snapshot.dart`
- 修改：`lib/data/local/rhythm_database.dart`
- 创建：`test/features/sync/sync_conflict_policy_test.dart`
- 创建：`test/features/membership/membership_paywall_policy_test.dart`
- 创建：`test/features/widget_bridge/widget_snapshot_contract_test.dart`

**步骤：**

1. 定义 `SyncQueueItem`、`SyncEntityType`、`SyncOperation`、`SyncRunSummary` 和 `SyncConflictPolicy`，明确目标作息、睡眠记录、原因标签、周报摘要四类实体的同步载荷边界。
2. 在 `rhythm_database.dart` 中只补齐 `sync_queue` 表结构和最小 DAO 暴露点，不在本轨道实现 Supabase 读写。
3. 编写 `sync_conflict_policy_test.dart`，覆盖“用户编辑优先”“远端较新但本地未编辑”“删除与更新冲突”“重复同步幂等”四类冲突口径。
4. 定义 `MembershipEntitlement` 和 `MembershipPaywallPolicy`，明确免费版、试用、月付、年付、永久会员的能力位和付费墙触发条件。
5. 编写 `membership_paywall_policy_test.dart`，覆盖免费用户受限、试用用户放行、会员用户放行、首次核心体验不强拦四类口径。
6. 定义 `WidgetSnapshot`，约束小组件只输出今晚目标、距离目标、昨晚状态和入口参数，不暴露过细睡眠健康数据。
7. 编写 `widget_snapshot_contract_test.dart`，覆盖无目标、无数据、未授权、有完整数据四类快照字段边界。

**并行轨道 A：云同步与账号同步页**

**文件：**

- 创建：`lib/app/bootstrap/supabase_bootstrap.dart`
- 创建：`lib/data/remote/supabase_sync_remote_data_source.dart`
- 创建：`lib/features/sync/data/sync_queue_repository.dart`
- 创建：`lib/features/sync/application/sync_service.dart`
- 创建：`lib/features/sync/application/account_sync_controller.dart`
- 创建：`lib/features/sync/presentation/account_sync_page.dart`
- 创建：`lib/features/sync/presentation/widgets/dialogs/sync_retry_dialog.dart`
- 创建：`test/features/sync/sync_service_test.dart`
- 创建：`test/features/sync/presentation/account_sync_page_test.dart`

**步骤：**

1. 实现 `SyncQueueRepository`，让应用层只消费队列接口，不直接拼 Drift 查询。
2. 实现 `supabase_bootstrap.dart` 和 `SupabaseSyncRemoteDataSource`，集中处理 Supabase 初始化、登录态检查、远端表读写和插件错误转换。
3. 实现 `SyncService` 的同步主流程：读取待同步队列 -> 上传本地变更 -> 拉取远端变更 -> 套用冲突策略 -> 标记队列状态 -> 输出同步摘要。
4. 编写 `sync_service_test.dart`，覆盖成功同步、失败重试、未登录不触发云同步、冲突合并、网络失败保留队列五类行为。
5. 实现 `AccountSyncController`、`account_sync_page.dart` 和 `sync_retry_dialog.dart`，展示匿名身份、登录绑定入口、最近同步时间、失败重试和冲突说明。
6. 编写 `account_sync_page_test.dart`，覆盖未登录、已登录、同步中、同步失败、重试成功五类 UI 状态。

**并行轨道 B：会员权益与付费墙**

**文件：**

- 创建：`lib/data/purchases/purchases_membership_data_source.dart`
- 创建：`lib/features/membership/data/membership_repository.dart`
- 创建：`lib/features/membership/application/membership_service.dart`
- 创建：`lib/features/membership/application/membership_controller.dart`
- 创建：`lib/features/membership/presentation/membership_page.dart`
- 创建：`lib/features/membership/presentation/widgets/paywall_entry_banner.dart`
- 创建：`lib/features/membership/presentation/widgets/sheets/membership_benefits_sheet.dart`
- 创建：`test/features/membership/membership_service_test.dart`
- 创建：`test/features/membership/presentation/membership_page_test.dart`

**步骤：**

1. 实现 `PurchasesMembershipDataSource`，把 `purchases_flutter` 的产品、购买、恢复购买、权益状态转换成项目内部 DTO。
2. 实现 `MembershipRepository` 和 `MembershipService`，对上只暴露项目内部 `MembershipEntitlement`，不让展示层依赖 Purchases 类型。
3. 编写 `membership_service_test.dart`，覆盖权益读取、购买成功、购买失败、取消购买、恢复购买、离线降级六类行为。
4. 实现 `MembershipController`、`membership_page.dart`、`paywall_entry_banner.dart` 和 `membership_benefits_sheet.dart`，覆盖当前权益、方案展示、恢复购买、受限能力拦截和失败提示。
5. 编写 `membership_page_test.dart`，覆盖免费用户、试用用户、会员用户、购买失败提示和恢复购买入口。

**并行轨道 C：桌面小组件快照与入口**

**文件：**

- 创建：`lib/features/widget_bridge/data/home_widget_gateway.dart`
- 创建：`lib/features/widget_bridge/application/widget_snapshot_service.dart`
- 创建：`lib/features/widget_bridge/presentation/widget_theme_page.dart`
- 创建：`test/features/widget_bridge/widget_snapshot_service_test.dart`
- 创建：`test/features/widget_bridge/presentation/widget_theme_page_test.dart`

**步骤：**

1. 实现 `HomeWidgetGateway`，封装 `home_widget` 的数据写入、刷新和点击入口参数，不让页面直接调用插件。
2. 实现 `WidgetSnapshotService`，从目标作息、今日摘要和权限状态生成 `WidgetSnapshot`。
3. 编写 `widget_snapshot_service_test.dart`，覆盖有目标、有昨晚记录、无目标、无数据、未授权、隐私字段过滤六类行为。
4. 实现 `widget_theme_page.dart`，展示小组件状态、刷新入口、今日页入口和睡前模式入口，并处理无目标、无数据、未授权三类空态。
5. 编写 `widget_theme_page_test.dart`，覆盖三类空态、刷新成功、刷新失败和入口跳转参数。

**集成收口轨道（等 A/B/C 合并后执行）：**

**文件：**

- 修改：`lib/app/router/app_router.dart`
- 修改：`lib/l10n/app_en.arb`
- 修改：`lib/l10n/app_zh.arb`
- 修改：`lib/app/bootstrap/app_bootstrap.dart`
- 创建：`test/features/task9/task9_integration_surface_test.dart`

**步骤：**

1. 在 `app_router.dart` 接入账号同步、会员中心、小组件设置三个页面路由，确保路径与 5.12 页面清单一致。
2. 在 `app_bootstrap.dart` 装配 Supabase、Purchases、HomeWidget 三类基础设施初始化，并保持未配置外部服务时可降级启动。
3. 更新 `app_en.arb` 和 `app_zh.arb`，补齐账号同步、会员中心、小组件设置、错误提示、付费拦截、恢复购买、刷新快照等用户可见文案。
4. 运行 `flutter gen-l10n`，确认生成的 `app_localizations*.dart` 包含新增文案键。
5. 接入任务 9 埋点：`sync_started`、`sync_completed`、`sync_failed`、`paywall_viewed`、`subscription_purchased`、`widget_snapshot_updated`。
6. 编写 `task9_integration_surface_test.dart`，覆盖三个二级页面从我的页入口可达，未登录不触发云同步，会员付费墙不阻断首次核心体验，小组件不展示敏感过细数据。
7. 运行 `flutter test test/features/sync/sync_conflict_policy_test.dart test/features/sync/sync_service_test.dart test/features/sync/presentation/account_sync_page_test.dart test/features/membership/membership_paywall_policy_test.dart test/features/membership/membership_service_test.dart test/features/membership/presentation/membership_page_test.dart test/features/widget_bridge/widget_snapshot_contract_test.dart test/features/widget_bridge/widget_snapshot_service_test.dart test/features/widget_bridge/presentation/widget_theme_page_test.dart test/features/task9/task9_integration_surface_test.dart`。
8. 完成一次人工走查：关闭网络后核心闭环仍可用，未登录不上传云端，会员付费墙不阻断首次核心体验，小组件不展示敏感过细数据。

**并行合并顺序：**

1. 先合并共享契约轨道，保证三条业务轨道拥有稳定类型、数据库表和测试口径。
2. 同步轨道、会员轨道、小组件轨道可同时开发；如出现 ARB、路由、Bootstrap 修改需求，只记录文案键、路径和初始化要求，不直接改共享文件。
3. 三条业务轨道各自测试通过后，再进入集成收口轨道统一修改共享文件。
4. 集成收口通过后再跑任务 9 全量测试命令和人工走查。

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

- Android Health Connect 厂商兼容专项、异常机型差异处理和设备矩阵专项测试。
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
