import 'app_preferences.dart';

/// 定义应用偏好读取边界，隔离显示层与底层存储实现。
abstract class AppPreferencesRepository {
  /// 读取当前已保存的应用偏好；若不存在则返回默认值。
  AppPreferences read();

  /// 保存最新应用偏好，供下次启动恢复。
  Future<void> save(AppPreferences preferences);
}
