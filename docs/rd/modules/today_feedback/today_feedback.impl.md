# today_feedback 实现 RD

> 配对 UI/UX RD：`docs/rd/modules/today_feedback/today_feedback.ui-ux.md`
> 全局基线：`docs/rd/2026-06-02-rhythm-commercial-global-rd.md`
> 工作流状态：`modules_split`

## 1. 业务能力与边界

负责聚合目标、有效睡眠记录、标签状态、恢复摘要和睡前入口，形成今日页 ViewState。不负责底层记录读取、周报生成或会员购买。

## 2. 继承包栈

- `hooks_riverpod`
- `riverpod_annotation`
- `freezed_annotation`
- `intl`

## 3. 领域与应用模型

- `TodaySummary`
- `TodayPrimaryAction`
- `TodayViewState`
- `TodayRecoveryPreview`
- `TodayTrendPoint`

## 4. 应用状态

从以下模块读取：

- `goal_schedule` 当前目标
- `sleep_records` 有效记录
- `calendar_tags` 原因标签状态
- `insights_recovery` 恢复摘要
- `membership_paywall` 付费入口策略

## 5. 基础设施边界

Today 不直接访问 Drift 或 Health SDK。所有数据通过应用层 Provider 和 Repository 抽象进入。

## 6. 数据与安全

今日页可展示用户可见的摘要数据，但埋点只记录状态类别和动作，不记录原始睡眠时间。

## 7. 埋点

- `today_viewed`
- `today_primary_action_clicked`
- `delay_tag_entry_clicked`
- `manual_record_entry_clicked`
- `recovery_plan_entry_clicked`

## 8. 测试范围

- 无目标
- 未授权
- 无数据
- 达标
- 轻微偏离
- 明显晚睡
- 恢复建议入口
- 付费锁定入口

## 9. 实现约束

不得在页面层拼接业务规则。若 UI 需要新摘要字段，先更新应用层 ViewState，再由页面消费。
