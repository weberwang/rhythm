# Stage Eight Supabase Sync Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** 将阶段八账号与同步骨架接入正式 Supabase 项目，启用匿名云身份，并让目标作息、睡眠记录、晚睡标签具备真实可运行的同步能力。

**Architecture:** 以 Supabase 匿名登录作为正式同步身份基础，在正式项目中创建三张同步表并开启 RLS。Flutter 端保留现有同步页面与控制器边界，但把同步核心从“空远端实现 + 内存队列摘要”升级为“本地快照与远端快照对账 + 实体级冲突决策 + 双向回写”。

**Tech Stack:** Flutter, hooks_riverpod, supabase_flutter, drift, shared_preferences, flutter_test, Supabase plugin migration tools

---

### Task 1: 建立正式 Supabase 同步 schema 与 RLS

**Files:**
- Create: `docs/superpowers/specs/2026-05-25-stage8-supabase-sync-design.md`
- Modify: Supabase project `uluuiocaoetuxhixytmr` (`public` schema)
- Verify: Supabase security advisors

- [ ] **Step 1: 列出现有 migration 状态**

Run: 使用 Supabase 插件 `list_migrations(project_id: "uluuiocaoetuxhixytmr")`
Expected: 能确认正式项目当前 migration 列表，用于后续命名与变更基线判断

- [ ] **Step 2: 编写同步表 migration SQL**

```sql
create table if not exists public.sync_goal_settings (
  user_id uuid primary key,
  target_bedtime_minutes integer not null,
  target_wake_minutes integer not null,
  late_threshold_minutes integer not null,
  day_start_minutes integer not null,
  updated_at timestamptz not null
);

create table if not exists public.sync_sleep_records (
  id text primary key,
  user_id uuid not null,
  record_date date not null,
  fell_asleep_at timestamptz not null,
  woke_up_at timestamptz not null,
  duration_minutes integer not null,
  source text not null,
  confidence text not null,
  timezone text not null,
  is_user_edited boolean not null,
  source_record_id text null,
  created_at timestamptz not null,
  updated_at timestamptz not null
);

create index if not exists sync_sleep_records_user_record_date_idx
  on public.sync_sleep_records (user_id, record_date);

create index if not exists sync_sleep_records_user_updated_at_idx
  on public.sync_sleep_records (user_id, updated_at desc);

create table if not exists public.sync_sleep_delay_tags (
  user_id uuid not null,
  record_date date not null,
  tags_json jsonb not null,
  updated_at timestamptz not null,
  primary key (user_id, record_date)
);

create index if not exists sync_sleep_delay_tags_user_updated_at_idx
  on public.sync_sleep_delay_tags (user_id, updated_at desc);

alter table public.sync_goal_settings enable row level security;
alter table public.sync_sleep_records enable row level security;
alter table public.sync_sleep_delay_tags enable row level security;

drop policy if exists sync_goal_settings_select_own on public.sync_goal_settings;
drop policy if exists sync_goal_settings_insert_own on public.sync_goal_settings;
drop policy if exists sync_goal_settings_update_own on public.sync_goal_settings;
drop policy if exists sync_goal_settings_delete_own on public.sync_goal_settings;

create policy sync_goal_settings_select_own
  on public.sync_goal_settings
  for select
  using (auth.uid() = user_id);

create policy sync_goal_settings_insert_own
  on public.sync_goal_settings
  for insert
  with check (auth.uid() = user_id);

create policy sync_goal_settings_update_own
  on public.sync_goal_settings
  for update
  using (auth.uid() = user_id)
  with check (auth.uid() = user_id);

create policy sync_goal_settings_delete_own
  on public.sync_goal_settings
  for delete
  using (auth.uid() = user_id);

drop policy if exists sync_sleep_records_select_own on public.sync_sleep_records;
drop policy if exists sync_sleep_records_insert_own on public.sync_sleep_records;
drop policy if exists sync_sleep_records_update_own on public.sync_sleep_records;
drop policy if exists sync_sleep_records_delete_own on public.sync_sleep_records;

create policy sync_sleep_records_select_own
  on public.sync_sleep_records
  for select
  using (auth.uid() = user_id);

create policy sync_sleep_records_insert_own
  on public.sync_sleep_records
  for insert
  with check (auth.uid() = user_id);

create policy sync_sleep_records_update_own
  on public.sync_sleep_records
  for update
  using (auth.uid() = user_id)
  with check (auth.uid() = user_id);

create policy sync_sleep_records_delete_own
  on public.sync_sleep_records
  for delete
  using (auth.uid() = user_id);

drop policy if exists sync_sleep_delay_tags_select_own on public.sync_sleep_delay_tags;
drop policy if exists sync_sleep_delay_tags_insert_own on public.sync_sleep_delay_tags;
drop policy if exists sync_sleep_delay_tags_update_own on public.sync_sleep_delay_tags;
drop policy if exists sync_sleep_delay_tags_delete_own on public.sync_sleep_delay_tags;

create policy sync_sleep_delay_tags_select_own
  on public.sync_sleep_delay_tags
  for select
  using (auth.uid() = user_id);

create policy sync_sleep_delay_tags_insert_own
  on public.sync_sleep_delay_tags
  for insert
  with check (auth.uid() = user_id);

create policy sync_sleep_delay_tags_update_own
  on public.sync_sleep_delay_tags
  for update
  using (auth.uid() = user_id)
  with check (auth.uid() = user_id);

create policy sync_sleep_delay_tags_delete_own
  on public.sync_sleep_delay_tags
  for delete
  using (auth.uid() = user_id);
```

