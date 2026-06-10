# onboarding-activation UI/UX RD

## 文档状态

- uiux_status：`implementation_in_progress`
- 当前阶段：`implementing`

## 模块目标与目标用户

帮助首次进入用户在最少阻力下完成匿名/登录选择、健康授权、目标作息设置与提醒策略设置，快速进入可用主链路。

## 页面范围与导航入口

- 欢迎与价值承接
- 匿名 / 登录选择
- 健康授权说明与兜底路径
- 目标睡眠窗口设置
- 提醒时间与策略设置

导航入口：冷启动未完成引导的用户、设置内重新进入部分步骤的用户。

## 核心用户路径

1. 用户进入欢迎页。
2. 选择匿名继续或登录绑定。
3. 处理健康授权或跳过至手动路径。
4. 设置目标睡眠窗口与提醒时间。
5. 完成后落到 today 首页。

## 状态矩阵

| 状态 | 表现 |
| --- | --- |
| ideal | 顺滑单向分步完成 |
| loading | 登录、权限状态检查、保存目标设置 |
| empty | 初次进入即为空白初始态 |
| error | 登录失败、保存失败、授权拉起失败 |
| permission | 健康 / 通知权限拒绝或未决定 |
| partial_data | 只完成目标设置，未完成授权 |
| disabled | 下一步按钮在表单未满足前禁用 |
| success | 设置保存成功并进入主链路 |
| locked_or_premium | 不适用 |

## 结构语义

- scroll_model：`whole-page scroll`
- list_model：`static block`
- overlay_model：`modal layer`
- layout_model：`linear`
- sticky_model：`sticky footer`
- component_repeatability：
  - 步骤进度头
  - 表单行
  - 权限说明卡
  - 底部确认区

## 模块级非页面组件骨架

- `activation-step-header`
- `permission-explainer-card`
- `sleep-window-picker-row`
- `notification-time-picker-row`

每个组件都需要定义 ideal / disabled / helper / error 四类状态。

## 设计源

- 继承共享设计冻结产物
- 本模块未来应在 warm planner 体系下保持更强引导性，但不能跳成营销 onboarding
- 模块预览默认不生成，若需要真机预览必须显式 `--perviewer`

## 设计冻结卡

- 待冻结项：步骤顺序、跳过策略、权限拒绝后的兜底路径、底部确认区

## 验收门槛

- UI/UX：步骤链路可连续完成，跳过逻辑清晰
- 模块设计冻结：每一步的表单/权限状态完整
- 代码交接：引导完成标记、匿名/登录路由回流、权限结果处理清晰

## 当前已落地范围

- 已落地四步最小激活链路：欢迎与进入方式 -> 健康路径选择 -> 作息窗口设置 -> 提醒策略设置 -> 回流 today
- 已落地 sticky footer 主动作、返回动作、步骤进度条和本地草稿恢复
- 当前登录绑定、真实健康权限拉起、真实通知调度仍保留到后续 adapter 接入阶段

## 开放问题

- 登录入口是否首发只保留 Apple / Google，还是允许稍后绑定？
- 健康授权拒绝后是否需要延迟教育页，还是直接进入 today？
