import 'package:rhythm/features/sleep_records/data/health_permission_gateway.dart';
import 'package:rhythm/features/sleep_records/data/health_sleep_data_source.dart';
import 'package:rhythm/features/sleep_records/domain/health_platform_state.dart';
import 'package:rhythm/features/sleep_records/domain/sleep_record.dart';

/// 提供阶段三测试共用的健康权限网关假实现。
class TestHealthPermissionGateway extends HealthPermissionGateway {
  /// 创建测试权限网关，并固定返回指定平台状态。
  TestHealthPermissionGateway({
    required this.platformState,
    this.requestAccessResult,
  });

  /// 当前测试场景下的主平台状态。
  final HealthPlatformState platformState;

  /// 模拟点击授权后的返回状态；未设置时沿用初始平台状态。
  final HealthPlatformState? requestAccessResult;

  /// 记录是否触发过安装引导。
  bool installOpened = false;

  /// 记录是否触发过权限申请。
  bool accessRequested = false;

  @override
  Future<HealthPlatformState> getCurrentPlatformState() async => platformState;

  @override
  Future<HealthPlatformState> requestAccess() async {
    accessRequested = true;
    return requestAccessResult ?? platformState;
  }

  @override
  Future<void> openHealthProviderInstallation() async {
    installOpened = true;
  }
}

/// 提供阶段三测试共用的睡眠数据源假实现。
class TestHealthSleepDataSource extends HealthSleepDataSource {
  /// 创建测试数据源，可返回固定记录或抛出异常。
  TestHealthSleepDataSource({
    this.records = const <SleepRecord>[],
    this.exception,
  });

  /// 本次同步要返回的记录列表。
  final List<SleepRecord> records;

  /// 若设置，则在读取时直接抛出异常，用于验证失败分支。
  final Object? exception;

  @override
  Future<List<SleepRecord>> readRecentSleepRecords({
    required int dayStartMinutes,
    required String timezone,
  }) async {
    if (exception != null) {
      throw exception!;
    }
    return records;
  }
}
