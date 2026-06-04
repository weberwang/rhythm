import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rhythm/l10n/app_localizations.dart';

import '../../features/app_shell/domain/entities/shell_tab.dart';
import '../../features/onboarding_activation/presentation/pages/onboarding_flow_page.dart';
import 'launch_state.dart';
import 'launch_state_provider.dart';

/// 启动页负责消费初始化决策，并把用户分发到引导或主壳。
class LaunchPage extends HookConsumerWidget {
  /// 创建启动页。
  const LaunchPage({super.key});

  /// 启动页路由路径。
  static const String routePath = '/launch';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localization = AppLocalizations.of(context);
    final launchState = ref.watch(launchStateProvider);

    return launchState.when(
      data: (snapshot) {
        useEffect(() {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            final destination = switch (snapshot.destination) {
              LaunchDestination.onboarding => OnboardingFlowPage.routePath,
              LaunchDestination.shell => ShellTab.fromEntryIntent(
                snapshot.entryIntent,
              ).location,
            };
            context.go(destination);
          });
          return null;
        }, [snapshot.destination]);

        return _LaunchScaffold(
          title: localization.launchLoadingTitle,
          body: localization.launchLoadingBody,
          child: const CircularProgressIndicator.adaptive(),
        );
      },
      loading: () => _LaunchScaffold(
        title: localization.launchLoadingTitle,
        body: localization.launchLoadingBody,
        child: const CircularProgressIndicator.adaptive(),
      ),
      error: (error, _) => _LaunchScaffold(
        title: localization.launchErrorTitle,
        body: localization.launchErrorBody,
        child: FilledButton(
          onPressed: () => ref.invalidate(launchStateProvider),
          child: Text(localization.retry),
        ),
      ),
    );
  }
}

/// 统一承载启动阶段的反馈容器，避免把启动态散落到路由层。
class _LaunchScaffold extends StatelessWidget {
  /// 创建启动容器。
  const _LaunchScaffold({
    required this.title,
    required this.body,
    required this.child,
  });

  /// 标题文案。
  final String title;

  /// 说明文案。
  final String body;

  /// 当前状态对应的交互部件。
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 360),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(title, style: theme.textTheme.headlineSmall),
                const SizedBox(height: 12),
                Text(
                  body,
                  style: theme.textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                child,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
