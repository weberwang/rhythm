import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rhythm/core/time/time_context.dart';
import 'package:rhythm/core/time/time_context_provider.dart';
import 'package:rhythm/features/goal_schedule/presentation/timezone_mode_page.dart';
import 'package:rhythm/l10n/app_localizations.dart';

/// 验证时区页只展示面向用户的规则说明，不再出现研发占位文案。
void main() {
  testWidgets('时区页展示用户规则说明并移除研发文案', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          timeContextProvider.overrideWithValue(
            TimeContext(
              now: DateTime.utc(2026, 5, 24, 20),
              timezoneName: 'Asia/Shanghai',
            ),
          ),
        ],
        child: MaterialApp(
          locale: const Locale('zh'),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: const Scaffold(body: TimezoneModePage()),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('时区与记录归属'), findsOneWidget);
    expect(
      find.text('这里会说明时区变化对记录归属的影响，以及特殊作息的处理方式。'),
      findsOneWidget,
    );
    expect(find.text('Asia/Shanghai'), findsOneWidget);
    expect(find.text('特殊情况'), findsOneWidget);
    expect(find.textContaining('V0.1'), findsNothing);
    expect(find.textContaining('占位'), findsNothing);
    expect(find.byIcon(Icons.arrow_back_ios_new_rounded), findsOneWidget);
  });
}
