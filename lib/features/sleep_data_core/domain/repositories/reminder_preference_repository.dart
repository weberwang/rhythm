import '../entities/reminder_preference.dart';

/// 统一约束提醒偏好的读取与持久化边界，避免功能页直接操作偏好存储。
abstract class ReminderPreferenceRepository {
  /// 读取当前设备上保存的提醒偏好；未设置时返回空，交由上层决定默认语义。
  Future<ReminderPreference?> readReminderPreference();

  /// 保存当前提醒偏好，供 bedtime 与后续提醒模块共享。
  Future<void> saveReminderPreference(ReminderPreference preference);
}
