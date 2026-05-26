import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../support/test_app.dart';

/// 验证首次引导会按欢迎、登录选择、健康权限顺序推进。
void main() {
  testWidgets('欢迎页到匿名登录再到健康权限说明后可跳转目标设置', (tester) async {
    await pumpRhythmApp(tester, onboardingCompleted: false);
    await tester.pumpAndSettle();

    expect(find.text('欢迎使用 Rhythm'), findsOneWidget);

    await tester.tap(find.text('开始设置'));
    await tester.pumpAndSettle();

    expect(find.text('先把节奏跑起来，登录只在需要同步时再做。'), findsOneWidget);

    await tester.tap(find.text('匿名进入'));
    await tester.pumpAndSettle();

    expect(find.text('读取睡眠数据'), findsOneWidget);

    await tester.tap(find.text('先用手动模式'));
    await tester.pumpAndSettle();

    // 目标设置页会同时在页头和主标题区复用同一文案，这里显式校验双处渲染。
    expect(find.text('目标是节律的参考线，不是每天必须完美做到的红线。'), findsNWidgets(2));
  });

  testWidgets('点击开始后立即切换到登录步骤', (tester) async {
    await pumpRhythmApp(tester, onboardingCompleted: false);
    await tester.pumpAndSettle();

    await tester.tap(find.text('开始设置'));
    await tester.pump();

    expect(find.text('先把节奏跑起来，登录只在需要同步时再做。'), findsOneWidget);
  });

  testWidgets('英文环境下首次引导不会混入中文文案', (tester) async {
    await pumpRhythmApp(
      tester,
      onboardingCompleted: false,
      locale: const Locale('en'),
    );
    await tester.pumpAndSettle();

    expect(find.text('Welcome to Rhythm'), findsOneWidget);
    expect(find.text('先把节奏跑起来'), findsNothing);

    await tester.tap(find.text('Start setup'));
    await tester.pumpAndSettle();

    expect(
      find.text(
        'Get the rhythm moving first; sign in only when sync is needed.',
      ),
      findsOneWidget,
    );
    expect(find.text('Continue anonymously'), findsOneWidget);

    await tester.tap(find.text('Continue anonymously'));
    await tester.pumpAndSettle();

    expect(find.text('Read sleep data'), findsOneWidget);
    expect(find.text('Use manual mode first'), findsOneWidget);

    await tester.tap(find.text('Use manual mode first'));
    await tester.pumpAndSettle();

    expect(
      find.text(
        'The target is a reference line, not a perfect daily red line.',
      ),
      // 英文目标设置页同样会在页头和主标题区复用标题文案。
      findsNWidgets(2),
    );
    expect(find.text('Workday rule'), findsOneWidget);
  });
}
