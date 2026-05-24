# Rhythm 剩余阶段实施计划

> 版本：V1.0
> 日期：2026-05-24
> 来源文档：`docs/rhythm-sleep-routine-management-dev-plan-2026-05-22.md`
> 适用范围：当前代码基线之后的剩余阶段实施
> 执行模式：根据实际情况选择串行或并行；可拆分任务优先采用子代理并行实施

## 一、文档目标

本文件用于重写当前基线之后的所有剩余阶段实施计划，统一采用以下执行原则：

- 复杂且可拆分的实施任务，按“共享契约冻结 -> 子代理并行轨道 -> 集成收口 -> 验收回归”组织。
- 不适合拆分、耦合度高或规模较小的任务，可由主线程串行实施，但仍需遵守 Pencil、GitNexus 和共享文件规则。
- 主线程负责范围确认、Pencil 设计核对、GitNexus 风险分析，以及在需要并行时进行子代理分派、结果审查和最终合流。
- 所有显示层实现默认以 `pen/app.pen` 为唯一设计标准；若设计稿与现有代码不一致，以设计稿为准。

## 二、当前完成基线

根据当前代码和测试状态，以下阶段已具备较高完成度：

- 阶段一：基础底座
- 阶段二：首次激活与目标设置
- 阶段三：睡眠记录与手动补录
- 阶段四：今日页

以下阶段属于剩余实施范围：

- 阶段五：睡前模式与提醒收口
- 阶段六：日历热力图与原因标签收口
- 阶段七：洞察周报与基础恢复建议
- 阶段八：账户、同步与隐私
- 阶段九：小组件与桌面存在感
- 阶段十：会员基础版与付费墙
- 阶段十一：灰度发布与数据看板

## 三、总执行原则

### 3.1 子代理实施规则

- 当阶段被拆成并行轨道后，主线程不得直接代写任何已分派到子代理轨道内的功能代码。
- 每个并行轨道应由独立子代理处理，并限制修改范围。
- 子代理完成后必须返回：状态、修改文件、测试结果、契约遵守、风险与待合流事项。
- 若子代理返回 `BLOCKED` 或 `NEEDS_CONTEXT`，主线程可以补上下文、重拆任务，或在确认不再并行后改为串行处理。

### 3.2 Pencil 设计强制规则

- 所有显示层任务实施前，必须先通过 Pencil MCP 读取对应页面、弹层或组件节点。
- `pen/app.pen` 是显示层唯一设计源；不得依据现有 Flutter 页面、旧实施文档或口头理解自由发挥。
- 如设计稿缺失必要状态，必须先补 Pencil 状态稿或在任务文档中明确设计缺口，再开始 Flutter 实现。
- 共享设计节点如下：
  - `e5igNG`：07 小组件引导页
  - `uZblo`：11 洞察页
  - `JFjkB`：12 我的页
  - `uVhda`：13 轻量付费墙页
  - `LvFOz`：14 周报详情页
  - `yHfEL`：15 历史洞察页
  - `Y8H2RS`：16 目标作息编辑页
  - `Vd5Ou`：17 提醒设置页
  - `C01GQ`：18 数据接入与权限页
  - `VAfQf`：19 账号与同步页
  - `jkCvN`：20 会员中心页
  - `dwr00`：21 隐私与数据页
  - `dNr9h`：22 小组件与主题页
  - `N0aow0`：23 时区与特殊模式页
  - `Q2xhiP`：24 弹层与对话框总览
  - `ZQBCz`：25 补充弹层与反馈组件

### 3.3 共享文件管理规则

- 以下文件默认视为共享文件，只能在“契约轨道”或“集成轨道”修改：
  - `lib/app/router/app_router.dart`
  - `lib/app/bootstrap/app_bootstrap.dart`
  - `lib/data/local/rhythm_database.dart`
  - `lib/l10n/app_en.arb`
  - `lib/l10n/app_zh.arb`
  - 生成的 `lib/l10n/app_localizations*.dart`
