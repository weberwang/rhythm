# Rhythm 全局技术基线

> 产物类型：`global_technical_baseline`
> 日期：`2026-06-08`
> 上游输入：`docs/rhythm-sleep-routine-management-prd-commercial-2026-06-02.md`
> 目标阶段：`prd_ready -> technical_baseline_ready`

## 0. 文档信息

本文档把已确认 PRD 收敛为可执行的 Flutter 全局技术基线，用于驱动后续共享设计方向、`DESIGN.md`、结构化设计源、模块拆分、项目初始化与实现边界控制。

本基线只回答“系统应该如何搭建”，不提前进入页面视觉冻结、模块级实现细节或代码生成执行。

## 1. PRD 需求理解

### 1.1 产品目标

- Rhythm 是一个面向长期晚睡、但愿意主动调整的人群的作息行为管理 App。
- 首发闭环是：`今晚提醒 -> 睡前进入 -> 次日反馈 -> 原因标记 -> 恢复建议 -> 周报复盘`。
- 产品定位是“行为改善”，不是医疗诊断、治疗工具或泛健康社区。

### 1.2 目标用户

- 核心用户：20-35 岁、长期晚睡、对自我调节有意愿的人群。
- 高价值细分：城市白领、自由职业者、跨时区用户、轮班用户。
- 用户对“低负担、低羞耻感、可恢复”的行为闭环更敏感，而不是深度睡眠报告。

### 1.3 主场景

- 引导激活：理解产品价值、选择登录方式、授权健康数据或走手动路径、设置目标作息与提醒。
- 晚间执行：从通知/小组件/首页进入睡前模式，完成轻量收尾动作。
- 次日反馈：查看昨晚偏移、补充原因标签、获取恢复建议。
- 周期复盘：查看周报、稳定度和恢复趋势，并在高意图节点承接付费。

### 1.4 范围内能力

- 健康数据读取与手动补录。
- 目标作息、提醒、小组件、今日页、日历页、睡前页、洞察页、我的页。
- 账号同步、订阅体系、本地优先数据闭环。

### 1.5 明确不做

- 医疗级诊断与治疗承诺。
- AI 聊天教练、社区陪伴、复杂游戏化体系。
- 首发即覆盖桌面端 / Web 端。

## 2. 假设前提与待确认项

### 2.1 假设前提

- 登录策略默认采用 `匿名本地先用，后续高信任节点再绑定账号`。
  设计原因：降低激活漏斗摩擦，符合 PRD 的 local-first 与低负担进入原则。
- 语言资源按 `中文 + 英文` 双语结构同时落位，首发市场优先级后续由运营决定。
  设计原因：国际化在当前阶段属于架构前置项，不应推迟到实现后补。
- 首发验证面按 PRD 采用 `ios_device`，长期保持 Android 同构能力。
- 付费策略不阻塞技术基线，首发只需要具备权益判定、付费墙承接和购买恢复能力。
- 当前仓库存在 Flutter 工程外壳与依赖声明，但 `lib/` 业务骨架当前在磁盘上不可验证。
  兼容处理：这不阻塞技术基线产出，但后续必须在 `project_initialized` 与 `bootstrap_code_ready` 阶段补齐真实入口与目录骨架。

### 2.2 待确认项

- 是否正式冻结“匿名可用”为首发商业策略，而不仅是当前技术默认项。
- 首发市场默认语言是否以 `zh-Hans` 为默认入口，还是按设备语言自动判定。
- 订阅定价偏向低价高转化还是中价高价值表达，这会影响付费墙文案与实验策略，但不改变当前架构主线。
- 云同步首发是否只覆盖账号与基础数据备份，还是同时承接跨设备恢复与订阅状态云校验。

## 3. 业务流程与页面范围

### 3.1 推荐方案

采用 `本地闭环优先 + 云能力增强` 的业务主流程：

1. `Launch / Onboarding`
2. `Today`
3. `Bedtime`
4. `Next-day Feedback`
5. `Calendar`
6. `Insights`
7. `Profile / Settings`

### 3.2 备选方案

- 方案 A：首发即要求登录后进入。
- 方案 B：首发即以远端同步为主、本地缓存为辅。

### 3.3 取舍理由

- 方案 A 会显著抬高首用门槛，不符合 PRD 的激活优先级。
- 方案 B 会把同步稳定性变成首发主风险，和“本地优先”的产品承诺冲突。
- 推荐方案能同时满足无健康权限、无账号、弱网络三类高频异常路径。

