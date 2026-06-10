import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rhythm/core/observability/app_logger.dart';
import 'package:rhythm/core/storage/app_storage_providers.dart';
import 'package:rhythm/features/app_shell/application/app_shell_bootstrap_controller.dart';
import 'package:rhythm/features/app_shell/domain/app_shell_models.dart';
import 'package:rhythm/features/app_shell/infrastructure/app_shell_deep_link_gateway.dart';
import 'package:rhythm/features/app_shell/infrastructure/app_shell_launch_state_store.dart';

void main() {
  test('未完成引导时返回 onboarding redirect', () async {
    final container = _createBootstrapContainer(
      onboardingCompleted: false,
      deepLink: const AppShellDeepLink.none(),
      sessionToken: null,
    );
    addTearDown(container.dispose);

    final result = await container.read(appShellBootstrapControllerProvider.future);

    expect(
      result,
      const LaunchDecision.redirect(target: LaunchRouteTarget.onboarding),
    );
  });

  test('已完成引导且无 deep link 时返回 today redirect', () async {
    final container = _createBootstrapContainer(
      onboardingCompleted: true,
      deepLink: const AppShellDeepLink.none(),
      sessionToken: 'token',
    );
    addTearDown(container.dispose);

    final result = await container.read(appShellBootstrapControllerProvider.future);

    expect(
      result,
      const LaunchDecision.redirect(
        target: LaunchRouteTarget.today,
        successMessage: 'sessionRestored',
      ),
    );
  });

  test('deep link 目标可进入时返回 handoff', () async {
    final container = _createBootstrapContainer(
      onboardingCompleted: true,
      deepLink: const AppShellDeepLink.target(
        target: LaunchRouteTarget.bedtime,
        source: 'notification',
      ),
      sessionToken: null,
    );
    addTearDown(container.dispose);

    final result = await container.read(appShellBootstrapControllerProvider.future);

    expect(
      result,
      const LaunchDecision.handoff(
        target: LaunchRouteTarget.bedtime,
        reason: 'handoffFromNotification',
      ),
    );
  });

  test('未完成引导时 deep link 返回 blocked fallback', () async {
    final container = _createBootstrapContainer(
      onboardingCompleted: false,
      deepLink: const AppShellDeepLink.target(
        target: LaunchRouteTarget.today,
        source: 'widget',
      ),
      sessionToken: null,
    );
    addTearDown(container.dispose);

    final result = await container.read(appShellBootstrapControllerProvider.future);

    expect(
      result,
      const LaunchDecision.blocked(
        fallbackTarget: LaunchRouteTarget.onboarding,
        message: 'deepLinkNeedsOnboarding',
      ),
    );
  });

  test('读取异常时返回 failure', () async {
    final container = ProviderContainer(
      overrides: [
        appShellLaunchStateStoreProvider.overrideWithValue(
          const _ThrowingLaunchStateStore(),
        ),
        appShellDeepLinkGatewayProvider.overrideWithValue(
          _FakeDeepLinkGateway(const AppShellDeepLink.none()),
        ),
        secureStorageProvider.overrideWithValue(
          const _FakeSecureStorage(sessionToken: null),
        ),
        appLoggerProvider.overrideWithValue(_FakeAppLogger()),
      ],
    );
    addTearDown(container.dispose);

    final result = await container.read(appShellBootstrapControllerProvider.future);

    expect(
      result,
      const LaunchDecision.failure(
        message: 'Unable to finish startup. Please try again.',
      ),
    );
  });
}

ProviderContainer _createBootstrapContainer({
  required bool onboardingCompleted,
  required AppShellDeepLink deepLink,
  required String? sessionToken,
}) {
  return ProviderContainer(
    overrides: [
      appShellLaunchStateStoreProvider.overrideWithValue(
        _FakeLaunchStateStore(onboardingCompleted),
      ),
      appShellDeepLinkGatewayProvider.overrideWithValue(
        _FakeDeepLinkGateway(deepLink),
      ),
      secureStorageProvider.overrideWithValue(
        _FakeSecureStorage(sessionToken: sessionToken),
      ),
      appLoggerProvider.overrideWithValue(_FakeAppLogger()),
    ],
  );
}

/// 测试用的启动状态存储假实现。
class _FakeLaunchStateStore extends AppShellLaunchStateStore {
  /// 创建假实现。
  const _FakeLaunchStateStore(this.onboardingCompleted);

  final bool onboardingCompleted;

  @override
  Future<bool> hasCompletedOnboarding(Ref ref) async {
    return onboardingCompleted;
  }
}

/// 测试用的抛错启动状态存储。
class _ThrowingLaunchStateStore extends AppShellLaunchStateStore {
  /// 创建抛错假实现。
  const _ThrowingLaunchStateStore();

  @override
  Future<bool> hasCompletedOnboarding(Ref ref) {
    throw StateError('boom');
  }
}

/// 测试用的 deep link 网关假实现。
class _FakeDeepLinkGateway extends AppShellDeepLinkGateway {
  /// 创建假实现。
  _FakeDeepLinkGateway(this.deepLink);

  final AppShellDeepLink deepLink;

  @override
  Future<AppShellDeepLink> consumeInitialLink() async {
    return deepLink;
  }
}

/// 测试用的安全存储假实现。
class _FakeSecureStorage extends FlutterSecureStorage {
  /// 创建假实现。
  const _FakeSecureStorage({required this.sessionToken});

  final String? sessionToken;

  @override
  Future<String?> read({
    required String key,
    AppleOptions? iOptions,
    AndroidOptions? aOptions,
    LinuxOptions? lOptions,
    WebOptions? webOptions,
    WindowsOptions? wOptions,
    AppleOptions? mOptions,
  }) async {
    return sessionToken;
  }
}

/// 测试用的日志门面。
class _FakeAppLogger extends AppLogger {
  /// 创建假实现。
  _FakeAppLogger();

  @override
  void error(String message, Object error, [StackTrace? stackTrace]) {}
}
