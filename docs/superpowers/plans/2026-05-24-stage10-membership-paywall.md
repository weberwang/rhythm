# Stage Ten Membership Paywall Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** 实现阶段十“会员基础版与付费墙”，交付轻量付费墙、会员中心、权益策略和基础能力拦截。

**Architecture:** 以 `membership` 为单一业务边界，使用 `purchases_flutter` 封装数据源、仓储与服务，再由页面层承接轻量付费墙与会员中心展示。付费墙只拦高意图场景，不阻断首开闭环。

**Tech Stack:** Flutter, purchases_flutter, hooks_riverpod, flutter_riverpod, flutter_test

---

### Task 1: 冻结权益与付费墙策略契约

**Files:**
- Modify: `docs/rhythm-remaining-stages-parallel-implementation-plan-2026-05-24.md`

- [ ] **Step 1: 锁定权益位**

至少定义：
- 免费
- 试用
- 月付
- 年付
- 永久

- [ ] **Step 2: 锁定拦截场景**

只拦：
- 历史 30 天前
- 稳定度说明
- 恢复计划详情
- 月报入口

---

### Task 2: 实现领域、数据源与服务

**Files:**
- Create: `lib/features/membership/domain/membership_entitlement.dart`
- Create: `lib/features/membership/domain/membership_paywall_policy.dart`
- Create: `lib/data/purchases/purchases_membership_data_source.dart`
- Create: `lib/features/membership/data/membership_repository.dart`
- Create: `lib/features/membership/application/membership_service.dart`
- Create: `test/features/membership/membership_paywall_policy_test.dart`
- Create: `test/features/membership/membership_service_test.dart`

- [ ] **Step 1: 写失败测试并实现权益策略**

- [ ] **Step 2: 写失败测试并实现会员服务**

- [ ] **Step 3: 跑测试**

Run:

```bash
flutter test test/features/membership/membership_paywall_policy_test.dart test/features/membership/membership_service_test.dart -r expanded
```

Expected: PASS

---

### Task 3: 实现付费墙与会员中心显示层

**Files:**
- Create: `lib/features/membership/application/membership_controller.dart`
- Create: `lib/features/membership/presentation/paywall_page.dart`
- Create: `lib/features/membership/presentation/membership_page.dart`
- Create: `lib/features/membership/presentation/widgets/paywall_entry_banner.dart`
- Create: `lib/features/membership/presentation/widgets/sheets/membership_benefits_sheet.dart`
- Create: `test/features/membership/presentation/membership_page_test.dart`

- [ ] **Step 1: 用 Pencil MCP 复核 `uVhda`、`jkCvN`、`ZQBCz`**

- [ ] **Step 2: 写失败测试并实现页面**

- [ ] **Step 3: 跑页面测试**

Run: `flutter test test/features/membership/presentation/membership_page_test.dart -r expanded`
Expected: PASS

---

### Task 4: 集成收口与回归

**Files:**
- Modify: `lib/app/router/app_router.dart`
- Modify: `lib/l10n/app_en.arb`
- Modify: `lib/l10n/app_zh.arb`

- [ ] **Step 1: 接能力拦截与路由**

- [ ] **Step 2: 生成本地化**

Run: `flutter gen-l10n`

- [ ] **Step 3: 跑阶段十专项与全量测试**

Run:

```bash
flutter test test/features/membership -r expanded
flutter test
```

Expected: PASS

```bash
git add lib/features/membership lib/data/purchases lib/app/router lib/l10n test/features/membership docs/superpowers/plans/2026-05-24-stage10-membership-paywall.md
git commit -m "feat: implement stage ten membership paywall"
```
