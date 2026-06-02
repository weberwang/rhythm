# membership_paywall 实现 RD

> 配对 UI/UX RD：`docs/rd/modules/membership_paywall/membership_paywall.ui-ux.md`
> 全局基线：`docs/rd/2026-06-02-rhythm-commercial-global-rd.md`
> 工作流状态：`modules_split`

## 1. 业务能力与边界

负责会员权益、付费墙策略、订阅状态读取、购买和恢复购买。不负责洞察、历史或恢复计划本身的业务规则。

## 2. 继承包栈

- `purchases_flutter`
- `freezed_annotation`
- `riverpod_annotation`

## 3. 领域模型

- `MembershipEntitlement`
- `MembershipTier`
- `MembershipSnapshot`
- `MembershipPaywallPolicy`
- `PaywallEntryContext`

## 4. 应用状态

- 免费用户
- 试用用户
- 月付、年付、永久会员
- 权益读取失败
- 购买中
- 购买失败
- 恢复购买成功或失败

## 5. 基础设施边界

- Purchases SDK 封装在 data 层。
- Repository 将 Purchases 类型转换为项目内部模型。
- 页面只消费 `MembershipViewState`。

## 6. 数据与安全

订阅状态可同步；购买失败原因不记录敏感支付细节。会员状态跨设备同步时以远端/SDK 权益为准。

## 7. 埋点

- `paywall_viewed`
- `paywall_source_clicked`
- `trial_started`
- `subscription_purchased`
- `subscription_restore_clicked`
- `subscription_purchase_failed`

## 8. 测试范围

- 免费用户受限
- 会员用户放行
- 首次核心体验不强拦
- 购买失败
- 恢复购买
- 权益读取失败降级

## 9. 实现约束

付费策略必须集中在 `MembershipPaywallPolicy`，不得在各页面手写付费判断。
