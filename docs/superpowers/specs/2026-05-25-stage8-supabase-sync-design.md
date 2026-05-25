# Rhythm 阶段八正式 Supabase 同步接入设计

> 日期：2026-05-25
> 适用范围：`profile + sync` 阶段八的正式云同步接入
> 关联项目：Supabase `rhythm`（`uluuiocaoetuxhixytmr`）
> 关联代码：
> - [lib/app/bootstrap/supabase_bootstrap.dart](</E:/Projects/flutter/rhythm/lib/app/bootstrap/supabase_bootstrap.dart>)
> - [lib/features/sync/application/sync_service.dart](</E:/Projects/flutter/rhythm/lib/features/sync/application/sync_service.dart>)
> - [lib/data/local/rhythm_database.dart](</E:/Projects/flutter/rhythm/lib/data/local/rhythm_database.dart>)

## 1. 目标

把阶段八现有的“本地优先同步骨架”接到正式 Supabase 项目，使 `Rhythm` 在不引入 Apple / Google 登录入口的前提下，具备可真实运行的云端同步能力。

本次设计的交付目标是：

- 接入正式 Supabase 项目，而不是继续停留在空实现或环境占位。
- 在应用启动时建立受 RLS 保护的匿名云端身份。
- 支持三类真实业务数据的正式同步：
  - 目标作息
  - 睡眠记录
  - 晚睡原因标签
- 保持当前阶段八页面与路由结构基本不变，只把同步状态从“占位摘要”升级为“真实状态”。

## 2. 范围

本次设计覆盖以下内容：

- Supabase 正式项目接入方式
- 匿名身份策略
- 同步表结构与 RLS 策略
- Flutter 端同步服务改造方式
- 账号与同步页的状态语义调整
- 对应测试与验证路径

本次设计不覆盖以下内容：

- Apple / Google 登录入口与绑定流程
- 周报摘要正式同步
- Realtime 订阅
- Edge Functions
- 删除传播与墓碑机制
- 完整离线队列框架重构

## 3. 当前状态判断

当前仓库已经具备“同步页面 + 同步服务 + Supabase 启动注入”的最小骨架，但还不具备正式同步能力。

已存在的基础：

- `supabase_flutter` 已经在 `pubspec.yaml` 中声明。
- 启动阶段已经有 `Supabase.initialize` 的入口。
- 账号与同步页已经落地，且有测试覆盖。
- 本地结构化数据边界已存在：
  - `SleepRecords` 在 Drift 中持久化
  - `SleepDelayTags` 在 Drift 中持久化
  - `GoalScheduleSettings` 在 SharedPreferences 中持久化

当前阻塞正式接入的核心问题：

- 正式 Supabase 项目 `public` schema 为空，没有同步表。
- `SupabaseSyncRemoteDataSource` 的 `pullChanges()` / `pushChanges()` 仍是空实现。
- 当前 `SyncQueueRepository` 只是内存实现，并没有真正接入各个本地仓储的写入链路。
- 目标作息没有 `updated_at` 元数据，无法可靠参与冲突决策。

## 4. 方案选择

本次从三种候选方案中选择其一：

### 方案 A：匿名鉴权 + 正式同步表 + 客户端直连 Supabase

做法：

- 应用启动后自动执行 `supabase.auth.signInAnonymously()`
- 所有同步表按 `auth.uid()` 做 RLS 隔离
- Flutter 客户端直接对 Supabase 表做 `select / upsert`

优点：

- 与当前“不做 Apple / Google 入口，但要正式同步”的目标完全对齐
- 后续可平滑升级到 Apple / Google 绑定身份
- 不需要额外维护服务端函数层

缺点：

- 需要明确匿名身份生命周期
- 需要在页面与状态层接受“匿名云端身份也是正式同步身份”

### 方案 B：无鉴权直接写库

不采用。  
原因：安全性不可接受，RLS 难以成立，无法作为正式方案。

### 方案 C：Flutter 仅调用 Edge Function，由函数代写同步

本次不采用。  
原因：虽然服务端边界更集中，但会显著扩大实现面，与当前阶段八范围不匹配。

### 最终选择

采用 **方案 A：匿名鉴权 + 正式同步表 + 客户端直连 Supabase**。

## 5. 身份模型

### 5.1 正式同步身份

本次正式同步身份不是 Apple / Google 用户，而是 **Supabase 匿名用户**。

这意味着：

- 用户即使不点击 Apple / Google，也会拥有一个云端身份。
- 这个身份有稳定的 `auth.uid()`，可用于 RLS 隔离数据。
- 账号与同步页展示的核心语义从“是否第三方登录”切换为“是否已建立云端同步身份”。

