import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:rhythm/core/error/app_error_mapper.dart';
import 'package:rhythm/core/observability/app_logger.dart';
import 'package:rhythm/core/storage/app_storage_providers.dart';
import 'package:rhythm/features/app_shell/domain/app_shell_models.dart';
import 'package:rhythm/features/app_shell/infrastructure/app_shell_deep_link_gateway.dart';
import 'package:rhythm/features/app_shell/infrastructure/app_shell_launch_state_store.dart';

part 'app_shell_bootstrap_controller.g.dart';

const _sessionAccessTokenKey = 'session_access_token';
const _sessionRestoredMessageKey = 'sessionRestored';
const _deepLinkNeedsOnboardingMessageKey = 'deepLinkNeedsOnboarding';

/// 聚合冷启动所需最小状态，并输出根级启动决策。
@Riverpod(keepAlive: true)
Future<LaunchDecision> appShellBootstrapController(Ref ref) async {
  final logger = ref.watch(appLoggerProvider);
  final errorMapper = const AppErrorMapper();

  try {
    final launchStateStore = ref.watch(appShellLaunchStateStoreProvider);
    final deepLinkGateway = ref.watch(appShellDeepLinkGatewayProvider);
    final secureStorage = ref.watch(secureStorageProvider);

    final onboardingCompleted = await launchStateStore.hasCompletedOnboarding(ref);
    final deepLink = await deepLinkGateway.consumeInitialLink();
    final sessionToken = await secureStorage.read(key: _sessionAccessTokenKey);
    final hasSession = sessionToken?.isNotEmpty ?? false;

    return deepLink.when(
      none: () {
        if (!onboardingCompleted) {
          return const LaunchDecision.redirect(
            target: LaunchRouteTarget.onboarding,
          );
        }

        return LaunchDecision.redirect(
          target: LaunchRouteTarget.today,
          successMessage: hasSession ? _sessionRestoredMessageKey : null,
        );
      },
      target: (target, source) {
        if (!onboardingCompleted) {
          return const LaunchDecision.blocked(
            fallbackTarget: LaunchRouteTarget.onboarding,
            message: _deepLinkNeedsOnboardingMessageKey,
          );
        }

        // 深链先进入 handoff，让壳层保留一层统一的过渡语义。
        return LaunchDecision.handoff(
          target: target,
          reason: _handoffReasonFromSource(source),
        );
      },
    );
  } catch (error, stackTrace) {
    logger.error('Failed to resolve startup route.', error, stackTrace);
    return LaunchDecision.failure(
      message: errorMapper.toDisplayMessage(error),
    );
  }
}

/// 将来源标识转换为壳层内部使用的 handoff 文案 key。
String _handoffReasonFromSource(String source) {
  switch (source) {
    case 'notification':
      return 'handoffFromNotification';
    case 'widget':
      return 'handoffFromWidget';
    default:
      return 'handoffFromShortcut';
  }
}
