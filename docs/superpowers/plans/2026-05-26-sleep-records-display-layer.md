# Sleep Records Display Layer Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** 对齐 `sleep_records` 模块在 Pencil 已覆盖范围内的显示层，包括手动补录页、晚睡原因标签弹层、自定义标签弹层与数据来源说明弹层。

**Architecture:** 保持 `sleep_records_hub_page.dart` 现有结构不变，仅在 Pencil 已覆盖的页面和弹层内补齐视觉结构、入口承接与测试。新增的数据来源说明弹层作为独立展示组件落在 `presentation/widgets/sheets/`，由手动补录页先接入，后续供日历详情页复用。

**Tech Stack:** Flutter、hooks_riverpod、GoRouter、Flutter l10n、Widget Test

---

### Task 1: 补齐数据来源说明弹层显示层

**Files:**
- Create: `lib/features/sleep_records/presentation/widgets/sheets/record_source_explainer_sheet.dart`
- Modify: `lib/l10n/app_en.arb`
- Modify: `lib/l10n/app_zh.arb`
- Test: `test/features/sleep_records/record_source_explainer_sheet_test.dart`

- [ ] **Step 1: 写弹层测试**

```dart
testWidgets('数据来源说明弹层展示来源、可信度与修正说明', (tester) async {
  await tester.pumpWidget(
    const MaterialApp(
      home: Scaffold(
        body: RecordSourceExplainerSheet(),
      ),
    ),
  );

  expect(find.text('数据来源说明'), findsOneWidget);
  expect(find.text('HealthKit'), findsOneWidget);
  expect(find.text('手动修正'), findsOneWidget);
  expect(find.text('可信度'), findsOneWidget);
});
```

- [ ] **Step 2: 运行测试确认失败**

Run: `flutter test test/features/sleep_records/record_source_explainer_sheet_test.dart`
Expected: FAIL，提示 `RecordSourceExplainerSheet` 未定义

- [ ] **Step 3: 实现最小弹层组件与国际化文案**

```dart
/// 数据来源说明弹层，用于解释系统来源、手动修正与可信度语义。
class RecordSourceExplainerSheet extends StatelessWidget {
  const RecordSourceExplainerSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 18, 20, 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(l10n.recordSourceExplainerTitle),
              const SizedBox(height: 12),
              Text(l10n.recordSourceExplainerDescription),
              const SizedBox(height: 16),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  _SourceChip(label: l10n.recordSourceExplainerChipHealthKit),
                  _SourceChip(label: l10n.recordSourceExplainerChipManual),
                  _SourceChip(label: l10n.recordSourceExplainerChipConfidence),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
```

- [ ] **Step 4: 运行测试确认通过**

Run: `flutter test test/features/sleep_records/record_source_explainer_sheet_test.dart`
Expected: PASS

- [ ] **Step 5: 提交阶段性变更**

```bash
git add lib/features/sleep_records/presentation/widgets/sheets/record_source_explainer_sheet.dart lib/l10n/app_en.arb lib/l10n/app_zh.arb test/features/sleep_records/record_source_explainer_sheet_test.dart
git commit -m "feat: add record source explainer sheet"
```

### Task 2: 对齐手动补录页与来源说明入口

**Files:**
- Modify: `lib/features/sleep_records/presentation/manual_sleep_record_page.dart`
- Modify: `test/features/sleep_records/manual_sleep_record_page_test.dart`
- Test: `test/features/sleep_records/manual_sleep_record_save_flow_test.dart`

- [ ] **Step 1: 写失败测试覆盖来源说明入口**

```dart
testWidgets('手动补录页点击数据来源后打开说明弹层', (tester) async {
  await _pumpManualSleepRecordPage(tester);

  await tester.tap(find.text('手动修正'));
  await tester.pumpAndSettle();

  expect(find.text('数据来源说明'), findsOneWidget);
});
```

- [ ] **Step 2: 运行测试确认失败**

Run: `flutter test test/features/sleep_records/manual_sleep_record_page_test.dart`
Expected: FAIL，提示未找到可点击的来源入口或说明弹层

- [ ] **Step 3: 改造手动补录页来源区**

```dart
SleepRecordSummaryRow(
  label: l10n.manualSleepRecordSourceLabel,
  value: l10n.manualSleepRecordSourceValue,
  onTap: () async {
    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (_) => const RecordSourceExplainerSheet(),
    );
  },
)
```

- [ ] **Step 4: 运行页面相关测试**

Run: `flutter test test/features/sleep_records/manual_sleep_record_page_test.dart test/features/sleep_records/manual_sleep_record_save_flow_test.dart`
Expected: PASS

- [ ] **Step 5: 提交阶段性变更**

```bash
git add lib/features/sleep_records/presentation/manual_sleep_record_page.dart test/features/sleep_records/manual_sleep_record_page_test.dart test/features/sleep_records/manual_sleep_record_save_flow_test.dart
git commit -m "feat: align manual sleep record source sheet"
```

### Task 3: 校准标签弹层与补录页视觉层回归

**Files:**
- Modify: `lib/features/sleep_records/presentation/widgets/sheets/sleep_delay_tag_picker_sheet.dart`
- Modify: `lib/features/sleep_records/presentation/widgets/sheets/custom_delay_tag_sheet.dart`
- Test: `test/features/sleep_records/sleep_delay_tag_picker_sheet_test.dart`
- Test: `test/features/sleep_records/custom_delay_tag_sheet_test.dart`

- [ ] **Step 1: 检查并补测试断言**

```dart
expect(find.text('晚睡原因标签'), findsOneWidget);
expect(find.text('自定义标签'), findsOneWidget);
expect(find.text('数据来源说明'), findsNothing);
```

- [ ] **Step 2: 运行标签弹层测试**

Run: `flutter test test/features/sleep_records/sleep_delay_tag_picker_sheet_test.dart test/features/sleep_records/custom_delay_tag_sheet_test.dart`
Expected: 若标题或按钮文案与设计稿不一致则 FAIL

- [ ] **Step 3: 最小调整标题、说明和按钮层级**

```dart
Text(l10n.sleepDelayTagPickerTitle)
Text(l10n.sleepDelayTagPickerDescription)
FilledButton(...)
TextButton(...)
```

- [ ] **Step 4: 再跑标签与补录相关测试**

Run: `flutter test test/features/sleep_records/sleep_delay_tag_picker_sheet_test.dart test/features/sleep_records/custom_delay_tag_sheet_test.dart test/features/sleep_records/manual_sleep_record_page_test.dart`
Expected: PASS

- [ ] **Step 5: 提交阶段性变更**

```bash
git add lib/features/sleep_records/presentation/widgets/sheets/sleep_delay_tag_picker_sheet.dart lib/features/sleep_records/presentation/widgets/sheets/custom_delay_tag_sheet.dart test/features/sleep_records/sleep_delay_tag_picker_sheet_test.dart test/features/sleep_records/custom_delay_tag_sheet_test.dart test/features/sleep_records/manual_sleep_record_page_test.dart
git commit -m "test: align sleep record display layer coverage"
```
