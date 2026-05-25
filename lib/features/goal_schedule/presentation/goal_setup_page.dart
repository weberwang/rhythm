import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../onboarding/application/app_session_controller.dart';

/// 目标作息设置页，用最小步骤完成首次激活的关键配置。
class GoalSetupPage extends ConsumerWidget {
  const GoalSetupPage({super.key});

  /// 渲染目标设置页，并在继续时完成首次激活。
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(title: const Text('目标设置')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('设置你的目标作息', style: textTheme.headlineMedium),
            const SizedBox(height: 16),
            Text('后续这里会接真实表单。当前先用默认目标跑通首次激活主路径。', style: textTheme.bodyLarge),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: () {
                  ref
                      .read(appSessionControllerProvider.notifier)
                      .completeOnboarding(goalScheduleId: 'default-goal');
                  Navigator.of(context).pop();
                },
                child: const Text('继续'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
