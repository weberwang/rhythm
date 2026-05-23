import 'package:shared_preferences/shared_preferences.dart';

/// 首次激活状态仓储，负责读写引导完成标记。
class LaunchStateRepository {
  /// 创建首启状态仓储。
  LaunchStateRepository(this._sharedPreferences);

  static const String onboardingCompletedKey = 'onboarding_completed';

  final SharedPreferences _sharedPreferences;

  /// 判断用户是否已经完成首次引导。
  bool isOnboardingCompleted() {
    return _sharedPreferences.getBool(onboardingCompletedKey) ?? false;
  }

  /// 标记首次引导已完成。
  Future<void> markOnboardingCompleted() async {
    await _sharedPreferences.setBool(onboardingCompletedKey, true);
  }
}
