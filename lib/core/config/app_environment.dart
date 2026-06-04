/// 记录初始化阶段可稳定确定的应用环境信息。
class AppEnvironment {
  /// 私有构造，避免被误实例化成可变配置对象。
  const AppEnvironment._();

  /// 当前项目名称。
  static const String appName = 'Rhythm';

  /// 当前应用包名基线。
  static const String appId = 'com.example.rhythm';

  /// REST 能力暂未冻结真实后端契约，因此使用不可访问的占位域名承接网络基线。
  static const String placeholderBaseUrl = 'https://placeholder.invalid';
}
