# Rhythm 模块拆分索引

> 产物类型：`module_split_index`
> 日期：`2026-06-08`
> 上游输入：
> - `docs/rhythm-sleep-routine-management-prd-commercial-2026-06-02.md`
> - `docs/rd/global-technical-baseline.md`
> - `docs/rd/global-design-guidelines.md`
> - `docs/rd/light-theme-freeze.yaml`
> - `docs/rd/dark-theme-freeze.yaml`
> - `docs/rd/pencil-design-source-packet.md`
> 当前模式：`initial_split`
> 文档成熟度：`split_draft`

## 1. 拆分结论

本次按“用户任务边界 + 导航壳层边界 + 数据生命周期边界 + 平台能力边界”进行初始模块拆分。  
拆分结果保留技术基线里已经冻结的 8 个粗粒度模块，不额外细碎化页面，不提前把模块草案冒充为可直接实现稿。

## 2. 模块总表

| module_name | goal_or_scope | uiux_doc | impl_doc | depends_on | unblocks | parallel_group | recommended_stage | parallelization_notes |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| `app-shell` | 根路由、共享壳层、底部导航、启动分发、深链入口 | `docs/rd/modules/app-shell/app-shell.ui-ux.md` | `docs/rd/modules/app-shell/app-shell.impl.md` | none | `onboarding-activation`、`today`、`bedtime`、`calendar`、`insights`、`profile-settings` | `foundation-a` | `stage-1` | 必须先落定，其他顶层模块不能各自藏一份壳层逻辑 |
| `sleep-data-core` | 睡眠记录、目标作息、提醒计划、手动修正、恢复计划基础能力 | `docs/rd/modules/sleep-data-core/sleep-data-core.ui-ux.md` | `docs/rd/modules/sleep-data-core/sleep-data-core.impl.md` | none | `onboarding-activation`、`today`、`bedtime`、`calendar`、`insights`、`profile-settings` | `foundation-b` | `stage-1` | 与 `app-shell` 同波次，但若权限/存储方案未落稳，不应放开下游功能模块 |
| `onboarding-activation` | 首次激活漏斗、登录策略、健康授权、目标设置、提醒设置、小组件引导 | `docs/rd/modules/onboarding-activation/onboarding-activation.ui-ux.md` | `docs/rd/modules/onboarding-activation/onboarding-activation.impl.md` | `app-shell`、`sleep-data-core` | `today`、`profile-settings` | `activation` | `stage-2` | 依赖基础壳层与目标/权限/提醒的数据写入能力 |
| `today` | 每日主入口，承载昨晚结果、今晚行动、快捷补录、恢复摘要 | `docs/rd/modules/today/today.ui-ux.md` | `docs/rd/modules/today/today.impl.md` | `app-shell`、`sleep-data-core`、`onboarding-activation` | `insights` | `behavior-loop` | `stage-3` | 可与 `bedtime`、`calendar` 条件并行，但依赖目标作息和记录读写能力先稳定 |
| `bedtime` | 睡前模式、状态选择、轻量收尾动作、行为线索留痕 | `docs/rd/modules/bedtime/bedtime.ui-ux.md` | `docs/rd/modules/bedtime/bedtime.impl.md` | `app-shell`、`sleep-data-core`、`onboarding-activation` | `today`、`insights` | `behavior-loop` | `stage-3` | 与 `today` 高耦合于闭环语义，但代码上可在共享契约稳定后并行推进 |
| `calendar` | 月历热力图、单日详情、趋势筛选、历史边界 | `docs/rd/modules/calendar/calendar.ui-ux.md` | `docs/rd/modules/calendar/calendar.impl.md` | `app-shell`、`sleep-data-core`、`onboarding-activation` | `insights`、`profile-settings` | `behavior-loop` | `stage-3` | 对热力图与历史锁定规则敏感，依赖数据口径和订阅口径明确 |
| `insights` | 周报、稳定度、原因分布、恢复计划详情、付费承接 | `docs/rd/modules/insights/insights.ui-ux.md` | `docs/rd/modules/insights/insights.impl.md` | `app-shell`、`sleep-data-core`、`today`、`bedtime`、`calendar` | `profile-settings` | `monetization` | `stage-4` | 不应在行为闭环未跑通前先做重洞察与重付费表达 |
| `profile-settings` | 账户、会员、同步、权限、目标与提醒配置、隐私入口 | `docs/rd/modules/profile-settings/profile-settings.ui-ux.md` | `docs/rd/modules/profile-settings/profile-settings.impl.md` | `app-shell`、`sleep-data-core`、`onboarding-activation` | none | `management` | `stage-4` | 与 `insights` 可部分并行，但会员/同步入口需服从已定付费与账户策略 |

## 3. 依赖摘要

### 3.1 基础先决模块

- `app-shell` 负责根壳层、顶层目的地切换、深链入口和启动分发，是几乎所有顶层页面模块的上游。
- `sleep-data-core` 负责记录、目标、提醒、权限、同步口径与恢复基础能力，是所有业务模块的数据与规则底座。

### 3.2 激活入口依赖

- `onboarding-activation` 必须在 `app-shell` 与 `sleep-data-core` 之后，原因是它需要把登录、权限、目标作息和提醒策略真正写入系统。

### 3.3 主闭环依赖

