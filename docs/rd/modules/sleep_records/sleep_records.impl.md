# sleep_records 实现 RD

> 配对 UI/UX RD：`docs/rd/modules/sleep_records/sleep_records.ui-ux.md`
> 全局基线：`docs/rd/2026-06-02-rhythm-commercial-global-rd.md`
> 工作流状态：`modules_split`

## 1. 业务能力与边界

负责健康数据读取、平台状态、睡眠记录标准化、有效记录、手动补录和修正。它不负责今日页布局、热力图展示或周报解释。

## 2. 继承包栈

- `health`
- `drift`
- `freezed_annotation`
- `riverpod_annotation`
- `timezone` 相关时间工具由 `core/time` 提供

## 3. 领域模型

- `SleepRecord`
- `EffectiveSleepRecord`
- `SleepRecordSource`
- `SleepRecordConfidence`
- `HealthPlatformState`
- `ManualSleepRecordFormState`

## 4. 应用状态

- 健康权限状态
- 同步中、同步成功、同步失败、无数据
- 手动补录表单
- 有效记录查询状态

## 5. 基础设施与仓储

- HealthKit / Health Connect 适配只在 data 层。
- Drift 保存原始记录、手动记录和修正信息。
- Repository 输出有效记录，不让 UI 拼接优先级。

## 6. 数据与安全

- 保留记录来源、时区和可信度。
- 用户修正优先展示，但不删除原始系统记录。
- 埋点不上传原始入睡/起床时间。

## 7. 埋点

- `health_permission_requested`
- `health_permission_granted`
- `sleep_record_synced`
- `sleep_record_sync_failed`
- `sleep_record_manual_created`
- `sleep_record_manual_edited`

## 8. 测试范围

- 平台状态映射
- 同步结果分类
- 有效记录优先级
- 跨午夜归属
- 手动补录校验
- 权限失败降级

## 9. 实现约束

不得在 presentation 直接调用 `health`；不得让 downstream 模块读取原始记录后自己判断有效记录。
