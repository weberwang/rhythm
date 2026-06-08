# sleep-data-core 实现 RD

> 产物类型：`module_impl_rd`
> 模块：`sleep-data-core`
> 文档成熟度：`split_draft`
> 日期：`2026-06-08`

## 1. 关联引用

- 配对 UI/UX RD：`docs/rd/modules/sleep-data-core/sleep-data-core.ui-ux.md`
- 全局技术基线：`docs/rd/global-technical-baseline.md`

## 2. 业务能力与边界上下文

`sleep-data-core` 是业务数据底座，负责记录、目标、提醒、权限、恢复基础能力与状态口径统一。  
它不负责顶层页面结构，也不负责会员视觉承接。

## 3. 继承的全局包栈与模块用法

- `drift`：结构化业务数据存储
- `health`：健康数据读取与权限
- `flutter_local_notifications` + `timezone` + `flutter_timezone`：提醒计划与调度基础
- `shared_preferences`：轻量首选项
- `flutter_secure_storage`：敏感身份或会话关联键
- `uuid`：本地实体标识
- `freezed` / `json_annotation`：领域模型与 DTO

## 4. 领域模型与应用状态

- 领域模型：
  - `GoalSchedule`
  - `SleepRecord`
  - `BedtimeSession`
  - `SleepDelayTag`
  - `RecoveryPlan`
  - `NotificationSetting`
  - `SyncQueue`
- 应用状态：
  - 记录读取状态
  - 权限状态
  - 同步状态
  - 补录/修正表单状态
  - 恢复计划计算状态

## 5. 基础设施依赖与展示边界

- 基础设施依赖：
  - 本地数据库
  - 健康数据网关
  - 通知调度服务
  - 可选云同步边界
- 展示边界：
  - 通过 repository / service 暴露给 feature
  - 不允许 UI 直接持有插件实例

## 6. 模块级组件实现说明

- UI/UX RD 中定义的来源标签、可信提示、补录表单与修正表单，都应基于统一的内部模型供给，不允许每页自行拼接字段。
- 恢复计划的基础数据与结果口径应由该模块提供，下游页面只负责展示。

## 7. API、存储、权限与后端协作

- 存储：
  - `drift` 保存目标、记录、提醒、恢复、同步队列
- 权限：
  - 健康权限与通知权限集中检查与映射
- 后端协作：
  - 可选同步时仅暴露归一后的 DTO
- 重点：
  - 自动数据不可静默覆盖手动修正

## 8. 数据、安全、埋点、监控、测试范围

- 数据：
  - 统一 UTC / 本地时区记录规范
  - 保留来源链路
- 安全：
  - 敏感会话与身份关系进入安全存储
  - 日志不打印原始敏感睡眠明细
- 埋点：
  - `sleep_record_synced`
  - `sleep_record_manual_created`
  - `delay_tag_added`
- 监控：
  - 健康读取失败
  - 提醒调度失败
  - 同步失败
- 测试：
  - repository 规则测试
  - 权限降级测试
  - 时间计算与提醒测试

## 9. 实现顺序与依赖说明

- 与 `app-shell` 同属基础阶段
- 先于所有 feature 页面模块
- 解锁 `onboarding-activation`、`today`、`bedtime`、`calendar`、`insights`、`profile-settings`

## 10. 模块特定实现约束

- 不得让业务页面直接依赖 `health`、通知或同步 SDK。
- 不得为旧路径兼容引入双重记录口径。
- 不得把会员锁定逻辑写成底层数据判断之外的散落 UI 分支。

## 11. 细化执行溯源

- `superpowers_refinement_status`: `not_executed`
- `superpowers_refinement_notes`: `当前文档为初始模块拆分草案，尚未经过模块级 @superpowers 细化执行`

## 12. 开放问题

- 轮班/时差策略是否进入首发，将影响目标与提醒的数据结构。
- 云同步首发范围是否仅备份基础数据，仍需业务确认。
