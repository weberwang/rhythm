import 'package:flutter_test/flutter_test.dart';

import '../../support/test_app.dart';

/// 验证阶段三管理入口已挂到今日占位页，并可进入睡眠记录管理页。
void main() {
  testWidgets('已完成引导后可从今日页进入睡眠记录管理页', (tester) async {
    await pumpRhythmApp(tester, onboardingCompleted: true);
    await tester.pumpAndSettle();

    expect(find.text('今晚先轻一点'), findsOneWidget);

    await tester.tap(find.text('进入睡眠记录管理'));
    await tester.pumpAndSettle();

    expect(find.text('睡眠记录管理'), findsOneWidget);
    expect(find.text('最近 30 天睡眠记录'), findsOneWidget);
    expect(find.text('改用手动模式'), findsOneWidget);
    expect(find.text('来源与可信度'), findsOneWidget);
  });
}
