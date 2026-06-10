# profile-settings UI/UX RD

## 文档状态

- uiux_status：`split_draft`
- 当前阶段：`modules_split`

## 模块目标与目标用户

提供账户、同步、隐私、通知、小组件、订阅等系统级管理入口，面向需要查看状态、修正设置或管理账号的用户。

## 页面范围与导航入口

- 我的 / 个人主页
- 账户与同步设置
- 通知设置
- 小组件设置
- 隐私、导出与删除
- 订阅与恢复购买

导航入口：底部 tab、洞察 / today 中的账户相关跳转。

## 核心用户路径

1. 用户进入 profile-settings。
2. 查看当前账号、同步、通知和订阅状态。
3. 修改某一项设置或执行恢复购买、导出、删除动作。

## 状态矩阵

| 状态 | 表现 |
| --- | --- |
| ideal | 设置分组清晰可读 |
| loading | 设置列表骨架、账户状态骨架 |
| empty | 匿名状态下显示最小账户信息 |
| error | 同步失败、恢复购买失败、导出失败 |
| permission | 通知 / widget 权限未开放 |
| partial_data | 只有本地状态，云端状态未同步 |
| disabled | 某些设置当前不可改 |
| success | 同步完成、恢复购买成功 |
| locked_or_premium | 订阅权益入口、付费状态 |

## 结构语义

- scroll_model：`whole-page scroll`
- list_model：`grouped list`
- overlay_model：`modal layer`
- layout_model：`linear`
- sticky_model：`none`
- component_repeatability：
  - settings group
  - settings row
  - account status card
  - subscription status card

## 模块级非页面组件骨架

- `settings-group-card`
- `settings-row`
- `account-state-banner`
- `subscription-state-card`

## 设计源

- 继承共享冻结
- settings 页面可以更工具化，但不能掉出 warm planner 体系
- 模块预览默认不生成

## 设计冻结卡

- 待冻结项：设置分组、状态反馈、危险动作区、订阅状态区

## 验收门槛

- UI/UX：设置分组清楚、状态反馈直接、危险动作不误触
- 模块设计冻结：账户、同步、通知、订阅几组信息语义明确
- 代码交接：auth、sync、widget、notification、purchase 边界明确

## 开放问题

- 删除数据是否需要单独确认流程和二次验证？
- 小组件设置是否留在 profile-settings，还是拆为独立系统页面？
