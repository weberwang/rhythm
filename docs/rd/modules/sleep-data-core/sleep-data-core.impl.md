# sleep-data-core 实现 RD

> 本文件对应 `flutter-workflow-orchestrator --auto` 的 `module_uiux_refinement` 阶段，按 `flutter-rd-module-splitter` 的细化契约由 `@superpowers` 收敛到实现前粒度；本文记录的是该阶段完成后的冻结输入。

## 文档关系

- 配对 UI/UX 文档：`docs/rd/modules/sleep-data-core/sleep-data-core.ui-ux.md`
- 继承全局基线：`docs/rd/01-global-technical-baseline.md`

## 业务能力与边界

- 负责：
  - 健康读取
  - 结构化本地存储
  - 手动补录与修正
  - 同步队列与冲突策略
  - 派生指标计算
- 不负责：
  - 任一业务页的最终显示布局

## 继承的全局包栈

- `drift`
- `health`
- `supabase_flutter`
- `flutter_secure_storage`
- `shared_preferences`
- `uuid`

## 领域模型与应用状态

- `GoalSchedule`
- `SleepRecord`
- `BedtimeSession`
- `SleepDelayTag`
- `RecoveryPlan`
- `Report`
- `SyncTask`
- `TimezoneContext`

## 数据/服务/插件边界

- `HealthDataSource`
- `SleepRecordRepository`
- `ScheduleRepository`
- `SyncQueueRepository`
- `ReportComposer`
- `RecoveryPlanEngine`

## 导航契约与交互规则

- 该模块不拥有页面导航
- 仅通过应用层状态向页面提供：
  - 数据可用性
  - 修正入口
  - 同步状态
  - 时区上下文

## 埋点、安全、监控

- 埋点：
  - `sleep_record_synced`
  - `sleep_record_manual_created`
  - `sync_retry_clicked`
- 日志脱敏：睡眠原始时间与身份凭据不进入 debug 输出

## 测试范围

- Health adapter 映射测试
- Drift schema 与 migration 测试
- 时区偏移算法测试
- 同步冲突与重试测试

## 设计冻结消费规则

- 数据来源与可信度标签是共享语义，不得各页面自行改写文案。
- 同步失败默认是“可恢复问题”，不是阻断态。

## 实施顺序

1. 建立实体、表结构与 repository 接口。
2. 接入健康读取与手动修正。
3. 建立派生指标与恢复计划引擎。
4. 接入同步队列与状态透出。