- [ ] **Step 3: 应用 migration**

Run: 使用 Supabase 插件 `apply_migration(name: "stage8_sync_tables_and_rls", project_id: "uluuiocaoetuxhixytmr", query: "...")`
Expected: Migration 应用成功，无 SQL 报错

- [ ] **Step 4: 校验表结构**

Run: 使用 Supabase 插件 `list_tables(project_id: "uluuiocaoetuxhixytmr", schemas: ["public"], verbose: true)`
Expected: 返回 `sync_goal_settings`、`sync_sleep_records`、`sync_sleep_delay_tags` 三张表及索引列

- [ ] **Step 5: 校验安全 advisor**

Run: 使用 Supabase 插件 `get_advisors(project_id: "uluuiocaoetuxhixytmr", type: "security")`
Expected: 不出现缺失 RLS 或明显安全基线问题

- [ ] **Step 6: 提交**

```bash
git add docs/superpowers/specs/2026-05-25-stage8-supabase-sync-design.md
git commit -m "docs: define stage eight supabase sync design"
```

### Task 2: 扩展启动状态并接入匿名云身份

**Files:**
- Modify: `lib/app/bootstrap/supabase_bootstrap.dart`
- Modify: `lib/app/bootstrap/app_bootstrap.dart`
- Test: `test/features/sync/sync_service_test.dart`

- [ ] **Step 1: 写启动状态与匿名登录的失败测试**

```dart
test('未持有会话且允许同步时会尝试匿名登录', () async {
  final auth = _FakeSupabaseAuth(
    currentSession: null,
    currentUser: null,
  );
  final bootstrap = await initializeSupabaseBootstrapForTest(
    url: 'https://example.supabase.co',
    publishableKey: 'pk-test',
    syncEnabled: true,
    auth: auth,
  );

  expect(auth.signInAnonymouslyCalled, isTrue);
  expect(bootstrap.signedIn, isTrue);
  expect(bootstrap.isAnonymous, isTrue);
  expect(bootstrap.userId, 'anon-user-1');
});
```

- [ ] **Step 2: 运行测试确认失败**

Run: `rtk flutter test test/features/sync/sync_service_test.dart -r expanded`
Expected: FAIL，报出缺少 `signedIn` / `isAnonymous` / `userId` 字段或匿名登录逻辑

- [ ] **Step 3: 给启动状态增加正式同步身份字段**

```dart
class SupabaseBootstrapState {
  const SupabaseBootstrapState({
    required this.configured,
    required this.initialized,
    required this.syncEnabled,
    required this.signedIn,
    required this.isAnonymous,
    this.userId,
    this.errorMessage,
  });

  final bool configured;
  final bool initialized;
  final bool syncEnabled;
  final bool signedIn;
  final bool isAnonymous;
  final String? userId;
  final String? errorMessage;
}
```

- [ ] **Step 4: 把初始化逻辑改成匿名会话优先**

