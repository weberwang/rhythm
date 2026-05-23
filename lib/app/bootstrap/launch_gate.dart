import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../router/app_router.dart';
import 'launch_state_provider.dart';

/// 启动分发页，根据首次激活状态导向主流程或引导流程。
class LaunchGate extends HookConsumerWidget {
  /// 创建启动分发页。
  const LaunchGate({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final completed = ref.watch(onboardingCompletedProvider);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!context.mounted) {
        return;
      }
      context.go(completed ? RhythmTab.today.path : onboardingWelcomePath);
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