### 3.4 页面与能力范围

| 页面 / 区域 | 主要职责 | 关键状态 |
| --- | --- | --- |
| `launch` | 启动恢复、分发、异常兜底 | 初始化中、配置缺失、恢复失败 |
| `onboarding` | 价值说明、登录选择、权限说明、目标与提醒设置 | 匿名进入、授权拒绝、跳过登录 |
| `today` | 昨晚结果、今晚目标、快捷补录、恢复摘要 | 无数据、同步失败、付费锁定 |
| `bedtime` | 睡前状态选择、行动建议、轻量收尾 | 提醒进入、手动进入、退出中断 |
| `calendar` | 热力图、单日记录、趋势浏览 | 权限缺失、部分数据、历史锁定 |
| `insights` | 周报、稳定度、恢复计划、付费承接 | 免费摘要、完整报告锁定 |
| `profile` | 账号、会员、权限、同步、隐私、目标管理 | 未登录、订阅异常、权限关闭 |

## 4. 总体技术架构

### 4.1 推荐方案

采用 `按 feature 分层的 DDD-lite + local-first + optional cloud sync`：

- `app/`：应用启动、根路由、ProviderScope、全局错误映射、App Shell
- `core/`：跨 feature 的公共基础设施
- `features/<feature>/domain`：实体、值对象、规则、仓储接口
- `features/<feature>/application`：用例编排、状态聚合、Provider 控制器
- `features/<feature>/data`：本地数据源、远端数据源、Repository 实现、SDK 适配
- `features/<feature>/presentation`：页面、区块组件、交互装配

### 4.2 备选方案

- 方案 A：按技术层全局分包，不以 feature 为主组织。
- 方案 B：直接用页面驱动的轻量目录，不明确 domain/application/data 边界。

### 4.3 取舍理由

- 方案 A 在首发阶段会快速积累跨页面耦合，后续付费、同步、通知会变得难以治理。
- 方案 B 前期快，但与当前项目对 `Riverpod + 注解生成 + 插件边界收口` 的约束不一致。
- 推荐方案更适合健康数据、通知、订阅、同步这类跨场景共享能力。

### 4.4 模块边界建议

当前仅给出粗粒度能力边界，详细模块拆分留给 `flutter-rd-module-splitter`：

- `app-shell`
- `onboarding-activation`
- `sleep-data-core`
- `today`
- `bedtime`
- `calendar`
- `insights`
- `profile-settings`

## 5. Flutter 客户端详细技术方案

### 5.1 状态管理与依赖注入

推荐方案：`hooks_riverpod + riverpod_annotation`

- 页面默认使用 `HookConsumerWidget`。
- Provider 默认使用 `@riverpod` 注解生成。
- 页面只消费内部状态模型，不直接持有三方 SDK 或仓储实现。

备选方案：`flutter_bloc` 或手写 Provider 栈。

取舍理由：当前仓库依赖与 AGENTS 规则已经冻结到 Riverpod 体系，继续切换只会增加心智负担与迁移成本。

### 5.2 路由与启动守卫

推荐方案：`go_router` 统一承接：

- 启动恢复
- onboarding 完成态
- 匿名 / 登录会话续接
- 通知深链、小组件入口、付费墙来源参数

备选方案：手写 `Navigator 2.0` 或并存多套路由状态。

取舍理由：`go_router` 足够覆盖当前复杂度，且更利于后续 root shell / tab shell 的统一收口。

### 5.3 数据层与存储

推荐方案：

- `drift`：结构化业务数据
- `flutter_secure_storage`：敏感凭据与会话密钥
- `shared_preferences`：轻量偏好与一次性标记

建议落库对象：

- `GoalSchedule`
- `SleepRecord`
- `BedtimeSession`
- `SleepDelayTag`
- `RecoveryPlan`
- `WeeklyReport`
- `NotificationSetting`
- `SyncQueue`

备选方案：`isar` 或仅用 `shared_preferences + json file`。

取舍理由：当前业务存在查询、聚合、追溯、来源标记、同步补偿等需求，`drift` 更适合结构化演进。

### 5.4 模型与序列化

推荐方案：`freezed + json_annotation + build_runner`

- 领域实体、DTO、ViewState 默认都走代码生成。
- 禁止长期手写 `copyWith`、相等性与 JSON 解析。

备选方案：手写 model 或只用 `json_serializable`。

