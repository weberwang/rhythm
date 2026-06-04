# profile-settings 实现 RD

> 本文件对应 `flutter-workflow-orchestrator --auto` 的 `module_uiux_refinement` 阶段，按 `flutter-rd-module-splitter` 的细化契约由 `@superpowers` 收敛到实现前粒度；本文记录的是该阶段完成后的冻结输入。

## 文档关系

- 配对 UI/UX 文档：`docs/rd/modules/profile-settings/profile-settings.ui-ux.md`
- 继承全局基线：`docs/rd/01-global-technical-baseline.md`

## 业务能力与边界

- 负责：
  - 账号信息展示
  - 会员状态展示与恢复购买入口
  - 同步与隐私入口
  - 目标作息与提醒设置入口
  - 小组件与主题入口
- 不负责：
  - 引导期登录主流程

## 继承的全局包栈

- `hooks_riverpod`
- `supabase_flutter`
- `purchases_flutter`
- `home_widget`
- `package_info_plus`

## 领域模型与应用状态

- `ProfileSettingsSnapshot`
- `AccountState`
- `MembershipState`
- `SyncHealthState`
- `ReminderSettingsSummary`

## 数据/服务/插件边界

- 账号信息来自 account gateway
- 会员状态来自 membership gateway
- 同步健康度来自 sync service
- 设置入口调用 `GoalScheduleRepository` 与通知设置服务

## 导航契约与交互规则

- 目标作息与提醒建议进入专门编辑页或 bottom sheet
- 会员卡入口进入 paywall / restore purchase
- 隐私与数据导出入口必须保留返回链路

## 埋点、安全、监控

- 埋点：
  - `profile_viewed`
  - `membership_entry_clicked`
  - `sync_retry_clicked`
  - `goal_settings_opened`

## 测试范围

- 匿名/登录状态分支测试
- 会员状态切换测试
- 同步错误重试测试
- 设置入口导航测试

## 设计冻结消费规则

- 不得把 profile 页的会员入口升级为强制全屏营销主视觉。
- 同步与隐私入口必须保留清晰的 grouped 信息架构。

## 实施顺序

1. 聚合 profile snapshot。
2. 落账户/会员/同步三块上半屏。
3. 落 grouped settings sections。
4. 接入真实会员与同步状态。
