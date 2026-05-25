import 'package:shared_preferences/shared_preferences.dart';

import '../domain/goal_schedule_settings.dart';
import '../domain/repositories/goal_schedule_settings_repository.dart';

/// 负责持久化目标作息设置，给今日页和同步链路提供统一读取边界。
class SharedPreferencesGoalScheduleSettingsRepository
    implements GoalScheduleSettingsRepository {
  /// 创建目标作息设置仓储。
  SharedPreferencesGoalScheduleSettingsRepository(this._sharedPreferences);

  static const String targetBedtimeMinutesKey = 'target_bedtime_minutes';
  static const String targetWakeMinutesKey = 'target_wake_minutes';
  static const String lateThresholdMinutesKey = 'late_threshold_minutes';
  static const String dayStartMinutesKey = 'day_start_minutes';
  static const String updatedAtKey = 'goal_schedule_updated_at';

  final SharedPreferences _sharedPreferences;

  /// 读取最近一次保存的目标作息设置；若尚未保存完整配置，则返回空。
  @override
  Future<GoalScheduleSettings?> read() async {
    final bedtime = _sharedPreferences.getInt(targetBedtimeMinutesKey);
    final wake = _sharedPreferences.getInt(targetWakeMinutesKey);
    final lateThreshold = _sharedPreferences.getInt(lateThresholdMinutesKey);
    final dayStart = _sharedPreferences.getInt(dayStartMinutesKey);
    if (bedtime == null ||
        wake == null ||
        lateThreshold == null ||
        dayStart == null) {
      return null;
    }

    final settings = GoalScheduleSettings.fromPreferenceMap(<String, Object>{
      targetBedtimeMinutesKey: bedtime,
      targetWakeMinutesKey: wake,
      lateThresholdMinutesKey: lateThreshold,
      dayStartMinutesKey: dayStart,
    });
    if (settings == null) {
      return null;
    }

    final updatedAtRaw = _sharedPreferences.getString(updatedAtKey);
    final updatedAt = updatedAtRaw == null
        ? null
        : DateTime.tryParse(updatedAtRaw)?.toUtc();
    return settings.copyWith(updatedAt: updatedAt);
  }

  /// 保存目标作息设置，并同步写入更新时间，供后续云端对账判断新旧。
  @override
  Future<void> save(GoalScheduleSettings settings) async {
    final updatedAt =
        (settings.updatedAt ?? DateTime.now().toUtc()).toIso8601String();
    await _sharedPreferences.setInt(
      targetBedtimeMinutesKey,
      settings.targetBedtimeMinutes,
    );
    await _sharedPreferences.setInt(
      targetWakeMinutesKey,
      settings.targetWakeMinutes,
    );
    await _sharedPreferences.setInt(
      lateThresholdMinutesKey,
      settings.lateThresholdMinutes,
    );
    await _sharedPreferences.setInt(
      dayStartMinutesKey,
      settings.dayStartMinutes,
    );
    await _sharedPreferences.setString(updatedAtKey, updatedAt);
  }
}