- `today`、`bedtime`、`calendar` 共享同一闭环语义，都是 `stage-3` 候选。
- `today` 消费 `bedtime` 留下的行为线索与 `sleep-data-core` 聚合结果。
- `calendar` 对单日记录与历史边界有只读放大作用，但数据口径仍依赖 `sleep-data-core`。

### 3.4 商业与管理依赖

- `insights` 需要消费 `today` / `bedtime` / `calendar` 已经稳定的结果口径，才能避免洞察页先于闭环成立。
- `profile-settings` 虽然是配置入口，但它暴露的会员、同步、目标、提醒与隐私入口都依赖基础能力先稳定。

## 4. 并行执行计划

### `stage-1`

- `app-shell`
- `sleep-data-core`

说明：两者都属于全局底座，可以并行准备文档与方案，但实际代码落地仍要避免互相发明重复初始化入口。

### `stage-2`

- `onboarding-activation`

说明：激活模块单独一波，确保首用漏斗不被下游页面实现节奏拖乱。

### `stage-3`

- `today`
- `bedtime`
- `calendar`

说明：三者共享一条主闭环，可在契约明确后并行推进模块细化，但默认仍应先选一个活动模块串行进入后续冻结与实现流程。

### `stage-4`

- `insights`
- `profile-settings`

说明：两者都依赖前面阶段已经形成稳定的行为与账户口径；可并行准备，但付费与同步文案、入口层级仍需统一口径。

## 5. 模块明细卡

### `app-shell`

- 用户任务：顺利进入正确顶层页面，并保持公共壳层一致
- 页面/状态范围：启动页、根壳层、底部导航、全局提示承载位
- 数据所有权：路由状态、当前顶层目的地、壳层级入口参数
- 释放价值：为所有功能模块提供稳定承载面

### `sleep-data-core`

- 用户任务：让结果、目标、提醒、补录、修正与恢复逻辑有可信底座
- 页面/状态范围：无独立导航页，以跨模块状态面和表单面为主
- 数据所有权：`GoalSchedule`、`SleepRecord`、`BedtimeSession`、`RecoveryPlan`、`NotificationSetting`
- 释放价值：为所有行为与洞察模块提供统一数据口径

### `onboarding-activation`

- 用户任务：低阻力完成首用激活并进入可用状态
- 页面/状态范围：欢迎价值、登录、健康授权、目标设置、提醒设置、小组件引导、完成过渡
- 数据所有权：首用流程状态、初始目标、初始提醒、授权状态快照
- 释放价值：打通首发激活漏斗

### `today`

- 用户任务：快速理解昨晚结果、今晚目标和下一步动作
- 页面/状态范围：Today 顶层页、快捷补录入口、恢复摘要入口
- 数据所有权：日级聚合 ViewState、主 CTA 触发路径
- 释放价值：承载日活与主闭环回访

### `bedtime`

- 用户任务：在目标时间附近完成一个低负担的收尾动作
- 页面/状态范围：Bedtime 顶层页、通知/小组件进入态、轻量状态选择
- 数据所有权：睡前状态选择、行动建议选择、行为线索留痕
- 释放价值：支撑北极星指标

### `calendar`

- 用户任务：查看长期节奏与单日解释，而不是被图表压迫
- 页面/状态范围：月历热力图、单日详情、筛选模式
- 数据所有权：日级历史聚合、历史锁定边界
- 释放价值：建立长期可视化信任

### `insights`

- 用户任务：理解周趋势、恢复路径和高级价值
- 页面/状态范围：周报摘要、稳定度解释、原因分布、恢复计划、付费承接
- 数据所有权：报告摘要、稳定度指标、恢复计划详情、付费入口来源
- 释放价值：承接留存与商业化

### `profile-settings`

- 用户任务：管理账户、会员、同步、权限、目标与提醒
- 页面/状态范围：账户与会员区、同步与隐私区、目标与提醒区、能力入口区
- 数据所有权：账户展示态、同步状态、设置入口装配态
- 释放价值：承接信任、可配置性和合规入口

## 6. 壳层模块说明

本项目明确拆出 `app-shell`，原因如下：

- 顶层五个 tab 已在共享冻结中固定，不应分散到各 feature 私自实现。
- 启动分发、根重定向、通知深链、小组件入口都属于壳层责任，不应埋进 `today` 或 `profile-settings`。
- 壳层本身有独立实现价值，且会成为后续所有视觉恢复与路由装配的前置模块。

## 7. 当前开放问题

- 首发是否正式允许匿名本地使用，还是必须登录后进入。该问题影响 `onboarding-activation` 与 `app-shell` 的最终重定向策略。
- 首发市场语言策略是中文优先还是中英同步。该问题影响 onboarding 与付费文案优先级，但不改变当前模块边界。
- 会员定价姿态偏低价高转化还是中价位高价值表达。该问题影响 `insights` 与 `profile-settings` 的付费入口文案，但不改变当前模块边界。
- 轮班/时差策略是否进入 V1.0。该问题影响 `sleep-data-core`、`profile-settings` 与 `insights` 的后续精细化范围。

## 8. 后续建议

- 下一步不是直接写代码，而是先确认本次模块拆分结果。
- 确认后，按串行活动模块机制进入后续模块细化；默认先处理 `app-shell` 或 `onboarding-activation`，再进入主闭环模块。
- 在进入单模块设计冻结前，仍需保持 Pencil 共享设计源和共享冻结合同作为唯一上游设计标准。
