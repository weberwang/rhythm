import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rhythm/features/sleep_records/presentation/widgets/sheets/record_source_explainer_sheet.dart';
import 'package:rhythm/l10n/app_localizations.dart';

/// 验证数据来源说明弹层会展示来源、修正与可信度说明。
void main() {
  testWidgets('数据来源说明弹层展示核心说明内容', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        locale: const Locale('zh'),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: const Scaffold(
          body: RecordSourceExplainerSheet(),
        ),
      ),
    );

    expect(find.text('数据来源说明'), findsOneWidget);
    expect(find.text('HealthKit'), findsOneWidget);
    expect(find.text('手动修正'), findsAtLeastNWidgets(2));
    expect(find.text('可信度'), findsAtLeastNWidgets(2));
    expect(find.text('系统来源'), findsOneWidget);
    expect(find.text('手动修改不会覆盖原始记录，而是生成一条用户确认结果，供今日页和日历优先展示。'), findsOneWidget);
  });
}
