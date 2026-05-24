import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rhythm/features/calendar/presentation/widgets/sheets/calendar_filter_sheet.dart';
import 'package:rhythm/l10n/app_localizations.dart';

/// 验证筛选弹层提供应用与重置入口。
void main() {
  testWidgets('筛选弹层展示重置与应用按钮', (tester) async {
    ({bool onlyRecordedDays, bool lateOnly})? appliedValue;
    bool reset = false;

    await tester.pumpWidget(
      MaterialApp(
        locale: const Locale('zh'),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(
          body: CalendarFilterSheet(
            onlyRecordedDays: false,
            lateOnly: false,
            onApply: (value) {
              appliedValue = value;
            },
            onReset: () {
              reset = true;
            },
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.text('重置筛选'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('应用筛选'));
    await tester.pumpAndSettle();

    expect(reset, isTrue);
    expect(appliedValue, isNotNull);
    expect(appliedValue!.onlyRecordedDays, false);
    expect(appliedValue!.lateOnly, false);
  });

  testWidgets('切换开关后仅在点击应用时提交最新筛选', (tester) async {
    ({bool onlyRecordedDays, bool lateOnly})? appliedValue;

    await tester.pumpWidget(
      MaterialApp(
        locale: const Locale('zh'),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(
          body: CalendarFilterSheet(
            onlyRecordedDays: false,
            lateOnly: false,
            onApply: (value) {
              appliedValue = value;
            },
            onReset: () {},
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.text('只看有记录日期'));
    await tester.pumpAndSettle();
    expect(appliedValue, isNull);

    await tester.tap(find.text('应用筛选'));
    await tester.pumpAndSettle();

    expect(appliedValue, isNotNull);
    expect(appliedValue!.onlyRecordedDays, isTrue);
    expect(appliedValue!.lateOnly, isFalse);
  });
}
