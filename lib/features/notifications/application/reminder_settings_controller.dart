import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../domain/reminder_settings_state.dart';

part 'reminder_settings_controller.g.dart';

/// 管理首次引导中的提醒策略草稿，保持展示层只处理用户意图。
@riverpod
class ReminderSettingsController extends _$ReminderSettingsController {
  /// 初始化提醒策略默认值。
  @override
  ReminderSettingsState build() {
    return const ReminderSettingsState();
  }

  /// 切换柔性提醒开关。
  void setSoftReminderEnabled(bool enabled) {
    state = state.copyWith(softReminderEnabled: enabled);
  }

  /// 切换到点提醒开关。
  void setTargetReminderEnabled(bool enabled) {
    state = state.copyWith(targetReminderEnabled: enabled);
  }

  /// 切换周报提醒开关。
  void setWeeklyReportEnabled(bool enabled) {
    state = state.copyWith(weeklyReportEnabled: enabled);
  }

  /// 更新提前提醒分钟数，后续接真实通知调度时可直接复用。
  void updateLeadMinutes(int minutes) {
    state = state.copyWith(leadMinutes: minutes);
  }
}
