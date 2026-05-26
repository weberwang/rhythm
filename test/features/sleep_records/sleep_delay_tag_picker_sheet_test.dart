import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rhythm/features/sleep_records/domain/sleep_delay_tag_rules.dart';
import 'package:rhythm/features/sleep_records/presentation/widgets/sheets/sleep_delay_tag_picker_sheet.dart';
import 'package:rhythm/l10n/app_localizations.dart';

/// 验证晚睡原因标签弹层的选择、嵌套弹层和宽度布局行为。
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

  testWidgets('自定义标签输入无效时在弹层内显示错误', (tester) async {
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

  testWidgets('底部标签弹层保持全屏宽度', (tester) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(
      MaterialApp(
        locale: const Locale('zh'),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Builder(
          builder: (context) {
            return Scaffold(
              body: Center(
                child: FilledButton(
                  onPressed: () {
                    showModalBottomSheet<void>(
                      context: context,
                      isScrollControlled: true,
                      builder: (_) {
                        return SleepDelayTagPickerSheet(
                          tags: SleepDelayTagRules.defaultTags,
                          selectedTags: const <String>[],
                          onSave: (_) {},
                        );
                      },
                    );
                  },
                  child: const Text('open'),
                ),
              ),
            );
          },
        ),
      ),
    );
    await tester.tap(find.text('open'));
    await tester.pumpAndSettle();

    // 标题左侧应只保留内容自身的 20 像素内边距，避免整张底部弹层被额外收窄。
    final titleLeft = tester.getTopLeft(find.text('补一个晚睡原因')).dx;
    expect(titleLeft, 20);
  });
}
