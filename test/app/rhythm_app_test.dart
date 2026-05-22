import 'package:flutter_test/flutter_test.dart';
import 'package:rhythm/app/rhythm_app.dart';

void main() {
  testWidgets('启动后展示五个一级模块并默认进入今日页', (tester) async {
    await tester.pumpWidget(const RhythmApp());

    expect(find.text('今日'), findsWidgets);
    expect(find.text('日历'), findsOneWidget);
    expect(find.text('睡前'), findsOneWidget);
    expect(find.text('洞察'), findsOneWidget);
    expect(find.text('我的'), findsOneWidget);
    expect(find.text('今晚先轻一点'), findsOneWidget);
  });

  testWidgets('点击底部模块后切换到对应页面', (tester) async {
    await tester.pumpWidget(const RhythmApp());

    await tester.tap(find.text('日历'));
    await tester.pumpAndSettle();

    expect(find.text('用热力图看清最近的作息节奏。'), findsOneWidget);
  });
}
