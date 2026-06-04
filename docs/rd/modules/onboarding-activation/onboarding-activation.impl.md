# onboarding-activation 实现 RD

> 本文件对应 `flutter-workflow-orchestrator --auto` 的 `module_uiux_refinement` 阶段，按 `flutter-rd-module-splitter` 的细化契约由 `@superpowers` 收敛到实现前粒度；本文记录的是该阶段完成后的冻结输入。

## 文档关系

- 配对 UI/UX 文档：`docs/rd/modules/onboarding-activation/onboarding-activation.ui-ux.md`
- 继承全局基线：`docs/rd/01-global-technical-baseline.md`

## 业务能力与边界

- 负责：
  - 首次激活状态推进
  - 登录/匿名选择
  - 健康授权意图触发
  - 目标作息设置
  - 提醒策略与小组件引导
- 不负责：
  - 正式首页业务数据展示

## 继承的全局包栈

- `go_router`
- `hooks_riverpod`
- `health`
- `google_sign_in`
- `sign_in_with_apple`
- `flutter_local_notifications`
- `home_widget`

## 领域模型与应用状态

- `ActivationStep`
- `ActivationDraft`
- `GoalScheduleDraft`
- `ReminderPreferenceDraft`

## 数据/服务/插件边界

- 健康授权通过 adapter 触发，不在页面直接调用插件
- 登录通过 account gateway 调用，页面只消费结果态
- 目标设置写入本地 repository，并在可同步时入队

## 导航契约与交互规则

- 每一步推进由应用层状态驱动，不使用页面内散乱导航
- 回流时根据 `ActivationStep` 恢复到未完成步骤

## 埋点、安全、监控

- 埋点：
  - `onboarding_started`
  - `signup_started`
  - `signup_completed`
  - `health_permission_requested`
  - `health_permission_granted`
  - `manual_mode_selected`
  - `goal_setup_completed`
  - `reminder_setup_completed`
  - `onboarding_completed`
- 登录中断或权限拒绝只记录结果，不写敏感上下文

## 测试范围

- 步骤恢复测试
- 授权拒绝仍可继续测试
- 目标设置表单校验测试
- 完成引导进入 today 流程测试

## 设计冻结消费规则

- 不得把任何一步骤重构成多主 CTA 页面。
- 不得在登录页或完成页新增付费墙。

## 实施顺序

1. 定义步骤状态机与 draft state。
2. 落登录/匿名 gateway。
3. 落健康授权与手动路径。
4. 落目标设置与提醒设置持久化。
5. 落小组件引导与完成页分发。
