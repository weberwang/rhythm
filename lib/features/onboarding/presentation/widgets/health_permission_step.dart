import 'package:flutter/material.dart';
import 'package:rhythm/core/presentation/widgets/rhythm_primary_button.dart';
import 'package:rhythm/core/presentation/widgets/rhythm_secondary_button.dart';
import 'package:rhythm/features/onboarding/domain/onboarding_draft.dart';
import 'package:rhythm/features/onboarding/presentation/widgets/onboarding_step_scaffold.dart';

/// 展示健康权限说明步骤，当前仅做价值说明和分流，不接真实系统权限。
class HealthPermissionStep extends StatelessWidget {
  /// 创建健康权限说明步骤组件实例。
  const HealthPermissionStep({
    super.key,
    required this.selectedAuthOption,
    required this.onAuthorize,
    required this.onSkip,
  });

  /// 上一步记录的登录方式，用于在说明文案中保持流程连贯。
  final OnboardingAuthOption selectedAuthOption;

  /// 点击授权入口后的回调。
  final VoidCallback onAuthorize;

  /// 点击跳过入口后的回调。
  final VoidCallback onSkip;

  /// 渲染健康权限说明步骤。
  @override
  Widget build(BuildContext context) {
    final authSummary = switch (selectedAuthOption) {
      OnboardingAuthOption.apple => '你刚刚选择了 Apple 入口，后续可再补充账号绑定。',
      OnboardingAuthOption.google => '你刚刚选择了 Google 入口，后续可再补充账号绑定。',
      OnboardingAuthOption.anonymous => '你当前以匿名体验进入，后续也可以在设置里再绑定账号。',
      OnboardingAuthOption.none => '你可以先了解健康记录会带来什么，再决定是否授权。',
    };

    return OnboardingStepScaffold(
      eyebrow: '第 3 步 / 3',
      title: '连接健康数据，记录会更完整',
      description: 'Rhythm 会优先用你已有的睡眠与活动数据，帮助你更稳定地回看节奏变化。',
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _InfoCard(
            title: '为什么建议开启',
            description: '如果后续接入健康数据，你可以减少手动补录，趋势回顾也会更完整。',
          ),
          const SizedBox(height: 12),
          _InfoCard(
            title: '当前阶段说明',
            description: '本任务先完成流程说明，不触发真实系统权限请求。',
          ),
          const SizedBox(height: 16),
          Text(authSummary),
        ],
      ),
      secondaryAction: RhythmSecondaryButton(
        label: '先用手动模式',
        onPressed: onSkip,
      ),
      primaryAction: RhythmPrimaryButton(
        label: '授权并继续',
        onPressed: onAuthorize,
      ),
    );
  }
}

/// 展示健康权限页的信息卡片，避免长段文本直接堆叠影响扫描效率。
class _InfoCard extends StatelessWidget {
  /// 创建信息卡片实例。
  const _InfoCard({required this.title, required this.description});

  /// 卡片标题。
  final String title;

  /// 卡片说明内容。
  final String description;

  /// 渲染信息卡片。
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Container(
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
          Text(title, style: textTheme.titleMedium),
          const SizedBox(height: 8),
          Text(
            description,
            style: textTheme.bodyMedium?.copyWith(
              color: colorScheme.onSurfaceVariant,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
