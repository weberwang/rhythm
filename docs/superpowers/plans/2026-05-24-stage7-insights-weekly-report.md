# Stage Seven Insights Weekly Report Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** 实现阶段七“洞察周报与基础恢复建议”，交付洞察首页、周报详情、历史洞察、恢复计划和稳定度说明的最小可交付闭环。

**Architecture:** 基于阶段三有效记录、阶段六标签结果和阶段五晚睡行为口径，构建 `insights` feature 的领域规则、应用聚合和显示层。页面只消费 `InsightsViewState`，领域规则只消费稳定输入，不依赖原始健康数据。

**Tech Stack:** Flutter, hooks_riverpod, flutter_riverpod, go_router, intl, flutter_test

---

## 文件结构

### 新建文件

- `lib/features/insights/domain/weekly_report.dart`
- `lib/features/insights/domain/weekly_report_generator.dart`
- `lib/features/insights/domain/stability_score_rules.dart`
- `lib/features/insights/domain/reason_distribution_rules.dart`
- `lib/features/insights/domain/recovery_plan.dart`
- `lib/features/insights/domain/recovery_plan_rules.dart`
- `lib/features/insights/application/insights_view_state.dart`
- `lib/features/insights/application/insights_controller.dart`
- `lib/features/insights/presentation/insights_page.dart`
- `lib/features/insights/presentation/weekly_report_detail_page.dart`
- `lib/features/insights/presentation/report_history_page.dart`
- `lib/features/insights/presentation/widgets/sections/weekly_report_summary_section.dart`
- `lib/features/insights/presentation/widgets/sections/stability_section.dart`
- `lib/features/insights/presentation/widgets/sections/reason_distribution_section.dart`
- `lib/features/insights/presentation/widgets/sections/recovery_effect_section.dart`
- `lib/features/insights/presentation/widgets/states/insights_empty_state.dart`
- `lib/features/insights/presentation/widgets/sheets/recovery_plan_detail_sheet.dart`
- `lib/features/insights/presentation/widgets/sheets/stability_explainer_sheet.dart`
- `test/features/insights/stability_score_rules_test.dart`
- `test/features/insights/recovery_plan_rules_test.dart`
- `test/features/insights/weekly_report_generator_test.dart`
- `test/features/insights/insights_controller_test.dart`
- `test/features/insights/presentation/insights_page_test.dart`

### 修改文件

- `lib/app/router/app_router.dart`
- `lib/l10n/app_en.arb`
- `lib/l10n/app_zh.arb`

---

## 共享契约冻结

- `WeeklyReport`
- `WeeklyReportDaySnapshot`
- `WeeklyReportSummary`
- `ReasonDistributionItem`
- `RecoveryPlan`
- `RecoveryPlanStatus`
- `InsightsViewState`
- 洞察埋点参数

---

## Pencil 对照要求

- 洞察首页只以 `uZblo` 为准
- 周报详情页只以 `LvFOz` 为准
- 历史洞察页只以 `yHfEL` 为准
- 稳定度说明、恢复计划详情、历史限制反馈组件只以 `Q2xhiP`、`ZQBCz` 为准

---

### Task 1: 冻结周报、恢复计划和 ViewState 契约

**Files:**
- Modify: `docs/rhythm-remaining-stages-parallel-implementation-plan-2026-05-24.md`

- [ ] **Step 1: 明确周报窗口和样本下限**

锁定：
- 最近 7 天窗口
- 少于 3 天有效记录不生成正式周报
- 原因分布只统计用户确认标签

- [ ] **Step 2: 明确恢复计划边界**

锁定：
- 只做 1-3 天规则建议
- 不做医疗表达
- 支持未查看、已查看、已完成、已延期

---

### Task 2: 实现周报生成与原因分布规则

**Files:**
- Create: `lib/features/insights/domain/weekly_report.dart`
- Create: `lib/features/insights/domain/weekly_report_generator.dart`
- Create: `lib/features/insights/domain/reason_distribution_rules.dart`
- Create: `test/features/insights/weekly_report_generator_test.dart`

- [ ] **Step 1: 写失败测试**

```dart
test('最近 7 天内至少 3 天有效记录时生成周报', () {
  final report = generateWeeklyReport(fixturesWithThreeDays());
  expect(report, isNotNull);
  expect(report!.summary.qualifiedDayCount, greaterThanOrEqualTo(1));
});
```

- [ ] **Step 2: 运行测试**