```dart
Future<SupabaseBootstrapState> initializeSupabaseBootstrap() async {
  const url = String.fromEnvironment('SUPABASE_URL');
  const publishableKey = String.fromEnvironment('SUPABASE_PUBLISHABLE_KEY');
  const syncEnabledFlag = String.fromEnvironment('SUPABASE_SYNC_ENABLED');
  final syncEnabled = syncEnabledFlag.toLowerCase() == 'true';

  if (url.isEmpty || publishableKey.isEmpty) {
    return const SupabaseBootstrapState(
      configured: false,
      initialized: false,
      syncEnabled: false,
      signedIn: false,
      isAnonymous: false,
    );
  }

  try {
    await Supabase.initialize(
      url: url,
      publishableKey: publishableKey,
      authOptions: const FlutterAuthClientOptions(
        authFlowType: AuthFlowType.pkce,
      ),
    );

    final client = Supabase.instance.client;
    var session = client.auth.currentSession;
    var user = client.auth.currentUser;

    if (syncEnabled && session == null) {
      final response = await client.auth.signInAnonymously();
      session = response.session;
      user = response.user;
    }

    return SupabaseBootstrapState(
      configured: true,
      initialized: true,
      syncEnabled: syncEnabled,
      signedIn: session != null || user != null,
      isAnonymous: user?.isAnonymous ?? false,
      userId: user?.id,
    );
  } catch (error) {
    return SupabaseBootstrapState(
      configured: true,
      initialized: false,
      syncEnabled: false,
      signedIn: false,
      isAnonymous: false,
      errorMessage: error.toString(),
    );
  }
}
```

- [ ] **Step 5: 运行同步测试确认通过**

Run: `rtk flutter test test/features/sync/sync_service_test.dart -r expanded`
Expected: PASS，启动状态用例通过

- [ ] **Step 6: 提交**

```bash
git add lib/app/bootstrap/supabase_bootstrap.dart lib/app/bootstrap/app_bootstrap.dart test/features/sync/sync_service_test.dart
git commit -m "feat: bootstrap anonymous supabase sync identity"
```

### Task 3: 让目标作息具备冲突决策时间戳

**Files:**
- Modify: `lib/features/goal_schedule/data/goal_schedule_settings_repository.dart`
- Modify: `lib/features/goal_schedule/domain/goal_schedule_settings.dart`
- Modify: `lib/features/goal_schedule/application/goal_schedule_providers.dart`
- Test: `test/features/sync/sync_service_test.dart`

- [ ] **Step 1: 写目标作息更新时间戳的失败测试**

```dart
test('保存目标作息时会同步写入 updatedAt 元数据', () async {
  final prefs = await SharedPreferences.getInstance();
  final repository = SharedPreferencesGoalScheduleSettingsRepository(prefs);

  await repository.save(
    const GoalScheduleSettings(
      targetBedtimeMinutes: 1410,
      targetWakeMinutes: 450,
      lateThresholdMinutes: 30,
      dayStartMinutes: 240,
    ),
  );

  final updatedAt = prefs.getString('goal_schedule_updated_at');
  expect(updatedAt, isNotNull);
});
```

- [ ] **Step 2: 运行测试确认失败**

Run: `rtk flutter test test/features/sync/sync_service_test.dart -r expanded`
Expected: FAIL，提示缺少 `goal_schedule_updated_at`

- [ ] **Step 3: 为目标作息仓储补更新时间持久化**

```dart
class SharedPreferencesGoalScheduleSettingsRepository
    implements GoalScheduleSettingsRepository {
  static const String updatedAtKey = 'goal_schedule_updated_at';

  @override
  Future<void> save(GoalScheduleSettings settings) async {
    final now = DateTime.now().toUtc().toIso8601String();
    await _sharedPreferences.setInt(
      targetBedtimeMinutesKey,
      settings.targetBedtimeMinutes,
    );
    await _sharedPreferences.setInt(
      targetWakeMinutesKey,
      settings.targetWakeMinutes,
    );
    await _sharedPreferences.setInt(
      lateThresholdMinutesKey,
      settings.lateThresholdMinutes,
    );
    await _sharedPreferences.setInt(
      dayStartMinutesKey,
      settings.dayStartMinutes,
    );
    await _sharedPreferences.setString(updatedAtKey, now);
  }
}
```

- [ ] **Step 4: 为读取结果补充更新时间**

```dart
final updatedAtRaw = _sharedPreferences.getString(updatedAtKey);
final updatedAt = updatedAtRaw == null
    ? null
    : DateTime.tryParse(updatedAtRaw)?.toUtc();

return GoalScheduleSettings.fromPreferenceMap(
  <String, Object>{
    targetBedtimeMinutesKey: bedtime,
    targetWakeMinutesKey: wake,
    lateThresholdMinutesKey: lateThreshold,
    dayStartMinutesKey: dayStart,
  },
).copyWith(updatedAt: updatedAt);
```

