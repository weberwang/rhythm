# Rhythm 模块索引

## 模块摘要表

| module_name | goal_or_scope | uiux_doc | impl_doc | depends_on | unblocks | parallel_group | recommended_stage | parallelization_notes |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| `app-shell` | 应用入口、底部导航、根路由守卫、全局壳层与启动分发 | [app-shell.ui-ux.md](/E:/Projects/flutter/rhythm/docs/project/modules/app-shell/app-shell.ui-ux.md) | [app-shell.impl.md](/E:/Projects/flutter/rhythm/docs/project/modules/app-shell/app-shell.impl.md) | `none` | `onboarding-activation`, `today`, `bedtime`, `calendar`, `insights`, `profile-settings` | `wave-0` | `stage-0` | 必须最先实现，因为其承载根导航、登录态分流与全局 shell 约束。 |
| `onboarding-activation` | 首启激活、匿名/登录选择、健康授权、初始目标与提醒设置 | [onboarding-activation.ui-ux.md](/E:/Projects/flutter/rhythm/docs/project/modules/onboarding-activation/onboarding-activation.ui-ux.md) | [onboarding-activation.impl.md](/E:/Projects/flutter/rhythm/docs/project/modules/onboarding-activation/onboarding-activation.impl.md) | `app-shell` | `today`, `bedtime`, `profile-settings` | `wave-1` | `stage-1` | 可与 `sleep-data-core` 并行，但依赖 app-shell 的启动路由与壳层容器。 |
| `sleep-data-core` | 睡眠记录、来源标记、手动补录、同步桥、节律计算基础 | [sleep-data-core.ui-ux.md](/E:/Projects/flutter/rhythm/docs/project/modules/sleep-data-core/sleep-data-core.ui-ux.md) | [sleep-data-core.impl.md](/E:/Projects/flutter/rhythm/docs/project/modules/sleep-data-core/sleep-data-core.impl.md) | `app-shell` | `today`, `bedtime`, `calendar`, `insights`, `profile-settings` | `wave-1` | `stage-1` | 是核心数据域，后续大部分 feature 依赖它的 repository、实体与同步边界。 |
| `today` | 今日页：睡眠窗口、wind-down、恢复卡与周视图摘要 | [today.ui-ux.md](/E:/Projects/flutter/rhythm/docs/project/modules/today/today.ui-ux.md) | [today.impl.md](/E:/Projects/flutter/rhythm/docs/project/modules/today/today.impl.md) | `app-shell`, `sleep-data-core` | `bedtime`, `insights` | `wave-2-core` | `stage-2` | 依赖主壳层与核心睡眠数据；与 `calendar`、`bedtime` 可条件并行。 |
| `bedtime` | 睡前模式、步骤执行、晚间状态与提醒承接 | [bedtime.ui-ux.md](/E:/Projects/flutter/rhythm/docs/project/modules/bedtime/bedtime.ui-ux.md) | [bedtime.impl.md](/E:/Projects/flutter/rhythm/docs/project/modules/bedtime/bedtime.impl.md) | `app-shell`, `sleep-data-core`, `today` | `insights` | `wave-2-core` | `stage-2` | 依赖 today 的入口语义与 sleep-data-core 的记录能力；与 `calendar` 可并行。 |
| `calendar` | 热力图、单日详情、趋势浏览与记录追溯 | [calendar.ui-ux.md](/E:/Projects/flutter/rhythm/docs/project/modules/calendar/calendar.ui-ux.md) | [calendar.impl.md](/E:/Projects/flutter/rhythm/docs/project/modules/calendar/calendar.impl.md) | `app-shell`, `sleep-data-core` | `insights` | `wave-2-core` | `stage-2` | 主要复用 sleep-data-core 数据查询；与 `today`、`bedtime` 并行前提是查询契约先冻结。 |
| `insights` | 周报、稳定度、恢复趋势、付费承接 | [insights.ui-ux.md](/E:/Projects/flutter/rhythm/docs/project/modules/insights/insights.ui-ux.md) | [insights.impl.md](/E:/Projects/flutter/rhythm/docs/project/modules/insights/insights.impl.md) | `app-shell`, `sleep-data-core`, `today`, `calendar` | `none` | `wave-3` | `stage-3` | 依赖历史数据、周视图指标与可能的订阅快照，是后置聚合模块。 |
| `profile-settings` | 账户、同步、隐私、通知、小组件、订阅设置 | [profile-settings.ui-ux.md](/E:/Projects/flutter/rhythm/docs/project/modules/profile-settings/profile-settings.ui-ux.md) | [profile-settings.impl.md](/E:/Projects/flutter/rhythm/docs/project/modules/profile-settings/profile-settings.impl.md) | `app-shell`, `sleep-data-core` | `none` | `wave-2-settings` | `stage-2` | 可与 `today`/`calendar` 并行，但涉及 auth、通知、小组件、订阅桥接，需依赖公共 bootstrap。 |

## 依赖摘要

- `app-shell` 是唯一 root-shell 模块，负责根导航、tab 持久化、启动分发、匿名/登录态引导和全局 overlay 承载。
- `sleep-data-core` 是核心领域数据拥有者，其他与睡眠记录、趋势和恢复建议相关的 feature 都必须消费它，而不是各自维护第二套数据模型。
- `today` 是主任务入口，`bedtime` 依赖其首页语义与部分状态承接。
- `calendar` 与 `insights` 都依赖 `sleep-data-core` 的查询与聚合能力，`insights` 额外依赖 today / calendar 已定义的指标语义。
- `profile-settings` 虽然可以较早开始，但其同步、订阅、通知与小组件配置最终依赖公共 bootstrap 与平台桥接。

## 并行实施波次

### `stage-0`

- `app-shell`

说明：必须最先完成，用于稳定路由、壳层和全局状态容器。

### `stage-1`

- `onboarding-activation`
- `sleep-data-core`

说明：这两个模块可以并行准备，但 `sleep-data-core` 的实体与数据契约必须在 `stage-2` 前冻结到可被消费的程度。

### `stage-2`

- `today`
- `bedtime`
- `calendar`
- `profile-settings`

说明：`today`、`bedtime`、`calendar` 属于核心行为闭环波次；`profile-settings` 作为系统设置波次可并行，但依赖公共 bootstrap 和部分平台接入。

### `stage-3`

- `insights`

说明：需要等核心行为与历史数据语义稳定后再落地，避免周报和稳定度算法反复返工。

## 条件性并行说明

- 如果 `sleep-data-core` 的 drift 表结构、健康数据映射和同步任务队列仍未确定，则 `today`、`calendar`、`insights` 只能做文档 refinement，不能安全实现并行。
- 如果 `app-shell` 的 tab 路由、深链承接和匿名/登录态分流仍未确定，则所有 feature 只能停留在模块文档阶段。
- 如果订阅权益快照策略未确认，`insights` 与 `profile-settings` 的付费相关部分只能先保留占位说明。

## shell 模块说明

- 本项目显式拆出 `app-shell`，因为根导航、底部 tab、重定向和全局状态容器具有独立实现价值。
- 不允许使用 `main` 这类泛技术名称替代 `app-shell`。