取舍理由：首发闭环看似简单，但后续涉及来源、可信度、锁定态、权益态，值语义模型能显著减少回归风险。

### 5.5 健康数据与权限

推荐方案：通过 `health` 封装 `HealthGateway`，由 `sleep-data-core` 持有权限检查、读取、映射和降级逻辑。

备选方案：页面直接拉取插件数据。

取舍理由：权限、平台差异、缺失数据和手动补录补偿必须集中治理，不能散落在页面层。

### 5.6 通知、小组件与时区

推荐方案：

- `flutter_local_notifications`
- `timezone`
- `flutter_timezone`
- `home_widget`

其中：

- `app/bootstrap/` 负责时区初始化与通知框架初始化
- 业务提醒计算下沉到提醒域或 `sleep-data-core`
- 小组件只消费内部快照模型

备选方案：在页面内就地调度通知，或小组件直接读取松散 key-value。

取舍理由：提醒属于全局能力，必须和作息目标、时区、权益状态保持一致。

### 5.7 账号、同步与订阅

推荐方案：

- `supabase_flutter`：账号、会话恢复、基础同步宿主
- `google_sign_in` / `sign_in_with_apple`：三方登录入口
- `purchases_flutter`：订阅购买、恢复、权益快照

关键约束：

- 账号与订阅都要经 `Repository` 转换为内部模型。
- 即使远端失败，本地闭环仍可继续。
- 权益只影响增强能力，不影响基础记录与反馈链路。

备选方案：完全自建账号 / 订阅接口。

取舍理由：当前阶段更适合优先验证产品闭环，而不是自建复杂账号与支付后端。

### 5.8 网络宿主与远端扩展

推荐方案：保留 `dio + retrofit + logger` 作为远端扩展宿主，但仅在 Supabase 之外出现明确自定义 API 时启用。

备选方案：完全不建立网络基线，或在首发就围绕 REST 大规模建模。

取舍理由：当前产品核心能力以本地与 SDK 为主，但后续订阅校验、灰度配置、运营接口可能需要统一宿主，提前留好边界更稳。

### 5.9 国际化、主题与错误处理

推荐方案：

- 国际化：`flutter_localizations + intl + ARB`
- 主题：在共享设计冻结后输出统一 token，再由 Flutter 落地
- 错误：应用层输出显式状态枚举，展示层只做渲染

备选方案：文案写死、异常对象直接驱动 UI 分支。

取舍理由：PRD 对语气、合规、国际化都有明确要求，必须前置为基础设施。

## 6. 第三方包选型与最佳搭档

### 6.1 状态与依赖注入

能力域：状态管理与依赖注入  
推荐主方案：`hooks_riverpod + flutter_riverpod + riverpod_annotation + riverpod_generator`  
推荐理由：与当前仓库约束完全一致，适合按 feature 管理异步状态与依赖边界。  
最佳搭档：`freezed`、`collection`  
备选方案：`bloc/cubit`  
避免混搭：不要在同一模块并存手写 Provider、旧式 Provider 和生成式 Provider。  
接入注意事项：Provider 命名、作用域、自动销毁策略统一用注解治理。  
升级 / 维护风险：生成代码需要纳入固定命令链路。

### 6.2 路由与导航

能力域：路由、深链、启动分发  
推荐主方案：`go_router`  
推荐理由：统一处理 root shell、tab shell、重定向和通知入口。  
最佳搭档：`hooks_riverpod`  
备选方案：原生 Navigator 组合  
避免混搭：不要为不同 feature 引入平行路由宿主。  
接入注意事项：导航守卫只读内部状态，不直接耦合 SDK。  
升级 / 维护风险：重定向链复杂时要有明确测试。

### 6.3 本地数据

能力域：结构化本地存储  
推荐主方案：`drift + sqlite3_flutter_libs + path_provider + path`  
推荐理由：可承载记录、聚合、查询、同步队列和历史追溯。  
最佳搭档：`freezed`、`json_annotation`  
备选方案：`isar`  
避免混搭：不要把结构化业务数据拆成数据库与偏好存储双写。  
接入注意事项：表结构与领域模型分层维护。  
升级 / 维护风险：迁移脚本与回填策略要前置设计。

### 6.4 凭据与轻量偏好

能力域：敏感信息与轻量配置  
推荐主方案：`flutter_secure_storage + shared_preferences`  
推荐理由：安全边界清晰，且与 current PRD 的 local-first 模式相容。  
最佳搭档：会话仓储与偏好仓储  
备选方案：全部落数据库  
避免混搭：不要把令牌放进 `shared_preferences`。  
接入注意事项：明确加密项与普通项边界。  
升级 / 维护风险：会话迁移与匿名绑定流程需要测试。

