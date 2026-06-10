# onboarding-activation Implementation RD

## 文档状态

- impl_status：`implementation_in_progress`
- superpowers_refinement_status：`deferred_then_minimal_landed`

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

## 当前已落地实现

- `presentation/`：已从单欢迎页扩展为四步激活流，包含步骤头、选择卡、作息窗口和提醒节奏设置
- `application/`：已使用生成式 Riverpod controller 承接步骤切换、返回、完成提交和本地恢复
- `infrastructure/`：已新增基于 `shared_preferences` 的草稿状态存储，保存当前步骤、进入方式、健康路径、作息时间和提醒策略
- `infrastructure/`：已新增 `health` 权限桥接与 `flutter_local_notifications + timezone + flutter_timezone` 提醒调度桥接；当前策略为“真实调用、失败降级但不阻断进入 today”
- `app-shell` 协作：完成后仍统一写入 onboarding 完成标记并回流 `/today`

## 埋点与测试

- 埋点：`onboarding_started`、`goal_setup_completed`、`health_permission_granted`、`health_permission_skipped`
- 测试：步骤跳转、保存恢复、授权拒绝兜底、登录失败回退

当前验证：

- `dart analyze lib test integration_test` 通过
- `test/features/onboarding_activation/presentation/onboarding_activation_page_test.dart` 通过
- `integration_test/app_shell_bootstrap_test.dart` 已在 Android 模拟器 `emulator-5554 / API 35` 上通过

当前仍未落地：

- 真实 Google / Apple / Supabase 绑定入口
- 向 `sleep-data-core` 写入初始目标与提醒配置
- 权限拒绝后的延迟教育页与更细粒度权限状态机

## 模块约束

- 不得直接持有第三方登录或 health SDK 实例到 UI 层
- 不得把登录逻辑与目标设置逻辑耦合成单个控制器
- 引导完成后必须可重放局部设置步骤

## 风险与开放问题

- 匿名升级登录时是否要在 onboarding 内完成账号合并提示
- 通知权限是否首发强引导，还是只作为可选增强
