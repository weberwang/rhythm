import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app_logger.dart';

/// 在初始化阶段集中观察 Provider 生命周期，便于后续扩展全局诊断。
final class AppProviderObserver extends ProviderObserver {
  /// 创建全局 Provider 观察器。
  const AppProviderObserver();

  static final AppLogger _logger = AppLogger();

  @override
  void didUpdateProvider(
    ProviderObserverContext context,
    Object? previousValue,
    Object? newValue,
  ) {
    _logger.info('Provider updated: ${context.provider.name ?? context.provider.runtimeType}');
    super.didUpdateProvider(context, previousValue, newValue);
  }
}
