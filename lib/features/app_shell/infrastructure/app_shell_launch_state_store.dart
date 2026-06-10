import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:rhythm/core/storage/app_storage_providers.dart';

part 'app_shell_launch_state_store.g.dart';

/// 管理 app-shell 启动阶段最小本地状态的存储适配器。
class AppShellLaunchStateStore {
  /// 创建存储适配器。
  const AppShellLaunchStateStore();

  /// onboarding 完成标记的 key。
  static const String onboardingCompletedKey = 'app.onboarding.completed';

  /// 读取 onboarding 是否完成。
  Future<bool> hasCompletedOnboarding(Ref ref) async {
    final preferences = await ref.watch(sharedPreferencesInstanceProvider.future);
    return preferences.getBool(onboardingCompletedKey) ?? false;
  }
}

/// 提供启动状态存储适配器。
@Riverpod(keepAlive: true)
AppShellLaunchStateStore appShellLaunchStateStore(Ref ref) {
  return const AppShellLaunchStateStore();
}
