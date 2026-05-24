# Stage Eleven Beta Release Closure Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** 实现阶段十一“灰度发布与数据看板”，完成内测收口、README 更新、人工验收清单、集成测试和发布前阻塞项整理。

**Architecture:** 这一阶段不再扩展核心业务功能，专注于验证、文档和交付闭环。通过集成测试覆盖首次激活到周报的主链路，通过 README 和验收清单沉淀运行与测试方法。

**Tech Stack:** Flutter, flutter_test, integration_test, Markdown docs

---

### Task 1: 锁定内测闭环范围

**Files:**
- Modify: `docs/rhythm-remaining-stages-parallel-implementation-plan-2026-05-24.md`

- [ ] **Step 1: 锁定集成路径**

主路径：
- 首次激活
- 今日页
- 睡前模式
- 日历补标签
- 洞察周报

---

### Task 2: 编写主链路集成测试

**Files:**
- Create: `integration_test/activation_to_weekly_report_test.dart`

- [ ] **Step 1: 写失败测试**

先锁定测试骨架和关键断言。

- [ ] **Step 2: 运行集成测试，确认当前失败**

Run: `flutter test integration_test/activation_to_weekly_report_test.dart -r expanded`
Expected: FAIL

- [ ] **Step 3: 实现最小可运行集成测试并再跑**

Expected: PASS

---

### Task 3: 更新 README 与人工验收清单

**Files:**
- Modify: `README.md`
- Create: `docs/rhythm-sleep-routine-management-test-checklist-2026-05-24.md`

- [ ] **Step 1: 在 README 补运行、测试、构建说明**

- [ ] **Step 2: 输出人工验收清单**

至少包含：
- 权限
- 时区
- 弱网
- 冷启动入口
- 付费墙不阻断

---

### Task 4: 发布前回归与阻塞项整理

**Files:**
- Modify: `docs/rhythm-sleep-routine-management-test-checklist-2026-05-24.md`

- [ ] **Step 1: 跑全量测试**

Run: `flutter test`
Expected: PASS

- [ ] **Step 2: 跑集成测试**

Run: `flutter test integration_test -r expanded`
Expected: PASS

- [ ] **Step 3: 运行变更检测**

Run: `npx gitnexus detect_changes`
Expected: 影响范围与文档、测试、最终收口一致

- [ ] **Step 4: 提交阶段十一收口**

```bash
git add integration_test README.md docs/rhythm-sleep-routine-management-test-checklist-2026-05-24.md docs/superpowers/plans/2026-05-24-stage11-beta-release-closure.md
git commit -m "docs: close stage eleven beta release"
```
