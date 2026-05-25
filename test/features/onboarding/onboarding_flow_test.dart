import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rhythm/app/rhythm_app.dart';

void main() {
  testWidgets('新用户首次启动时进入首次激活流程', (tester) async {
    await tester.pumpWidget(const ProviderScope(child: RhythmApp()));
    await tester.pumpAndSettle();

    expect(find.text('先把作息节奏安顿下来'), findsOneWidget);
    expect(find.text('开始设置'), findsOneWidget);
    expect(find.text('今晚先轻一点'), findsNothing);
  });

  testWidgets('完成首次激活后进入今日页', (tester) async {
    await tester.pumpWidget(const ProviderScope(child: RhythmApp()));
    await tester.pumpAndSettle();

    await tester.tap(find.text('开始设置'));
    await tester.pumpAndSettle();

    expect(find.text('设置你的目标作息'), findsOneWidget);

    await tester.tap(find.text('继续'));
    await tester.pumpAndSettle();

    expect(find.text('今晚先轻一点'), findsOneWidget);
    expect(find.text('先把作息节奏安顿下来'), findsNothing);
  });
}
