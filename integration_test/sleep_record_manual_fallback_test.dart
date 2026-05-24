import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:rhythm/features/sleep_records/application/sleep_record_providers.dart';
import 'package:rhythm/features/sleep_records/domain/health_platform_state.dart';

import '../test/support/sleep_records_test_app.dart';
import '../test/support/sleep_records_test_doubles.dart';

/// 锁定阶段三最小降级闭环：Android 不可用时仍可手动补录并回到管理页。
void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Android 不可用时可降级手动补录并生成记录', (tester) async {
    final gateway = TestHealthPermissionGateway(
      platformState: HealthPlatformState.androidUnavailable(),
    );

    await pumpSleepRecordsFlowApp(
      tester,
      overrides: [
        healthPermissionGatewayProvider.overrideWith((ref) => gateway),
      ],
    );
    await tester.pumpAndSettle();

    expect(find.text('当前改用手动补录'), findsOneWidget);
    expect(find.text('改用手动模式'), findsOneWidget);

    await tester.tap(find.text('改用手动模式'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('保存补录结果'));
    await tester.pumpAndSettle();

    expect(find.text('睡眠记录管理'), findsOneWidget);
    expect(find.text('手动补录记录'), findsOneWidget);
  });
}
