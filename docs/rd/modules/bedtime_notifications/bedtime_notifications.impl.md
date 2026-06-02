# bedtime_notifications 实现 RD

> 配对 UI/UX RD：`docs/rd/modules/bedtime_notifications/bedtime_notifications.ui-ux.md`
> 全局基线：`docs/rd/2026-06-02-rhythm-commercial-global-rd.md`
> 工作流状态：`modules_split`

## 1. 业务能力与边界

负责睡前会话、提醒策略、本地通知调度、通知打开入口和睡前动作建议。不负责次日结果计算或周报生成。

## 2. 继承包栈

- `flutter_local_notifications`
- `timezone`
- `flutter_timezone`
- `riverpod_annotation`
- `freezed_annotation`

## 3. 领域模型

- `BedtimeSession`
- `BedtimeStatus`
- `BedtimeAction`
- `BedtimeReminderPlan`
- `NotificationOpenSource`
- `ReminderSettingsState`

## 4. 应用状态

- 当前目标读取状态
- 距离目标时间
- 状态选择
- 动作建议
- 通知权限和调度结果
- 通知入口 payload 解析

## 5. 基础设施边界

- 通知插件封装为 Gateway。
- 时区读取集中在 data/core 边界。
- 入口解析交给应用层 Controller，不在平台回调直接跳页面。

## 6. 数据与安全

通知内容不展示过细健康数据。提醒计划基于目标时间，不基于固定系统时间。

## 7. 埋点

- `bedtime_mode_entered`
- `bedtime_status_selected`
- `bedtime_action_clicked`
- `notification_opened`
- `reminder_setup_completed`
- `reminder_schedule_failed`

## 8. 测试范围

- 三种睡前状态
- 动作建议规则
- 通知调度成功与失败
- 通知点击路由
- 无目标降级
- 时区读取失败降级

## 9. 实现约束

通知、时区和平台入口不得散落在页面层。若改变提醒策略默认值，必须回到 PRD 或设计冻结确认。
