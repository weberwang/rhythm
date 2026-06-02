# goal_schedule 实现 RD

> 配对 UI/UX RD：`docs/rd/modules/goal_schedule/goal_schedule.ui-ux.md`
> 全局基线：`docs/rd/2026-06-02-rhythm-commercial-global-rd.md`
> 工作流状态：`modules_split`

## 1. 业务能力与边界

负责作息目标、阈值、一日开始时间、工作日规则和特殊模式入口。它不负责睡眠记录读取、周报生成或通知实际调度。

## 2. 继承包栈

- `drift`
- `freezed_annotation`
- `riverpod_annotation`
- `intl`

## 3. 领域模型

- `GoalSchedule`
- `GoalScheduleFormState`
- `LateThreshold`
- `DayStartRule`
- `SpecialScheduleMode`

所有领域实体和值对象必须可单测。

## 4. 应用状态

- 目标设置表单
- 保存中、保存成功、保存失败
- 高级模式入口状态
- 下游模块读取的当前有效目标

## 5. 存储与仓储

目标作息落 `drift`。Repository 对外暴露：

- 读取当前目标
- 保存基础目标
- 更新阈值和一天起始时间
- 读取特殊模式状态

## 6. 数据与安全

目标数据属于业务数据，不是凭据；可同步但需要保留本地优先。

## 7. 埋点

- `goal_setup_started`
- `goal_setup_completed`
- `goal_schedule_edited`
- `special_mode_entry_clicked`

## 8. 测试范围

- 表单校验
- 跨午夜目标
- 一天起始时间归属
- 保存失败提示
- 下游读取一致性

## 9. 实现约束

不得在页面层计算达标口径；目标规则必须由领域层提供，下游模块只消费稳定接口。
