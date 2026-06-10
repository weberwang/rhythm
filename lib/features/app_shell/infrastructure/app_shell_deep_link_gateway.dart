import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:rhythm/features/app_shell/domain/app_shell_models.dart';

part 'app_shell_deep_link_gateway.g.dart';

/// 根级 deep link 解析网关。
///
/// 当前 bootstrap 阶段只提供可替换的空实现，避免在共享底座阶段
/// 就把通知、小组件或平台入口细节写死。
class AppShellDeepLinkGateway {
  /// 读取首次启动时的 deep link。
  Future<AppShellDeepLink> consumeInitialLink() async {
    return const AppShellDeepLink.none();
  }
}

/// 提供 deep link 网关实例。
@Riverpod(keepAlive: true)
AppShellDeepLinkGateway appShellDeepLinkGateway(Ref ref) {
  return AppShellDeepLinkGateway();
}
