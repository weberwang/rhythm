import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rhythm/app/rhythm_app.dart';
import 'package:rhythm/features/onboarding/application/app_session_controller.dart';

void main() {
  testWidgets('手动补录后在今日页看到最新记录摘要', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          appSessionControllerProvider.overrideWith(
            AppSessionController.new,
          ),
        ],
        child: const RhythmApp(),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.text('开始设置'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('继续'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('手动补录'));
    await tester.pumpAndSettle();

    expect(find.text('补一条睡眠记录'), findsOneWidget);

    await tester.enterText(find.byKey(const Key('fellAsleepField')), '23:40');
    await tester.enterText(find.byKey(const Key('wokeUpField')), '07:20');
    await tester.tap(find.text('保存记录'));
    await tester.pumpAndSettle();

    expect(find.text('最近一条记录：23:40 - 07:20'), findsOneWidget);
  });
}
