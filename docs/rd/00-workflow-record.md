---
artifact_type: flutter_workflow_record
workflow_status: active
execution_mode: manual
current_stage: module_design_frozen
current_module: today
confirmation_status: pending_confirmation
next_skill: none
pending_next_stage: architecture_ready
pending_next_skill: next_module_or_flutter_init_review
pending_status_updates: today.architecture=generated; today.design_source_status=frozen; today.impl_status=landed
route_lock: expected_stage=module_design_frozen|expected_module=today|expected_next_skill=flutter-uiux-to-architecture|expected_next_stage=architecture_ready|expected_status_delta=today.architecture+today.design_source_status+today.impl_status
execution_owner: orchestrator
last_receipt_status: advanced
auto_progress_delta: today_architecture_pack_regenerated_after_preview_feedback
---

## workflow_summary

当前工作流仍停在 `today` 的 `module_design_frozen` 主阶段，但修订后的 `today` 模块设计源已经重新完成 Flutter 架构输出包。

当前手动流程已从“修订版设计源确认门”前进到新的“架构输出确认门”。

你一旦确认这份新的架构输出包，`today` 就会成为当前路线下第一个真正进入 `architecture_ready` 的模块，然后我们再决定是继续处理下一个前置模块，还是评估 `flutter-init` 的触发时机。

## current_stage_detail

当前已确认阶段为 `module_design_frozen`。

当前事实：

- `today.design_source_status` 已可视为 `frozen` 候选
- `today.impl_status` 已可视为 `landed` 候选
- 已完成一次 `flutter-design-source-control` 范围内的设计修订
- 已刷新：
  - `docs/rd/modules/today/today.pencil-design-source-packet.md`
  - `docs/rd/modules/today/pencil-exports/MCgNV.png`
- 已完成新的 `flutter-uiux-to-architecture`
- 已生成：
  - `docs/rd/modules/today/today.architecture.md`

本轮架构输出的重点是：

- 把修订后的结果卡、目标卡、动作卡和趋势块映射成 Flutter token、组件拆解与显示层决策
- 锁定哪些区域必须 `preserve_faithfully`
- 锁定哪些区域允许 `flutterize`
- 明确当前不需要额外运行时位图资产

当前 route lock：

- `expected_stage=module_design_frozen`
- `expected_module=today`
- `expected_next_skill=flutter-uiux-to-architecture`
- `expected_next_stage=architecture_ready`
- `expected_status_delta=today.architecture+today.design_source_status+today.impl_status`

## current_module_detail

当前活动模块为 `today`。

当前模块状态如下：

- `impl_status`: `landed_candidate`
- `design_source_status`: `frozen_candidate`
- `code_status`: `not_started`
- `generation_trace_status`: `today_architecture_waiting_confirmation`

当前模块已具备：

- [today.ui-ux.md](/D:/Projects/Flutter/rhythm/docs/rd/modules/today/today.ui-ux.md)
- [today.impl.md](/D:/Projects/Flutter/rhythm/docs/rd/modules/today/today.impl.md)
- [today.pencil-design-source-packet.md](/D:/Projects/Flutter/rhythm/docs/rd/modules/today/today.pencil-design-source-packet.md)
- [today-design-freeze-decision.md](/D:/Projects/Flutter/rhythm/docs/rd/modules/today/today-design-freeze-decision.md)
- [today.architecture.md](/D:/Projects/Flutter/rhythm/docs/rd/modules/today/today.architecture.md)
- [MCgNV.png](/D:/Projects/Flutter/rhythm/docs/rd/modules/today/pencil-exports/MCgNV.png)
- [today-module-preview.png](/D:/Projects/Flutter/rhythm/docs/rd/modules/today/today-module-preview.png)

模块级效果图仍然只作为 `supplemental_only`，不会覆盖 Pencil 设计源包；当前新的架构包已经基于回灌后的 Pencil 真源重算。

## next_action

当前 `next_skill` 为 `none`，因为手动模式下必须先确认 `today` 的新架构输出包。

你确认后继续的动作：

