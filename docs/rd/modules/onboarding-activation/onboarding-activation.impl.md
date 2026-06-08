# onboarding-activation 实现 RD

> 产物类型：`module_impl_rd`
> 模块：`onboarding-activation`
> 文档成熟度：`split_draft`
> 日期：`2026-06-08`

## 1. 关联引用

- 配对 UI/UX RD：`docs/rd/modules/onboarding-activation/onboarding-activation.ui-ux.md`
- 全局技术基线：`docs/rd/global-technical-baseline.md`
- 共享设计冻结：
  - `docs/rd/global-design-guidelines.md`
  - `docs/rd/pencil-design-source-packet.md`

## 2. 业务能力与边界上下文

该模块负责“首次可用状态建立”，包括登录入口、健康权限、目标作息、提醒策略和小组件引导。  
它不负责长期展示结果，不负责顶层壳层，也不负责深度会员解释。

## 3. 继承的全局包栈与模块用法

- `go_router`：首用步骤流转与完成后跳转
- `hooks_riverpod` / `riverpod_annotation`：步骤状态与表单装配
- `health`：健康权限请求与读取能力入口
- `google_sign_in` / `sign_in_with_apple` / `supabase_flutter`：登录与会话绑定
- `shared_preferences`：首用完成标记
- `home_widget`：小组件引导状态标记

## 4. 领域模型与应用状态

- 领域对象：
  - `OnboardingProgress`
  - `LoginChoice`
  - `PermissionGrantState`
  - `InitialGoalSetup`
  - `InitialReminderSetup`
- 应用状态：
  - 当前步骤
  - 登录处理状态
  - 权限处理状态
  - 目标与提醒的表单状态
  - 是否已完成可用状态写入

## 5. 基础设施依赖与展示边界

- 依赖：
  - `sleep-data-core` 提供目标作息与提醒的写入边界
  - 账户与会话适配层
  - 权限网关
- 展示边界：
  - 只负责首用漏斗
  - 完成后跳回 `app-shell` 控制的主应用入口

## 6. 模块级组件实现说明

- 登录入口组必须通过统一账户适配层返回内部模型，不允许页面直接持有第三方 SDK 结果。
- 权限说明与请求逻辑要分离；页面负责解释与触发，网关负责真正请求。
- 时间设置与提醒设置优先复用后续 `profile-settings` 的表单语义，而不是复制新规则。

## 7. API、存储、权限与后端协作

- API/SDK：
  - 第三方登录
  - 健康权限请求
  - 本地通知初始化前的策略写入
- 存储：
  - 首用完成标记
  - 初始目标与提醒
- 后端协作：
  - 若存在云会话绑定，仅在高信任节点绑定，不让登录阻断首用主路径

## 8. 数据、安全、埋点、监控、测试范围

- 数据：
  - 不沉淀复杂长期业务数据
  - 只负责首用配置写入
- 安全：
  - 登录凭据仅经过边界层
  - 权限拒绝不应泄露无关健康范围
- 埋点：
  - `onboarding_started`
  - `signup_started`
  - `signup_completed`
  - `health_permission_requested`
  - `health_permission_granted`
  - `goal_setup_completed`
  - `reminder_setup_completed`
  - `onboarding_completed`
- 监控：
  - 登录失败
  - 授权失败
  - 首用完成率
- 测试：
  - 首用主路径集成测试
  - 权限拒绝降级路径测试

## 9. 实现顺序与依赖说明

- 依赖 `app-shell` 与 `sleep-data-core`
- 解锁 `today` 与 `profile-settings`
- 必须早于主闭环模块的真实进入体验

## 10. 模块特定实现约束

- 不得把 onboarding 做成纯宣传页。
- 不得在登录或授权失败时直接把用户锁死。
- 不得在该模块偷做长期会员承接页。

## 11. 细化执行溯源

- `superpowers_refinement_status`: `not_executed`
- `superpowers_refinement_notes`: `当前文档为初始模块拆分草案，尚未经过模块级 @superpowers 细化执行`

## 12. 开放问题

- 匿名使用策略需要最终确认。
- 中英双语同步落地是否首发同批，需要后续业务确认。
