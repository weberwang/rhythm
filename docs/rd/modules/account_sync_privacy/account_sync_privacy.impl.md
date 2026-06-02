# account_sync_privacy 实现 RD

> 配对 UI/UX RD：`docs/rd/modules/account_sync_privacy/account_sync_privacy.ui-ux.md`
> 全局基线：`docs/rd/2026-06-02-rhythm-commercial-global-rd.md`
> 工作流状态：`modules_split`

## 1. 业务能力与边界

负责账号绑定、同步队列、冲突策略、隐私数据控制和同步状态展示。不负责会员购买，也不直接生成业务报告。

## 2. 继承包栈

- `supabase_flutter`
- `flutter_secure_storage`
- `drift`
- `riverpod_annotation`
- `freezed_annotation`

## 3. 领域模型

- `SyncQueueItem`
- `SyncEntityType`
- `SyncOperation`
- `SyncRunSummary`
- `SyncConflictPolicy`
- `AccountSyncViewState`
- `PrivacyExportAction`

## 4. 应用状态

- 未登录
- 已登录
- 同步中
- 同步失败
- 本地待同步
- 冲突处理
- 数据导出或删除确认

## 5. 基础设施与接口

- Supabase 初始化在 app/bootstrap。
- SyncService 读取本地队列并与远端同步。
- Token 和敏感会话存 secure storage。
- 远端错误映射为项目内部错误。

## 6. 数据与安全

- 用户编辑优先于远端覆盖。
- 隐私操作需要明确日志脱敏。
- 删除账号、清空本地和数据导出必须区分。

## 7. 埋点

- `sync_started`
- `sync_completed`
- `sync_failed`
- `account_bound`
- `privacy_data_export_clicked`
- `account_delete_clicked`

## 8. 测试范围

- 未登录不触发云同步
- 成功同步
- 网络失败保留队列
- 冲突策略
- 删除/导出确认
- 同步失败重试

## 9. 实现约束

presentation 不直接调用 Supabase；同步共享文件只能由集成轨道统一修改。
