# 日历页顶部筛选栏语义对齐 Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** 将日历页顶部红框区域从“3 个平级胶囊”重构为“左侧摘要区 + 右侧筛选入口”，修正条件摘要、统计摘要和操作按钮的语义混排问题。

**Architecture:** 新建一个独立的 `CalendarFilterBar` 显示层组件，收口顶部摘要文案映射、唯一操作按钮样式和无障碍语义；`calendar_page.dart` 只负责装配当前筛选状态和统计值，不再直接拼装混合胶囊。实现过程中保持 `CalendarFilter`、`CalendarMonthSummary` 和筛选弹层行为不变，只补顶部国际化键值和页面测试。

**Tech Stack:** Flutter, hooks_riverpod, flutter_test, Flutter l10n, GitNexus

---

## 文件结构

### 新建文件

- `lib/features/calendar/presentation/widgets/calendar_filter_bar.dart`
作用：承接顶部筛选栏显示层，固定“两个只读摘要 + 一个可点击按钮”的组件边界。

### 修改文件

- `lib/features/calendar/presentation/calendar_page.dart`
作用：改为装配 `CalendarFilterBar`，移除页面内混排 `_CalendarChip` / `ActionChip` 的实现。

- `lib/l10n/app_zh.arb`
作用：补齐顶部摘要短文案和筛选按钮语义文案。

- `lib/l10n/app_en.arb`
作用：补齐对应英文文案。

- `test/features/calendar/calendar_page_test.dart`
作用：锁定顶部筛选栏的默认态、单筛选态、双筛选汇总态、弹层打开行为和窄屏稳定性。

### 生成文件

- `lib/l10n/app_localizations*.dart`
作用：由 `flutter gen-l10n` 自动生成，提供新增国际化 getter。

### 执行约束

- 任何代码修改前，先按仓库约束对 `CalendarPage` 相关符号运行 GitNexus 影响分析。
- 任务内不默认执行 `git add`、`git commit`、`git push`；提交动作必须等待用户选择 `仅提交`、`提交并推送` 或 `忽略`。

---

### Task 1: 锁定顶部筛选栏失败测试

**Files:**
- Modify: `test/features/calendar/calendar_page_test.dart`

- [ ] **Step 1: 对 `CalendarPage` 和旧混排辅助符号运行 GitNexus 影响分析**

Run:

- `使用 mcp__gitnexus__.impact({ repo: "rhythm", target: "CalendarPage", file_path: "lib/features/calendar/presentation/calendar_page.dart", kind: "Class", direction: "upstream" })`
- `使用 mcp__gitnexus__.impact({ repo: "rhythm", target: "_buildFilterSummaryChips", file_path: "lib/features/calendar/presentation/calendar_page.dart", kind: "Function", direction: "upstream" })`
- `使用 mcp__gitnexus__.impact({ repo: "rhythm", target: "_CalendarChip", file_path: "lib/features/calendar/presentation/calendar_page.dart", kind: "Class", direction: "upstream" })`

Expected: 风险等级为 `LOW` 或 `MEDIUM`；若任一结果返回 `HIGH` 或 `CRITICAL`，先暂停实现并重新确认改动边界。

- [ ] **Step 2: 在页面测试中新增顶部语义断言**

```dart
testWidgets('顶部筛选栏默认显示条件摘要、统计摘要和唯一操作入口', (
  tester,
) async {
  await pumpPage(tester, state: _readyState());

  expect(find.text('全部日期'), findsOneWidget);
  expect(find.text('晚睡 1 天'), findsOneWidget);
  expect(find.widgetWithText(OutlinedButton, '筛选'), findsOneWidget);
});

testWidgets('仅记录筛选生效时显示短摘要', (tester) async {
  await pumpPage(
    tester,
    state: _readyState(
      activeFilter: const CalendarFilter(onlyRecordedDays: true),
    ),
  );

  expect(find.text('仅记录'), findsOneWidget);
  expect(find.text('全部日期'), findsNothing);
});

testWidgets('双筛选生效时汇总显示已筛选 2 项', (tester) async {
  await pumpPage(
    tester,
    state: _readyState(
      activeFilter: const CalendarFilter(
        onlyRecordedDays: true,
        lateOnly: true,
      ),
    ),
  );

  expect(find.text('已筛选 2 项'), findsOneWidget);
  expect(find.text('只看有记录日期'), findsNothing);
  expect(find.text('只看晚睡日期'), findsNothing);
});

testWidgets('点击筛选按钮会打开筛选弹层', (tester) async {
  await pumpPage(tester, state: _readyState());

  await tester.tap(find.widgetWithText(OutlinedButton, '筛选'));
  await tester.pumpAndSettle();

  expect(find.text('筛选日历反馈'), findsOneWidget);
});

testWidgets('窄屏宽度下顶部筛选栏不溢出', (tester) async {
  await tester.binding.setSurfaceSize(const Size(320, 720));
  addTearDown(() => tester.binding.setSurfaceSize(null));

  await pumpPage(tester, state: _readyState());

  expect(tester.takeException(), isNull);
  expect(find.widgetWithText(OutlinedButton, '筛选'), findsOneWidget);
});
```