- [ ] **Step 5: 运行测试确认通过**

Run: `rtk flutter test test/features/sync/sync_service_test.dart -r expanded`
Expected: PASS，目标作息更新时间测试通过

- [ ] **Step 6: 提交**

```bash
git add lib/features/goal_schedule/data/goal_schedule_settings_repository.dart lib/features/goal_schedule/domain/goal_schedule_settings.dart lib/features/goal_schedule/application/goal_schedule_providers.dart test/features/sync/sync_service_test.dart
git commit -m "feat: persist goal schedule sync timestamps"
```

### Task 4: 实现 Supabase 远端 DTO 与真实读写

**Files:**
- Create: `lib/features/sync/data/supabase_sync_models.dart`
- Modify: `lib/features/sync/application/sync_service.dart`
- Test: `test/features/sync/sync_service_test.dart`

- [ ] **Step 1: 写远端 upsert / pull 映射的失败测试**

```dart
test('远端数据源会把睡眠记录 upsert 到 sync_sleep_records', () async {
  final client = _FakeSupabaseClient();
  final dataSource = SupabaseSyncRemoteDataSource.forTest(
    client: client,
    bootstrapState: const SupabaseBootstrapState(
      configured: true,
      initialized: true,
      syncEnabled: true,
      signedIn: true,
      isAnonymous: true,
      userId: 'user-1',
    ),
  );

  await dataSource.pushSleepRecords([
    _sleepRecordRemoteMap(),
  ]);

  expect(client.upserts.single.table, 'sync_sleep_records');
});
```

- [ ] **Step 2: 运行测试确认失败**

Run: `rtk flutter test test/features/sync/sync_service_test.dart -r expanded`
Expected: FAIL，提示缺少 DTO / pushSleepRecords / pull 逻辑

- [ ] **Step 3: 定义远端 DTO 与映射器**

```dart
class SyncGoalSettingsRemoteModel {
  const SyncGoalSettingsRemoteModel({
    required this.userId,
    required this.targetBedtimeMinutes,
    required this.targetWakeMinutes,
    required this.lateThresholdMinutes,
    required this.dayStartMinutes,
    required this.updatedAt,
  });

  final String userId;
  final int targetBedtimeMinutes;
  final int targetWakeMinutes;
  final int lateThresholdMinutes;
  final int dayStartMinutes;
  final DateTime updatedAt;

  Map<String, Object?> toJson() => <String, Object?>{
        'user_id': userId,
        'target_bedtime_minutes': targetBedtimeMinutes,
        'target_wake_minutes': targetWakeMinutes,
        'late_threshold_minutes': lateThresholdMinutes,
        'day_start_minutes': dayStartMinutes,
        'updated_at': updatedAt.toIso8601String(),
      };
}
```

- [ ] **Step 4: 实现真实远端读写**

```dart
@override
Future<void> pushChanges(List<SyncQueueItem> items) async {
  final client = Supabase.instance.client;
  final grouped = _groupByEntity(items);

  if (grouped.goalSettings.isNotEmpty) {
    await client.from('sync_goal_settings').upsert(
          grouped.goalSettings.map((item) => item.toJson()).toList(),
        );
  }
  if (grouped.sleepRecords.isNotEmpty) {
    await client.from('sync_sleep_records').upsert(
          grouped.sleepRecords.map((item) => item.toJson()).toList(),
        );
  }
  if (grouped.sleepDelayTags.isNotEmpty) {
    await client.from('sync_sleep_delay_tags').upsert(
          grouped.sleepDelayTags.map((item) => item.toJson()).toList(),
        );
  }
}

@override
Future<List<SyncQueueItem>> pullChanges() async {
  final client = Supabase.instance.client;
  final userId = _bootstrapState.userId;
  if (userId == null) {
    return const <SyncQueueItem>[];
  }

  final goalRows = await client
      .from('sync_goal_settings')
      .select()
      .eq('user_id', userId);
  final recordRows = await client
      .from('sync_sleep_records')
      .select()
      .eq('user_id', userId);
  final tagRows = await client
      .from('sync_sleep_delay_tags')
      .select()
      .eq('user_id', userId);

  return [
    ...goalRows.map(_goalSettingsRowToQueueItem),
    ...recordRows.map(_sleepRecordRowToQueueItem),
    ...tagRows.map(_sleepDelayTagRowToQueueItem),
  ];
}
```