### 6.5 健康、通知、小组件

能力域：平台能力接入  
推荐主方案：`health + flutter_local_notifications + flutter_timezone + timezone + home_widget`  
推荐理由：覆盖首发闭环的核心平台触点。  
最佳搭档：统一 Gateway / Service 边界  
备选方案：平台通道自建  
避免混搭：不要让多个页面分别直接调用相同插件。  
接入注意事项：权限、失败重试、平台差异集中处理。  
升级 / 维护风险：iOS / Android 行为差异要通过装配测试约束。

### 6.6 账号、同步、订阅

能力域：登录、云同步、权益  
推荐主方案：`supabase_flutter + google_sign_in + sign_in_with_apple + purchases_flutter`  
推荐理由：首发阶段优先降低服务端自建成本。  
最佳搭档：`flutter_secure_storage`  
备选方案：完全自建账号与支付后端  
避免混搭：不要让 UI 直接消费 SDK 返回对象。  
接入注意事项：账号、同步、订阅三者的失败语义要分层。  
升级 / 维护风险：沙盒 / 真机 / 商店环境差异必须纳入验收。

## 7. 后端协作与接口契约要求

### 7.1 推荐方案

采用 `本地权威记录 + 远端增强同步` 的协作模式：

- 本地记录先落 `drift`
- 远端只同步已归一化的内部 DTO
- 服务端时间统一使用 `UTC` 存储，客户端按用户时区渲染
- 登录、权益、同步冲突都返回结构化错误码

### 7.2 备选方案

- 方案 A：远端为唯一真实源，本地仅缓存。
- 方案 B：同步阶段不定义错误契约，完全依赖 SDK 默认报错。

### 7.3 取舍理由

- 方案 A 与 local-first 冲突。
- 方案 B 会把异常处理下沉到 UI 层，难以治理。

### 7.4 契约要求

- 认证模型：匿名身份可升级绑定正式账号。
- 时间规范：远端统一 `UTC ISO-8601`，客户端记录本地 `timezone id`。
- 重试规则：同步写入需要显式幂等键，避免重复补录。
- 分页规则：历史记录和报告列表统一使用稳定游标，不使用页码猜测。
- 错误模型：至少区分 `auth`、`network`、`permission`、`subscription`、`conflict`、`unknown`。
- 实时边界：首发不要求 WebSocket；同步、订阅刷新和周报生成可采用拉取或事件触发。

## 8. 数据与安全方案

### 8.1 推荐方案

- 健康数据、作息记录、标签和报告都视为敏感个人行为数据。
- 日志默认不记录原始睡眠明细、登录凭据、订阅票据。
- 手动修正不覆盖原始来源，需要保留修正标记与来源链路。

### 8.2 备选方案

- 方案 A：把所有调试细节直接打进日志。
- 方案 B：只存修正后的最终值，不保留来源元信息。

### 8.3 取舍理由

- 方案 A 会带来隐私与运维风险。
- 方案 B 会破坏“数据可解释性”，不利于恢复建议与用户信任。

### 8.4 安全边界

- 凭据只进入 `flutter_secure_storage`。
- 业务日志要做脱敏。
- 导出 / 删除路径在产品上要有固定承载位。
- 权限失败不应阻断主闭环，但必须给出透明说明。

## 9. 埋点、监控与运营支持

### 9.1 推荐方案

首发建立最小可用事件体系：

- 激活漏斗：`app_open`、`onboarding_started`、`goal_setup_completed`
- 晚间行为：`bedtime_mode_entered`、`bedtime_action_clicked`
- 次日反馈：`sleep_record_synced`、`delay_tag_added`
- 商业化：`paywall_viewed`、`trial_started`、`subscription_purchased`

### 9.2 备选方案

- 方案 A：先不上埋点，靠人工观察。
- 方案 B：上大量细粒度事件，但不定义口径。

### 9.3 取舍理由

- 方案 A 无法验证 PRD 中的关键转化指标。
- 方案 B 会制造噪声，反而拖慢分析。

### 9.4 监控与发布支持

- Crash 与性能监控需在 bootstrap 阶段预留接入位。
- 远端配置 / A/B / kill-switch 首发可不强依赖，但要预留配置宿主。
- 发布前要覆盖：权限拒绝、无网络、匿名使用、购买失败、同步失败、时区切换。

