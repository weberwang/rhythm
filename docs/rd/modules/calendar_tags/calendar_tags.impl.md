# calendar_tags 实现 RD

> 配对 UI/UX RD：`docs/rd/modules/calendar_tags/calendar_tags.ui-ux.md`
> 全局基线：`docs/rd/2026-06-02-rhythm-commercial-global-rd.md`
> 工作流状态：`modules_split`

## 1. 业务能力与边界

负责月历热力图规则、单日摘要、原因标签规则和标签弹层状态。不负责健康数据读取、周报生成或付费购买。

## 2. 继承包栈

- `drift`
- `collection`
- `freezed_annotation`
- `riverpod_annotation`

## 3. 领域模型

- `CalendarHeatLevel`
- `CalendarDaySummary`
- `CalendarMonthSummary`
- `CalendarFilter`
- `SleepDelayTag`
- `SleepDelayTagSnapshot`
- `SleepDelayTagValidationError`

## 4. 应用状态

- 当前月份
- 月度摘要
- 选中日期
- 单日详情
- 标签选择与保存状态
- 历史锁定状态

## 5. 基础设施与仓储

从 `sleep_records` 读取有效记录，从 `goal_schedule` 读取目标基准，标签仓储落 Drift。

## 6. 数据与安全

标签属于用户行为数据，可同步但不应用于医疗推断。自定义标签需要长度和敏感文案限制。

## 7. 埋点

- `calendar_viewed`
- `day_detail_viewed`
- `delay_tag_added`
- `custom_delay_tag_created`
- `calendar_history_locked_clicked`

## 8. 测试范围

- 热力等级规则
- 月度摘要
- 缺失数据
- 标签校验
- 标签保存
- 历史锁定策略

## 9. 实现约束

日历展示只消费有效记录，不直接读取健康原始记录。标签文案展示由国际化资源解析。
