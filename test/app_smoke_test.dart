import 'package:flutter_test/flutter_test.dart';
import 'package:rhythm/app/rhythm_app.dart';

/// 应用烟雾测试，确保初始化基线至少可以完成根组件挂载。
void main() {
  testWidgets('Rhythm 应用可以完成根组件挂载', (WidgetTester tester) async {
    await tester.pumpWidget(const RhythmApp());
    await tester.pumpAndSettle();

    expect(find.text('Rhythm'), findsOneWidget);
  });
}
