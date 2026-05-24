# Stage Six Calendar And Tag Closure Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** 收口阶段六“日历热力图与原因标签”，把当前工作区中已开工的 `calendar` 与 `sleep_delay_tag` 相关能力推进到稳定可交付状态，并确保显示层严格对齐 `pen/app.pen`。

**Architecture:** 以现有 `calendar` 和 `sleep_records` 的标签边界为基础，分别收口领域规则、应用状态聚合、页面组件、详情/筛选/标签弹层，再由集成任务统一处理共享文件、路由、本地化和埋点。默认优先并行拆轨道，但若执行时共享文件冲突过高，可退回串行收口。

**Tech Stack:** Flutter, hooks_riverpod, flutter_riverpod, go_router, intl, flutter_test

---

## 文件结构

### 新建文件

- `test/features/calendar/calendar_integration_surface_test.dart`
作用：补一条跨页面交互面测试，锁定月历 -> 日详情 -> 标签保存的集成面。

### 修改文件

- `lib/features/calendar/application/calendar_controller.dart`
- `lib/features/calendar/application/calendar_view_state.dart`
- `lib/features/calendar/application/calendar_analytics.dart`
- `lib/features/calendar/domain/calendar_day_summary.dart`
- `lib/features/calendar/domain/calendar_filter.dart`
- `lib/features/calendar/domain/calendar_heat_level.dart`
- `lib/features/calendar/domain/calendar_heatmap_rules.dart`
- `lib/features/calendar/domain/calendar_month_summary.dart`
- `lib/features/calendar/presentation/calendar_page.dart`
- `lib/features/calendar/presentation/widgets/calendar_heatmap.dart`
- `lib/features/calendar/presentation/widgets/sheets/calendar_day_detail_sheet.dart`
- `lib/features/calendar/presentation/widgets/sheets/calendar_filter_sheet.dart`
- `lib/features/sleep_records/application/sleep_delay_tag_controller.dart`
- `lib/features/sleep_records/application/sleep_delay_tag_providers.dart`
- `lib/features/sleep_records/data/in_memory_sleep_delay_tag_repository.dart`
- `lib/features/sleep_records/domain/repositories/sleep_delay_tag_repository.dart`
- `lib/features/sleep_records/domain/sleep_delay_tag.dart`
- `lib/features/sleep_records/domain/sleep_delay_tag_rules.dart`
- `lib/features/sleep_records/presentation/widgets/sheets/custom_delay_tag_sheet.dart`
- `lib/features/sleep_records/presentation/widgets/sheets/sleep_delay_tag_picker_sheet.dart`
- `lib/app/router/app_router.dart`
- `lib/l10n/app_en.arb`
- `lib/l10n/app_zh.arb`
- `test/features/calendar/*`
- `test/features/sleep_records/*sleep_delay_tag*`

---

## 共享契约冻结

先冻结以下公共类型和字段：

- `CalendarHeatLevel`
- `CalendarDaySummary`
- `CalendarMonthSummary`
- `CalendarFilter`
- `CalendarViewState`
- `SleepDelayTag`
- `SleepDelayTagRepository`
- 标签保存后的返回口径
- 埋点参数：
  - `calendar_viewed`
  - `day_detail_viewed`
  - `delay_tag_added`

---

## Pencil 对照要求

- 日历页显示层只以 `nBLqq` 为准。
- 详情、筛选、标签和轻反馈组件只以 `Q2xhiP` 与 `ZQBCz` 为准。
- 若空态、来源说明或自定义标签错误态在当前设计稿里没有完整展开，执行前先明确复用哪个现有反馈组件。

---

## 执行方式建议

### 推荐并行轨道

- 轨道 A：日历领域规则
- 轨道 B：标签领域与保存
- 轨道 C：日历页面与热力图
- 轨道 D：详情/筛选/标签弹层
- 轨道 E：应用聚合与埋点接线

### 回退串行顺序

1. 先收口领域规则和标签规则
2. 再收口页面与弹层
3. 最后统一接控制器、路由和本地化

---

### Task 1: 冻结阶段六共享契约

**Files:**
- Modify: `docs/rhythm-remaining-stages-parallel-implementation-plan-2026-05-24.md`
- Test: `test/features/calendar/calendar_heatmap_rules_test.dart`

- [ ] **Step 1: 复核当前热力图规则测试夹具**

Run: `flutter test test/features/calendar/calendar_heatmap_rules_test.dart -r expanded`
Expected: PASS，说明当前热力等级口径可作为稳定契约继续收口

- [ ] **Step 2: 明确标签模型边界**

锁定：
- 默认标签不超过 8 个
- 自定义标签长度 1-12
- 标签保存只绑定归属日与展示记录，不提前引入远端同步字段

- [ ] **Step 3: 记录当前共享字段清单**

