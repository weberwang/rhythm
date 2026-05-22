import 'package:flutter/material.dart';
import 'package:rhythm/core/presentation/widgets/rhythm_primary_button.dart';
import 'package:rhythm/features/onboarding/presentation/widgets/onboarding_step_scaffold.dart';

/// 展示首次引导欢迎页，向用户说明产品价值并进入下一步。
class OnboardingWelcomeStep extends StatelessWidget {
  /// 创建欢迎步骤组件实例。
  const OnboardingWelcomeStep({super.key, required this.onContinue});

  /// 点击主按钮后的推进回调。
  final VoidCallback onContinue;

  /// 渲染欢迎步骤内容。
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return OnboardingStepScaffold(
      eyebrow: '首次引导占位页',
      title: '欢迎使用 Rhythm',
      description: '从今晚开始，用更温和的方式建立稳定作息，先完成 3 步基础设置。',
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: colorScheme.surface,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: colorScheme.outlineVariant),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('你将会完成', style: textTheme.titleMedium),
                const SizedBox(height: 16),
                _WelcomeBullet(
                  title: '选择进入方式',
                  description: '支持匿名体验，也为后续接入 Apple / Google 登录预留入口。',
                ),
                const SizedBox(height: 12),
                _WelcomeBullet(
                  title: '了解健康数据价值',
                  description: '先说明记录价值，暂不请求真实系统权限。',
                ),
                const SizedBox(height: 12),
                _WelcomeBullet(
                  title: '进入目标设置',
                  description: '本任务只负责把流程导向下一步，不实现目标设置页面内容。',
                ),
              ],
            ),
          ),
        ],
      ),
      primaryAction: RhythmPrimaryButton(
        label: '开始设置',
        onPressed: onContinue,
      ),
    );
  }
}

/// 展示欢迎页的分组说明项，保持信息结构清晰且便于后续替换设计细节。
class _WelcomeBullet extends StatelessWidget {
  /// 创建欢迎页说明项实例。
  const _WelcomeBullet({required this.title, required this.description});

  /// 说明项标题。
  final String title;

  /// 说明项正文。
  final String description;

  /// 渲染单条说明项。
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 10,
          height: 10,
          margin: const EdgeInsets.only(top: 6),
          decoration: BoxDecoration(
            color: colorScheme.primary,
            borderRadius: BorderRadius.circular(999),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: textTheme.titleSmall),
              const SizedBox(height: 4),
              Text(
                description,
                style: textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
