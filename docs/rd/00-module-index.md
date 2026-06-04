# Rhythm 模块索引

## 模块总表

| module_name | goal_or_scope | uiux_doc | impl_doc | depends_on | unblocks | parallel_group | recommended_stage | parallelization_notes |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| app-shell | 启动、根路由、Tab Shell、全局跳转与全局覆盖层 | docs/rd/modules/app-shell/app-shell.ui-ux.md | docs/rd/modules/app-shell/app-shell.impl.md | none | onboarding-activation, today, bedtime, calendar, insights, profile-settings | foundation-shell | Stage 1 | 必须先定义根导航和 redirect 策略，否则功能模块无法安全并行。 |
| sleep-data-core | 健康读取、手动补录、派生指标、同步队列与数据可信度基线 | docs/rd/modules/sleep-data-core/sleep-data-core.ui-ux.md | docs/rd/modules/sleep-data-core/sleep-data-core.impl.md | none | onboarding-activation, today, bedtime, calendar, insights, profile-settings | foundation-data | Stage 1 | 可与 app-shell 并行产出文档，但代码实施前必须先有本地库与 repository 契约。 |
| onboarding-activation | 首次激活漏斗、登录/匿名、健康授权、目标设置、提醒与小组件引导 | docs/rd/modules/onboarding-activation/onboarding-activation.ui-ux.md | docs/rd/modules/onboarding-activation/onboarding-activation.impl.md | app-shell, sleep-data-core | today, bedtime, calendar, insights, profile-settings | activation | Stage 2 | 依赖根路由与数据能力；完成后为所有核心页面提供目标作息与授权上下文。 |
| today | 今日回访首页、昨晚结果、今晚目标、恢复建议、快捷记录、7 日趋势 | docs/rd/modules/today/today.ui-ux.md | docs/rd/modules/today/today.impl.md | app-shell, sleep-data-core, onboarding-activation | bedtime, insights | daily-experience | Stage 3 | 与 bedtime、calendar、profile-settings 可以并行，但依赖统一的睡眠与目标数据接口。 |
| bedtime | 睡前模式、状态选择、轻量收尾动作、提醒跳转承接 | docs/rd/modules/bedtime/bedtime.ui-ux.md | docs/rd/modules/bedtime/bedtime.impl.md | app-shell, sleep-data-core, onboarding-activation | insights | daily-experience | Stage 3 | 与 today 并行实现最合适，共享目标作息与通知触发能力。 |
| calendar | 月历热力图、筛选、单日详情、未记录/待补录解释 | docs/rd/modules/calendar/calendar.ui-ux.md | docs/rd/modules/calendar/calendar.impl.md | app-shell, sleep-data-core, onboarding-activation | insights | history-review | Stage 3 | 与 today/bedtime 并行可行，但需要稳定的 SleepRecord 查询与偏移算法。 |
| profile-settings | 账户、会员、同步隐私、目标设置、提醒设置、小组件与主题入口 | docs/rd/modules/profile-settings/profile-settings.ui-ux.md | docs/rd/modules/profile-settings/profile-settings.impl.md | app-shell, sleep-data-core, onboarding-activation | none | account-config | Stage 3 | 可与 today/bedtime/calendar 并行，前提是账户与订阅适配层接口已确定。 |
| insights | 周报、稳定度、原因分布、恢复效果、月报/高级报告入口 | docs/rd/modules/insights/insights.ui-ux.md | docs/rd/modules/insights/insights.impl.md | app-shell, sleep-data-core, onboarding-activation, today, bedtime, calendar | none | history-review | Stage 4 | 依赖其它模块沉淀的数据与恢复结果，建议在基础体验稳定后实现。 |

## 依赖摘要

- `app-shell` 是根宿主模块，负责 `go_router` 根入口、启动分发、底部导航壳、通知/小组件/深链统一落点。
- `sleep-data-core` 是共享业务底座，负责 `GoalSchedule`、`SleepRecord`、`BedtimeSession`、`DelayTag`、`RecoveryPlan`、`Report` 的持久化与派生。
- `onboarding-activation` 为后续功能模块提供授权状态、目标作息、提醒策略与首轮本地配置。
- `today`、`bedtime`、`calendar`、`profile-settings` 可在同一实施波次并行。
- `insights` 依赖更多历史数据与恢复结果，建议作为后置波次。

## 并行实施波次

### Stage 1：公共基线

- `app-shell`
- `sleep-data-core`

### Stage 1 bootstrap-critical 标记

- `app-shell`: `bootstrap_critical=true`
  - 原因：它定义 root router、redirect policy、主壳结构与全局入口承接。
- `sleep-data-core`: `bootstrap_critical=true`
  - 原因：它定义本地存储、睡眠记录、目标作息、同步队列与派生指标的共享底座。
- `flutter-init` 的最早合理触发点：Stage 1 两个模块的实现前架构输入已经明确之后，而不是等全部 feature module 都完成后再触发。

### Stage 2：激活漏斗

- `onboarding-activation`

### Stage 3：核心日常体验

- `today`
- `bedtime`
- `calendar`
- `profile-settings`

### Stage 4：复盘与高意图转化

- `insights`

## 严格 auto loop 执行顺序

- 本索引的“推荐阶段”只描述依赖关系，不再被误读为“模块文档可批量一次性细化”。
- 严格的 `--auto` 轨迹是：
  1. `app-shell`
  2. `sleep-data-core`
  3. `onboarding-activation`
  4. `today`
  5. `bedtime`
  6. `calendar`
  7. `profile-settings`
  8. `insights`
- 每个模块都必须经历：
  - `modules_split` 产出的 `split_draft`
  - `@superpowers` 执行的 `module_uiux_refinement`
  - `flutter-design-freeze-gate` 模块冻结
  - `flutter-uiux-to-architecture` 实现前架构输出
- 这条轨迹的执行痕迹已记录在 `docs/rd/04-superpowers-module-refinement-log.md`。

## Shell 模块说明

- 本项目必须显式拆出 `app-shell`，原因不是“有一个首页”，而是存在独立的根责任：
  - 登录/匿名后的根跳转
  - 首次引导与正式主壳切换
  - 底部导航持久化
  - 通知、小组件、深链进入后的路由归一
  - 全局顶部/底部覆盖层

## 条件性并行约束

- 若 `sleep-data-core` 中健康读取可信度、同步策略或时区偏移算法未冻结，`today`、`calendar`、`insights` 只能先落显示层骨架，不应完成真实数据接线。
- 若 `account` 与 `subscription` 契约未冻结，`profile-settings` 与 `onboarding-activation` 只能用接口占位，不应直接绑定真实购买流程。
- 若 `flutter-init` 尚未落地，全体模块均不应转入真实代码实施。
