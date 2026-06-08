# profile-settings 实现 RD

> 产物类型：`module_impl_rd`
> 模块：`profile-settings`
> 文档成熟度：`split_draft`
> 日期：`2026-06-08`

## 1. 关联引用

- 配对 UI/UX RD：`docs/rd/modules/profile-settings/profile-settings.ui-ux.md`
- 全局技术基线：`docs/rd/global-technical-baseline.md`

## 2. 业务能力与边界上下文

`profile-settings` 负责设置与信任入口，不直接拥有睡眠主闭环，但会承载账户、同步、权限、会员、目标与提醒的入口与展示状态。

## 3. 继承的全局包栈与模块用法

- `hooks_riverpod` / `riverpod_annotation`：设置页状态与入口装配
- `supabase_flutter` / 登录适配层：账户状态
- `purchases_flutter`：会员状态
- `health` / 通知适配层：权限状态读取
- `shared_preferences`：轻量设置

## 4. 领域模型与应用状态

- 视图模型：
  - `ProfileViewState`
  - `AccountSummary`
  - `MembershipSummary`
  - `PermissionSummary`
  - `SyncSummary`
- 应用状态：
  - 会话状态
  - 同步状态
  - 权限状态
  - 设置写入状态

## 5. 基础设施依赖与展示边界

- 依赖：
  - `sleep-data-core` 的目标与提醒设置边界
  - 账户与会员适配层
- 展示边界：
  - 只暴露入口与状态
  - 具体底层能力由对应 repository/service 持有

## 6. 模块级组件实现说明

- 会员状态卡必须复用统一权益模型。
- 目标与提醒设置入口优先复用 onboarding 已有表单语义。
- 权限与同步状态行必须消费统一状态对象，而不是每行各自访问插件。

## 7. API、存储、权限与后端协作

- 依赖账户会话、订阅状态、同步状态读取
- 设置写入下沉到 `sleep-data-core` 或账户边界层
- 隐私/导出/删除入口至少先承载说明与跳转位

## 8. 数据、安全、埋点、监控、测试范围

- 埋点：
  - `profile_viewed`
  - `paywall_viewed`
  - `subscription_purchased`
- 监控：
  - 同步失败率
  - 权限异常状态占比
- 测试：
  - 设置入口装配测试
  - 权限/同步异常展示测试
  - 会员边界展示测试

## 9. 实现顺序与依赖说明

- 依赖 `app-shell`、`sleep-data-core`、`onboarding-activation`
- 与 `insights` 同属 `stage-4`
- 可在主闭环稳定后再放大会员与同步承接

## 10. 模块特定实现约束

- 不得让页面直接调用第三方 SDK。
- 不得将隐私/导出/删除路径隐藏过深。
- 不得将会员入口设计成页面第一重心。

## 11. 细化执行溯源

- `superpowers_refinement_status`: `not_executed`
- `superpowers_refinement_notes`: `当前文档为初始模块拆分草案，尚未经过模块级 @superpowers 细化执行`

## 12. 开放问题

- 会员套餐表达与同步首发范围仍需最终确认。