把 `CalendarDaySummary`、`CalendarFilter`、`SleepDelayTag` 当前字段名写入阶段总计划备注，执行期间不随意改名。

---

### Task 2: 收口日历领域规则

**Files:**
- Modify: `lib/features/calendar/domain/calendar_day_summary.dart`
- Modify: `lib/features/calendar/domain/calendar_filter.dart`
- Modify: `lib/features/calendar/domain/calendar_heat_level.dart`
- Modify: `lib/features/calendar/domain/calendar_heatmap_rules.dart`
- Modify: `lib/features/calendar/domain/calendar_month_summary.dart`
- Modify: `test/features/calendar/calendar_heatmap_rules_test.dart`

- [ ] **Step 1: 补失败测试，锁定目标作息变化会影响热力等级**

```dart
test('同一条记录在不同目标入睡时间下热力等级不同', () {
  final earlyTarget = buildSummary(targetBedtimeMinutes: 22 * 60 + 30);
  final lateTarget = buildSummary(targetBedtimeMinutes: 23 * 60 + 30);

  expect(earlyTarget.heatLevel, isNot(equals(lateTarget.heatLevel)));
});
```

- [ ] **Step 2: 运行热力规则测试，确认当前缺口**

Run: `flutter test test/features/calendar/calendar_heatmap_rules_test.dart -r expanded`
Expected: FAIL 或缺少该场景断言

- [ ] **Step 3: 收口 `CalendarHeatLevel` 与 `CalendarMonthSummary`**

要求：
- 不再依赖页面层补计算
- 月摘要直接输出达标率、有效记录天数、最晚一晚和连续表现

- [ ] **Step 4: 再跑日历领域测试**

Run: `flutter test test/features/calendar/calendar_heatmap_rules_test.dart -r expanded`
Expected: PASS

---

### Task 3: 收口标签领域与保存逻辑

**Files:**
- Modify: `lib/features/sleep_records/domain/sleep_delay_tag.dart`
- Modify: `lib/features/sleep_records/domain/sleep_delay_tag_rules.dart`
- Modify: `lib/features/sleep_records/domain/repositories/sleep_delay_tag_repository.dart`
- Modify: `lib/features/sleep_records/data/in_memory_sleep_delay_tag_repository.dart`
- Modify: `lib/features/sleep_records/application/sleep_delay_tag_controller.dart`
- Modify: `test/features/sleep_records/sleep_delay_tag_rules_test.dart`
- Modify: `test/features/sleep_records/sleep_delay_tag_controller_test.dart`

- [ ] **Step 1: 补失败测试，锁定重复标签不会重复保存**

```dart
test('保存包含重复默认标签时会自动去重', () async {
  final result = SleepDelayTagRules.normalize([
    '刷手机',
    '刷手机',
    '追剧',
  ]);

  expect(result, ['刷手机', '追剧']);
});
```

- [ ] **Step 2: 运行标签规则测试**

Run: `flutter test test/features/sleep_records/sleep_delay_tag_rules_test.dart -r expanded`
Expected: FAIL 或覆盖不足

- [ ] **Step 3: 收口标签控制器返回口径**

要求：
- 保存成功后能刷新依赖方
- 不把 Snackbar 文案硬编码在控制器层
- 不在此阶段引入远端同步耦合

- [ ] **Step 4: 运行标签相关测试**

Run: `flutter test test/features/sleep_records/sleep_delay_tag_rules_test.dart test/features/sleep_records/sleep_delay_tag_controller_test.dart -r expanded`
Expected: PASS

---

### Task 4: 收口日历页面与热力图组件

**Files:**
- Modify: `lib/features/calendar/presentation/calendar_page.dart`
- Modify: `lib/features/calendar/presentation/widgets/calendar_heatmap.dart`
- Modify: `test/features/calendar/calendar_page_test.dart`
- Modify: `test/features/calendar/calendar_page_analytics_flow_test.dart`

- [ ] **Step 1: 用 Pencil MCP 复核 `nBLqq` 首屏层级**

核对：
- 顶部标题与副标题
- 月历容器位置
- 摘要卡顺序
- 底部导航占位高度

- [ ] **Step 2: 补失败测试，锁定无记录月份仍要显示完整网格**

```dart
testWidgets('无记录月份仍展示完整月历网格', (tester) async {
  await pumpCalendarPage(tester, state: emptyMonthState());
  expect(find.byType(CalendarHeatmap), findsOneWidget);
});
```

- [ ] **Step 3: 运行页面测试，确认缺口**

Run: `flutter test test/features/calendar/calendar_page_test.dart -r expanded`
Expected: FAIL 或断言不足

- [ ] **Step 4: 收口热力图组件输入边界**