## 10. 测试与质量保障

### 10.1 推荐方案

- `domain`：规则测试
- `application`：Provider / use case 测试
- `data`：仓储与降级路径测试
- `presentation`：关键页面 Widget 测试
- `integration_test`：至少覆盖一条 `onboarding -> today` 主路径

### 10.2 备选方案

- 方案 A：只靠人工真机验证。
- 方案 B：只做 Widget 测试，不测数据边界。

### 10.3 取舍理由

- 健康数据、通知、订阅、同步都带平台差异，仅人工验证会让回归成本失控。

### 10.4 质量门禁

- `flutter pub get`
- `flutter gen-l10n`
- `dart run build_runner build --delete-conflicting-outputs`
- `flutter analyze`
- `flutter test`

说明：本轮仅产出文档，不触发上述命令。

## 11. 实施计划与里程碑

### 11.1 阶段划分

1. `technical_baseline_ready`
2. `flutter-taste-router` 生成共享设计方向
3. 用户确认最终产品设计方向并输出 `DESIGN.md`
4. 选择结构化设计源适配器（`stitch` 或 `pencil`）
5. 共享设计冻结
6. `flutter-rd-module-splitter` 模块拆分
7. 模块级设计冻结
8. `flutter-uiux-to-architecture`
9. `flutter-init`
10. `bootstrap_code_ready`
11. `@superpowers Spec -> Plan -> 实现`

### 11.2 可并行流

- 共享设计方向确认前：不建议并行推进模块细化。
- 模块拆分后：可并行准备模块冻结资料，但必须按依赖安全顺序进入实现。
- 运营与埋点口径可与设计方向阶段并行准备。

### 11.3 当前阻塞

- 缺少共享设计方向产物。
- 缺少 `DESIGN.md`。
- 缺少结构化设计源适配器选择。
- 当前仓库 `lib/` 实现骨架不可验证，后续初始化与 bootstrap 必须重新落盘核验。

## 12. 风险清单与替代方案

| 风险 | 影响 | 推荐缓解 |
| --- | --- | --- |
| 强依赖健康权限 | 激活漏斗下降 | 保留手动补录一等路径 |
| 提醒调度与时区处理复杂 | 通知失准、用户信任受损 | 把时区初始化与调度集中到 bootstrap / reminder service |
| 账号 / 同步 / 订阅耦合 | 异常语义混乱 | 分离会话、同步、权益三类内部模型 |
| 当前仓库缺少可验证 `lib/` 骨架 | 后续实现无落点 | 在 `flutter-init` / bootstrap 阶段先补工程真实入口 |
| 过早引入复杂远端能力 | 延迟首发 | 先坚持本地权威记录，远端只做增强 |

## 13. 交接说明

交给 `flutter-taste-router` 时，必须继承以下全局约束：

- 目标作息是全局判断基准。
- 设计不能默认“必须登录才可用”。
- 任何关键页面都要承载 `权限缺失 / 无数据 / 部分数据 / 同步失败 / 付费锁定`。
- 设计方向必须服务 `today / bedtime / next-day feedback / insights` 这条行为闭环，而不是做成纯数据仪表盘。
- 首发验证面明确为 `ios_device`，但长期保持 Android 同构。

交给 `flutter-rd-module-splitter` 时，必须继承以下技术约束：

- 保持 `app-shell / onboarding-activation / sleep-data-core / today / bedtime / calendar / insights / profile-settings` 的粗粒度边界。
- 所有三方能力通过 `Repository / Gateway / DataSource` 收口。
- 领域模型与 DTO 默认用 `freezed` / `json_annotation`。
- 不允许把共享基础设施埋进单页面模块。

## 14. 最终结论

### 14.1 推荐主方案

采用 `Flutter 单仓 + local-first + optional cloud sync + hooks_riverpod + drift + Supabase/RevenueCat 增强接入` 的技术基线。

### 14.2 为什么这是当前推荐路径

- 它最贴合 PRD 的低门槛激活、本地优先、恢复导向与行为闭环目标。
- 它能最大化复用当前仓库已声明的依赖与工程约束。
- 它把未来设计冻结、模块拆分、实现执行的边界提前固定下来，减少后续返工。

### 14.3 下一步

下一技能应进入 `flutter-taste-router`，基于本技术基线生成共享视觉方向包，并等待用户确认最终产品设计方向。