- 业务轨道不得直接改共享文件；如确有需要，只能提交“共享改动请求清单”给集成轨道统一处理。

### 3.4 GitNexus 规则

- 任何修改既有函数、类、方法前，必须先运行 GitNexus impact 分析。
- 若某个目标符号 impact 风险为 `HIGH` 或 `CRITICAL`，主线程必须先记录风险，再决定是否继续拆分轨道。
- 最终合流前必须运行 `detect_changes`，确认影响范围只覆盖预期阶段和预期模块。

## 四、统一执行模板

可并行阶段统一按四段执行：

1. 共享契约冻结
2. 子代理并行轨道
3. 集成收口轨道
4. 验收与回归轨道

采用并行方式的阶段必须产出：

- 共享契约清单
- 子代理轨道矩阵
- 共享文件限制
- Pencil 对应节点
- 专项测试命令
- 最终回归命令
- GitNexus 风险和变更检测要求

## 五、阶段五：睡前模式与提醒收口

### 5.1 阶段目标

- 收口睡前模式真实会话、提醒调度、通知点击入口和提醒设置编辑页。
- 补齐“真实提醒链路接线”与“阶段二提醒设置草稿”之间的缺口。
- 以 `Vd5Ou`、`Q2xhiP`、`ZQBCz` 为显示层补充基线，以 `bedtime` 已有代码为行为基线。

### 5.2 共享契约冻结

- `BedtimeSession`
- `BedtimeReminderPlan`
- `NotificationOpenSource`
- `ReminderSettingsState`
- `BedtimeViewState`
- 提醒相关埋点事件名

### 5.3 子代理并行轨道

| 子代理 | 轨道任务 | 允许文件范围 | 必跑测试 |
| --- | --- | --- | --- |
| A | 睡前会话与提醒领域规则收口 | `lib/features/bedtime/domain/*`、`lib/features/notifications/domain/*`、对应单测 | `test/features/bedtime/*summary*`、`test/features/notifications/*scheduler*` |
| B | 提醒设置编辑页与通知策略应用层 | `lib/features/notifications/application/*`、`lib/features/notifications/presentation/*`、对应测试 | `test/features/notifications/reminder_setup_test.dart` |
| C | 通知网关、点击入口、时区桥接 | `lib/features/notifications/data/*`、`lib/app/bootstrap/*` 中非共享请求清单部分、对应测试 | `test/features/notifications/notification_open_route_test.dart` |
| D | 睡前页显示层与状态补图对齐 | `lib/features/bedtime/presentation/*`、对应测试 | `test/features/bedtime/bedtime_page_test.dart` |
| E | 弹层与提醒反馈组件 | `pen/app.pen` 对应节点补稿、`Q2xhiP`/`ZQBCz` 结构核对说明 | Pencil 截图核对 |

### 5.4 集成收口轨道

- 统一修改 `app_router.dart`
- 统一修改 `app_bootstrap.dart`
- 统一修改 `lib/l10n/*.arb`
- 统一执行 `flutter gen-l10n`
- 统一挂接提醒设置页、睡前页、通知入口和埋点

### 5.5 验收回归

- `flutter test test/features/bedtime test/features/notifications`
- `flutter test`
- `npx gitnexus detect_changes`

## 六、阶段六：日历热力图与原因标签收口

### 6.1 阶段目标

- 收口当前工作区里的日历与标签进行中改动，统一改造成可稳定合流的并行交付模式。
- 以 `nBLqq`、`Q2xhiP`、`ZQBCz` 为唯一显示层基线。

### 6.2 共享契约冻结

- `CalendarHeatLevel`
- `CalendarDaySummary`
- `CalendarMonthSummary`
- `CalendarFilter`
- `SleepDelayTag`
- `SleepDelayTagRepository`
- `CalendarViewState`

### 6.3 子代理并行轨道

