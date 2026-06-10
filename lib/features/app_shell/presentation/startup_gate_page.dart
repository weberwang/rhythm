import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rhythm/app/theme/rhythm_theme.dart';
import 'package:rhythm/features/app_shell/application/app_shell_bootstrap_controller.dart';
import 'package:rhythm/features/app_shell/domain/app_shell_models.dart';
import 'package:rhythm/l10n/app_localizations.dart';

/// 冷启动分发页面。
class StartupGatePage extends HookConsumerWidget {
  /// 启动分发路由名。
  static const String routeName = 'startup-gate';

  /// 启动分发路径。
  static const String routePath = '/startup';

  /// 创建启动分发页面。
  const StartupGatePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final decision = ref.watch(appShellBootstrapControllerProvider);
    final l10n = AppLocalizations.of(context);

    ref.listen<AsyncValue<LaunchDecision>>(
      appShellBootstrapControllerProvider,
      (previous, next) {
        next.whenData(
          (value) {
            WidgetsBinding.instance.addPostFrameCallback((duration) {
              if (!context.mounted) {
                return;
              }

              value.when(
                redirect: (target, successMessage) => context.go(target.path),
                handoff: (target, reason) => context.goNamed(
                  DeepLinkHandoffPage.routeName,
                  extra: DeepLinkHandoffArgs(
                    target: target,
                    reason: reason,
                  ),
                ),
                blocked: (fallbackTarget, message) => context.goNamed(
                  DeepLinkHandoffPage.routeName,
                  extra: DeepLinkHandoffArgs.blocked(
                    target: fallbackTarget,
                    reason: message,
                  ),
                ),
                failure: (message) {},
              );
            });
          },
        );
      },
    );

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 24, 24, 24),
          child: Center(
            child: decision.when(
              data: (value) => value.when(
                redirect: (target, successMessage) => _StartupStatusView(
                  title: l10n.startupGatePreparingTitle,
                  message: l10n.startupGatePreparingMessage,
                  icon: Icons.arrow_forward_rounded,
                ),
                handoff: (target, reason) => _StartupStatusView(
                  title: l10n.startupGateOpeningShortcutTitle,
                  message: _resolveStartupCopy(l10n, reason),
                  icon: Icons.open_in_new_rounded,
                ),
                blocked: (fallbackTarget, message) => _StartupStatusView(
                  title: l10n.startupGateRedirectingSafelyTitle,
                  message: _resolveStartupCopy(l10n, message),
                  icon: Icons.shield_outlined,
                  showProgress: true,
                ),
                failure: (message) => _StartupErrorView(
                  title: l10n.startupGateNeedsAttentionTitle,
                  message: message,
                  onRetry: () => ref.invalidate(appShellBootstrapControllerProvider),
                  retryLabel: l10n.appShellRetry,
                ),
              ),
              error: (error, stackTrace) => _StartupErrorView(
                message: 'Unable to finish startup. Please try again.',
                onRetry: () => ref.invalidate(appShellBootstrapControllerProvider),
                title: l10n.startupGateNeedsAttentionTitle,
                retryLabel: l10n.appShellRetry,
              ),
              loading: () => _StartupStatusView(
                title: l10n.startupGateLoadingTitle,
                message: l10n.startupGateLoadingMessage,
                icon: Icons.hourglass_top_rounded,
                showProgress: true,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// 深链承接过渡页面。
class DeepLinkHandoffPage extends HookConsumerWidget {
  /// deep link handoff 路由名。
  static const String routeName = 'deep-link-handoff';

  /// deep link handoff 路径。
  static const String routePath = '/handoff';

  /// 创建 deep link handoff 页面。
  const DeepLinkHandoffPage({super.key, required this.args});

  /// 过渡参数。
  final DeepLinkHandoffArgs args;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);

    useEffect(
      () {
        Future<void>.delayed(
          const Duration(milliseconds: 450),
          () {
            if (context.mounted) {
              context.go(args.target.path);
            }
          },
        );
        return null;
      },
      const [],
    );
    
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 24, 24, 24),
          child: Center(
            child: _StartupStatusView(
              title: args.isBlocked
                  ? l10n.startupGateRedirectingSafelyTitle
                  : l10n.startupGateOpeningDestinationTitle,
              message: _resolveStartupCopy(l10n, args.reason),
              icon: args.isBlocked
                  ? Icons.shield_outlined
                  : Icons.open_in_new_rounded,
              showProgress: true,
            ),
          ),
        ),
      ),
    );
  }
}

