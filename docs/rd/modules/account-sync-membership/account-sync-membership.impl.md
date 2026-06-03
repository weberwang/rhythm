# Account Sync Membership Implementation RD

## 1. 关联文档

- 配对 UI/UX RD：[account-sync-membership.ui-ux.md](D:/Projects/Flutter/rhythm/docs/rd/modules/account-sync-membership/account-sync-membership.ui-ux.md)
- 全局技术基线：[01-global-technical-baseline.md](D:/Projects/Flutter/rhythm/docs/rd/01-global-technical-baseline.md)

## 2. 业务能力与边界

- 业务能力：账号状态、同步状态、会员权益、付费墙、隐私与数据入口。
- 有界上下文：拥有会话、同步状态和权益承接，但不拥有主业务内容规则。

## 3. 继承的全局技术栈与模块使用说明

- 账号与同步：`supabase_flutter` 边界封装 + 同步队列仓储
- 购买：`purchases_flutter` 边界封装
- 安全：会话与敏感身份信息使用 `flutter_secure_storage`

## 4. 领域模型与应用状态

- 领域对象：会员快照、权益策略、同步队列项、账户状态摘要
- 应用状态：登录中、同步中、同步失败、购买中、恢复购买中、隐私数据操作中

## 5. 基础设施依赖与表现边界

- 依赖 Supabase 会话、购买网关、同步服务、隐私数据服务。
- 表现层不直接持有登录 SDK 或购买 SDK 实例。

## 6. API / 仓储 / 权限 / 后端协作说明

- 匿名态与登录态切换必须有统一绑定策略。
- 同步失败不得阻塞本地核心功能。
- 会员状态拉取失败时保留最近可解释状态并允许恢复购买。

## 7. 数据、安全、埋点、监控、发布与测试范围

- 数据：会话摘要、同步状态、会员快照、数据访问事件
- 安全：令牌、身份绑定和敏感状态全部走安全存储
- 埋点：登录开始/完成、同步失败/重试、付费墙曝光、购买开始/完成/取消
- 监控：会话恢复失败、购买恢复失败、同步冲突、数据清理失败
- 测试：匿名到登录绑定测试、购买恢复测试、同步失败降级测试、隐私入口测试

## 8. 模块约束

- 不允许为了商业化破坏匿名本地可用性前提。
- 不允许把同步错误包装成“数据已丢失”。
- 实现阶段在设计冻结后不得擅自改变付费墙触发语义与隐私入口层级。

## 9. 页面级状态与路由合同

- 路由入口：
  - 主导航“我的”进入账号与同步摘要页。
  - 今日页、洞察页和激活链路可深链到登录、付费墙或恢复购买入口。
- 页面状态所有权：
  - 我的页拥有账号/同步摘要与高优先恢复动作。
  - 会员页与付费墙拥有权益摘要、套餐选择与恢复购买状态。
  - 隐私页拥有导出、删除、退出登录等高风险操作确认状态。
- 返回行为：
  - 登录、恢复购买或同步修复完成后必须返回触发入口，并刷新账号/同步摘要。
  - 删除数据、退出登录等破坏性操作完成后必须给出显式结果确认并回到安全入口页。

## 10. 设计源消费与实现边界

- 实现必须直接消费 [account-sync-membership.ui-ux.md](D:/Projects/Flutter/rhythm/docs/rd/modules/account-sync-membership/account-sync-membership.ui-ux.md) 中定义的 `account_status_summary_card`、`sync_status_detail_card`、`membership_value_card`、`privacy_action_group` 组件边界。
- 账号与同步主信息必须优先映射全局冻结的 dominant/secondary/support 层级，会员价值卡只能作为次焦点承接，不能在实现中升格为首屏主英雄。
- `supabase_flutter`、`purchases_flutter`、`flutter_secure_storage` 的真实接入集中在仓储、网关与 bootstrap 层；显示层只读取账户摘要、同步摘要和权益快照，不直接处理 SDK 错误码。
