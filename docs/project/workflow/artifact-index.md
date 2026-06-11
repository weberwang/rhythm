# 工作流产物索引
## 当前状态
- 当前阶段：`module_impl_docs_ready`
- 当前模块：`onboarding-activation`
- 当前确认状态：`pending_confirmation`
- 已确认主线：`global shared freeze = stitch`
- 当前模块设计源：`onboarding-activation -> pencil`
- Pencil 来源引用：`docs/project/design/app.pen`
- 共享冻结结果：`frozen_shared_for_split`
- 当前模块冻结结果：`app-shell -> frozen_module_for_architecture`
- 当前模块架构结果：`app-shell -> architecture_ready`
- 项目初始化结果：`project_initialized`
- 共享运行时底座：`bootstrap_code_ready`
- `app-shell` Spec：`approved`
- `app-shell` Plan：`executed`
- `app-shell` 代码状态：`landed`
- `app-shell` 设计复核：`deferred-by-user`
- `onboarding-activation` 文档状态：`implementation_final_for_design_review`
- `onboarding-activation` 设计源状态：`preview_round_generated_waiting_direction`
- `onboarding-activation` 代码状态：`activation_flow_plus_gateways_landed`
- 用户决策：`app-shell` 运行态证据延后到后续运行时统一验收，本轮先继续推进下游模块
- 下一前置动作：先在 `preview-v1 / v2 / v3` 中选定 `onboarding-activation` 的代表页方向，再扩展其余步骤并进入 Pencil 重建准备

## 已归位产物
| 类型 | 路径 | 说明 |
| --- | --- | --- |
| 原始需求输入 | [rhythm-sleep-routine-management-prd-commercial-2026-06-02.md](/E:/Projects/flutter/rhythm/docs/project/intake/rhythm-sleep-routine-management-prd-commercial-2026-06-02.md) | 改写前商业需求输入 |
| 标准 PRD | [rhythm-sleep-routine-management-commercial.prd.md](/E:/Projects/flutter/rhythm/docs/project/prd/rhythm-sleep-routine-management-commercial.prd.md) | 当前工作流使用的 PRD |
| 全局技术基线 | [global-technical-baseline.md](/E:/Projects/flutter/rhythm/docs/project/rd/global-technical-baseline.md) | `prd_ready -> technical_baseline_ready` 产物 |
| 设计设备预设 | [design-device-preset.md](/E:/Projects/flutter/rhythm/docs/project/rd/design-device-preset.md) | 已冻结的设计视口记录 |
| 根级设计约束 | [DESIGN.md](/E:/Projects/flutter/rhythm/DESIGN.md) | 根目录保留的共享设计约束 |
| 最终确认效果图 | [rhythm-prd-only-option-2-ordered-planner.png](/E:/Projects/flutter/rhythm/docs/project/design/recommendations/rhythm-prd-only-option-2-ordered-planner.png) | 当前共享冻结唯一视觉基线 |
| 共享设计指南 | [global-design-guidelines.md](/E:/Projects/flutter/rhythm/docs/project/rd/global-design-guidelines.md) | 共享冻结主文档 |
| 浅色主题冻结 | [light-theme-freeze.yaml](/E:/Projects/flutter/rhythm/docs/project/rd/light-theme-freeze.yaml) | 共享设计主题冻结产物 |
| 深色主题冻结 | [dark-theme-freeze.yaml](/E:/Projects/flutter/rhythm/docs/project/rd/dark-theme-freeze.yaml) | 共享设计主题冻结产物 |
| Stitch 共享设计主包 | [stitch-shared-design-master.md](/E:/Projects/flutter/rhythm/docs/project/rd/stitch-shared-design-master.md) | Stitch 主线共享设计主包 |
| Stitch 设计源包 | [stitch-design-source-packet.md](/E:/Projects/flutter/rhythm/docs/project/rd/stitch-design-source-packet.md) | 结构化设计源冻结包 |
| 共享冻结决策 | [shared-design-freeze-decision.md](/E:/Projects/flutter/rhythm/docs/project/rd/shared-design-freeze-decision.md) | shared freeze gate 通过记录 |
| 模块索引 | [00-module-index.md](/E:/Projects/flutter/rhythm/docs/project/00-module-index.md) | 模块边界、依赖与实施波次索引 |
| 模块文档目录 | [modules](/E:/Projects/flutter/rhythm/docs/project/modules) | 各模块 `ui-ux` / `impl` 文档目录 |
| app-shell 模块设计源包 | [app-shell.design-source-packet.md](/E:/Projects/flutter/rhythm/docs/project/modules/app-shell/app-shell.design-source-packet.md) | `app-shell` 模块设计冻结输入包 |
| app-shell 模块冻结决策 | [app-shell-design-freeze-decision.md](/E:/Projects/flutter/rhythm/docs/project/modules/app-shell/app-shell-design-freeze-decision.md) | `app-shell` 模块 freeze gate 通过记录 |
| app-shell 架构产物 | [app-shell.architecture.md](/E:/Projects/flutter/rhythm/docs/project/modules/app-shell/app-shell.architecture.md) | `app-shell` Flutter 架构映射产物 |
| app-shell 设计复核 | [app-shell-design-parity-review.md](/E:/Projects/flutter/rhythm/docs/project/modules/app-shell/app-shell-design-parity-review.md) | `app-shell` 实现对照冻结设计的复核结果 |
| app-shell 运行态截图 | [app-shell-runtime-onboarding-web-390x844.png](/E:/Projects/flutter/rhythm/docs/project/modules/app-shell/app-shell-runtime-onboarding-web-390x844.png) | 当前已补到的 onboarding Web 视口截图 |
| onboarding-activation 模块设计源包 | [onboarding-activation.design-source-packet.md](/E:/Projects/flutter/rhythm/docs/project/modules/onboarding-activation/onboarding-activation.design-source-packet.md) | `onboarding-activation` 当前 Pencil 分支设计输入包 |
| onboarding-activation Pencil preview 评审 | [onboarding-activation-pencil-preview-review.md](/E:/Projects/flutter/rhythm/docs/project/modules/onboarding-activation/onboarding-activation-pencil-preview-review.md) | 当前代表页 preview 方向评审记录 |
| 项目初始化总结 | [project-initialization-summary.md](/E:/Projects/flutter/rhythm/docs/project/rd/project-initialization-summary.md) | `flutter-init` 阶段交付说明 |
| bootstrap 总结 | [bootstrap-code-summary.md](/E:/Projects/flutter/rhythm/docs/project/rd/bootstrap-code-summary.md) | 共享运行时底座交付说明 |
| app-shell Spec | [2026-06-10-app-shell-design.md](/E:/Projects/flutter/rhythm/docs/superpowers/specs/2026-06-10-app-shell-design.md) | `@superpowers Spec` 阶段交付说明 |
| app-shell Plan | [2026-06-10-app-shell-implementation-plan.md](/E:/Projects/flutter/rhythm/docs/superpowers/plans/2026-06-10-app-shell-implementation-plan.md) | `@superpowers Plan` 阶段交付说明 |

