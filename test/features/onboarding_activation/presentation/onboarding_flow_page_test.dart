import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rhythm/features/onboarding_activation/presentation/pages/onboarding_flow_page.dart';
import 'package:rhythm/l10n/app_localizations.dart';

/// 验证 onboarding 首屏已从初始化占位页升级为真实激活入口。
void main() {
  testWidgets(
    'onboarding flow shows welcome step and can advance into permission step',
    (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          locale: const Locale('zh'),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: const OnboardingFlowPage(),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('欢迎使用 Rhythm'), findsOneWidget);
    expect(find.text('第 1 步 / 6'), findsOneWidget);
    expect(find.text('开始设置'), findsOneWidget);

    await tester.tap(find.text('开始设置'));
    await tester.pumpAndSettle();

    expect(find.text('选择进入方式'), findsOneWidget);
    expect(find.text('第 2 步 / 6'), findsOneWidget);

    await tester.tap(find.text('先本地开始'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('继续设置'));
    await tester.pumpAndSettle();

    expect(find.text('先理解价值，再决定是否授权'), findsOneWidget);
  });
}
