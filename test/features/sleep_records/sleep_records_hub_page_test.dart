import 'package:flutter_test/flutter_test.dart';
import 'package:rhythm/features/sleep_records/application/sleep_record_providers.dart';
import 'package:rhythm/features/sleep_records/domain/health_platform_state.dart';

import '../../support/sleep_records_test_app.dart';
import '../../support/sleep_records_test_doubles.dart';

/// 验证阶段三管理页和关键状态分支可从独立路由验收。
void main() {
  testWidgets('睡眠记录管理页展示同步卡、记录列表和手动入口', (tester) async {
    await pumpSleepRecordsFlowApp(tester);
    await tester.pumpAndSettle();

    expect(find.text('睡眠记录管理'), findsOneWidget);
    expect(find.text('最近 30 天睡眠记录'), findsOneWidget);
    expect(find.text('改用手动模式'), findsOneWidget);
    expect(find.text('来源与可信度'), findsOneWidget);
  });

  testWidgets('Android 未安装 Health Connect 时展示安装引导', (tester) async {
    final gateway = TestHealthPermissionGateway(
      platformState: HealthPlatformState.androidInstallRequired(),
    );

    await _pumpSleepRecordsHubPage(
      tester,
      overrides: [
        healthPermissionGatewayProvider.overrideWith((ref) => gateway),
      ],
    );

    expect(find.text('需要安装 Health Connect'), findsOneWidget);
    expect(find.text('安装 Health Connect'), findsOneWidget);

    await tester.tap(find.text('安装 Health Connect'));
    await tester.pumpAndSettle();

    expect(gateway.installOpened, isTrue);
  });

  testWidgets('Android 未授权时展示重新授权入口', (tester) async {
    final gateway = TestHealthPermissionGateway(
      platformState: HealthPlatformState.androidPermissionRequired(),
      requestAccessResult: HealthPlatformState.androidAvailable(),
    );

    await _pumpSleepRecordsHubPage(
      tester,
      overrides: [
        healthPermissionGatewayProvider.overrideWith((ref) => gateway),
      ],
    );

    expect(find.text('需要授权读取睡眠数据'), findsOneWidget);
    expect(find.text('重新授权'), findsOneWidget);

    await tester.tap(find.text('重新授权'));
    await tester.pumpAndSettle();

    expect(gateway.accessRequested, isTrue);
  });

  testWidgets('同步失败时展示重试状态', (tester) async {
    final gateway = TestHealthPermissionGateway(
      platformState: HealthPlatformState.androidAvailable(),
    );
    final dataSource = TestHealthSleepDataSource(
      exception: Exception('sync failed'),
    );

    await _pumpSleepRecordsHubPage(
      tester,
      overrides: [
        healthPermissionGatewayProvider.overrideWith((ref) => gateway),
        healthSleepDataSourceProvider.overrideWith((ref) => dataSource),
      ],
    );

    await tester.tap(find.text('重新同步'));
    await tester.pumpAndSettle();

    expect(find.text('同步失败'), findsOneWidget);
    expect(find.text('这次自动同步没有完成，你可以稍后重试，或直接改用手动补录。'), findsOneWidget);
  });

  testWidgets('同步后无记录时展示手动补录降级状态', (tester) async {
    final gateway = TestHealthPermissionGateway(
      platformState: HealthPlatformState.androidAvailable(),
    );
    final dataSource = TestHealthSleepDataSource(records: const []);

    await _pumpSleepRecordsHubPage(
      tester,
      overrides: [
        healthPermissionGatewayProvider.overrideWith((ref) => gateway),
        healthSleepDataSourceProvider.overrideWith((ref) => dataSource),
      ],
    );

    await tester.tap(find.text('重新同步'));
    await tester.pumpAndSettle();

    expect(find.text('当前改用手动补录'), findsOneWidget);
    expect(find.text('未读取到可用睡眠记录，你仍可手动确认昨晚的睡眠结果。'), findsOneWidget);
  });
}

/// 打开今日页中的阶段三入口，并进入睡眠记录管理页。
Future<void> _pumpSleepRecordsHubPage(
  WidgetTester tester, {
  required List<dynamic> overrides,
}) async {
  await pumpSleepRecordsFlowApp(tester, overrides: overrides);
  await tester.pumpAndSettle();
}