- [ ] **Step 5: 运行测试确认通过**

Run: `rtk flutter test test/features/sync/sync_service_test.dart -r expanded`
Expected: PASS，远端 DTO 映射与真实读写测试通过

- [ ] **Step 6: 提交**

```bash
git add lib/features/sync/data/supabase_sync_models.dart lib/features/sync/application/sync_service.dart test/features/sync/sync_service_test.dart
git commit -m "feat: add supabase sync remote data source"
```

### Task 5: 把同步服务改成快照对账模型

**Files:**
- Modify: `lib/features/sync/application/sync_service.dart`
- Modify: `lib/features/sync/domain/sync_queue_item.dart`
- Test: `test/features/sync/sync_service_test.dart`

- [ ] **Step 1: 写本地优先与远端覆盖的失败测试**

```dart
test('本地 isUserEdited 睡眠记录会优先于远端普通记录', () async {
  final service = _buildSyncServiceForConflict(
    localRecordUpdatedAt: DateTime.utc(2026, 5, 25, 8),
    localUserEdited: true,
    remoteRecordUpdatedAt: DateTime.utc(2026, 5, 25, 9),
  );

  final summary = await service.sync();

  expect(summary.conflictCount, 1);
  expect(summary.uploadedCount, 1);
});
```

- [ ] **Step 2: 运行测试确认失败**

Run: `rtk flutter test test/features/sync/sync_service_test.dart -r expanded`
Expected: FAIL，当前队列模型无法满足快照对账预期

- [ ] **Step 3: 实现本地快照读取与对账**

```dart
Future<SyncRunSummary> sync() async {
  final localSnapshot = await _readLocalSnapshot();
  final remoteSnapshot = await _remoteDataSource.pullChanges();
  final resolution = _resolver.resolve(
    local: localSnapshot,
    remote: remoteSnapshot,
  );

  await _writeRemoteWinners(resolution.remoteWinners);
  await _writeLocalWinners(resolution.localWinners);

  final summary = SyncRunSummary(
    configured: _remoteDataSource.isConfigured,
    signedIn: _remoteDataSource.isSignedIn,
    supportsRemoteSync: _remoteDataSource.supportsSync,
    email: _remoteDataSource.email,
    pendingCount: 0,
    uploadedCount: resolution.remoteWinners.length,
    downloadedCount: resolution.localWinners.length,
    conflictCount: resolution.conflictCount,
    lastSyncedAt: _now(),
  );
  _lastSummary = summary;
  return summary;
}
```

- [ ] **Step 4: 把睡眠记录用户手动优先规则编码到冲突决策**

```dart
bool _preferLocal(SyncQueueItem local, SyncQueueItem remote) {
  if (local.entityType == SyncEntityType.sleepRecord &&
      local.payload['isUserEdited'] == true &&
      remote.payload['isUserEdited'] != true) {
    return true;
  }
  return local.updatedAt.isAfter(remote.updatedAt);
}
```

- [ ] **Step 5: 运行测试确认通过**

Run: `rtk flutter test test/features/sync/sync_service_test.dart -r expanded`
Expected: PASS，快照对账与冲突规则测试通过

- [ ] **Step 6: 提交**

```bash
git add lib/features/sync/application/sync_service.dart lib/features/sync/domain/sync_queue_item.dart test/features/sync/sync_service_test.dart
git commit -m "feat: reconcile local and remote sync snapshots"
```

### Task 6: 让账号与同步页展示真实匿名云身份状态

**Files:**
- Modify: `lib/features/sync/application/account_sync_controller.dart`
- Modify: `lib/features/sync/presentation/account_sync_page.dart`
- Modify: `lib/l10n/app_en.arb`
- Modify: `lib/l10n/app_zh.arb`
- Test: `test/features/sync/presentation/account_sync_page_test.dart`

- [ ] **Step 1: 写匿名云身份状态的失败页面测试**

```dart
testWidgets('匿名云身份已建立时展示云端同步身份文案', (tester) async {
  await pumpAccountSyncPage(
    tester,
    state: const AccountSyncViewState(
      status: AccountSyncStatus.synced,
      hasLinkedAccount: true,
      email: null,
    ),
  );

  expect(find.text('已建立云端同步身份'), findsOneWidget);
  expect(find.text('已启用云端同步'), findsOneWidget);
});
```

