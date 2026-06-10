# onboarding-activation Implementation RD

## 文档状态

- impl_status：`split_draft`
- superpowers_refinement_status：`not_executed`

## 关联文档

- 配对 UI/UX：[onboarding-activation.ui-ux.md](/E:/Projects/flutter/rhythm/docs/project/modules/onboarding-activation/onboarding-activation.ui-ux.md)
- 全局技术基线：[global-technical-baseline.md](/E:/Projects/flutter/rhythm/docs/project/rd/global-technical-baseline.md)

## 业务能力与边界

负责首次激活流程，不拥有长期睡眠数据，但拥有首次目标设置、授权状态确认、提醒初始化和匿名/登录升级触发。

## 包栈与模块说明

- `go_router`：步骤流与完成回流
- `hooks_riverpod`：步骤状态、表单状态、权限状态
- `health`、`flutter_local_notifications`：只通过 adapter 触发请求
- `shared_preferences`：引导完成标记

## 分层边界

- domain：目标睡眠窗口值对象、提醒偏好值对象
- application：步骤流编排、提交、跳过逻辑
- data：权限桥接、引导标记存取、登录入口桥接
- presentation：分步页面、底部操作区、错误提示

## 数据、权限与依赖

- 依赖 `app-shell` 提供完成后回流 today 的 root 路由
- 可向 `sleep-data-core` 写入初始目标与提醒配置
- 权限状态应统一通过 `core/permissions` 转换

## 埋点与测试

- 埋点：`onboarding_started`、`goal_setup_completed`、`health_permission_granted`、`health_permission_skipped`
- 测试：步骤跳转、保存恢复、授权拒绝兜底、登录失败回退

## 模块约束

- 不得直接持有第三方登录或 health SDK 实例到 UI 层
- 不得把登录逻辑与目标设置逻辑耦合成单个控制器
- 引导完成后必须可重放局部设置步骤

## 风险与开放问题

- 匿名升级登录时是否要在 onboarding 内完成账号合并提示
- 通知权限是否首发强引导，还是只作为可选增强
