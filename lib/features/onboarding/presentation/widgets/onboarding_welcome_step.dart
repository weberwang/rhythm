import 'package:flutter/material.dart';
import 'package:rhythm/core/presentation/widgets/rhythm_primary_button.dart';
import 'package:rhythm/features/onboarding/presentation/widgets/onboarding_step_scaffold.dart';
import 'package:rhythm/l10n/app_localizations.dart';

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
    final l10n = AppLocalizations.of(context);

    return OnboardingStepScaffold(
      eyebrow: l10n.onboardingStepOneEyebrow,
      title: l10n.onboardingWelcomeTitle,
      description: l10n.onboardingWelcomeDescription,
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
                Text(l10n.onboardingWelcomeChecklistTitle, style: textTheme.titleMedium),
                const SizedBox(height: 16),
                _WelcomeBullet(
                  title: l10n.onboardingWelcomeBulletAuthTitle,
                  description: l10n.onboardingWelcomeBulletAuthDescription,
                ),
                const SizedBox(height: 12),
                _WelcomeBullet(
                  title: l10n.onboardingWelcomeBulletHealthTitle,
                  description: l10n.onboardingWelcomeBulletHealthDescription,
                ),
                const SizedBox(height: 12),
                _WelcomeBullet(
                  title: l10n.onboardingWelcomeBulletGoalTitle,
                  description: l10n.onboardingWelcomeBulletGoalDescription,
                ),
              ],
            ),
          ),
        ],
      ),
      primaryAction: RhythmPrimaryButton(
        label: l10n.onboardingWelcomePrimaryButton,
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