| 子代理 | 轨道任务 | 允许文件范围 | 必跑测试 |
| --- | --- | --- | --- |
| A | 日历领域规则 | `lib/features/calendar/domain/*`、对应测试 | `test/features/calendar/calendar_heatmap_rules_test.dart` |
| B | 标签领域与控制器 | `lib/features/sleep_records/domain/sleep_delay_tag*`、`application/sleep_delay_tag*`、对应测试 | `test/features/sleep_records/sleep_delay_tag_rules_test.dart`、`sleep_delay_tag_controller_test.dart` |
| C | 日历页面与热力图组件 | `lib/features/calendar/presentation/*`、对应测试 | `test/features/calendar/calendar_page_test.dart` |
| D | 详情、筛选、标签弹层 | `lib/features/calendar/presentation/widgets/sheets/*`、`lib/features/sleep_records/presentation/widgets/sheets/*` | `calendar_day_detail_sheet_test.dart`、`calendar_filter_sheet_test.dart`、`sleep_delay_tag_picker_sheet_test.dart` |
| E | 应用聚合与埋点桥接 | `lib/features/calendar/application/*`、分析入口、对应测试 | `test/features/calendar/calendar_controller_test.dart`、`calendar_analytics_test.dart` |

### 6.4 集成收口轨道

- 统一接路由与共享文案
- 统一处理 ARB、埋点和生成文件
- 统一合并当前未提交的 `calendar` 与 `sleep_delay_tag` 相关改动

### 6.5 验收回归

- `flutter test test/features/calendar test/features/sleep_records`
- `flutter test`
- Pencil 对照 `09 日历页` 与补充弹层总览

## 七、阶段七：洞察周报与基础恢复建议

### 7.1 阶段目标

- 实现洞察首页、周报详情、历史洞察、恢复建议和稳定度说明。
- 显示层严格对齐 `uZblo`、`LvFOz`、`yHfEL`、`Q2xhiP`、`ZQBCz`。

### 7.2 共享契约冻结

- `WeeklyReport`
- `WeeklyReportDaySnapshot`
- `WeeklyReportSummary`
- `ReasonDistributionItem`
- `RecoveryPlan`
- `RecoveryPlanStep`
- `RecoveryPlanStatus`
- `InsightsViewState`
- 周报窗口固定为最近 7 天业务归属日
- 少于 3 天有效记录时不生成正式周报，只输出数据不足状态
- 原因分布只统计用户已确认的标签，不回推未打标签记录
- 恢复计划只生成 1 到 3 天建议，不输出医疗表达
- 恢复计划状态限定为未查看、已查看、已完成、已延期

### 7.3 子代理并行轨道

| 子代理 | 轨道任务 | 允许文件范围 | 必跑测试 |
| --- | --- | --- | --- |
| A | 周报生成与原因分布规则 | `lib/features/insights/domain/weekly_report*`、`reason_distribution_rules.dart`、对应测试 | `weekly_report_generator_test.dart` |
| B | 稳定度规则 | `lib/features/insights/domain/stability_score_rules.dart`、对应测试 | `stability_score_rules_test.dart` |
| C | 恢复计划规则 | `lib/features/insights/domain/recovery_plan*`、对应测试 | `recovery_plan_rules_test.dart` |
| D | 洞察首页与空态显示层 | `lib/features/insights/presentation/insights_page.dart`、sections、states、对应测试 | `insights_page_test.dart` |
| E | 详情页、历史页、说明弹层 | `weekly_report_detail_page.dart`、`report_history_page.dart`、相关 sheets、对应测试 | `insights_page_test.dart` 中详情/历史场景 |
| F | 应用聚合与会员拦截桥接 | `lib/features/insights/application/*`、对应测试 | `insights_controller_test.dart` |

### 7.4 集成收口轨道

- 统一挂接 `/insights`、详情页、历史页路由
- 统一处理洞察文案与埋点
- 统一将恢复建议与今日页、日历标签数据源对齐