### 5.2 启动行为

当以下条件同时满足时，应用会在启动后尝试建立匿名云端身份：

- `SUPABASE_URL` 已提供
- `SUPABASE_PUBLISHABLE_KEY` 已提供
- `SUPABASE_SYNC_ENABLED=true`

启动链路规则：

1. 初始化 Supabase
2. 若当前已有 `currentSession`，直接复用
3. 若无会话，则自动执行 `signInAnonymously()`
4. 成功后把 `userId`、`signedIn`、`isAnonymous` 注入启动状态

### 5.3 状态语义

启动状态需要扩展为至少包含：

- `configured`
- `initialized`
- `syncEnabled`
- `signedIn`
- `isAnonymous`
- `userId`
- `errorMessage`

这样同步服务与页面无需直接推断 SDK 细节。

## 6. 同步边界

本次只同步三类数据：

### 6.1 目标作息

来源：

- `SharedPreferencesGoalScheduleSettingsRepository`

原因：

- 是“今日 / 睡前 / 提醒 / 日历”多个模块的基础设置
- 当前是单用户单份配置，适合作为最先同步的数据类型

### 6.2 睡眠记录

来源：

- `DriftSleepRecordRepository`

原因：

- 已有稳定的 Drift 存储结构
- 已具备 `updatedAt` 与 `isUserEdited`，便于冲突决策

### 6.3 晚睡原因标签

来源：

- `DriftSleepDelayTagRepository`

原因：

- 已有稳定的 Drift 存储结构
- 主键天然可按 `recordDate` 归并

### 6.4 不同步周报摘要

本次明确不把 `WeeklyReport` / `WeeklyReportSummary` 纳入正式同步。

原因：

- 当前代码中周报是运行时计算结果，不是稳定持久化边界
- 如强行纳入同步，会额外引出周报持久化表、生成时机与历史版本策略三个新问题
- 这超出本次“正式 Supabase 接入”的最小范围

## 7. 远端表设计

### 7.1 `sync_goal_settings`

用途：保存当前用户唯一一份目标作息配置。

字段：

- `user_id uuid primary key`
- `target_bedtime_minutes int not null`
- `target_wake_minutes int not null`
- `late_threshold_minutes int not null`
- `day_start_minutes int not null`
- `updated_at timestamptz not null`

说明：

- 一人一行，不保留历史版本
- 目标作息没有删除语义，只做覆盖式同步

### 7.2 `sync_sleep_records`

用途：保存当前用户的睡眠记录全集。

字段：

- `id text primary key`
- `user_id uuid not null`
- `record_date date not null`
- `fell_asleep_at timestamptz not null`
- `woke_up_at timestamptz not null`
- `duration_minutes int not null`
- `source text not null`
- `confidence text not null`
- `timezone text not null`
- `is_user_edited boolean not null`
- `source_record_id text null`
- `created_at timestamptz not null`
- `updated_at timestamptz not null`

索引：

- `(user_id, record_date)`
- `(user_id, updated_at desc)`

### 7.3 `sync_sleep_delay_tags`

用途：保存用户在某个业务日期上的最终标签集合。

字段：

- `user_id uuid not null`
- `record_date date not null`
- `tags_json jsonb not null`
- `updated_at timestamptz not null`

主键：

- `(user_id, record_date)`

索引：

- `(user_id, updated_at desc)`

## 8. RLS 策略

三张表全部启用 RLS，并统一使用当前登录用户隔离。

### 8.1 查询策略

- `select` 仅允许 `auth.uid() = user_id`

### 8.2 插入策略

- `insert` 仅允许新行的 `user_id = auth.uid()`

### 8.3 更新策略

- `update` 仅允许旧行与新行都属于 `auth.uid()`

### 8.4 删除策略

- `delete` 仅允许删除 `auth.uid()` 自己的数据

### 8.5 安全基线

本次不开放匿名公共表，不使用 service role，也不允许跨用户可见。

## 9. Flutter 端总体架构

### 9.1 保留的结构

保留以下边界不变：

- `supabase_bootstrap.dart`
- `sync_service.dart`
- `account_sync_controller.dart`
- 账号与同步页

也就是说，本次是“在现有接口内升级实现”，而不是推翻阶段八页面与路由结构。

### 9.2 同步模式调整

当前同步骨架是“队列模型”，但真实项目里还没有稳定的“所有本地写操作都入队”的链路。

因此本次建议改为 **本地快照对账模型**：

- 读取本地快照
- 读取远端快照
- 做实体级冲突决策
- 把赢家回写到本地或远端

原因：

