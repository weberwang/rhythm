import 'package:flutter_test/flutter_test.dart';

import '../../support/test_app.dart';

/// 验证首次引导会按欢迎、登录选择、健康权限、目标设置顺序推进。
void main() {
  testWidgets('欢迎页到匿名登录再到健康权限说明后可跳转目标设置', (tester) async {
    await pumpRhythmApp(tester, onboardingCompleted: false);
    await tester.pumpAndSettle();

    expect(find.text('欢迎使用 Rhythm'), findsOneWidget);

    await tester.tap(find.text('开始设置'));
    await tester.pumpAndSettle();

    expect(find.text('选择你的进入方式'), findsOneWidget);

    await tester.tap(find.text('匿名体验'));
    await tester.pumpAndSettle();

    expect(find.text('连接健康数据，记录会更完整'), findsOneWidget);

    await tester.tap(find.text('先用手动模式'));
    await tester.pumpAndSettle();

    expect(find.text('设置你的目标作息'), findsOneWidget);
  });

  testWidgets('点击开始设置后立即切换到登录方式步骤', (tester) async {
    await pumpRhythmApp(tester, onboardingCompleted: false);
    await tester.pumpAndSettle();

    await tester.tap(find.text('开始设置'));
    await tester.pump();

    expect(find.text('选择你的进入方式'), findsOneWidget);
  });
}
