import 'package:flutter_test/flutter_test.dart';

import '../../support/test_app.dart';

/// 验证首次引导会按欢迎、登录选择、健康权限顺序推进。
void main() {
  testWidgets('欢迎页到匿名登录再到健康权限说明后可跳转目标设置', (tester) async {
    await pumpRhythmApp(tester, onboardingCompleted: false);
    await tester.pumpAndSettle();

    expect(find.text('先把节奏跑起来'), findsOneWidget);

    await tester.tap(find.text('开始建立我的作息目标'));
    await tester.pumpAndSettle();

    expect(find.text('先把节奏跑起来，登录只在需要同步时再做。'), findsOneWidget);

    await tester.tap(find.text('匿名进入'));
    await tester.pumpAndSettle();

    expect(find.text('读取睡眠数据'), findsOneWidget);

    await tester.tap(find.text('先用手动模式'));
    await tester.pumpAndSettle();

    expect(find.text('目标是节律的参考线，不是每天必须完美做到的红线。'), findsOneWidget);
  });

  testWidgets('点击开始后立即切换到登录步骤', (tester) async {
    await pumpRhythmApp(tester, onboardingCompleted: false);
    await tester.pumpAndSettle();

    await tester.tap(find.text('开始建立我的作息目标'));
    await tester.pump();

    expect(
      find.text('先把节奏跑起来，登录只在需要同步时再做。'),
      findsOneWidget,
    );
  });
}
