# sleep-data-core Implementation RD

## 文档状态

- impl_status：`split_draft`
- superpowers_refinement_status：`not_executed`

## 关联文档

- 配对 UI/UX：[sleep-data-core.ui-ux.md](/E:/Projects/flutter/rhythm/docs/project/modules/sleep-data-core/sleep-data-core.ui-ux.md)
- 全局技术基线：[global-technical-baseline.md](/E:/Projects/flutter/rhythm/docs/project/rd/global-technical-baseline.md)

## 业务能力与边界

这是睡眠记录的 bounded context，拥有统一睡眠记录模型、来源标记、补录修正、基础聚合、同步桥与节律计算基础。

## 包栈与模块说明

- `drift`：本地记录主存储、同步队列
- `health`：系统健康数据读取 adapter
- `uuid`：本地记录和同步任务标识
- `supabase_flutter`：后续业务快照同步桥

## 分层边界

- domain：睡眠记录实体、来源类型、补录规则、节律计算规则
- application：读取、修正、同步编排
- data：health datasource、drift repository、remote sync gateway
- presentation：补录页、来源说明、数据异常提示

## 数据与依赖

- 为 `today`、`calendar`、`insights` 暴露统一 repository 接口
- 为 `profile-settings` 提供同步状态与删除导出能力接口
- 与 `onboarding-activation` 共享目标窗口配置但不拥有其 UI

## 安全、埋点、测试

- 安全：健康原始数据最小化上云，敏感字段脱敏
- 埋点：`sleep_record_synced`、`manual_sleep_record_created`、`sleep_source_conflict_detected`
- 测试：
  - drift 查询与迁移
  - 来源合并与冲突处理
  - 补录校验
  - 同步队列重试

## 模块约束

- 不允许其他模块直接接 `health` 包
- 不允许 UI 层直接操作 drift 表
- 任何来源冲突解释都必须先映射到内部失败 / 状态模型

## 风险与开放问题

- 不同平台健康数据精度与字段缺失差异
- 手动补录与自动记录合并策略是否需要更细的优先级规则
