# Schedule Reminders Implementation RD

## 1. 关联文档

- 配对 UI/UX RD：[schedule-reminders.ui-ux.md](D:/Projects/Flutter/rhythm/docs/rd/modules/schedule-reminders/schedule-reminders.ui-ux.md)
- 全局技术基线：[01-global-technical-baseline.md](D:/Projects/Flutter/rhythm/docs/rd/01-global-technical-baseline.md)

## 2. 业务能力与边界

- 业务能力：目标作息、熬夜阈值、一天起始时间、时区模式、提醒策略设置。
- 有界上下文：本模块拥有时间基准与提醒设置，不拥有睡眠结果和周报解释。

## 3. 继承的全局技术栈与模块使用说明

- 状态：`@riverpod` 表单控制器与设置读取 provider。
- 存储：`Drift` 或稳定设置仓储持久化结构化计划，轻量偏好落 `SharedPreferences`。
- 时区与提醒：`flutter_timezone` + `timezone` + `flutter_local_notifications`

## 4. 领域模型与应用状态

- 领域对象：`GoalSchedule`、`GoalScheduleFormState`、`ReminderSettingsState`
- 应用状态：表单草稿、保存中、保存失败、通知权限解释、时区切换提示

## 5. 基础设施依赖与表现边界

- 依赖本地设置仓储与通知调度网关。
- 表现层负责引导输入和状态提示，不负责直接计算通知调度细节。

## 6. API / 仓储 / 权限 / 后端协作说明

- 作息设置本地为主，云同步为增强。
- 通知权限缺失不阻塞本地保存，但影响调度落地。
- 时区策略必须保留可计算字段与显示语义。

## 7. 数据、安全、埋点、监控、发布与测试范围

- 数据：目标作息设置、提醒策略、时区模式
- 安全：无高敏数据，但修改需保留一致性
- 埋点：`goal_setup_started`、`goal_setup_completed`、`reminder_setup_completed`
- 监控：通知调度失败、时区读取失败、设置保存失败
- 测试：规则计算测试、表单保存测试、权限降级测试、时区模式测试

## 8. 模块约束

- 不允许在其他模块重复定义“晚睡阈值”规则。
- 高级模式是否开放只能通过显式能力边界控制，不能散落隐藏开关。
- 实现阶段在设计冻结后不得擅自改变字段优先级和默认值策略。

## 9. 页面级状态与路由合同

- 路由入口：
  - `activation-entry` 首轮激活链路内嵌进入。
  - `today-feedback` 与 `account-sync-membership` 通过设置入口二次进入。
- 页面状态所有权：
  - 目标时间页拥有 `GoalScheduleFormState` 草稿与推荐值回填。
  - 提醒策略页拥有提醒模式、权限收益说明与保存前校验状态。
  - 时区模式页拥有时区跟随策略、切换解释和保存后的调度重建提示。
- 返回行为：
  - 未保存变更时必须给出轻量离开确认，防止用户误丢草稿。
  - 保存成功后返回上游页面时，需要携带最新目标时间摘要，供首页、小组件和睡前页立即复用。

## 10. 设计源消费与实现边界

- 实现必须直接消费 [schedule-reminders.ui-ux.md](D:/Projects/Flutter/rhythm/docs/rd/modules/schedule-reminders/schedule-reminders.ui-ux.md) 中定义的 `goal_time_pair_card`、`reminder_strategy_option_card`、`timezone_explainer_card`、`schedule_support_note` 组件边界，不得在页面实现阶段重新发明第二套相似组件。
- 视觉层必须对齐以下冻结证据：
  - [schedule-reminders-overview.png](D:/Projects/Flutter/rhythm/output/imagegen/schedule-reminders-overview.png)
  - [schedule-reminders-goal-detail.png](D:/Projects/Flutter/rhythm/output/imagegen/schedule-reminders-goal-detail.png)
  - [schedule-reminders-reminder-dark.png](D:/Projects/Flutter/rhythm/output/imagegen/schedule-reminders-reminder-dark.png)
- 深浅主题的颜色、边框和 CTA 对比必须来自全局冻结文件映射，不能在本模块临时重算。
- `flutter_local_notifications`、`flutter_timezone`、`timezone` 的真实能力接入集中在 `data` 与 `app/bootstrap` 边界层处理；显示层只消费已经解释过的业务状态，不直接触碰插件返回值。
