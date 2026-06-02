# Sleep Records Implementation RD

## 1. 关联文档

- 配对 UI/UX RD：[sleep-records.ui-ux.md](D:/Projects/Flutter/rhythm/docs/rd/modules/sleep-records/sleep-records.ui-ux.md)
- 全局技术基线：[01-global-technical-baseline.md](D:/Projects/Flutter/rhythm/docs/rd/01-global-technical-baseline.md)

## 2. 业务能力与边界

- 业务能力：自动读取、手动补录、来源可信度、记录修正、晚睡原因标签。
- 有界上下文：本模块拥有原始记录与修正语义，是今日、日历、洞察的主数据提供方。

## 3. 继承的全局技术栈与模块使用说明

- 存储：`Drift` 作为主存储，支持按日查询、筛选、聚合与同步对账。
- 插件：`health` 通过数据源网关接入；权限网关单独封装。
- 模型：`freezed` + `json_serializable`

## 4. 领域模型与应用状态

- 领域对象：`SleepRecord`、`EffectiveSleepRecord`、`SleepDelayTag`、`HealthPlatformState`
- 应用状态：同步中、同步失败、补录中、修正中、标签提交中

## 5. 基础设施依赖与表现边界

- 依赖健康数据客户端、本地数据库、同步队列接口。
- 表现层只展示记录与操作入口，不直接调用平台健康 SDK。

## 6. API / 仓储 / 权限 / 后端协作说明

- 自动记录与手动补录都需落成统一内部记录模型。
- 同步时要保留来源、可信度、修正标记和更新时间。
- 权限拒绝、数据为空、数据延迟要映射为可展示业务状态。

## 7. 数据、安全、埋点、监控、发布与测试范围

- 数据：原始记录、有效记录、标签、来源、修正状态
- 安全：健康原始数据最小化持久化，不泄露完整载荷到日志
- 埋点：`health_permission_requested`、`health_permission_granted`、`sleep_record_synced`、`sleep_record_manual_created`、`delay_tag_added`
- 监控：同步异常、补录失败、标签失败、权限异常
- 测试：记录规则测试、补录测试、同步降级测试、来源可信度展示测试

## 8. 模块约束

- 不允许把平台异常原样向上透传到页面。
- 不允许静默覆盖原始记录来源或删除修正痕迹。
- 实现阶段在设计冻结后不得擅自改变补录与修正的主要入口层级。