1. 将 `today` 提升到 `architecture_ready`
2. 重新评估实现顺序：
   - 是继续处理 `app-shell` 这类更前置模块
   - 还是进入 `flutter-init` 触发条件核查

当前最小输入已齐备：

- `docs/rd/modules/today/today.architecture.md`
- `docs/rd/modules/today/today-design-freeze-decision.md`
- `docs/rd/modules/today/today.pencil-design-source-packet.md`
- `docs/rd/modules/today/pencil-exports/MCgNV.png`

## confirmation_gate

- `confirmation_status`: `pending_confirmation`
- 原因：修订后的 `today` 架构输出包已完成，手动模式下必须先确认该包，才能正式提升到 `architecture_ready`
- `pending_next_stage`: `architecture_ready`
- `pending_next_skill`: `next_module_or_flutter_init_review`
- `pending_status_updates`: `today.architecture=generated; today.design_source_status=frozen; today.impl_status=landed`
- 用户确认目标：确认 `docs/rd/modules/today/today.architecture.md` 可作为修订后的 `today` 模块 Flutter 架构输出包

## blockers

- `waiting_for_user_confirmation`

## global_artifact_index

- prd: `docs/rhythm-sleep-routine-management-prd-commercial-2026-06-02.md`
- global technical baseline: `docs/rd/global-technical-baseline.md`
- DESIGN.md: `DESIGN.md`
- chosen design_source_adapter: `pencil`
- frozen pencil source reference: `docs/rd/app.pen`
- pencil design-source packet: `docs/rd/pencil-design-source-packet.md`
- global-design-guidelines.md: `docs/rd/global-design-guidelines.md`
- light-theme-freeze.yaml: `docs/rd/light-theme-freeze.yaml`
- dark-theme-freeze.yaml: `docs/rd/dark-theme-freeze.yaml`
- shared freeze evidence or freeze decision: `docs/rd/shared-design-freeze-decision.md`
- module index: `docs/rd/00-module-index.md`
- active module uiux doc: `docs/rd/modules/today/today.ui-ux.md`
- active module impl doc: `docs/rd/modules/today/today.impl.md`
- active module design source packet: `docs/rd/modules/today/today.pencil-design-source-packet.md`
- active module freeze decision: `docs/rd/modules/today/today-design-freeze-decision.md`
- active module architecture pack: `docs/rd/modules/today/today.architecture.md`
- active module visual evidence:
  - `docs/rd/modules/today/pencil-exports/MCgNV.png`
  - `docs/rd/modules/today/today-module-preview.png`
- verified platform identifier or target validation surface: `ios_device`

## module_status_table

