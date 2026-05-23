import 'package:flutter/material.dart';
import 'package:rhythm/core/presentation/widgets/rhythm_primary_button.dart';
import 'package:rhythm/core/presentation/widgets/rhythm_secondary_button.dart';
import 'package:rhythm/features/onboarding/domain/onboarding_draft.dart';
import 'package:rhythm/features/onboarding/presentation/widgets/onboarding_step_scaffold.dart';

/// 登录选择页，提供匿名进入和后续绑定的入口。
class AuthEntryStep extends StatelessWidget {
  /// 创建登录选择页。
  const AuthEntryStep({super.key, required this.onSelectAuthOption});

  /// 选择某种进入方式。
  final ValueChanged<OnboardingAuthOption> onSelectAuthOption;

  @override
  Widget build(BuildContext context) {
    return OnboardingStepScaffold(
      eyebrow: '匿名也能开始',
      title: '先把节奏跑起来，登录只在需要同步时再做。',
      description: '匿名进入降低首启压力，登录用于换机恢复和会员状态同步。',
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          _AuthInfoCard(
            title: '本地优先',
            description: '数据先留在设备里',
          ),
          SizedBox(height: 12),
          _AuthInfoCard(
            title: '随时绑定',
            description: '之后再连账号也不会丢',
          ),
        ],
      ),
      footer: Row(
        children: [
          Expanded(
            child: RhythmSecondaryButton(
              label: '使用 Apple 继续',
              onPressed: () => onSelectAuthOption(OnboardingAuthOption.apple),
            ),
          ),
        ],
      ),
      secondaryAction: RhythmSecondaryButton(
        label: '使用 Google 继续',
        onPressed: () => onSelectAuthOption(OnboardingAuthOption.google),
      ),
      primaryAction: RhythmPrimaryButton(
        label: '匿名进入',
        onPressed: () => onSelectAuthOption(OnboardingAuthOption.anonymous),
      ),
    );
  }
}

/// 登录页的说明卡。
class _AuthInfoCard extends StatelessWidget {
  /// 创建说明卡。
  const _AuthInfoCard({required this.title, required this.description});

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
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.35),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: textTheme.titleSmall),
          const SizedBox(height: 6),
          Text(
            description,
            style: textTheme.bodySmall?.copyWith(
              color: colorScheme.onSurfaceVariant,
              height: 1.35,
            ),
          ),
        ],
      ),
    );
  }
}
