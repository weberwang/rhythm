import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../support/test_app.dart';

/// 验证首次引导会按欢迎、登录选择、健康权限顺序推进。
void main() {
  testWidgets('欢迎页到匿名登录再到健康权限说明后可跳转目标设置', (tester) async {
    await pumpRhythmApp(tester, onboardingCompleted: false);
    await tester.pumpAndSettle();

    expect(find.text('欢迎使用 Rhythm'), findsOneWidget);

    await tester.ensureVisible(find.text('开始设置'));
    await tester.tap(find.text('开始设置'));
    await tester.pumpAndSettle();

    expect(find.text('今晚开始，慢慢早一点睡'), findsOneWidget);
    expect(find.text('使用邮箱继续'), findsOneWidget);

    await tester.ensureVisible(find.text('使用匿名继续'));
    await tester.tap(find.text('使用匿名继续'));
    await tester.pumpAndSettle();

    expect(find.text('让系统帮你记录昨晚的睡眠'), findsOneWidget);

    await tester.ensureVisible(find.text('先手动记录'));
    await tester.tap(find.text('先手动记录'));
    await tester.pumpAndSettle();

    expect(find.text('先定一个你想靠近的作息'), findsWidgets);
  });

  testWidgets('点击开始后立即切换到登录步骤', (tester) async {
    await pumpRhythmApp(tester, onboardingCompleted: false);
    await tester.pumpAndSettle();

    await tester.ensureVisible(find.text('开始设置'));
    await tester.tap(find.text('开始设置'));
    await tester.pump();

    expect(find.text('今晚开始，慢慢早一点睡'), findsOneWidget);
  });

  testWidgets('英文环境下首次引导不会混入中文文案', (tester) async {
    await pumpRhythmApp(
      tester,
      onboardingCompleted: false,
      locale: const Locale('en'),
    );
    await tester.pumpAndSettle();

    expect(find.text('Welcome to Rhythm'), findsOneWidget);
    expect(find.text('今晚开始，慢慢早一点睡'), findsNothing);

    await tester.ensureVisible(find.text('Start setup'));
    await tester.tap(find.text('Start setup'));
    await tester.pumpAndSettle();

    expect(
      find.text('Starting tonight, shift a little earlier'),
      findsOneWidget,
    );
    expect(find.text('Continue with email'), findsOneWidget);
    expect(find.text('Continue as guest'), findsOneWidget);

    await tester.ensureVisible(find.text('Continue as guest'));
    await tester.tap(find.text('Continue as guest'));
    await tester.pumpAndSettle();

    expect(find.text('Let Rhythm log last night for you'), findsOneWidget);
    expect(find.text('Log manually first'), findsOneWidget);

    await tester.ensureVisible(find.text('Log manually first'));
    await tester.tap(find.text('Log manually first'));
    await tester.pumpAndSettle();

    expect(find.text('Set the rhythm you want to move toward'), findsWidgets);
  });
}
