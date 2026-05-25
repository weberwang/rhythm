import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rhythm/core/time/time_context.dart';
import 'package:rhythm/core/time/time_context_provider.dart';
import 'package:rhythm/features/goal_schedule/presentation/timezone_mode_page.dart';
import 'package:rhythm/l10n/app_localizations.dart';

/// 验证时区与特殊模式页会展示当前时区和特殊模式说明。
void main() {
  testWidgets('时区页展示当前时区和特殊模式说明', (tester) async {
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

    expect(find.text('先保留边界，再逐渐支持'), findsOneWidget);
    expect(find.text('Asia/Shanghai'), findsOneWidget);
    expect(find.text('特殊模式'), findsOneWidget);
    expect(find.byIcon(Icons.arrow_back_ios_new_rounded), findsOneWidget);
  });
}
