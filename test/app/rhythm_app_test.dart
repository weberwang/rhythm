import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../support/test_app.dart';

/// 验证根应用在不同首次引导状态下维持既有主题与主导航行为。
void main() {
  testWidgets('英文环境下首页和底部导航文案使用国际化资源', (tester) async {
    await pumpRhythmApp(
      tester,
      onboardingCompleted: true,
      locale: const Locale('en'),
    );
    await tester.pumpAndSettle();

    expect(find.text('Today'), findsWidgets);
    expect(find.text('Calendar'), findsOneWidget);
    expect(find.text('Set a sleep goal first'), findsOneWidget);
    await tester.tap(find.text('Bedtime'));
    await tester.pumpAndSettle();
    expect(find.text('Set tonight’s target first'), findsOneWidget);
  });

  testWidgets('应用同时挂载亮色和暗色主题并跟随系统', (tester) async {
    await pumpRhythmApp(tester, onboardingCompleted: true);

    final materialApp = tester.widget<MaterialApp>(find.byType(MaterialApp));

    expect(materialApp.theme, isNotNull);
    expect(materialApp.darkTheme, isNotNull);
    expect(materialApp.themeMode, ThemeMode.system);
    expect(materialApp.darkTheme!.brightness, Brightness.dark);
    expect(
      materialApp.darkTheme!.scaffoldBackgroundColor,
      isNot(equals(materialApp.theme!.scaffoldBackgroundColor)),
    );
  });

  testWidgets('首次打开默认进入引导流', (tester) async {
    await pumpRhythmApp(tester, onboardingCompleted: false);
    await tester.pumpAndSettle();

    expect(find.text('先把节奏跑起来'), findsOneWidget);
  });

  testWidgets('完成引导后展示五个一级模块并默认进入今日页', (tester) async {
    await pumpRhythmApp(tester, onboardingCompleted: true);
    await tester.pumpAndSettle();

    expect(find.text('今日'), findsWidgets);
    expect(find.text('日历'), findsOneWidget);
    expect(find.text('睡前'), findsOneWidget);
    expect(find.text('洞察'), findsOneWidget);
    expect(find.text('我的'), findsOneWidget);
    expect(find.text('还没有设置作息目标'), findsOneWidget);
  });

  testWidgets('点击底部模块后切换到对应页面', (tester) async {
    await pumpRhythmApp(tester, onboardingCompleted: true);
    await tester.pumpAndSettle();

    await tester.tap(find.text('日历'));
    await tester.pumpAndSettle();

    expect(find.text('用热力图看清最近的作息节奏。'), findsOneWidget);

    await tester.tap(find.text('睡前'));
    await tester.pumpAndSettle();

    expect(find.text('还没有设置今晚目标'), findsOneWidget);
  });
}
