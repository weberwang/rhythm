# Rhythm 全局技术基线

> 产物类型：global_technical_baseline
> 日期：2026-06-07
> 上游输入：`docs/rhythm-sleep-routine-management-prd-commercial-2026-06-02.md`
> 目标阶段：`prd_ready -> technical_baseline_ready`

## 1. 文档目的

本文档用于把 PRD 收敛为可执行的 Flutter 技术基线，服务后续共享视觉方向确认、全局设计冻结、模块拆分、项目初始化和实现边界控制。

当前结论只解决“系统应该如何搭起来”，不提前进入页面视觉、模块冻结或实现细节。

## 2. 基线结论

- 产品形态采用 `Flutter 单仓跨平台应用`，首发验证面为 `iOS 真机`，长期保持 Android 同构落地能力。
- 系统架构采用 `local-first + optional cloud sync`，本地闭环先成立，云同步与账号绑定作为增强层接入。
- 显示层统一采用 `hooks_riverpod + riverpod_annotation`，数据层统一通过 `Repository / Gateway / DataSource` 收口第三方能力。
- 结构化业务数据统一落 `drift`，敏感凭据落 `flutter_secure_storage`，轻量偏好落 `shared_preferences`。
- 所有领域模型、数据 DTO、状态模型统一采用 `freezed + json_annotation`，避免手写样板结构。
- 首发阶段默认允许 `匿名本地进入 + 后续账号绑定`，以降低激活漏斗阻力；这是当前技术默认项，不等于商业策略永久冻结。

## 3. 目标平台与运行边界

### 3.1 平台基线

- `platform_baseline`：`iOS HIG`
- `platform_identifier`：`ios_device`
- `长期支持目标`：`ios + android`

### 3.2 首发边界

- 本轮技术基线只保证移动端 App 主闭环，不包含桌面端或 Web 首发实现。
- Apple Health / Health Connect、通知、小组件、订阅、登录均通过统一边界层封装，不允许页面直接持有三方 SDK。
- 轮班、跨时区、多目标等高级策略保留扩展接口，但不在首发基线里强制实现完整策略引擎。

## 4. 全局架构原则

### 4.1 架构风格

采用 `按 feature 分层的 DDD-lite`：

- `app/`：启动、全局路由、根依赖注入、App Shell、全局错误映射
- `core/`：跨 feature 的非业务基础设施
- `features/<feature>/domain`：实体、值对象、仓储接口、业务规则
- `features/<feature>/application`：用例编排、状态聚合、控制器 Provider
- `features/<feature>/data` 或 `infrastructure`：本地/远端数据源、Repository 实现、SDK 适配
- `features/<feature>/presentation`：页面、区块组件、交互编排

### 4.2 核心原则

- 本地可用优先：健康权限失败、登录失败、网络失败都不能阻断用户进入基本闭环。
- 依赖隔离优先：任何第三方插件都只允许有一个项目内适配入口。
- 代码生成优先：Provider、实体、DTO、数据库访问统一走注解和生成。
- 视觉实现后置：本基线只定义实现容器与约束，不替代后续共享设计方向和冻结产物。

## 5. 模块边界

首发按以下业务边界组织：

| 模块 | 职责 | 备注 |
| --- | --- | --- |
| `app-shell` | 启动分发、底部导航、全局反馈承载、路由守卫 | 共享壳层 |
| `onboarding-activation` | 引导、登录选择、权限说明、目标设置、提醒设置、小组件引导 | 激活漏斗 |
| `sleep-data-core` | 目标作息、睡眠记录、提醒偏好、共享状态契约 | 核心数据中台 |
| `today` | 昨晚结果、今晚目标、恢复建议、快捷补录、趋势摘要 | 每日回访首页 |
| `bedtime` | 睡前进入、状态选择、轻动作建议、行为线索沉淀 | 晚间执行页 |
| `calendar` | 月视图、偏移热力图、单日详情、筛选模式 | 长期反馈 |
| `insights` | 周报、稳定度、恢复计划、付费承接 | 复盘与商业化 |
| `profile-settings` | 账户、会员、权限、同步、隐私、目标与提醒设置 | 信任与配置 |

## 6. 数据与存储基线

### 6.1 本地数据主线

以下对象进入 `drift`：

- `goal_schedules`
- `sleep_records`
- `bedtime_sessions`
- `sleep_delay_tags`
- `recovery_plans`
- `weekly_reports`
- `notification_settings`
- `sync_queue`（若后续开启云同步）

### 6.2 凭据与轻量偏好

- `flutter_secure_storage`：匿名身份绑定信息、登录会话、订阅凭据映射、需要加密的同步令牌
- `shared_preferences`：引导完成标记、非敏感 UI 偏好、最近一次周报提示时间等轻量配置

### 6.3 数据可信性策略

- 自动健康数据与手动补录都进入统一 `SleepRecord` 领域模型。
- 记录必须保留 `source / confidence / corrected` 元信息，避免手动修正覆盖来源语义。
- 当自动数据缺失、延迟或冲突时，应用层负责输出可解释状态，而不是让页面自行猜测。

## 7. 关键能力接入策略

