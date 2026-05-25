import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../goal_schedule/presentation/goal_setup_page.dart';

/// 首次激活入口页，用最小步骤把用户带入目标设置流程。
class OnboardingFlowPage extends ConsumerWidget {
  const OnboardingFlowPage({super.key});

  /// 渲染首次激活欢迎页，并提供进入设置的唯一主操作。
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Spacer(),
              Text('先把作息节奏安顿下来', style: textTheme.headlineMedium),
              const SizedBox(height: 16),
              Text('我们先帮你设一个轻量目标，让今晚到明早都更有方向。', style: textTheme.bodyLarge),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute<void>(builder: (_) => GoalSetupPage()),
                    );
                  },
                  child: const Text('开始设置'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
