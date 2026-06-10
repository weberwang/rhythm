# profile-settings Implementation RD

## 文档状态

- impl_status：`split_draft`
- superpowers_refinement_status：`not_executed`

## 关联文档

- 配对 UI/UX：[profile-settings.ui-ux.md](/E:/Projects/flutter/rhythm/docs/project/modules/profile-settings/profile-settings.ui-ux.md)
- 全局技术基线：[global-technical-baseline.md](/E:/Projects/flutter/rhythm/docs/project/rd/global-technical-baseline.md)

## 业务能力与边界

管理系统级状态与外部能力配置，不拥有睡眠记录主数据，但拥有账户绑定、同步状态查看、通知和小组件偏好、订阅状态展示与危险操作入口。

## 包栈与模块说明

- `supabase_flutter`：账户与同步状态
- `flutter_local_notifications` / `home_widget`：设置读取与授权状态展示
- `purchases_flutter`：订阅状态与恢复购买
- `shared_preferences`：偏好配置

## 分层边界

- domain：设置项、订阅状态、同步状态值对象
- application：设置页聚合、危险操作流、恢复购买流程
- data：auth gateway、sync gateway、widget/notification gateway、purchase gateway
- presentation：设置列表、详情页、确认弹层

## 埋点与测试

- 埋点：`profile_viewed`、`sync_settings_opened`、`restore_purchase_tapped`
- 测试：
  - 匿名/登录双状态
  - 通知与 widget 权限状态变化
  - 恢复购买成功 / 失败
  - 数据删除确认流程

## 模块约束

- 不得让 UI 层直接调用 purchases、supabase 或 widget SDK
- 危险动作必须集中在统一确认流中
- 与账号和同步相关的文案必须可国际化

## 风险与开放问题

- 订阅权益快照策略未定时，恢复购买结果页只能先保留弱承诺
- 小组件设置与系统真实状态同步的边界需后续 refinement 明确
