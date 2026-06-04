# profile-settings UI/UX RD

> 本文件对应 `flutter-workflow-orchestrator --auto` 的 `module_uiux_refinement` 阶段，按 `flutter-rd-module-splitter` 的细化契约由 `@superpowers` 收敛到实现前粒度；本文记录的是该阶段完成后的冻结输入。

## 模块目标与目标用户

- 模块目标：冻结账户、会员、同步、作息配置与隐私入口的分组结构，让用户“找得到、看得懂、不会被强推销”。
- 目标用户：需要查看账号状态、调整目标与提醒、处理同步问题、查看会员权益的用户。

## 页面范围与导航入口

- 我的 tab 主页面
- 账户信息区
- 会员状态区
- 数据接入状态区
- 目标作息设置区
- 提醒设置区
- 同步与隐私区
- 小组件与主题入口区

## 核心用户路径

1. 用户先看到当前身份与会员状态。
2. 再看到同步/数据接入是否健康。
3. 最后进入目标作息、提醒、隐私等具体配置。

## 状态矩阵

| 状态 | 处理 |
| --- | --- |
| anonymous | 展示稍后绑定价值 |
| signed_in | 展示账号与同步状态 |
| non_member | 展示会员价值但不压迫 |
| member_active | 展示权益摘要 |
| sync_failed | 页内提示 + 重试 |
| widget_unsupported | 说明平台限制 |

## 结构语义

- `scroll_model`: whole-page scroll
- `list_model`: grouped list
- `overlay_model`: none
- `layout_model`: linear
- `sticky_model`: none
- `component_repeatability`:
  - 会员状态卡
  - Grouped setting cell
  - 状态 tile
  - 法务 footer 链接区

## 模块级组件骨架

- `MembershipStatusCard`
- `AccountIdentityBlock`
- `SyncHealthTile`
- `SettingsSectionGroup`
- `LegalFooterLinks`

## 设计源

- 共享设计包：`docs/rd/02-shared-design-packet.md`
- 共享冻结：`docs/rd/global-design-guidelines.md`
- 模块视觉证据：`docs/rd/modules/profile-settings/profile-settings.png`
- 本模块冻结包：本文 + `profile-settings.impl.md` + 共享冻结产物 + 模块预览图

## 设计冻结卡

- 已冻结：
  - 会员入口可见但不喧宾夺主
  - 隐私与数据入口必须可被快速找到
  - 同步失败不可只在 toast 中一闪而过
- 允许工程调整：
  - section 间距与 grouped cell 具体实现
  - 法务链接排列形式

## 验收门槛

- 用户必须能在一屏内判断：我是谁、是否已同步、是否是会员。
- 作息和提醒设置入口必须比次要装饰更靠前。
- 页面不能演变成营销页。