### 7.5 验收回归

- `flutter test test/features/insights`
- `flutter test`
- Pencil 对照洞察页、周报详情页、历史洞察页

## 八、阶段八：账户、同步与隐私

### 8.1 阶段目标

- 实现我的页下的账户、同步、权限、隐私、目标编辑、提醒设置、数据接入等二级页面。
- 显示层对齐 `JFjkB`、`Y8H2RS`、`Vd5Ou`、`C01GQ`、`VAfQf`、`dwr00`、`N0aow0`。

### 8.2 共享契约冻结

- `SyncQueueItem`
- `SyncConflictPolicy`
- `AccountSyncViewState`
- `PrivacyExportAction`
- `DataAccessStatus`

### 8.3 子代理并行轨道

| 子代理 | 轨道任务 | 允许文件范围 | 必跑测试 |
| --- | --- | --- | --- |
| A | 同步领域与冲突策略 | `lib/features/sync/domain/*`、对应测试 | `sync_conflict_policy_test.dart` |
| B | 账号同步页与同步应用层 | `lib/features/sync/application/*`、`presentation/*`、对应测试 | `sync_service_test.dart`、`account_sync_page_test.dart` |
| C | 数据接入与权限页 | `lib/features/profile` 或对应新边界显示层、对应测试 | 专项 widget 测试 |
| D | 隐私与数据页 | 导出、删除、授权说明显示层和协调层、对应测试 | 专项 widget 测试 |
| E | 目标编辑、提醒设置、时区与特殊模式页 | 对应 `goal_schedule`、`notifications`、`profile` 二级页面 | 对应 widget 测试 |
| F | 我的页首页装配 | `my/profile` 首页及入口编排、对应测试 | 我的页 widget 测试 |

### 8.4 集成收口轨道

- 统一接我的页入口、二级页面路由
- 统一装配 Supabase 初始化与降级启动
- 统一处理 ARB、埋点和共享导航

### 8.5 验收回归

- `flutter test test/features/sync`
- `flutter test` 与我的页相关测试
- Pencil 对照我的页、同步页、隐私页、设置页

## 九、阶段九：小组件与桌面存在感

### 9.1 阶段目标

- 实现小组件主题页、快照服务、入口跳转与小组件引导页闭环。
- 显示层对齐 `e5igNG`、`dNr9h`。

### 9.2 共享契约冻结

- `WidgetSnapshot`
- `WidgetSnapshotService`
- `WidgetEntrySource`
- `WidgetThemeViewState`

### 9.3 子代理并行轨道

| 子代理 | 轨道任务 | 允许文件范围 | 必跑测试 |
| --- | --- | --- | --- |
| A | 小组件快照领域与隐私过滤 | `lib/features/widget_bridge/domain/*`、`application/widget_snapshot_service.dart`、对应测试 | `widget_snapshot_contract_test.dart`、`widget_snapshot_service_test.dart` |
| B | HomeWidget 网关与刷新能力 | `lib/features/widget_bridge/data/*`、对应测试 | 网关专项测试 |
| C | 小组件引导页与主题页显示层 | `presentation/*`、对应测试 | `widget_theme_page_test.dart` |
| D | 小组件入口与导航桥接 | `application/widget_entry_controller.dart`、对应测试 | `widget_entry_controller_test.dart` |

### 9.4 集成收口轨道

- 统一将小组件入口接入启动流程
- 统一处理我的页到小组件页的入口
- 统一处理 ARB 和埋点

### 9.5 验收回归

- `flutter test test/features/widget_bridge`
- 关闭网络、无目标、无数据、未授权等场景人工走查

## 十、阶段十：会员基础版与付费墙

### 10.1 阶段目标

- 实现轻量付费墙、会员中心页、权益位和基础能力拦截。
- 显示层对齐 `uVhda`、`jkCvN`、`ZQBCz` 中会员相关弹层。

### 10.2 共享契约冻结

