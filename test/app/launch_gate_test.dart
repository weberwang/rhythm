import 'package:flutter_test/flutter_test.dart';

import '../support/test_app.dart';

/// 验证启动分发会根据首次引导状态进入正确页面。
void main() {
  testWidgets('首次启动时跳转到引导欢迎页', (tester) async {
    await pumpRhythmApp(tester, onboardingCompleted: false);
    await tester.pumpAndSettle();

    expect(find.text('先把节奏跑起来'), findsOneWidget);
    expect(find.text('今晚先轻一点'), findsNothing);
  });

  testWidgets('已完成引导时跳转到今日页', (tester) async {
    await pumpRhythmApp(tester, onboardingCompleted: true);
    await tester.pumpAndSettle();

    expect(find.text('今晚先轻一点'), findsOneWidget);
  });
}