/// deep link handoff 参数。
class DeepLinkHandoffArgs {
  /// 创建过渡参数。
  const DeepLinkHandoffArgs({
    required this.target,
    required this.reason,
    this.isBlocked = false,
  });

  /// 创建 blocked fallback 的过渡参数。
  const DeepLinkHandoffArgs.blocked({
    required this.target,
    required this.reason,
  }) : isBlocked = true;

  /// 目标模块。
  final LaunchRouteTarget target;

  /// 过渡说明。
  final String reason;

  /// 标记当前 handoff 是否为 blocked fallback。
  final bool isBlocked;
}

/// 启动状态视图。
class _StartupStatusView extends StatelessWidget {
  /// 创建启动状态视图。
  const _StartupStatusView({
    required this.title,
    required this.message,
    required this.icon,
    this.showProgress = false,
  });

  final String title;
  final String message;
  final IconData icon;
  final bool showProgress;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 280),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              color: RhythmColors.surfaceCard,
              borderRadius: BorderRadius.circular(RhythmRadius.card),
              border: Border.all(color: RhythmColors.borderSubtle),
            ),
            child: Icon(icon, color: RhythmColors.brandPrimary, size: 28),
          ),
          const SizedBox(height: RhythmSpacing.l),
          Text(
            title,
            style: RhythmTextStyles.cardTitle,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: RhythmSpacing.s),
          Text(
            message,
            style: RhythmTextStyles.body,
            textAlign: TextAlign.center,
          ),
          if (showProgress) ...[
            const SizedBox(height: RhythmSpacing.l),
            const CircularProgressIndicator.adaptive(
              strokeWidth: 2.5,
              valueColor: AlwaysStoppedAnimation<Color>(
                RhythmColors.brandPrimary,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

/// 启动失败视图。
class _StartupErrorView extends StatelessWidget {
  /// 创建启动失败视图。
  const _StartupErrorView({
    required this.title,
    required this.message,
    required this.onRetry,
    required this.retryLabel,
  });

  final String title;
  final String message;
  final VoidCallback onRetry;
  final String retryLabel;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 280),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              color: const Color(0xFFFFF3EF),
              borderRadius: BorderRadius.circular(RhythmRadius.card),
              border: Border.all(color: RhythmColors.borderSubtle),
            ),
            child: const Icon(
              Icons.error_outline_rounded,
              color: RhythmColors.error,
              size: 28,
            ),
          ),
          const SizedBox(height: RhythmSpacing.l),
          Text(
            title,
            style: RhythmTextStyles.cardTitle,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: RhythmSpacing.s),
          Text(
            message,
            style: RhythmTextStyles.body,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: RhythmSpacing.l),
          FilledButton(
            onPressed: onRetry,
            child: Text(retryLabel),
          ),
        ],
      ),
    );
  }
}

/// 启动目标路径映射。
extension on LaunchRouteTarget {
  String get path {
    switch (this) {
      case LaunchRouteTarget.onboarding:
        return '/onboarding';
      case LaunchRouteTarget.today:
        return '/today';
      case LaunchRouteTarget.calendar:
        return '/calendar';
      case LaunchRouteTarget.bedtime:
        return '/bedtime';
      case LaunchRouteTarget.insights:
        return '/insights';
      case LaunchRouteTarget.profile:
        return '/profile';
    }
  }
}

/// 将启动链路内部消息 key 解析为本地化文案。
String _resolveStartupCopy(AppLocalizations l10n, String key) {
  switch (key) {
    case 'handoffFromNotification':
      return l10n.handoffFromNotification;
    case 'handoffFromWidget':
      return l10n.handoffFromWidget;
    case 'handoffFromShortcut':
      return l10n.handoffFromShortcut;
    case 'deepLinkNeedsOnboarding':
      return l10n.deepLinkNeedsOnboarding;
    case 'sessionRestored':
      return l10n.sessionRestored;
    default:
      return key;
  }
}
