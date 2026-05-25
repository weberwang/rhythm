import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:rhythm/app/rhythm_app.dart';

/// 锁定阶段十一主链路，先用红灯测试暴露缺少的集成装配。
void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('首次激活后可进入周报主链路', (tester) async {
    await tester.pumpWidget(const RhythmApp());
    await tester.pumpAndSettle();

    expect(find.text('先把节奏跑起来'), findsOneWidget);
  });
}
