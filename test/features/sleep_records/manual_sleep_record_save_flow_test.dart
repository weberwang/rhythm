import 'package:flutter_test/flutter_test.dart';

import '../../support/test_app.dart';

/// 验证手动补录保存后会回到管理页并展示新增记录。
void main() {
  testWidgets('手动补录保存后管理页展示新增记录', (tester) async {
    await pumpRhythmApp(tester, onboardingCompleted: true);
    await tester.pumpAndSettle();

    await tester.tap(find.text('进入睡眠记录管理'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('改用手动模式'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('保存补录结果'));
    await tester.pumpAndSettle();

    expect(find.text('睡眠记录管理'), findsOneWidget);
    expect(find.text('手动补录记录'), findsOneWidget);
  });
}
