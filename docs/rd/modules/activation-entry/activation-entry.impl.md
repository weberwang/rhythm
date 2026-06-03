# Activation Entry Implementation RD

## 1. 关联文档

- 配对 UI/UX RD：[activation-entry.ui-ux.md](D:/Projects/Flutter/rhythm/docs/rd/modules/activation-entry/activation-entry.ui-ux.md)
- 全局技术基线：[01-global-technical-baseline.md](D:/Projects/Flutter/rhythm/docs/rd/01-global-technical-baseline.md)

## 2. 业务能力与边界

- 业务能力：启动分发、首启激活、登录/匿名进入编排、健康权限引导、完成态交接。
- 有界上下文：只拥有激活流程和首轮草稿，不拥有长期作息规则、历史记录或会员权益结算。

## 3. 继承的全局技术栈与模块使用说明

- 状态：`hooks_riverpod` + `@riverpod`，负责首开状态与引导草稿编排。
- 路由：`GoRouter` 的 `/launch` 与 onboarding 页面族。
- 本地存储：`SharedPreferences` 保存首启完成态，`flutter_secure_storage` 保存敏感身份绑定前置信息。
- 权限：健康权限只经数据网关触发，不在页面直接操作平台 API。

## 4. 领域模型与应用状态

- 领域对象：`LaunchState`、`OnboardingDraft`
- 应用状态：首开判断、登录选择态、权限引导态、进入主应用的交接态

## 5. 基础设施依赖与表现边界

- 依赖 `account-sync-membership` 提供登录入口与匿名/登录语义。
- 依赖 `schedule-reminders` 提供首轮目标与提醒输入承接。
- 表现层只承载激活决策与入口编排，不承载长期业务实体写入规则。

## 6. API / 仓储 / 权限 / 后端协作说明

- 登录入口统一通过账号网关调用，不在本模块散落第三方登录 SDK。
- 健康权限请求通过 `sleep-records` 相关权限网关发起。
- 若匿名可用，需保存匿名本地态并为未来绑定账号留桥接点。

## 7. 数据、安全、埋点、监控、发布与测试范围

- 数据：首轮配置草稿与完成态最小持久化。
- 安全：不在普通偏好中存储敏感登录票据。
- 埋点：`app_open`、`onboarding_started`、`signup_started`、`signup_completed`、`onboarding_completed`
- 监控：启动分发失败、登录失败、授权失败需可分类。
- 测试：启动守卫测试、匿名与登录路径测试、权限拒绝降级测试。

## 8. 模块约束

- 不允许把首轮激活页变成会员承接页。
- 不允许在本模块内固化长期作息或同步策略。
- 实现阶段在设计冻结后不得擅自改变入口层级与激活顺序。

## 9. 页面级状态与路由合同

- 路由入口：
  - `/launch` 负责启动分发与回流判断。
  - `activation-entry` 页面族只承载欢迎、登录、权限与完成交接，不承载主应用长期导航。
- 页面状态所有权：
  - 欢迎页拥有价值承诺展示态与继续动作。
  - 登录页拥有登录方式选择、失败恢复和匿名继续提示态。
  - 权限页拥有授权解释、拒绝降级和继续进入主链路的状态。
  - 完成交接页拥有首轮草稿摘要与进入首页前的轻确认。
- 返回行为：
  - 启动分发阶段禁止回到空白页；只能回到上一步激活节点或退出应用流程。
  - 激活完成后进入首页时必须携带匿名/登录身份、权限结果和首轮草稿摘要。

## 10. 设计源消费与实现边界

- 实现必须直接消费 [activation-entry.ui-ux.md](D:/Projects/Flutter/rhythm/docs/rd/modules/activation-entry/activation-entry.ui-ux.md) 中定义的 `onboarding_value_hero_card`、`sign_in_method_stack`、`permission_benefit_card`、`activation_handoff_note` 组件边界，不得在页面实现阶段重新发明第二套首启骨架。
- 首启显示层必须继承 [global-design-guidelines.md](D:/Projects/Flutter/rhythm/docs/rd/global-design-guidelines.md)、[light-theme-freeze.yaml](D:/Projects/Flutter/rhythm/docs/rd/light-theme-freeze.yaml)、[dark-theme-freeze.yaml](D:/Projects/Flutter/rhythm/docs/rd/dark-theme-freeze.yaml) 的单主焦点、按钮主次、权限语气和卡片边界规则。
- `google_sign_in`、`sign_in_with_apple`、健康权限桥接与匿名绑定只允许在 `data` 与网关边界落地；显示层只消费可解释的业务状态，不直接持有三方 SDK 类型或权限返回对象。
