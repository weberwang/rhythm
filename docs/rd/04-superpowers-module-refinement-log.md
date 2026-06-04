# Rhythm `@superpowers` 模块细化执行痕迹

## 说明

- 本文用于把 `flutter-workflow-orchestrator --auto` 在 `modules_split` 之后的逐模块推进轨迹显式化。
- 它不替代 [00-workflow-record.md](E:/Projects/flutter/rhythm/docs/rd/00-workflow-record.md)，而是为其中的 `decision_log`、`current_module` 变化和模块成熟度升级提供详细证据。
- 每个模块都按同一契约推进：
  - 选中 `current_module`
  - 通过 `@superpowers` 执行 `module_uiux_refinement`
  - 升级到 `implementation_final`
  - 通过 `flutter-design-freeze-gate` 冻结设计源
  - 通过 `flutter-uiux-to-architecture` 完成实现前架构收敛

## 执行顺序总览

1. `app-shell`
2. `sleep-data-core`
3. `onboarding-activation`
4. `today`
5. `bedtime`
6. `calendar`
7. `profile-settings`
8. `insights`

## app-shell

- `current_module`: `app-shell`
- refinement owner: `@superpowers`
- refinement inputs:
  - `docs/rd/01-global-technical-baseline.md`
  - `docs/rd/02-shared-design-packet.md`
  - `docs/rd/00-module-index.md`
- refinement outputs:
  - `docs/rd/modules/app-shell/app-shell.ui-ux.md`
  - `docs/rd/modules/app-shell/app-shell.impl.md`
- maturity transition:
  - `split_draft -> implementation_final -> landed`
- freeze result:
  - `design_source_status: frozen`
- architecture result:
  - 被 `docs/rd/03-implementation-architecture.md` 吸收为 root shell 与 bootstrap 输入

## sleep-data-core

- `current_module`: `sleep-data-core`
- refinement owner: `@superpowers`
- refinement inputs:
  - 全局技术基线
  - 共享设计包
  - `app-shell` 已冻结的上游约束
- refinement outputs:
  - `docs/rd/modules/sleep-data-core/sleep-data-core.ui-ux.md`
  - `docs/rd/modules/sleep-data-core/sleep-data-core.impl.md`
- maturity transition:
  - `split_draft -> implementation_final -> landed`
- freeze result:
  - `design_source_status: frozen`
- architecture result:
  - 被 `docs/rd/03-implementation-architecture.md` 吸收为本地存储、健康读取、同步队列与派生指标基线

## onboarding-activation

- `current_module`: `onboarding-activation`
- refinement owner: `@superpowers`
- refinement inputs:
  - 全局技术基线
  - 共享设计包
  - `app-shell`、`sleep-data-core` 上游约束
  - 静态证据：`docs/rd/modules/onboarding-activation/onboarding-welcome.png`
- refinement outputs:
  - `docs/rd/modules/onboarding-activation/onboarding-activation.ui-ux.md`
  - `docs/rd/modules/onboarding-activation/onboarding-activation.impl.md`
- maturity transition:
  - `split_draft -> implementation_final -> landed`
- freeze result:
  - `design_source_status: frozen`
- architecture result:
  - 被架构摘要吸收为首次激活状态机与目标作息/提醒初始化输入

## today

- `current_module`: `today`
- refinement owner: `@superpowers`
- refinement inputs:
  - 全局技术基线
  - 共享设计包
  - 上游 `sleep-data-core`、`onboarding-activation`
  - 静态证据：`docs/rd/modules/today/today-dashboard.png`
- refinement outputs:
  - `docs/rd/modules/today/today.ui-ux.md`
  - `docs/rd/modules/today/today.impl.md`
- maturity transition:
  - `split_draft -> implementation_final -> landed`
- freeze result:
  - `design_source_status: frozen`
- architecture result:
  - 被架构摘要吸收为首页聚合、五区块显示层与趋势图决策

## bedtime

- `current_module`: `bedtime`
- refinement owner: `@superpowers`
- refinement inputs:
  - 全局技术基线
  - 共享设计包
  - 上游 `sleep-data-core`、`onboarding-activation`
  - 静态证据：`docs/rd/modules/bedtime/bedtime-mode.png`
- refinement outputs:
  - `docs/rd/modules/bedtime/bedtime.ui-ux.md`
  - `docs/rd/modules/bedtime/bedtime.impl.md`
- maturity transition:
  - `split_draft -> implementation_final -> landed`
- freeze result:
  - `design_source_status: frozen`
- architecture result:
  - 被架构摘要吸收为倒计时页、状态选择与通知入口收敛

## calendar

- `current_module`: `calendar`
- refinement owner: `@superpowers`
- refinement inputs:
  - 全局技术基线
  - 共享设计包
  - 上游 `sleep-data-core`、`onboarding-activation`
  - 静态证据：`docs/rd/modules/calendar/calendar-heatmap.png`
- refinement outputs:
  - `docs/rd/modules/calendar/calendar.ui-ux.md`
  - `docs/rd/modules/calendar/calendar.impl.md`
- maturity transition:
  - `split_draft -> implementation_final -> landed`
- freeze result:
  - `design_source_status: frozen`
- architecture result:
  - 被架构摘要吸收为热力图、筛选与单日详情决策

## profile-settings

- `current_module`: `profile-settings`
- refinement owner: `@superpowers`
- refinement inputs:
  - 全局技术基线
  - 共享设计包
  - 上游 `sleep-data-core`、`onboarding-activation`
  - 静态证据：`docs/rd/modules/profile-settings/profile-settings.png`
- refinement outputs:
  - `docs/rd/modules/profile-settings/profile-settings.ui-ux.md`
  - `docs/rd/modules/profile-settings/profile-settings.impl.md`
- maturity transition:
  - `split_draft -> implementation_final -> landed`
- freeze result:
  - `design_source_status: frozen`
- architecture result:
  - 被架构摘要吸收为会员、同步、设置入口与 grouped list 决策

## insights

- `current_module`: `insights`
- refinement owner: `@superpowers`
- refinement inputs:
  - 全局技术基线
  - 共享设计包
  - 上游 `today`、`bedtime`、`calendar`
  - 静态证据：`docs/rd/modules/insights/insights-weekly-report.png`
- refinement outputs:
  - `docs/rd/modules/insights/insights.ui-ux.md`
  - `docs/rd/modules/insights/insights.impl.md`
- maturity transition:
  - `split_draft -> implementation_final -> landed`
- freeze result:
  - `design_source_status: frozen`
- architecture result:
  - 被架构摘要吸收为周报、稳定度解释、恢复效果与付费承接决策

## stop condition 结论

- 所有目标模块均满足：
  - `uiux_status=landed`
  - `impl_status=landed`
  - `design_source_status=frozen`
  - 已纳入实现前架构摘要
- 因此 auto loop 的正确终点是“等待 `flutter-init` 与共享公共代码基线”，而不是“某个模块刚写完文档”。
