import 'package:freezed_annotation/freezed_annotation.dart';

part 'sleep_data_core_status.freezed.dart';

/// 定义睡眠数据来源可信度，供共享页面统一解释数据质量。
enum SleepSourceConfidence {
  /// 数据已完成主链路校验，可按默认语义解释。
  trusted,

  /// 数据只有部分来源可用，需要页面展示补充说明。
  partial,

  /// 数据已被用户手动修正，页面应显式标识来源变化。
  manualAdjusted,
}

/// 定义同步状态，确保跨页面对“可恢复失败”有一致表达。
enum SleepSyncStatus {
  /// 当前没有需要提示的同步问题。
  idle,

  /// 同步失败但本地链路仍然安全，应提示用户后续修复。
  failedRecoverable,
}

/// 定义时区上下文状态，避免页面在跨时区场景下继续沿用普通解释规则。
enum SleepTimezoneContext {
  /// 当前时区上下文稳定，无需额外提示。
  stable,

  /// 检测到时区变化，后续页面应引导用户确认。
  shiftPending,
}

/// 聚合 `sleep-data-core` 对外暴露的最小共享状态契约。
@freezed
abstract class SleepDataCoreStatus with _$SleepDataCoreStatus {
  /// 创建共享状态快照。
  const factory SleepDataCoreStatus({
    required SleepSourceConfidence sourceConfidence,
    required SleepSyncStatus syncStatus,
    required SleepTimezoneContext timezoneContext,
  }) = _SleepDataCoreStatus;
}