- 能用最小改造直接得到真实正式同步
- 不需要为本次目标引入完整离线队列框架
- 更符合项目“除非明确要求，否则优先采用最干净实现”的约束

### 9.3 本次不做的同步能力

- 不做删除传播
- 不做墓碑记录
- 不做实时订阅
- 不做增量 token / cursor 同步协议

本次同步按“最小可运行正式同步”定义为：

- 以全量快照为主
- 以 `updated_at` 与 `is_user_edited` 做决策
- 以覆盖式回写收敛结果

## 10. 本地边界改造

### 10.1 目标作息

当前目标作息保存在 SharedPreferences，但缺失 `updated_at`。

本次必须补充：

- `goal_schedule_updated_at` 持久化字段

这样目标作息才能参与：

- 本地与远端的新旧比较
- 远端拉回时的覆盖判断

### 10.2 睡眠记录

睡眠记录已具备：

- `updatedAt`
- `isUserEdited`
- `createdAt`

因此无需重构表结构，只需把仓储数据映射到远端 DTO。

### 10.3 晚睡标签

晚睡标签已具备：

- `recordDate`
- `updatedAt`

只需把 `tagsJson` 与远端 `jsonb` 对齐。

## 11. 远端数据源设计

`SupabaseSyncRemoteDataSource` 负责：

- 读取当前用户远端目标作息
- 读取当前用户远端睡眠记录
- 读取当前用户远端晚睡标签
- 将本地结果按表 `upsert` 到 Supabase

职责边界：

- 只处理 Supabase SDK 与远端 DTO
- 不处理业务冲突策略
- 不直接操作 Flutter 展示文案

建议拆成小型 mapper / DTO 辅助文件，避免 `sync_service.dart` 继续膨胀。

## 12. 同步决策规则

### 12.1 目标作息

规则：

- `updated_at` 新者优先

### 12.2 睡眠记录

规则：

- 若本地记录 `isUserEdited = true`，则本地优先
- 否则比较 `updated_at`
- `updated_at` 新者优先

### 12.3 晚睡标签

规则：

- `updated_at` 新者优先

### 12.4 删除策略

本次不传播删除：

- 目标作息：无删除语义
- 晚睡标签：用空数组表示“当前无标签”
- 睡眠记录：当前产品与仓储侧没有明确删除流程，不引入额外语义

## 13. 页面状态调整

### 13.1 账号与同步页

账号与同步页的状态语义调整为：

- 未配置 Supabase：本地优先，云同步未启用
- 已配置但匿名会话失败：云同步暂时不可用
- 已建立匿名身份：已启用云端同步身份
- 最近一次同步失败：展示重试按钮
- 最近一次同步成功：展示最近同步时间

### 13.2 Apple / Google 文案

本次不应在页面里暗示 Apple / Google 已正式可用。

因此账号与同步页中原先偏“绑定 Apple 账号”的动作文案，需要改为更中性的同步身份状态文案。

## 14. 验证方案

### 14.1 Supabase 侧验证

需要验证：

- 三张表创建成功
- RLS 已开启
- 查询策略只允许当前用户访问自己的数据
- Security Advisor 不再报告缺失 RLS

### 14.2 Flutter 单元测试

保留并扩展 `test/features/sync`：

- 匿名登录成功后 `supportsSync = true`
- 目标作息本地快照能正确 upsert 到远端
- 睡眠记录本地快照能正确 upsert 到远端
- 晚睡标签本地快照能正确 upsert 到远端
- 远端新数据能正确映射回本地模型
- 本地 `isUserEdited=true` 的睡眠记录优先于远端普通记录

### 14.3 全量验证

必须运行：

- `flutter gen-l10n`
- `flutter test test/features/sync -r expanded`
- `flutter test`

## 15. 风险与约束

### 15.1 风险

- 匿名身份一旦建立，就需要后续设计“如何升级为 Apple / Google 正式账号”
- 目标作息当前仍在 SharedPreferences，中长期可能仍需迁移到 Drift
- 本次不做删除传播，意味着未来若产品补删除能力，还需要再扩展同步协议

### 15.2 约束

- 本次不引入额外兼容层，不保留多套同步路径
- 本次不扩展到周报摘要
- 本次不在显示层直接依赖 Supabase SDK
- 单文件不能继续无控制增长，必要时拆小 mapper / DTO 文件

## 16. 结论

本次正式 Supabase 接入采用“匿名鉴权 + 正式同步表 + 客户端直连 + 本地快照对账”的方案。

这样可以在不引入 Apple / Google 登录入口、不重做完整离线队列框架的前提下，把阶段八现有同步骨架升级为真实可运行的云同步能力，并且与当前代码库中已经稳定存在的本地数据边界保持一致。
