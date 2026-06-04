import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/entities/sleep_data_core_status.dart';

part 'sleep_data_core_status_provider.g.dart';

/// 暴露当前数据来源可信度，后续可由健康读取、手动修正链路接入真实实现。
@Riverpod(keepAlive: true)
SleepSourceConfidence sleepSourceConfidence(Ref ref) {
  return SleepSourceConfidence.trusted;
}

/// 暴露当前同步状态，先统一“可恢复失败”语义，再延后真实同步接线。
@Riverpod(keepAlive: true)
SleepSyncStatus sleepSyncStatus(Ref ref) {
  return SleepSyncStatus.idle;
}

/// 暴露当前时区上下文状态，为后续跨时区确认入口预留统一边界。
@Riverpod(keepAlive: true)
SleepTimezoneContext sleepTimezoneContext(Ref ref) {
  return SleepTimezoneContext.stable;
}

/// 聚合 `sleep-data-core` 的共享状态快照，避免下游页面各自拼装语义。
@Riverpod(keepAlive: true)
SleepDataCoreStatus sleepDataCoreStatus(Ref ref) {
  return SleepDataCoreStatus(
    sourceConfidence: ref.watch(sleepSourceConfidenceProvider),
    syncStatus: ref.watch(sleepSyncStatusProvider),
    timezoneContext: ref.watch(sleepTimezoneContextProvider),
  );
}
