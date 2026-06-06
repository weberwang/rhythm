/// 定义当前设备上保存的最小提醒偏好，供 onboarding 与 bedtime 共享。
enum ReminderPreference {
  /// 使用轻提醒语义，后续可继续扩展到真实调度能力。
  gentle,

  /// 当前先不主动提醒，bedtime 只给出轻提示而不假装已开启。
  disabled,
}
