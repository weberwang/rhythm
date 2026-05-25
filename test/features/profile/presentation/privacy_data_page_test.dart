import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rhythm/features/profile/presentation/privacy_data_page.dart';
import 'package:rhythm/l10n/app_localizations.dart';

/// 验证隐私与数据页会展示关键操作入口，且不再展示底部危险提示区域。
void main() {
  testWidgets('隐私页展示操作入口且不展示底部危险提示区域', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        locale: const Locale('zh'),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: const Scaffold(body: PrivacyDataPage()),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('隐私协议'), findsOneWidget);
    expect(find.text('导出数据'), findsOneWidget);
    expect(find.text('删除账号'), findsOneWidget);
    expect(find.text('清空本地数据'), findsOneWidget);
    expect(find.byIcon(Icons.arrow_back_ios_new_rounded), findsOneWidget);
    expect(find.text('危险操作需要二次确认'), findsNothing);
  });

  testWidgets('点击导出数据会弹出确认对话框', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        locale: const Locale('zh'),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: const Scaffold(body: PrivacyDataPage()),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.text('导出数据'));
    await tester.pumpAndSettle();

    expect(find.text('确认导出数据'), findsOneWidget);
  });
}
