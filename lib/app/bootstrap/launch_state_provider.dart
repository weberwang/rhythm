import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'launch_state_repository.dart';

part 'launch_state_provider.g.dart';

/// 提供启动阶段使用的共享偏好实例，必须在应用启动时完成覆盖。
final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError('sharedPreferencesProvider 必须在启动时注入实例');
});

/// 提供首次激活状态仓储，统一封装持久化键和值读取逻辑。
@riverpod
LaunchStateRepository launchStateRepository(Ref ref) {
  return LaunchStateRepository(ref.watch(sharedPreferencesProvider));
}

/// 提供是否完成首次引导的状态，供启动分发页决定跳转目标。
@riverpod
bool onboardingCompleted(Ref ref) {
  return ref.watch(launchStateRepositoryProvider).isOnboardingCompleted();
}