- [ ] **Step 2: 运行测试确认失败**

Run: `rtk flutter test test/features/sync/presentation/account_sync_page_test.dart -r expanded`
Expected: FAIL，当前仍展示 Apple 绑定语义

- [ ] **Step 3: 调整控制器状态映射**

```dart
AccountSyncViewState _fromSummary(SyncRunSummary summary) {
  if (!summary.configured) {
    return const AccountSyncViewState(
      status: AccountSyncStatus.localOnly,
      hasLinkedAccount: false,
    );
  }

  if (summary.hadFailure) {
    return AccountSyncViewState(
      status: AccountSyncStatus.failed,
      hasLinkedAccount: summary.signedIn,
      email: summary.email,
      lastSyncedAt: summary.lastSyncedAt,
    );
  }

  return AccountSyncViewState(
    status: summary.supportsRemoteSync
        ? AccountSyncStatus.synced
        : AccountSyncStatus.signInRequired,
    hasLinkedAccount: summary.signedIn,
    email: summary.email,
    lastSyncedAt: summary.lastSyncedAt,
  );
}
```

- [ ] **Step 4: 调整页面文案与主按钮语义**

```dart
String _primaryActionLabel(
  AppLocalizations l10n,
  AccountSyncViewState state,
) {
  return state.hasLinkedAccount
      ? l10n.accountSyncCloudIdentityReadyButton
      : l10n.accountSyncCloudIdentityPendingButton;
}
```

- [ ] **Step 5: 重新生成本地化并运行测试**

Run: `rtk flutter gen-l10n`
Expected: 本地化代码生成成功

Run: `rtk flutter test test/features/sync/presentation/account_sync_page_test.dart -r expanded`
Expected: PASS，账号同步页展示真实匿名云身份状态

- [ ] **Step 6: 提交**

```bash
git add lib/features/sync/application/account_sync_controller.dart lib/features/sync/presentation/account_sync_page.dart lib/l10n/app_en.arb lib/l10n/app_zh.arb lib/l10n/app_localizations.dart lib/l10n/app_localizations_en.dart lib/l10n/app_localizations_zh.dart test/features/sync/presentation/account_sync_page_test.dart
git commit -m "feat: show live supabase sync identity states"
```

### Task 7: 跑专项与全量验证

**Files:**
- Verify only: existing implementation files and tests

- [ ] **Step 1: 跑阶段八同步专项测试**

Run: `rtk flutter test test/features/sync -r expanded`
Expected: PASS

- [ ] **Step 2: 跑页面与根应用回归**

Run: `rtk flutter test test/app/rhythm_app_test.dart -r expanded`
Expected: PASS

Run: `rtk flutter test test/features/profile/presentation/profile_page_test.dart -r expanded`
Expected: PASS

- [ ] **Step 3: 跑全量测试**

Run: `rtk flutter test`
Expected: PASS

- [ ] **Step 4: 记录 Supabase 侧结果**

Run: 用 Supabase 插件再次执行 `list_tables` 与 `get_advisors`
Expected: 表结构完整、RLS 正常、安全 advisor 无新增高风险项

- [ ] **Step 5: 提交**

```bash
git add lib/app/bootstrap lib/features/sync lib/features/goal_schedule lib/l10n test/features/sync test/app/rhythm_app_test.dart
git commit -m "test: verify live supabase sync integration"
```

## Self-Review

- Spec coverage:
  - 正式项目与 RLS：Task 1
  - 匿名云身份：Task 2
  - 目标作息 `updated_at`：Task 3
  - 远端 DTO 与真实读写：Task 4
  - 快照对账与冲突策略：Task 5
  - 页面真实状态：Task 6
  - 专项与全量验证：Task 7
- Placeholder scan:
  - 未使用 `TODO` / `TBD` / “类似前文”类占位
- Type consistency:
  - `SupabaseBootstrapState` 的新增字段、`AccountSyncViewState` 的状态语义、`GoalScheduleSettings` 的 `updatedAt` 都在前置任务中先定义，再在后续任务中消费

## Execution Handoff

Plan complete and saved to `docs/superpowers/plans/2026-05-25-stage8-supabase-sync-plan.md`. Two execution options:

**1. Subagent-Driven (recommended)** - I dispatch a fresh subagent per task, review between tasks, fast iteration

**2. Inline Execution** - Execute tasks in this session using executing-plans, batch execution with checkpoints

Which approach?
