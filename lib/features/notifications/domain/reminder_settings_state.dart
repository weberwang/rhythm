import 'package:freezed_annotation/freezed_annotation.dart';

part 'reminder_settings_state.freezed.dart';

/// 承载首次引导中的提醒策略默认值，后续可平滑接入持久化与系统调度。
@freezed
abstract class ReminderSettingsState with _$ReminderSettingsState {
  /// 创建提醒策略状态实例。
  const factory ReminderSettingsState({
    @Default(true) bool softReminderEnabled,
    @Default(false) bool targetReminderEnabled,
    @Default(true) bool weeklyReportEnabled,
    @Default(45) int leadMinutes,
  }) = _ReminderSettingsState;
}
