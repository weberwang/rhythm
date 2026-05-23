import 'package:flutter/material.dart';
import 'package:rhythm/core/presentation/widgets/rhythm_primary_button.dart';
import 'package:rhythm/core/presentation/widgets/rhythm_secondary_button.dart';
import 'package:rhythm/features/onboarding/domain/onboarding_draft.dart';
import 'package:rhythm/features/onboarding/presentation/widgets/onboarding_step_scaffold.dart';

/// 健康权限说明页，只负责说明价值和分流，不接真实系统权限。
class HealthPermissionStep extends StatelessWidget {
  /// 创建权限说明页。
  const HealthPermissionStep({
    super.key,
    required this.selectedAuthOption,
    required this.onAuthorize,
    required this.onSkip,
  });

  /// 登录方式。
  final OnboardingAuthOption selectedAuthOption;

  /// 授权动作。
  final VoidCallback onAuthorize;

  /// 跳过动作。
  final VoidCallback onSkip;

  @override
  Widget build(BuildContext context) {
    final authSummary = switch (selectedAuthOption) {
      OnboardingAuthOption.apple => '自动同步睡眠记录',
      OnboardingAuthOption.google => '近 30 天数据会写入本地节律时间线',
      OnboardingAuthOption.anonymous => '授权失败可降级',
      OnboardingAuthOption.none => '没有权限时仍能手动补录并生成周报',
    };

    return OnboardingStepScaffold(
      eyebrow: '读取睡眠数据',
      title: '让结果更省心，但你随时可以跳过，改用手动补录。',
      description: '我们只读取睡眠记录，不会把数据用于医疗判断或广告。',
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _InfoCard(
            title: '自动同步睡眠记录',
            description: '近 30 天数据会写入本地节律时间线',
          ),
          const SizedBox(height: 12),
          const _InfoCard(
            title: '授权失败可降级',
            description: '没有权限时仍能手动补录并生成周报',
          ),
          const SizedBox(height: 12),
          const _InfoCard(
            title: '你可以随时关闭',
            description: '在系统设置中撤回后仍可继续使用 App',
          ),
          const SizedBox(height: 12),
          Text(
            authSummary,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
          ),
        ],
      ),
      primaryAction: RhythmPrimaryButton(
        label: '授权读取睡眠数据',
        onPressed: onAuthorize,
      ),
      secondaryAction: RhythmSecondaryButton(
        label: '先用手动模式',
        onPressed: onSkip,
      ),
    );
  }
}

/// 权限页的信息卡。
class _InfoCard extends StatelessWidget {
  /// 创建信息卡。
  const _InfoCard({required this.title, required this.description});

  /// 标题。
  final String title;

  /// 说明。
  final String description;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0F000000),
            blurRadius: 18,
            offset: Offset(0, 6),
          ),
        ],
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
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}