Run: `flutter test test/features/insights/weekly_report_generator_test.dart -r expanded`
Expected: FAIL

- [ ] **Step 3: 实现最小规则**

要求：
- 只消费有效记录、目标作息和标签
- 输出达标率、最晚入睡日、主要原因、下周建议

- [ ] **Step 4: 再跑测试**

Run: 同上
Expected: PASS

---

### Task 3: 实现稳定度与恢复计划规则

**Files:**
- Create: `lib/features/insights/domain/stability_score_rules.dart`
- Create: `lib/features/insights/domain/recovery_plan.dart`
- Create: `lib/features/insights/domain/recovery_plan_rules.dart`
- Create: `test/features/insights/stability_score_rules_test.dart`
- Create: `test/features/insights/recovery_plan_rules_test.dart`

- [ ] **Step 1: 写失败测试，锁定稳定度四种分支**

```dart
test('样本不足时返回数据不足说明', () {
  final score = calculateStabilityScore(fixturesWithTwoDays());
  expect(score.level, 'insufficient');
});
```

- [ ] **Step 2: 写失败测试，锁定恢复计划触发与成功口径**

```dart
test('明显晚睡后会生成 1 到 3 天恢复计划', () {
  final plan = buildRecoveryPlan(fixturesWithLateNight());
  expect(plan, isNotNull);
});
```

- [ ] **Step 3: 运行规则测试**

Run:

```bash
flutter test test/features/insights/stability_score_rules_test.dart test/features/insights/recovery_plan_rules_test.dart -r expanded
```

Expected: FAIL

- [ ] **Step 4: 实现最小规则并再跑测试**

Expected: PASS

---

### Task 4: 实现洞察应用聚合

**Files:**
- Create: `lib/features/insights/application/insights_view_state.dart`
- Create: `lib/features/insights/application/insights_controller.dart`
- Create: `test/features/insights/insights_controller_test.dart`

- [ ] **Step 1: 写失败测试**

```dart
test('无有效记录时输出 empty 状态', () async {
  final state = await buildInsightsState(noRecordsFixture());
  expect(state.status, InsightsStatus.empty);
});
```

- [ ] **Step 2: 运行测试**

Run: `flutter test test/features/insights/insights_controller_test.dart -r expanded`
Expected: FAIL

- [ ] **Step 3: 实现最小控制器**

要求：
- 只输出 `InsightsViewState`
- 不在页面层重算达标率、稳定度和恢复计划

- [ ] **Step 4: 再跑测试**

Expected: PASS

---

### Task 5: 实现洞察首页、详情页、历史页和弹层

**Files:**
- Create: `lib/features/insights/presentation/*`
- Create: `test/features/insights/presentation/insights_page_test.dart`

- [ ] **Step 1: 用 Pencil MCP 复核 `uZblo`、`LvFOz`、`yHfEL`、`Q2xhiP`、`ZQBCz`**

- [ ] **Step 2: 写失败测试，锁定首页在 ready 状态展示四个核心区块**

```dart
testWidgets('洞察首页 ready 状态展示周报摘要、稳定度、原因分布和恢复效果', (tester) async {
  await pumpInsightsPage(tester, state: readyInsightsState());
  expect(find.text('本周洞察'), findsOneWidget);
});
```

- [ ] **Step 3: 运行页面测试**

Run: `flutter test test/features/insights/presentation/insights_page_test.dart -r expanded`
Expected: FAIL

- [ ] **Step 4: 实现页面与弹层**

- [ ] **Step 5: 再跑页面测试**

Expected: PASS

---

### Task 6: 集成收口与回归

**Files:**
- Modify: `lib/app/router/app_router.dart`
- Modify: `lib/l10n/app_en.arb`
- Modify: `lib/l10n/app_zh.arb`

- [ ] **Step 1: 补文案并生成本地化**

Run: `flutter gen-l10n`
Expected: PASS

- [ ] **Step 2: 跑阶段七专项测试**

Run:

```bash
flutter test test/features/insights -r expanded
```

Expected: PASS

- [ ] **Step 3: 跑全量测试**

Run: `flutter test`
Expected: PASS

- [ ] **Step 4: 运行变更检测并提交**

Run: `npx gitnexus detect_changes`
Expected: 影响范围集中在 `insights`、`router`、`l10n` 和对应测试

```bash
git add lib/features/insights lib/app/router lib/l10n test/features/insights docs/superpowers/plans/2026-05-24-stage7-insights-weekly-report.md
git commit -m "feat: implement stage seven insights"
```
