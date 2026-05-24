import 'package:rhythm/features/sleep_records/data/health_permission_gateway.dart';
import 'package:rhythm/features/sleep_records/data/health_sleep_data_source.dart';
import 'package:rhythm/features/sleep_records/domain/health_platform_state.dart';
import 'package:rhythm/features/sleep_records/domain/repositories/sleep_record_repository.dart';

/// 同步状态类型，供管理页和后续今日页共用。
enum SleepRecordSyncStatus {
  /// 尚未触发同步。
  idle,

  /// 当前正在执行同步。
  syncing,

  /// 同步成功。
  success,

  /// 当前需要提示用户先安装健康提供方。
  installRequired,

  /// 当前需要提示用户重新授权。
  permissionRequired,

  /// 当前应引导用户进入手动补录降级路径。
  manualFallback,

  /// 当前设备或平台暂不支持自动睡眠同步。
  unavailable,

  /// 当前同步失败，但仍允许用户重试。
  error,
}

/// 承载阶段三同步结果摘要。
class SleepRecordSyncState {
  /// 创建同步状态实例。
  const SleepRecordSyncState({
    this.status = SleepRecordSyncStatus.idle,
    this.syncedCount = 0,
    this.platformState,
    this.lastSyncedAt,
    this.failureReason,
  });

  /// 当前同步状态。
  final SleepRecordSyncStatus status;

  /// 本次同步成功写入的记录数量。
  final int syncedCount;

  /// 当前平台主状态，供管理页决定显示安装、授权或降级卡。
  final HealthPlatformState? platformState;

  /// 最近一次同步完成时间，供管理页展示状态摘要。
  final DateTime? lastSyncedAt;

  /// 最近一次失败原因代码，供页面与埋点复用。
  final String? failureReason;

  /// 返回带有更新字段的新状态。
  SleepRecordSyncState copyWith({
    SleepRecordSyncStatus? status,
    int? syncedCount,
    HealthPlatformState? platformState,
    DateTime? lastSyncedAt,
    String? failureReason,
    bool clearPlatformState = false,
    bool clearLastSyncedAt = false,
    bool clearFailureReason = false,
  }) {
    return SleepRecordSyncState(
      status: status ?? this.status,
      syncedCount: syncedCount ?? this.syncedCount,
      platformState: clearPlatformState
          ? null
          : platformState ?? this.platformState,
      lastSyncedAt: clearLastSyncedAt
          ? null
          : lastSyncedAt ?? this.lastSyncedAt,
      failureReason: clearFailureReason
          ? null
          : failureReason ?? this.failureReason,
    );
  }
}

/// 统一编排阶段三最小同步流程，先打通平台状态与仓储写入。
class SleepRecordSyncController {
  /// 创建同步控制器实例。
  SleepRecordSyncController({
    required this.permissionGateway,
    required this.dataSource,
    required this.repository,
  });

  /// 健康权限与平台状态网关。
  final HealthPermissionGateway permissionGateway;

  /// 健康睡眠数据源。
  final HealthSleepDataSource dataSource;

  /// 睡眠记录仓储。
  final SleepRecordRepository repository;

  SleepRecordSyncState _state = const SleepRecordSyncState();

  /// 当前同步状态。
  SleepRecordSyncState get state => _state;

  /// 执行最近 30 天睡眠记录同步。
  Future<void> syncRecentRecords({
    required int dayStartMinutes,
    required String timezone,
  }) async {
    _state = _state.copyWith(
      status: SleepRecordSyncStatus.syncing,
      clearPlatformState: true,
      clearFailureReason: true,
    );
    final platformState = await permissionGateway.getCurrentPlatformState();
    if (!platformState.canReadData) {
      _state = _state.copyWith(
        status: _resolveFallbackStatus(platformState),
        syncedCount: 0,
        platformState: platformState,
        failureReason: 'platform_unavailable',
      );
      return;
    }

    try {
      final records = await dataSource.readRecentSleepRecords(
        dayStartMinutes: dayStartMinutes,
        timezone: timezone,
      );
      for (final record in records) {
        await repository.saveRecord(record);
      }
      _state = _state.copyWith(
        status: records.isEmpty
            ? SleepRecordSyncStatus.manualFallback
            : SleepRecordSyncStatus.success,
        syncedCount: records.length,
        platformState: platformState,
        lastSyncedAt: DateTime.now(),
        clearFailureReason: true,
      );
    } catch (_) {
      _state = _state.copyWith(
        status: SleepRecordSyncStatus.error,
        syncedCount: 0,
        platformState: platformState,
        failureReason: 'sync_failed',
      );
    }
  }

  SleepRecordSyncStatus _resolveFallbackStatus(
    HealthPlatformState platformState,
  ) {
    switch (platformState.platformCode) {
      case 'android_install_required':
        return SleepRecordSyncStatus.installRequired;
      case 'android_permission_required':
      case 'ios_permission_required':
        return SleepRecordSyncStatus.permissionRequired;
      case 'android_unavailable':
      case 'unsupported':
        return SleepRecordSyncStatus.unavailable;
      default:
        return SleepRecordSyncStatus.manualFallback;
    }
  }
}