要求：
- 只消费月摘要/日摘要
- 不直接读 Provider
- 不在组件内部算业务规则

- [ ] **Step 5: 再跑页面相关测试**

Run: `flutter test test/features/calendar/calendar_page_test.dart test/features/calendar/calendar_page_analytics_flow_test.dart -r expanded`
Expected: PASS

---

### Task 5: 收口详情、筛选与标签弹层

**Files:**
- Modify: `lib/features/calendar/presentation/widgets/sheets/calendar_day_detail_sheet.dart`
- Modify: `lib/features/calendar/presentation/widgets/sheets/calendar_filter_sheet.dart`
- Modify: `lib/features/sleep_records/presentation/widgets/sheets/sleep_delay_tag_picker_sheet.dart`
- Modify: `lib/features/sleep_records/presentation/widgets/sheets/custom_delay_tag_sheet.dart`
- Modify: `test/features/calendar/calendar_day_detail_sheet_test.dart`
- Modify: `test/features/calendar/calendar_filter_sheet_test.dart`
- Modify: `test/features/sleep_records/sleep_delay_tag_picker_sheet_test.dart`
- Modify: `test/features/sleep_records/custom_delay_tag_sheet_test.dart`

- [ ] **Step 1: 用 Pencil MCP 复核 `Q2xhiP` 与 `ZQBCz`**

核对：
- 底部弹层布局
- 轻提示/说明承载形态
- 自定义标签输入反馈

- [ ] **Step 2: 补失败测试，锁定保存标签后会关闭弹层并回调刷新**

```dart
testWidgets('保存标签后触发 onSave 并关闭弹层', (tester) async {
  var saved = false;
  await pumpTagSheet(tester, onSave: (_) => saved = true);
  await tester.tap(find.text('保存'));
  await tester.pumpAndSettle();
  expect(saved, isTrue);
});
```

- [ ] **Step 3: 运行弹层测试**

Run: `flutter test test/features/calendar/calendar_day_detail_sheet_test.dart test/features/calendar/calendar_filter_sheet_test.dart test/features/sleep_records/sleep_delay_tag_picker_sheet_test.dart test/features/sleep_records/custom_delay_tag_sheet_test.dart -r expanded`
Expected: FAIL 或覆盖不足

- [ ] **Step 4: 收口弹层回调和关闭时机**

要求：
- 弹层不直接写共享路由
- 标签保存、筛选应用、编辑入口都通过回调抛给页面层
- 不叠加双层主弹层

- [ ] **Step 5: 再跑弹层测试**

Run: 同上
Expected: PASS

---

### Task 6: 收口控制器、路由、本地化和埋点

**Files:**
- Modify: `lib/features/calendar/application/calendar_controller.dart`
- Modify: `lib/features/calendar/application/calendar_view_state.dart`
- Modify: `lib/features/calendar/application/calendar_analytics.dart`
- Modify: `lib/app/router/app_router.dart`
- Modify: `lib/l10n/app_en.arb`
- Modify: `lib/l10n/app_zh.arb`
- Create: `test/features/calendar/calendar_integration_surface_test.dart`

- [ ] **Step 1: 补失败测试，锁定标签保存后日详情会刷新**

```dart
test('保存标签后会刷新选中日摘要', () async {
  final controller = buildControllerWithTagSave();
  await controller.saveTags(...);
  expect(controller.debugState.selectedDay?.tags, isNotEmpty);
});
```

- [ ] **Step 2: 运行控制器测试**

Run: `flutter test test/features/calendar/calendar_controller_test.dart -r expanded`
Expected: FAIL 或缺少刷新场景

- [ ] **Step 3: 统一补文案并生成本地化**

Run: `flutter gen-l10n`
Expected: PASS

- [ ] **Step 4: 增加交互面测试**

Run: `flutter test test/features/calendar/calendar_integration_surface_test.dart -r expanded`
Expected: PASS

- [ ] **Step 5: 跑阶段六专项测试和全量测试**

Run:

```bash
flutter test test/features/calendar test/features/sleep_records -r expanded
flutter test
```

Expected: PASS

---

### Task 7: 运行 GitNexus 变更检测并提交

**Files:**
- Modify: `docs/rhythm-remaining-stages-parallel-implementation-plan-2026-05-24.md`

- [ ] **Step 1: 运行变更检测**

Run: `npx gitnexus detect_changes`
Expected: 影响范围集中在 `calendar`、`sleep_records`、`router`、`l10n` 和对应测试

- [ ] **Step 2: 提交阶段六收口**

```bash
git add lib/features/calendar lib/features/sleep_records lib/app/router lib/l10n test/features/calendar test/features/sleep_records docs/superpowers/plans/2026-05-24-stage6-calendar-tag-closure.md
git commit -m "feat: close stage six calendar and tags"
```