- [ ] **Step 3: 运行页面测试，确认顶部语义断言先失败**

Run: `flutter test test/features/calendar/calendar_page_test.dart -r expanded`

Expected: FAIL，至少出现以下一种失败：

- 找不到 `仅记录`
- 找不到 `已筛选 2 项`
- 找不到 `OutlinedButton` 类型的 `筛选` 按钮

---

### Task 2: 补齐顶部筛选栏国际化文案

**Files:**
- Modify: `lib/l10n/app_zh.arb`
- Modify: `lib/l10n/app_en.arb`

- [ ] **Step 1: 在中文 ARB 中加入顶部摘要和无障碍文案**

```json
"calendarFilterSummaryRecorded": "仅记录",
"calendarFilterSummaryLateOnly": "仅晚睡",
"calendarFilterSummaryAppliedCount": "已筛选 {count} 项",
"@calendarFilterSummaryAppliedCount": {
  "placeholders": {
    "count": {
      "type": "int"
    }
  }
},
"calendarFilterOpenSemantics": "打开筛选",
"calendarFilterOpenActiveSemantics": "打开筛选，当前已启用筛选",
```

- [ ] **Step 2: 在英文 ARB 中补齐对应文案**

```json
"calendarFilterSummaryRecorded": "Recorded only",
"calendarFilterSummaryLateOnly": "Late only",
"calendarFilterSummaryAppliedCount": "{count} filters on",
"@calendarFilterSummaryAppliedCount": {
  "placeholders": {
    "count": {
      "type": "int"
    }
  }
},
"calendarFilterOpenSemantics": "Open filters",
"calendarFilterOpenActiveSemantics": "Open filters, filters are active",
```

- [ ] **Step 3: 生成本地化代码**

Run: `flutter gen-l10n`

Expected: PASS，`lib/l10n/app_localizations*.dart` 更新且无生成错误。

---

### Task 3: 提取筛选栏组件并接入日历页

**Files:**
- Create: `lib/features/calendar/presentation/widgets/calendar_filter_bar.dart`
- Modify: `lib/features/calendar/presentation/calendar_page.dart`

- [ ] **Step 1: 新建 `CalendarFilterBar` 组件文件**

```dart
import 'package:flutter/material.dart';
import 'package:rhythm/app/theme/app_theme_tokens.dart';
import 'package:rhythm/features/calendar/domain/calendar_filter.dart';
import 'package:rhythm/l10n/app_localizations.dart';

/// 承接日历页顶部筛选栏，固定摘要区与操作区的语义边界。
class CalendarFilterBar extends StatelessWidget {
  /// 创建顶部筛选栏实例。
  const CalendarFilterBar({
    super.key,
    required this.l10n,
    required this.tokens,
    required this.activeFilter,
    required this.lateCount,
    required this.onOpenFilter,
  });

  final AppLocalizations l10n;
  final AppThemeTokens tokens;
  final CalendarFilter activeFilter;
  final int lateCount;
  final VoidCallback onOpenFilter;

  @override
  Widget build(BuildContext context) {
    final conditionLabel = _buildConditionLabel(l10n, activeFilter);
    final hasActiveFilter =
        activeFilter.onlyRecordedDays || activeFilter.lateOnly;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _CalendarSummaryChip(
                label: conditionLabel,
                backgroundColor: tokens.successSurface,
                foregroundColor: tokens.primary,
              ),
              _CalendarSummaryChip(
                label: l10n.calendarFilterLateCountSummary(lateCount),
                backgroundColor: tokens.surface,
                foregroundColor: tokens.textSecondary,
              ),
            ],
          ),
        ),
        const SizedBox(width: 12),
        _CalendarFilterButton(
          label: l10n.calendarFilterOpen,
          semanticsLabel: hasActiveFilter
              ? l10n.calendarFilterOpenActiveSemantics
              : l10n.calendarFilterOpenSemantics,
          isActive: hasActiveFilter,
          tokens: tokens,
          onPressed: onOpenFilter,
        ),
      ],
    );
  }
}

/// 根据当前筛选状态输出顶部条件摘要短文案。
String _buildConditionLabel(
  AppLocalizations l10n,
  CalendarFilter activeFilter,
) {
  final activeCount = [
    activeFilter.onlyRecordedDays,
    activeFilter.lateOnly,
  ].where((value) => value).length;

  if (activeCount > 1) {
    return l10n.calendarFilterSummaryAppliedCount(activeCount);
  }
  if (activeFilter.onlyRecordedDays) {
    return l10n.calendarFilterSummaryRecorded;
  }
  if (activeFilter.lateOnly) {
    return l10n.calendarFilterSummaryLateOnly;
  }
  return l10n.calendarFilterAllDays;
}

/// 只读摘要胶囊，专门承接条件和统计信息。
class _CalendarSummaryChip extends StatelessWidget {
  const _CalendarSummaryChip({
    required this.label,
    required this.backgroundColor,
    required this.foregroundColor,
  });

  final String label;
  final Color backgroundColor;
  final Color foregroundColor;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      readOnly: true,
      child: ConstrainedBox(
        constraints: const BoxConstraints(minHeight: 48),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(24),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Text(
              label,
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                color: foregroundColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// 顶部唯一筛选操作按钮，统一承接交互与激活态。
class _CalendarFilterButton extends StatelessWidget {
  const _CalendarFilterButton({
    required this.label,
    required this.semanticsLabel,
    required this.isActive,
    required this.tokens,
    required this.onPressed,
  });

  final String label;
  final String semanticsLabel;
  final bool isActive;
  final AppThemeTokens tokens;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: semanticsLabel,
      child: OutlinedButton.icon(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          minimumSize: const Size(0, 48),
          padding: const EdgeInsets.symmetric(horizontal: 18),
          side: BorderSide(
            color: isActive ? tokens.primary : tokens.divider,
          ),
          backgroundColor: isActive ? tokens.surfaceElevated : null,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
        ),
        icon: const Icon(Icons.tune_rounded, size: 18),
        label: Text(
          label,
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
            color: tokens.textPrimary,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
```