### 7.1 健康数据

- 插件：`health`
- 落点：`sleep-data-core` 下的 `Gateway + Repository`
- 原则：页面不直接请求权限，也不直接消费插件原始模型

### 7.2 通知与时区

- 插件：`flutter_local_notifications`、`flutter_timezone`、`timezone`
- 落点：`app/bootstrap` 完成全局时区初始化，`sleep-data-core` 或独立提醒子域负责业务调度
- 原则：所有提醒按用户目标作息计算，不在页面散落调度逻辑

### 7.3 小组件

- 插件：`home_widget`
- 落点：独立 `WidgetGateway`
- 原则：先支持“展示今晚目标 + 进入睡前模式”的最小价值，不把小组件做成主题系统

### 7.4 登录与账号

- 插件：`google_sign_in`、`sign_in_with_apple`、`supabase_flutter`
- 默认策略：匿名本地先用，用户在高信任节点再绑定账号
- 落点：`app-shell` 或账号子域统一管理账号会话快照，业务页面只读取内部模型

### 7.5 订阅与权益

- 插件：`purchases_flutter`
- 落点：独立 `SubscriptionRepository`
- 原则：付费状态判断集中在边界层，页面只消费内部的 `EntitlementSnapshot`

### 7.6 图表

- 插件：`fl_chart`
- 落点：`today`、`calendar`、`insights` 的展示层组件
- 原则：图表只负责呈现结果，不承载业务计算

## 8. 路由与启动分发

### 8.1 路由栈

- 统一使用 `go_router`
- 根层负责：
  - 首启分发
  - onboarding 完成态判断
  - 登录/匿名状态续接
  - 深链与通知入口收敛

### 8.2 首发路由骨架

- `/launch`
- `/onboarding`
- `/today`
- `/calendar`
- `/bedtime`
- `/insights`
- `/profile`

### 8.3 启动策略

- 应用启动先恢复本地目标作息和基础会话状态
- 即使远端同步失败，也必须能进入本地可用首页
- 启动失败优先降级到 onboarding 或本地恢复说明页，不停留在不可操作错误页

## 9. 显示层与状态管理基线

### 9.1 显示层规范

- 页面默认使用 `HookConsumerWidget` 或 Hook 方案
- Provider 默认使用 `@riverpod` 注解定义
- 显示层只负责触发用户意图、展示状态、消费国际化文案

### 9.2 状态分层

- `domain`：纯业务语义
- `application`：聚合后的 ViewState、命令入口、异步流程控制
- `presentation`：最小局部 UI 状态，如 tab、sheet、表单焦点

### 9.3 错误与空态

- 权限缺失、数据为空、同步失败、付费锁定都要在应用层产出明确状态枚举
- 页面不直接从异常对象推断文案分支

## 10. 国际化、可访问性与合规

### 10.1 国际化

- 强制采用 `flutter_localizations + intl + arb`
- 首批文案基线：`zh` 与 `en`
- 所有用户可见文案必须进入 ARB，不允许长期写死

### 10.2 可访问性

- 状态色必须有文字辅助
- 夜间页面保证对比度与点击热区
- 错误与锁定态需要清晰主次动作

### 10.3 合规

- 领域与展示文案都不得出现医疗诊断承诺
- 健康数据读取范围、订阅条款、隐私入口、数据删除/导出说明需要留出固定落点

## 11. 测试与质量门禁

### 11.1 最低测试配置

- `domain / application`：规则测试、Provider 测试
- `data / infrastructure`：Repository 与降级路径测试
- `presentation`：关键页面 Widget 测试
- 关键主路径：至少一条集成测试覆盖 onboarding 到今日页可用状态

### 11.2 质量门禁

- `flutter gen-l10n`
- `dart run build_runner build --delete-conflicting-outputs`
- `flutter analyze`
- `flutter test`

## 12. 当前默认项与风险

### 12.1 默认项

- 登录策略：默认允许匿名本地使用，后续再绑定账号
- 市场语言策略：技术上按中英双语资源结构落位，首发可按运营策略决定默认语言市场
- 定价姿态：不阻塞技术架构，保留给付费配置与实验层处理

### 12.2 风险

- 若后续改成“必须登录后进入”，需要回调 onboarding 和启动守卫策略
- 若首发即强依赖远端同步，当前 `local-first` 基线需要增加远端失败恢复设计
- 若视觉冻结要求大量复杂位图，架构阶段需要额外补资产下载与缓存规范

## 13. 对下游阶段的约束

进入共享视觉方向阶段前，以下技术约束已冻结：

- App 必须围绕 `目标作息` 作为全局判断基准组织信息
- 视觉设计不能假设“无登录不可用”作为首发前提
- 任一页面都必须能承载 `权限缺失 / 数据为空 / 部分数据 / 同步失败 / 付费锁定` 状态
- 全局设计冻结后，模块拆分必须遵守本文档定义的业务边界，不得把共享基础设施埋进单页面模块

## 14. 下一跳

本技术基线完成后，工作流下一技能应为 `flutter-taste-router`，用于在该技术约束下重新生成共享视觉方向包，再进入最终产品设计方向确认与代表页效果图流程。
