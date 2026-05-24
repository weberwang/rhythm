import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rhythm/features/sleep_records/presentation/widgets/sheets/custom_delay_tag_sheet.dart';
import 'package:rhythm/l10n/app_localizations.dart';

/// 验证自定义标签弹层会回传用户输入。
void main() {
  testWidgets('输入自定义标签后触发保存回调', (tester) async {
    String? saved;

    await tester.pumpWidget(
      MaterialApp(
        locale: const Locale('zh'),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(
          body: CustomDelayTagSheet(
            onSave: (value) async {
              saved = value;
            },
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextField), '临时项目');
    await tester.pumpAndSettle();
    await tester.tap(find.text('保存自定义标签'));
    await tester.pumpAndSettle();

    expect(saved, '临时项目');
  });

  testWidgets('保存空白自定义标签时展示错误且不触发回调', (tester) async {
    String? saved;

    await tester.pumpWidget(
      MaterialApp(
        locale: const Locale('zh'),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(
          body: CustomDelayTagSheet(
            onSave: (value) async {
              saved = value;
            },
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextField), '   ');
    await tester.pumpAndSettle();
    await tester.tap(find.text('保存自定义标签'));
    await tester.pumpAndSettle();

    expect(saved, isNull);
    expect(find.text('请输入原因标签'), findsOneWidget);
  });
}
