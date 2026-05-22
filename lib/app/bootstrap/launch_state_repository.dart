import 'package:shared_preferences/shared_preferences.dart';

/// 首次激活状态仓储，负责读写引导完成标记。
class LaunchStateRepository {
  /// 使用共享偏好存储作为持久化介质，保证启动分发结果可跨进程保留。
  LaunchStateRepository(this._sharedPreferences);

  static const String onboardingCompletedKey = 'onboarding_completed';

  final SharedPreferences _sharedPreferences;

  /// 读取是否已经完成首次引导，未写入时默认按首次启动处理。
  Future<bool> isOnboardingCompleted() async {
    return _sharedPreferences.getBool(onboardingCompletedKey) ?? false;
  }

  /// 持久化首次引导完成状态，供后续启动直接分发到主流程。
  Future<void> setOnboardingCompleted(bool completed) async {
    await _sharedPreferences.setBool(onboardingCompletedKey, completed);
  }
}
