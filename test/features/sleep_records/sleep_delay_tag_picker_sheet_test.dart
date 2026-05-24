import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rhythm/features/sleep_records/domain/sleep_delay_tag_rules.dart';
import 'package:rhythm/features/sleep_records/presentation/widgets/sheets/sleep_delay_tag_picker_sheet.dart';
import 'package:rhythm/l10n/app_localizations.dart';

/// 验证标签选择弹层会展示默认标签并回传用户选择。
void main() {
  testWidgets('点击默认标签后触发保存回调', (tester) async {
    String? selected;

    await tester.pumpWidget(
      MaterialApp(
        locale: const Locale('zh'),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(
          body: SleepDelayTagPickerSheet(
            tags: SleepDelayTagRules.defaultTags,
            selectedTags: const <String>[],
            onSave: (tags) {
              selected = tags.single;
            },
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.text('刷手机'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('保存标签'));
    await tester.pumpAndSettle();

    expect(selected, '刷手机');

    await tester.tap(find.text('自定义标签'));
    await tester.pumpAndSettle();
    expect(find.text('添加自定义原因'), findsOneWidget);
  });

  testWidgets('自定义标签输入无效时在弹层内展示错误', (tester) async {
    String? selected;

    await tester.pumpWidget(
      MaterialApp(
        locale: const Locale('zh'),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(
          body: SleepDelayTagPickerSheet(
            tags: SleepDelayTagRules.defaultTags,
            selectedTags: const <String>[],
            onSave: (tags) {
              selected = tags.single;
            },
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.text('自定义标签'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField), '   ');
    await tester.pumpAndSettle();
    await tester.tap(find.text('保存自定义标签'));
    await tester.pumpAndSettle();

    expect(selected, isNull);
    expect(find.text('请输入原因标签'), findsOneWidget);
  });
}