| module | current_state | confirmation_status | next_skill | pending_next_stage | pending_next_skill | pending_status_updates | design_source_adapter | design_source_project_mode | design_source_project_ref | design_source_packet | effect_images | impl_rd | impl_status | generation_trace_status | global_guidelines | light_theme | dark_theme | taste_direction | visual_evidence | high_fidelity_freeze_status | design_source_status | code_status | init_status | blockers |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| global | module_design_frozen | not_required | none | none | none | none | pencil | frozen | `docs/rd/app.pen` | `docs/rd/pencil-design-source-packet.md` | `docs/rd/pencil-exports/MCgNV.png` + `docs/rd/pencil-exports/SvlPW.png` + `docs/rd/pencil-exports/N3lMk.png` + `docs/rd/pencil-exports/OSwll.png` + `docs/rd/pencil-exports/BwvXZ.png` + `docs/rd/pencil-exports/dMZS3.png` | none | not_started | today_architecture_generated | `docs/rd/global-design-guidelines.md` | `docs/rd/light-theme-freeze.yaml` | `docs/rd/dark-theme-freeze.yaml` | `docs/rd/rhythm-direction-jingye-order.png` | `docs/rd/modules/today/pencil-exports/MCgNV.png` | not_evaluated | frozen | not_started | not_started | none |
| app-shell | modules_split | not_required | none | none | none | none | pencil | frozen | `docs/rd/app.pen` | `docs/rd/modules/app-shell/app-shell.pencil-design-source-packet.md` | `docs/rd/modules/app-shell/pencil-exports/VRrsM.png` | `docs/rd/modules/app-shell/app-shell.impl.md` | not_started | split_draft_available | `docs/rd/global-design-guidelines.md` | `docs/rd/light-theme-freeze.yaml` | `docs/rd/dark-theme-freeze.yaml` | `docs/rd/rhythm-direction-jingye-order.png` | `docs/rd/modules/app-shell/pencil-exports/VRrsM.png` | not_evaluated | not_started | not_started | not_started | none |
| onboarding-activation | modules_split | not_required | none | none | none | none | pencil | frozen | `docs/rd/app.pen` | `docs/rd/pencil-design-source-packet.md` | `docs/rd/pencil-exports/dMZS3.png` | `docs/rd/modules/onboarding-activation/onboarding-activation.impl.md` | not_started | split_draft_available | `docs/rd/global-design-guidelines.md` | `docs/rd/light-theme-freeze.yaml` | `docs/rd/dark-theme-freeze.yaml` | `docs/rd/rhythm-direction-jingye-order.png` | `docs/rd/pencil-exports/dMZS3.png` | not_evaluated | not_started | not_started | not_started | none |
| sleep-data-core | modules_split | not_required | none | none | none | none | pencil | frozen | `docs/rd/app.pen` | `docs/rd/pencil-design-source-packet.md` | cross_module_states | `docs/rd/modules/sleep-data-core/sleep-data-core.impl.md` | not_started | split_draft_available | `docs/rd/global-design-guidelines.md` | `docs/rd/light-theme-freeze.yaml` | `docs/rd/dark-theme-freeze.yaml` | `docs/rd/rhythm-direction-jingye-order.png` | cross_module_evidence | not_evaluated | not_started | not_started | not_started | none |
| today | module_design_frozen | pending_confirmation | none | architecture_ready | next_module_or_flutter_init_review | today.architecture=generated; today.design_source_status=frozen; today.impl_status=landed | pencil | frozen | `docs/rd/app.pen` | `docs/rd/modules/today/today.pencil-design-source-packet.md` | `docs/rd/modules/today/today-module-preview.png` | `docs/rd/modules/today/today.impl.md` | landed_candidate | today_architecture_waiting_confirmation | `docs/rd/global-design-guidelines.md` | `docs/rd/light-theme-freeze.yaml` | `docs/rd/dark-theme-freeze.yaml` | `docs/rd/rhythm-direction-jingye-order.png` | `docs/rd/modules/today/pencil-exports/MCgNV.png` + `docs/rd/modules/today/today-module-preview.png` | passed | frozen_candidate | not_started | not_started | waiting_for_user_confirmation |
| bedtime | modules_split | not_required | none | none | none | none | pencil | frozen | `docs/rd/app.pen` | `docs/rd/pencil-design-source-packet.md` | `docs/rd/pencil-exports/N3lMk.png` | `docs/rd/modules/bedtime/bedtime.impl.md` | not_started | split_draft_available | `docs/rd/global-design-guidelines.md` | `docs/rd/light-theme-freeze.yaml` | `docs/rd/dark-theme-freeze.yaml` | `docs/rd/rhythm-direction-jingye-order.png` | `docs/rd/pencil-exports/N3lMk.png` | not_evaluated | not_started | not_started | not_started | none |
| calendar | modules_split | not_required | none | none | none | none | pencil | frozen | `docs/rd/app.pen` | `docs/rd/pencil-design-source-packet.md` | `docs/rd/pencil-exports/SvlPW.png` | `docs/rd/modules/calendar/calendar.impl.md` | not_started | split_draft_available | `docs/rd/global-design-guidelines.md` | `docs/rd/light-theme-freeze.yaml` | `docs/rd/dark-theme-freeze.yaml` | `docs/rd/rhythm-direction-jingye-order.png` | `docs/rd/pencil-exports/SvlPW.png` | not_evaluated | not_started | not_started | not_started | none |
| insights | modules_split | not_required | none | none | none | none | pencil | frozen | `docs/rd/app.pen` | `docs/rd/pencil-design-source-packet.md` | `docs/rd/pencil-exports/OSwll.png` | `docs/rd/modules/insights/insights.impl.md` | not_started | split_draft_available | `docs/rd/global-design-guidelines.md` | `docs/rd/light-theme-freeze.yaml` | `docs/rd/dark-theme-freeze.yaml` | `docs/rd/rhythm-direction-jingye-order.png` | `docs/rd/pencil-exports/OSwll.png` | not_evaluated | not_started | not_started | not_started | none |
| profile-settings | modules_split | not_required | none | none | none | none | pencil | frozen | `docs/rd/app.pen` | `docs/rd/pencil-design-source-packet.md` | `docs/rd/pencil-exports/BwvXZ.png` | `docs/rd/modules/profile-settings/profile-settings.impl.md` | not_started | split_draft_available | `docs/rd/global-design-guidelines.md` | `docs/rd/light-theme-freeze.yaml` | `docs/rd/dark-theme-freeze.yaml` | `docs/rd/rhythm-direction-jingye-order.png` | `docs/rd/pencil-exports/BwvXZ.png` | not_evaluated | not_started | not_started | not_started | none |

