import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rhythm/core/time/time_context.dart';
import 'package:rhythm/core/time/time_context_provider.dart';
import 'package:rhythm/features/goal_schedule/application/goal_schedule_providers.dart';
import 'package:rhythm/features/goal_schedule/domain/goal_schedule_settings.dart';
import 'package:rhythm/features/sleep_records/application/sleep_record_sync_controller.dart';
import 'package:rhythm/features/sleep_records/application/sleep_record_providers.dart';
import 'package:rhythm/features/sleep_records/domain/health_platform_state.dart';
import 'package:rhythm/features/sleep_records/domain/repositories/sleep_record_repository.dart';
import 'package:rhythm/features/sleep_records/domain/sleep_record.dart';

import '../../support/sleep_records_test_app.dart';
import '../../support/sleep_records_test_doubles.dart';

/// 验证阶段三管理页和关键状态分支可从独立路由验收。
void main() {
  testWidgets('睡眠记录管理页展示同步卡、记录列表和手动入口', (tester) async {
    await pumpSleepRecordsFlowApp(tester);
    await tester.pumpAndSettle();

    expect(find.text('睡眠记录管理'), findsOneWidget);
    expect(find.text('最近 30 天睡眠记录'), findsOneWidget);
    expect(find.text('改用手动模式'), findsWidgets);
    expect(find.text('来源与可信度'), findsOneWidget);
    expect(find.byIcon(Icons.arrow_back_ios_new_rounded), findsOneWidget);
  });

  testWidgets('来源说明卡占满手机内容区宽度', (tester) async {
    await tester.binding.setSurfaceSize(const Size(390, 844));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await _pumpSleepRecordsHubPage(tester, overrides: const []);

    final card = find.ancestor(
      of: find.text('来源与可信度'),
      matching: find.byType(Card),
    );

    expect(tester.getSize(card).width, closeTo(342, 0.1));
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

  testWidgets('同步成功时展示最近同步时间摘要', (tester) async {
    await _pumpSleepRecordsHubPage(
      tester,
      overrides: [
        sleepRecordSyncControllerProvider.overrideWith(
          (ref) => _FakeSleepRecordSyncController(
            SleepRecordSyncState(
              status: SleepRecordSyncStatus.success,
              syncedCount: 2,
              lastSyncedAt: DateTime.utc(2026, 5, 24, 20),
            ),
          ),
        ),
      ],
    );

    expect(find.text('最近同步'), findsOneWidget);
    expect(find.textContaining('20:00'), findsOneWidget);
  });

  testWidgets('同步失败时展示失败原因摘要', (tester) async {
    await _pumpSleepRecordsHubPage(
      tester,
      overrides: [
        sleepRecordSyncControllerProvider.overrideWith(
          (ref) => _FakeSleepRecordSyncController(
            const SleepRecordSyncState(
              status: SleepRecordSyncStatus.error,
              failureReason: 'sync_failed',
            ),
          ),
        ),
      ],
    );

    expect(find.text('失败原因'), findsOneWidget);
    expect(find.text('健康数据读取失败，请稍后重试。'), findsOneWidget);
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

  testWidgets('平台不受支持时展示不可用说明', (tester) async {
    final gateway = TestHealthPermissionGateway(
      platformState: HealthPlatformState.unsupported(),
    );

    await _pumpSleepRecordsHubPage(
      tester,
      overrides: [
        healthPermissionGatewayProvider.overrideWith((ref) => gateway),
      ],
    );

    expect(find.text('当前设备暂不支持睡眠同步'), findsOneWidget);
    expect(find.text('你仍可以手动补录昨晚结果，后续再接入自动记录。'), findsOneWidget);
  });

  testWidgets('同步时使用已保存目标作息的一天起始时间', (tester) async {
    final gateway = TestHealthPermissionGateway(
      platformState: HealthPlatformState.androidAvailable(),
    );
    final dataSource = TestHealthSleepDataSource(records: const []);
    final settingsRepository = TestGoalScheduleSettingsRepository(
      const GoalScheduleSettings(
        targetBedtimeMinutes: 23 * 60 + 30,
        targetWakeMinutes: 7 * 60 + 30,
        lateThresholdMinutes: 30,
        dayStartMinutes: 5 * 60,
      ),
    );

    await _pumpSleepRecordsHubPage(
      tester,
      overrides: [
        healthPermissionGatewayProvider.overrideWith((ref) => gateway),
        healthSleepDataSourceProvider.overrideWith((ref) => dataSource),
        goalScheduleSettingsRepositoryProvider.overrideWithValue(
          settingsRepository,
        ),
      ],
    );

    await tester.tap(find.text('重新同步'));
    await tester.pumpAndSettle();

    expect(dataSource.lastDayStartMinutes, 5 * 60);
  });

  testWidgets('同步时使用时间上下文提供的时区', (tester) async {
    final gateway = TestHealthPermissionGateway(
      platformState: HealthPlatformState.androidAvailable(),
    );
    final dataSource = TestHealthSleepDataSource(records: const []);
    final settingsRepository = TestGoalScheduleSettingsRepository(
      const GoalScheduleSettings(
        targetBedtimeMinutes: 23 * 60 + 30,
        targetWakeMinutes: 7 * 60 + 30,
        lateThresholdMinutes: 30,
        dayStartMinutes: 4 * 60,
      ),
    );

    await _pumpSleepRecordsHubPage(
      tester,
      overrides: [
        healthPermissionGatewayProvider.overrideWith((ref) => gateway),
        healthSleepDataSourceProvider.overrideWith((ref) => dataSource),
        goalScheduleSettingsRepositoryProvider.overrideWithValue(
          settingsRepository,
        ),
        timeContextProvider.overrideWithValue(
          TimeContext(
            now: DateTime.utc(2026, 5, 24, 20),
            timezoneName: 'America/Los_Angeles',
          ),
        ),
      ],
    );

    await tester.tap(find.text('重新同步'));
    await tester.pumpAndSettle();

    expect(dataSource.lastTimezone, 'America/Los_Angeles');
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

/// 提供测试专用同步控制器，避免页面摘要测试依赖真实平台调用。
class _FakeSleepRecordSyncController extends SleepRecordSyncController {
  _FakeSleepRecordSyncController(this._state)
    : super(
        permissionGateway: TestHealthPermissionGateway(
          platformState: HealthPlatformState.androidAvailable(),
        ),
        dataSource: TestHealthSleepDataSource(records: const []),
        repository: _NoopSleepRecordRepository(),
      );

  final SleepRecordSyncState _state;

  @override
  SleepRecordSyncState get state => _state;

  @override
  Future<void> syncRecentRecords({
    required int dayStartMinutes,
    required String timezone,
  }) async {}
}

/// 提供同步摘要测试用空仓储，避免页面装配依赖真实数据。
class _NoopSleepRecordRepository implements SleepRecordRepository {
  @override
  Future<List<SleepRecord>> readAllRecords() async {
    return const <SleepRecord>[];
  }

  @override
  Future<SleepRecord?> readRecordById(String id) async => null;

  @override
  Future<List<SleepRecord>> readRecords({
    required DateTime startRecordDate,
    required DateTime endRecordDate,
  }) async {
    return const <SleepRecord>[];
  }

  @override
  Future<void> saveRecord(SleepRecord record) async {}
}
