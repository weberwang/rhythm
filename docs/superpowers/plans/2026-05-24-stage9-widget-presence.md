# Stage Nine Widget Presence Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** 实现阶段九“小组件与桌面存在感”，完成小组件引导页、主题页、快照服务与桌面入口闭环。

**Architecture:** 以 `widget_bridge` 为单一边界，聚焦快照生成、隐私过滤、入口跳转和设置页展示，不把小组件插件类型泄漏到页面层。

**Tech Stack:** Flutter, home_widget, hooks_riverpod, flutter_riverpod, flutter_test

---

### Task 1: 冻结小组件快照契约

**Files:**
- Modify: `docs/rhythm-remaining-stages-parallel-implementation-plan-2026-05-24.md`

- [ ] **Step 1: 锁定快照字段**

仅允许：
- 今晚目标
- 距离目标
- 昨晚状态
- 入口参数

- [ ] **Step 2: 锁定隐私边界**

不输出过细健康数据。

---

### Task 2: 实现快照服务与网关

**Files:**
- Create: `lib/features/widget_bridge/domain/widget_snapshot.dart`
- Create: `lib/features/widget_bridge/data/home_widget_gateway.dart`
- Create: `lib/features/widget_bridge/application/widget_snapshot_service.dart`
- Create: `test/features/widget_bridge/widget_snapshot_contract_test.dart`
- Create: `test/features/widget_bridge/widget_snapshot_service_test.dart`

- [ ] **Step 1: 写失败测试并实现快照契约**

- [ ] **Step 2: 写失败测试并实现快照服务**

- [ ] **Step 3: 跑测试**

Run:

```bash
flutter test test/features/widget_bridge/widget_snapshot_contract_test.dart test/features/widget_bridge/widget_snapshot_service_test.dart -r expanded
```

Expected: PASS

---

### Task 3: 实现引导页、主题页和入口桥接

**Files:**
- Create: `lib/features/widget_bridge/presentation/widget_guide_page.dart`
- Create: `lib/features/widget_bridge/presentation/widget_theme_page.dart`
- Modify: `lib/features/widget_bridge/application/widget_entry_controller.dart`
- Create: `test/features/widget_bridge/presentation/widget_theme_page_test.dart`

- [ ] **Step 1: 用 Pencil MCP 复核 `e5igNG` 与 `dNr9h`**

- [ ] **Step 2: 写失败测试并实现页面**

- [ ] **Step 3: 跑页面测试**

Run: `flutter test test/features/widget_bridge/presentation/widget_theme_page_test.dart test/features/widget_bridge/widget_entry_controller_test.dart -r expanded`
Expected: PASS

---

### Task 4: 集成收口与回归

**Files:**
- Modify: `lib/app/router/app_router.dart`
- Modify: `lib/app/bootstrap/app_bootstrap.dart`
- Modify: `lib/l10n/app_en.arb`
- Modify: `lib/l10n/app_zh.arb`

- [ ] **Step 1: 接入口与路由**

- [ ] **Step 2: 生成本地化**

Run: `flutter gen-l10n`

- [ ] **Step 3: 跑阶段九专项与全量测试**

Run:

```bash
flutter test test/features/widget_bridge -r expanded
flutter test
```

Expected: PASS

```bash
git add lib/features/widget_bridge lib/app/router lib/app/bootstrap lib/l10n test/features/widget_bridge docs/superpowers/plans/2026-05-24-stage9-widget-presence.md
git commit -m "feat: implement stage nine widget presence"
```
