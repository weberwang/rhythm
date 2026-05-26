import 'package:rhythm/features/goal_schedule/domain/goal_schedule_settings.dart';
import 'package:rhythm/features/goal_schedule/domain/repositories/goal_schedule_settings_repository.dart';
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

  /// 模拟页面重新读取时看到的最新平台状态，便于覆盖授权成功后的刷新场景。
  late HealthPlatformState _currentPlatformState = platformState;

  /// 记录是否触发过安装引导。
  bool installOpened = false;

  /// 记录是否触发过权限申请。
  bool accessRequested = false;

  @override
  Future<HealthPlatformState> getCurrentPlatformState() async =>
      _currentPlatformState;

  @override
  Future<HealthPlatformState> requestAccess() async {
    accessRequested = true;
    _currentPlatformState = requestAccessResult ?? platformState;
    return _currentPlatformState;
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

  /// 记录最近一次读取时使用的一天起始时间，便于验证页面是否消费目标配置。
  int? lastDayStartMinutes;

  /// 记录最近一次读取时使用的时区名称，便于验证是否脱离硬编码。
  String? lastTimezone;

  @override
  Future<List<SleepRecord>> readRecentSleepRecords({
    required int dayStartMinutes,
    required String timezone,
  }) async {
    lastDayStartMinutes = dayStartMinutes;
    lastTimezone = timezone;
    if (exception != null) {
      throw exception!;
    }
    return records;
  }
}

/// 提供阶段三测试共用的目标作息仓储假实现。
class TestGoalScheduleSettingsRepository
    implements GoalScheduleSettingsRepository {
  /// 创建测试目标作息仓储。
  TestGoalScheduleSettingsRepository(this._settings);

  final GoalScheduleSettings? _settings;

  @override
  Future<GoalScheduleSettings?> read() async => _settings;

  @override
  Future<void> save(GoalScheduleSettings settings) async {}
}
