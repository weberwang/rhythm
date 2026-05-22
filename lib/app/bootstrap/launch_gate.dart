import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../router/app_router.dart';
import 'launch_state_provider.dart';

/// 启动分发页，根据首次激活状态将用户导向主流程或引导流程。
class LaunchGate extends StatefulWidget {
  /// 构建启动分发页。
  const LaunchGate({super.key});

  /// 创建启动分发页状态对象，承接首次激活状态读取与跳转时机控制。
  @override
  State<LaunchGate> createState() => _LaunchGateState();
}

/// 启动分发页状态，负责在异步结果返回后完成一次性路由跳转。
class _LaunchGateState extends State<LaunchGate> {
  late final Future<bool> _onboardingCompletedFuture = _loadOnboardingState();

  /// 只通过启动阶段注入的 Provider 读取首次引导状态，保持运行路径唯一。
  Future<bool> _loadOnboardingState() async {
    final container = ProviderScope.containerOf(context, listen: false);
    return container.read(onboardingCompletedProvider.future);
  }

  /// 在首帧后根据首次引导状态跳转，避免在构建过程中直接触发路由变更。
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: _onboardingCompletedFuture,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (!context.mounted) {
              return;
            }

            final targetLocation = snapshot.data!
                ? RhythmTab.today.path
                : onboardingWelcomePath;

            if (GoRouterState.of(context).uri.toString() != targetLocation) {
              context.go(targetLocation);
            }
          });
        }

        return const Scaffold(
          body: SafeArea(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          ),
        );
      },
    );
  }
}
