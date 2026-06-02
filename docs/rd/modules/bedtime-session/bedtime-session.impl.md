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