## decision_log

- 2026-06-08：已根据确认后的 PRD 生成 `docs/rd/global-technical-baseline.md`
- 2026-06-08：已生成并确认早前版本的 `docs/rd/global-design-guidelines.md`
- 2026-06-08：已生成早前版本的根目录 `DESIGN.md`
- 2026-06-08：设计源路线已固定为 `design_source_adapter=pencil`
- 2026-06-08：已基于早前方向生成 `docs/rd/app.pen`、`docs/rd/pencil-design-source-packet.md` 与页面导出图
- 2026-06-08：已完成一轮共享冻结，并进入模块拆分与 `app-shell` 模块冻结候选阶段
- 2026-06-08：用户新确认 `docs/rd/rhythm-direction-jingye-order.png` 为最终产品设计方向输入
- 2026-06-08：因新方向与旧共享冻结合同在首页首屏层级、摘要与行动排序、视觉节奏和组件主次上发生冲突，工作流已按 `design_change` 回退到 `product_direction_confirmed`
- 2026-06-08：已按 `静夜秩序` 重写根级 `DESIGN.md`
- 2026-06-08：已刷新 `docs/rd/app.pen`、重排 Today 首屏层级并重导出 6 个共享页面 PNG
- 2026-06-08：已重建 `docs/rd/global-design-guidelines.md`、`docs/rd/light-theme-freeze.yaml`、`docs/rd/dark-theme-freeze.yaml`
- 2026-06-08：已重新执行共享冻结评审并生成新的 `docs/rd/shared-design-freeze-decision.md`
- 2026-06-08：已基于新的共享冻结结果重跑 `docs/rd/00-module-index.md`，并同步修正 `today` 成对模块文档
- 2026-06-08：已将 `today` 设为首个活动模块，并把 `today` 成对文档细化到 implementation-final 候选粒度
- 2026-06-09：已新增 `docs/rd/modules/today/today.pencil-design-source-packet.md` 与 `docs/rd/modules/today/pencil-exports/MCgNV.png`
- 2026-06-09：已按显式 `--perviewer` 生成 `docs/rd/modules/today/today-module-preview.png`，并判定其为 `supplemental_only`
- 2026-06-09：已完成 `today` 模块冻结评审并生成 `docs/rd/modules/today/today-design-freeze-decision.md`
- 2026-06-09：已执行 `flutter-uiux-to-architecture` 并生成 `docs/rd/modules/today/today.architecture.md`，当前手动流程停在 `today` 架构结果确认门前
- 2026-06-09：用户要求“按效果图优化 today 设计稿”，工作流已按 `flutter-design-source-control` 执行一次模块级设计修订
- 2026-06-09：已刷新 `docs/rd/app.pen` 中的 `Today Screen`，并重导出 `docs/rd/modules/today/pencil-exports/MCgNV.png`
- 2026-06-09：修订后的模块级 Pencil 真源已获继续推进授权
- 2026-06-09：已基于修订后的 `today` 设计源重新执行 `flutter-uiux-to-architecture` 并重写 `docs/rd/modules/today/today.architecture.md`
