import 'package:rhythm/features/sleep_records/application/sleep_records_analytics.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rhythm/features/sleep_records/application/sleep_record_sync_controller.dart';
import 'package:rhythm/features/sleep_records/data/health_permission_gateway.dart';
import 'package:rhythm/features/sleep_records/data/health_sleep_data_source.dart';
import 'package:rhythm/features/sleep_records/data/drift_sleep_record_repository.dart';
import 'package:rhythm/features/sleep_records/data/sleep_health_client.dart';
import 'package:rhythm/features/sleep_records/data/sleep_health_platform_runtime.dart';
import 'package:rhythm/features/sleep_records/domain/repositories/effective_sleep_record_repository.dart';
import 'package:rhythm/features/sleep_records/domain/repositories/sleep_record_repository.dart';
import 'package:rhythm/features/sleep_records/domain/health_platform_state.dart';

/// 提供阶段三睡眠记录仓储实例。
final sleepRecordRepositoryProvider = Provider<SleepRecordRepository>((ref) {
  final repository = DriftSleepRecordRepository.inMemory();
  ref.onDispose(repository.close);
  return repository;
});

/// 提供健康插件客户端实例，供权限网关与数据源共享。
final sleepHealthClientProvider = Provider<SleepHealthClient>((ref) {
  return PluginSleepHealthClient();
});

/// 提供当前设备平台运行时。
final sleepHealthPlatformRuntimeProvider =
    Provider<SleepHealthPlatformRuntime>((ref) {
  return const DeviceSleepHealthPlatformRuntime();
});

/// 提供健康权限网关实例。
final healthPermissionGatewayProvider = Provider<HealthPermissionGateway>((ref) {
  return HealthPermissionGateway(
    client: ref.watch(sleepHealthClientProvider),
    runtime: ref.watch(sleepHealthPlatformRuntimeProvider),
  );
});

/// 提供睡眠健康数据源实例。
final healthSleepDataSourceProvider = Provider<HealthSleepDataSource>((ref) {
  return HealthSleepDataSource(
    client: ref.watch(sleepHealthClientProvider),
  );
});

/// 提供阶段三同步控制器实例。
final sleepRecordSyncControllerProvider =
    Provider<SleepRecordSyncController>((ref) {
  return SleepRecordSyncController(
    permissionGateway: ref.watch(healthPermissionGatewayProvider),
    dataSource: ref.watch(healthSleepDataSourceProvider),
    repository: ref.watch(sleepRecordRepositoryProvider),
  );
});

/// 提供阶段三埋点实例。
final sleepRecordsAnalyticsProvider = Provider<SleepRecordsAnalytics>((ref) {
  return const NoopSleepRecordsAnalytics();
});

/// 读取当前健康平台状态，供管理页渲染权限、安装与降级分支。
final healthPlatformStateProvider = FutureProvider<HealthPlatformState>((ref) {
  final gateway = ref.watch(healthPermissionGatewayProvider);
  return gateway.getCurrentPlatformState();
});

/// 提供有效记录查询仓储，供今日页和管理页统一读取最终展示结果。
final effectiveSleepRecordRepositoryProvider =
    Provider<EffectiveSleepRecordRepository>((ref) {
  final repository = ref.watch(sleepRecordRepositoryProvider);
  return repository as EffectiveSleepRecordRepository;
});
