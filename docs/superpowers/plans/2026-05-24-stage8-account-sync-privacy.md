# Stage Eight Account Sync Privacy Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** 实现阶段八“账户、同步与隐私”，补齐我的页下的账号同步、数据接入、隐私与数据管理、目标编辑和提醒设置二级页。

**Architecture:** 以 `profile`、`sync`、`goal_schedule`、`notifications` 为主要边界，通过共享契约统一路由、二级页入口和本地化，再按同步、隐私、设置三块拆任务。

**Tech Stack:** Flutter, hooks_riverpod, flutter_riverpod, go_router, drift, supabase_flutter, flutter_test

---

### Task 1: 冻结阶段八页面与同步契约

**Files:**
- Modify: `docs/rhythm-remaining-stages-parallel-implementation-plan-2026-05-24.md`

- [ ] **Step 1: 锁定二级页范围**

范围只含：
- 数据接入与权限页
- 账号与同步页
- 隐私与数据页
- 目标作息编辑页
- 提醒设置页
- 时区与特殊模式页

- [ ] **Step 2: 锁定同步边界**

只做最小同步：
- 目标设置
- 睡眠记录
- 原因标签
- 周报摘要

---

### Task 2: 实现同步领域与同步页

**Files:**
- Create: `lib/features/sync/domain/sync_queue_item.dart`
- Create: `lib/features/sync/domain/sync_conflict_policy.dart`
- Create: `lib/features/sync/data/sync_queue_repository.dart`
- Create: `lib/features/sync/application/sync_service.dart`
- Create: `lib/features/sync/application/account_sync_controller.dart`
- Create: `lib/features/sync/presentation/account_sync_page.dart`
- Create: `test/features/sync/sync_conflict_policy_test.dart`
- Create: `test/features/sync/sync_service_test.dart`
- Create: `test/features/sync/presentation/account_sync_page_test.dart`

- [ ] **Step 1: 写失败测试并实现冲突策略**

Run: `flutter test test/features/sync/sync_conflict_policy_test.dart -r expanded`
Expected: FAIL -> PASS

- [ ] **Step 2: 写失败测试并实现同步服务**

Run: `flutter test test/features/sync/sync_service_test.dart -r expanded`
Expected: FAIL -> PASS

- [ ] **Step 3: 写失败测试并实现账号同步页**

Run: `flutter test test/features/sync/presentation/account_sync_page_test.dart -r expanded`
Expected: FAIL -> PASS

---

### Task 3: 实现数据接入、隐私与设置二级页

**Files:**
- Create: `lib/features/profile/presentation/profile_page.dart`
- Create: `lib/features/profile/presentation/data_access_page.dart`
- Create: `lib/features/profile/presentation/privacy_data_page.dart`
- Create: `lib/features/goal_schedule/presentation/goal_schedule_settings_page.dart`
- Create: `lib/features/goal_schedule/presentation/timezone_mode_page.dart`
- Create: `lib/features/notifications/presentation/notification_settings_page.dart`
- Create: 对应 widget 测试

- [ ] **Step 1: 用 Pencil MCP 复核 `JFjkB`、`C01GQ`、`dwr00`、`Y8H2RS`、`Vd5Ou`、`N0aow0`**

- [ ] **Step 2: 为每个二级页写失败 Widget 测试**

Expected: 先失败再实现

- [ ] **Step 3: 实现页面与入口**

- [ ] **Step 4: 再跑对应测试**

Expected: PASS

---

### Task 4: 集成收口与回归

**Files:**
- Modify: `lib/app/router/app_router.dart`
- Modify: `lib/app/bootstrap/app_bootstrap.dart`
- Modify: `lib/l10n/app_en.arb`
- Modify: `lib/l10n/app_zh.arb`

- [ ] **Step 1: 接路由与入口**

- [ ] **Step 2: 生成本地化**

Run: `flutter gen-l10n`

- [ ] **Step 3: 跑阶段八专项测试**

Run: `flutter test test/features/sync -r expanded`

- [ ] **Step 4: 跑全量测试并提交**

Run: `flutter test`
Expected: PASS

```bash
git add lib/features/sync lib/features/profile lib/features/goal_schedule lib/features/notifications lib/app/router lib/app/bootstrap lib/l10n test/features/sync docs/superpowers/plans/2026-05-24-stage8-account-sync-privacy.md
git commit -m "feat: implement stage eight account sync and privacy"
```
