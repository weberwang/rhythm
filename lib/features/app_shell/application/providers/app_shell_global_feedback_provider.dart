import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../sleep_data_core/application/providers/sleep_data_core_status_provider.dart';
import '../../../sleep_data_core/domain/entities/sleep_data_core_status.dart';

part 'app_shell_global_feedback_provider.g.dart';

/// 定义主壳需要提升到全局层的反馈类型。
enum AppShellGlobalFeedbackKind {
  /// 同步失败但本地写入仍然安全，应提醒用户稍后修复。
  syncFailedRecoverable,

  /// 时区变化会影响解释语义，应优先提示用户确认上下文。
  timezoneShiftPending,
}

/// 根据 `sleep-data-core` 的共享状态决定是否需要展示全局反馈。
@Riverpod(keepAlive: true)
AppShellGlobalFeedbackKind? appShellGlobalFeedback(Ref ref) {
  final status = ref.watch(sleepDataCoreStatusProvider);

  // 时区变化会直接影响后续睡眠解释，因此优先级高于可恢复的同步失败。
  if (status.timezoneContext == SleepTimezoneContext.shiftPending) {
    return AppShellGlobalFeedbackKind.timezoneShiftPending;
  }

  if (status.syncStatus == SleepSyncStatus.failedRecoverable) {
    return AppShellGlobalFeedbackKind.syncFailedRecoverable;
  }

  return null;
}