- `MembershipEntitlement`
- `MembershipPaywallPolicy`
- `MembershipViewState`
- `PaywallEntryContext`

### 10.3 子代理并行轨道

| 子代理 | 轨道任务 | 允许文件范围 | 必跑测试 |
| --- | --- | --- | --- |
| A | 会员领域与权益策略 | `lib/features/membership/domain/*`、对应测试 | `membership_paywall_policy_test.dart` |
| B | Purchases 数据源与仓储 | `lib/data/purchases/*`、`lib/features/membership/data/*`、对应测试 | `membership_service_test.dart` |
| C | 轻量付费墙显示层 | `presentation/paywall*`、对应测试 | 付费墙 widget 测试 |
| D | 会员中心显示层 | `membership_page.dart`、benefits sheet、对应测试 | `membership_page_test.dart` |
| E | 会员应用聚合与拦截桥接 | `application/*`、与洞察/历史限制接线、对应测试 | 应用层测试 |

### 10.4 集成收口轨道

- 统一接入洞察历史限制、会员中心入口、我的页能力位展示
- 统一处理购买恢复、错误提示、文案和埋点

### 10.5 验收回归

- `flutter test test/features/membership`
- 付费墙不阻断首次核心体验的专项走查

## 十一、阶段十一：灰度发布与数据看板

### 11.1 阶段目标

- 补齐内测收口、README、人工验收清单、集成测试、关键数据看板事件。
- 这一阶段不再新增核心业务功能，只做交付收口。

### 11.2 共享契约冻结

- 内测集成路径范围
- 验收清单结构
- 发布前必跑命令清单
- 核心埋点字典

### 11.3 子代理并行轨道

| 子代理 | 轨道任务 | 允许文件范围 | 必跑测试 |
| --- | --- | --- | --- |
| A | 首次激活到周报的集成测试 | `integration_test/*` | `flutter test integration_test` |
| B | README 与开发/测试文档收口 | `README.md`、说明文档 | 文档自检 |
| C | 人工验收清单与已知风险清单 | `docs/*checklist*`、发布清单 | 文档自检 |
| D | 埋点字典与数据看板事件核对 | 埋点文档、必要代码补点 | 事件核对清单 |

### 11.4 集成收口轨道

- 统一跑全量 `flutter test`
- 统一跑集成测试
- 统一跑 `detect_changes`
- 统一输出发布前阻塞项

### 11.5 验收回归

- `flutter test`
- `flutter test integration_test`
- 内测打包前人工清单完成

## 十二、子代理返回格式

每个子代理必须严格返回以下结构：

- `状态`：`DONE`、`DONE_WITH_CONCERNS`、`NEEDS_CONTEXT`、`BLOCKED`
- `修改文件`
- `测试结果`
- `契约遵守`
- `风险与待合流事项`

主线程收到返回后只做三类动作：

- 审核通过并等待合流
- 补上下文后重派
- 调整共享契约后重派

## 十三、主线程禁止事项

- 不得在已分派轨道中直接代写功能代码。
- 不得在业务轨道中直接修改共享文件。
- 不得在未核对 Pencil 节点前开始显示层实现。

## 十四、推荐执行顺序

1. 先完成阶段五与阶段六收口，稳定今日页之后的主路径。
2. 再完成阶段七洞察，补齐核心闭环的“反馈”部分。
3. 再完成阶段八、九、十，补齐账户、同步、小组件和会员。
4. 最后做阶段十一内测收口。

## 十五、完成定义

当且仅当以下条件全部满足时，剩余阶段视为完成：

- 洞察、我的、会员、小组件不再是占位或半成品状态。
- 所有新增显示层均已按 `pen/app.pen` 对齐。
- 需要并行的阶段已通过子代理实施并完成主线程合流审查；不需要并行的阶段已完成串行实现与验收。
- 所有共享文件修改都只发生在契约轨道或集成轨道。
- 全量测试、集成测试和 GitNexus 变更检测通过。
