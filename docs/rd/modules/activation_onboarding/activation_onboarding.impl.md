# activation_onboarding 实现 RD

> 配对 UI/UX RD：`docs/rd/modules/activation_onboarding/activation_onboarding.ui-ux.md`
> 全局基线：`docs/rd/2026-06-02-rhythm-commercial-global-rd.md`
> 工作流状态：`modules_split`

## 1. 业务能力与边界

负责首次激活状态机、欢迎价值、登录选择、健康授权说明和完成状态。不直接实现目标作息表单、真实提醒调度或小组件能力。

## 2. 继承包栈

- `hooks_riverpod`
- `go_router`
- `shared_preferences`
- `google_sign_in`
- `sign_in_with_apple`
- `health` 的授权状态通过 `sleep_records` 边界暴露

## 3. 领域模型

- `OnboardingStep`
- `OnboardingDraft`
- `OnboardingCompletion`
- `HealthPermissionIntent`

模型需用 `freezed` 表达状态和值语义。

## 4. 应用状态

- 当前步骤
- 登录方式选择结果
- 授权请求结果
- 手动模式选择
- 完成状态写入

Provider 默认使用 `@riverpod`。

## 5. 基础设施与接口

- 登录 SDK 只在 data/infrastructure 层封装。
- 健康权限实际请求由 `sleep_records` 的权限网关完成。
- onboarding 只消费授权状态和触发入口。

## 6. 数据与安全

- 匿名模式不上传云端。
- 登录失败不得阻塞手动路径。
- 授权说明不得记录敏感健康原始数据。

## 7. 埋点

- `onboarding_started`
- `signup_started`
- `signup_completed`
- `health_permission_requested`
- `health_permission_granted`
- `manual_mode_selected`
- `onboarding_completed`

## 8. 测试范围

- 首次打开进入欢迎页。
- 登录失败可继续。
- 授权拒绝可进入手动模式。
- 完成后进入今日页。
- 不出现付费墙。

## 9. 实现约束

实现必须遵守 UI/UX 冻结结果；若要调整文案层级、按钮优先级或登录策略，必须回设计控制。
