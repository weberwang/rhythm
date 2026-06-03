# Bedtime Session Implementation RD

## 1. 关联文档

- 配对 UI/UX RD：[bedtime-session.ui-ux.md](D:/Projects/Flutter/rhythm/docs/rd/modules/bedtime-session/bedtime-session.ui-ux.md)
- 全局技术基线：[01-global-technical-baseline.md](D:/Projects/Flutter/rhythm/docs/rd/01-global-technical-baseline.md)

## 2. 业务能力与边界

- 业务能力：睡前进入、倒计时、今晚状态、动作建议、执行会话记录。
- 有界上下文：拥有夜间会话过程，但不拥有历史记录仓储和长期恢复分析。

## 3. 继承的全局技术栈与模块使用说明

- 状态：`BedtimeController` 类似的应用状态聚合
- 时间基准：完全继承 `schedule-reminders` 的目标时间与阈值
- 平台入口：接受通知、小组件、首页入口来源

## 4. 领域模型与应用状态

- 领域对象：`BedtimeSession`、`BedtimeStatus`、`BedtimeAction`
- 应用状态：当前倒计时、进入来源、建议动作、提交结果

## 5. 基础设施依赖与表现边界

- 依赖作息设置仓储、通知入口控制器、小组件入口来源桥接。
- 表现层负责夜间低刺激呈现，不直接计算全部行为建议规则。

## 6. API / 仓储 / 权限 / 后端协作说明

- 会话结果默认先本地落库，再决定是否同步增强。
- 若从通知或小组件进入，必须保留来源以支持埋点和回流分析。

## 7. 数据、安全、埋点、监控、发布与测试范围

- 数据：睡前会话、状态选择、建议动作点击
- 安全：无高敏数据，但要控制夜间入口参数完整性
- 埋点：`bedtime_mode_entered`、`bedtime_status_selected`、`bedtime_action_clicked`
- 监控：会话保存失败、入口参数异常、时间基准缺失
- 测试：时间差计算、入口来源测试、夜间主路径测试

## 8. 模块约束

- 不允许把睡前页扩展成复杂任务清单。
- 不允许在本模块重写目标时间基准或标签规则。
- 实现阶段在设计冻结后不得擅自增加需要高认知负担的交互。

## 9. 页面级状态与路由合同

- 路由入口：
  - 通知、小组件和今日页主动作都可进入睡前页。
  - 倒计时、状态选择和动作建议属于同一模块内部状态流，不拆成跨模块页面所有权。
- 页面状态所有权：
  - 睡前页拥有倒计时主卡、今晚状态选择和当前唯一动作状态。
  - 退出确认层拥有中断确认、草稿保留和回流说明状态。
  - 次级编辑入口只承接作息设置深链，不在本模块重算规则。
- 返回行为：
  - 完成动作或退出会话后必须返回触发来源，并保留来源标记用于首页或埋点回流。
  - 通知与桌面入口回流时必须恢复正确夜间上下文，而不是落到普通首页。

## 10. 设计源消费与实现边界

- 实现必须直接消费 [bedtime-session.ui-ux.md](D:/Projects/Flutter/rhythm/docs/rd/modules/bedtime-session/bedtime-session.ui-ux.md) 中定义的 `bedtime_countdown_hero_card`、`tonight_state_choice_strip`、`bedtime_action_card`、`bedtime_exit_confirm_sheet` 组件边界。
- 夜间显示层必须保留单一倒计时主焦点、低刺激动作卡和克制确认语气，禁止在实现中扩张成任务面板或效率清单。
- 通知入口、小组件来源桥接和夜间会话持久化只允许在应用层与数据层落地；显示层只消费时间差、来源语义和动作结果状态。
