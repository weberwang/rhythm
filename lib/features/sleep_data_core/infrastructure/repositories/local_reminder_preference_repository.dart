import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/entities/reminder_preference.dart';
import '../../domain/repositories/reminder_preference_repository.dart';

const _reminderPreferenceKey = 'reminder_preference';

/// 基于 SharedPreferences 持久化最小提醒偏好，先服务 onboarding 到 bedtime 的状态闭环。
class LocalReminderPreferenceRepository
    implements ReminderPreferenceRepository {
  /// 创建本地提醒偏好仓储。
  const LocalReminderPreferenceRepository(this._preferencesFuture);

  final Future<SharedPreferences> _preferencesFuture;

  @override
  Future<ReminderPreference?> readReminderPreference() async {
    final preferences = await _preferencesFuture;
    final rawValue = preferences.getString(_reminderPreferenceKey);

    return switch (rawValue) {
      'gentle' => ReminderPreference.gentle,
      'disabled' => ReminderPreference.disabled,
      _ => null,
    };
  }

  @override
  Future<void> saveReminderPreference(ReminderPreference preference) async {
    final preferences = await _preferencesFuture;
    await preferences.setString(_reminderPreferenceKey, preference.name);
  }
}
