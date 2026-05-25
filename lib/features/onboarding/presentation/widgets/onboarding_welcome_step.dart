import 'package:flutter/material.dart';
import 'package:rhythm/core/presentation/widgets/rhythm_primary_button.dart';
import 'package:rhythm/features/onboarding/presentation/widgets/onboarding_step_scaffold.dart';
import 'package:rhythm/l10n/app_localizations.dart';

/// 欢迎价值页，向用户说明首启的整体节奏。
class OnboardingWelcomeStep extends StatelessWidget {
  /// 创建欢迎页。
  const OnboardingWelcomeStep({super.key, required this.onContinue});

  /// 继续到下一步。
  final VoidCallback onContinue;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return OnboardingStepScaffold(
      eyebrow: l10n.onboardingStepOneEyebrow,
      title: l10n.onboardingWelcomeTitle,
      description: l10n.onboardingWelcomeDescription,
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _BenefitCard(
            title: l10n.onboardingWelcomeBulletAuthTitle,
            description: l10n.onboardingWelcomeBulletAuthDescription,
          ),
          const SizedBox(height: 12),
          _BenefitCard(
            title: l10n.onboardingWelcomeBulletHealthTitle,
            description: l10n.onboardingWelcomeBulletHealthDescription,
          ),
          const SizedBox(height: 12),
          _BenefitCard(
            title: l10n.onboardingWelcomeBulletGoalTitle,
            description: l10n.onboardingWelcomeBulletGoalDescription,
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

/// 欢迎页的价值卡片。
class _BenefitCard extends StatelessWidget {
  /// 创建价值卡片。
  const _BenefitCard({required this.title, required this.description});

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
      padding: const EdgeInsets.all(16),
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
              height: 1.35,
            ),
          ),
        ],
      ),
    );
  }
}