## 本次整理边界

- 仅整理当前磁盘上真实存在的工作流文件到 `docs/project/`。
- 未擅自恢复 Git 中已记录但当前工作区缺失的历史工作流文件，避免覆盖已有删除决策。
- 运行态状态文件保留在 `tmp/flutter-workflow-orchestrator/`，不混入长期归档目录。

## 最新推进

- 已按用户要求将 `onboarding-activation` 的模块设计源切换到 Pencil 分支，项目级来源引用为 [app.pen](/E:/Projects/flutter/rhythm/docs/project/design/app.pen)。
- 已生成代表页 3 个 preview 方向图：
  - [preview-v1-welcome-entry.png](/E:/Projects/flutter/rhythm/docs/project/modules/onboarding-activation/previews/preview-v1-welcome-entry.png)
  - [preview-v2-welcome-entry.png](/E:/Projects/flutter/rhythm/docs/project/modules/onboarding-activation/previews/preview-v2-welcome-entry.png)
  - [preview-v3-welcome-entry.png](/E:/Projects/flutter/rhythm/docs/project/modules/onboarding-activation/previews/preview-v3-welcome-entry.png)
- 已确认 `preview-v2` 作为 `onboarding-activation` 当前设计周期唯一视觉基线，并补齐：
  - [preview-v2-step-2-health-access.png](/E:/Projects/flutter/rhythm/docs/project/modules/onboarding-activation/previews/preview-v2-step-2-health-access.png)
  - [preview-v2-step-3-sleep-window.png](/E:/Projects/flutter/rhythm/docs/project/modules/onboarding-activation/previews/preview-v2-step-3-sleep-window.png)
  - [preview-v2-step-4-reminder-strategy.png](/E:/Projects/flutter/rhythm/docs/project/modules/onboarding-activation/previews/preview-v2-step-4-reminder-strategy.png)
- 已新增 [onboarding-activation-pencil-preview-review.md](/E:/Projects/flutter/rhythm/docs/project/modules/onboarding-activation/onboarding-activation-pencil-preview-review.md) 记录当前方向门评审结果。

## 仍待补齐

- `app-shell` 的 root-shell、handoff、overlay 运行态截图
- Android 模拟器下可稳定复用的截图采集链路
- `onboarding-activation` 的模块级冻结评审与 freeze decision
- `onboarding-activation` Pencil 代表页方向确认
- `onboarding-activation` 剩余 Step 2-4 preview 扩展
- `onboarding-activation` 的真实登录入口
- `onboarding-activation` 向 `sleep-data-core` 写入初始目标与提醒配置
- 其余模块的 refinement 与模块级设计冻结产物
- feature 真实实现代码
