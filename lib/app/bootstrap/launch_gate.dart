import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../router/app_router.dart';
import 'launch_state_provider.dart';

/// 启动分发页，根据首次激活状态将用户导向主流程或引导流程。
class LaunchGate extends HookConsumerWidget {
  /// 构建启动分发页。
  const LaunchGate({super.key});

  /// 在首次引导状态就绪后执行一次性跳转。
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(onboardingCompletedProvider, (previous, next) {
      next.whenData((completed) {
        final targetLocation = completed
            ? RhythmTab.today.path
            : onboardingWelcomePath;

        if (GoRouterState.of(context).uri.toString() != targetLocation) {
          context.go(targetLocation);
        }
      });
    });

    return const Scaffold(
      body: SafeArea(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