- [ ] **Step 2: 在 `calendar_page.dart` 中接入新组件并移除旧混排实现**

```dart
import 'package:rhythm/features/calendar/presentation/widgets/calendar_filter_bar.dart';
```

```dart
final monthSummary = state.monthSummary!;
final lateCount = monthSummary.days
    .where((day) => day.heatLevel == CalendarHeatLevel.late)
    .length;
final monthLabel = _formatMonthLabel(context, monthSummary.month);
```

```dart
CalendarFilterBar(
  l10n: l10n,
  tokens: tokens,
  activeFilter: state.activeFilter,
  lateCount: lateCount,
  onOpenFilter: () => _showFilterSheetWithState(
    context,
    state.activeFilter.onlyRecordedDays,
    state.activeFilter.lateOnly,
    ref,
  ),
),
```

```dart
// 删除以下页面内旧实现：
// - _buildFilterSummaryChips(...)
// - _CalendarChip
```

- [ ] **Step 3: 格式化新旧文件**

Run: `dart format lib/features/calendar/presentation/calendar_page.dart lib/features/calendar/presentation/widgets/calendar_filter_bar.dart test/features/calendar/calendar_page_test.dart`

Expected: PASS，三个文件格式化完成且无语法错误。

- [ ] **Step 4: 重新运行页面测试，确认顶部语义测试转为通过**

Run: `flutter test test/features/calendar/calendar_page_test.dart -r expanded`

Expected: PASS，新增顶部语义测试和现有标题/摘要卡测试全部通过。

---

### Task 4: 做回归验证并检查影响范围

**Files:**
- Modify: `test/features/calendar/calendar_page_test.dart`（如前序测试名称或断言需要微调）

- [ ] **Step 1: 运行日历页相关回归测试**

Run: `flutter test test/features/calendar/calendar_page_test.dart test/features/calendar/calendar_page_analytics_flow_test.dart -r expanded`

Expected: PASS，不引入页面渲染或埋点流转回归。

- [ ] **Step 2: 对未提交改动执行 GitNexus 变更检测**

Run: `使用 mcp__gitnexus__.detect_changes({ repo: "rhythm", scope: "all", worktree: "D:\\Projects\\Flutter\\rhythm" })`

Expected: 变更范围集中在以下文件与符号：

- `calendar_page.dart`
- `calendar_filter_bar.dart`
- `app_zh.arb`
- `app_en.arb`
- `calendar_page_test.dart`

若检测到日历页以外的高风险执行流，先停下并复核是否误改了共享符号。

- [ ] **Step 3: 记录结果并等待用户选择提交策略**

Expected: 明确告知用户顶部筛选栏语义对齐已完成验证，但不执行任何 `git add`、`git commit` 或 `git push`，直到用户选择 `仅提交`、`提交并推送` 或 `忽略`。
