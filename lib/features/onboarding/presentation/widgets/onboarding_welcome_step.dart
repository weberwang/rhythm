import 'package:flutter/material.dart';
import 'package:rhythm/core/presentation/widgets/rhythm_primary_button.dart';
import 'package:rhythm/core/presentation/widgets/rhythm_surface_card.dart';
import 'package:rhythm/features/onboarding/presentation/widgets/onboarding_step_scaffold.dart';
import 'package:rhythm/l10n/app_localizations.dart';

/// 欢迎价值页，向用户说明首启阶段会收获的三个核心收益。
class OnboardingWelcomeStep extends StatelessWidget {
  /// 创建欢迎页。
  const OnboardingWelcomeStep({super.key, required this.onContinue});

  /// 继续到下一步。
  final VoidCallback onContinue;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return OnboardingStepScaffold(
      eyebrow: l10n.onboardingStepOneEyebrow,
      title: l10n.onboardingWelcomeTitle,
      description: l10n.onboardingWelcomeDescription,
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.onboardingWelcomeChecklistTitle,
            style: textTheme.titleMedium?.copyWith(
              fontFamily: 'Geist',
              fontWeight: FontWeight.w700,
              color: colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 12),
          RhythmSurfaceCard(
            child: _BenefitCardBody(
              title: l10n.onboardingWelcomeBulletAuthTitle,
              description: l10n.onboardingWelcomeBulletAuthDescription,
            ),
          ),
          const SizedBox(height: 12),
          RhythmSurfaceCard(
            child: _BenefitCardBody(
              title: l10n.onboardingWelcomeBulletHealthTitle,
              description: l10n.onboardingWelcomeBulletHealthDescription,
            ),
          ),
          const SizedBox(height: 12),
          RhythmSurfaceCard(
            child: _BenefitCardBody(
              title: l10n.onboardingWelcomeBulletGoalTitle,
              description: l10n.onboardingWelcomeBulletGoalDescription,
            ),
          ),
        ],
      ),
      footer: Text(
        l10n.onboardingWelcomeFooterNote,
        textAlign: TextAlign.center,
        style: textTheme.bodySmall?.copyWith(
          fontFamily: 'Geist',
          fontWeight: FontWeight.w500,
          height: 1.35,
          color: colorScheme.onSurfaceVariant,
        ),
      ),
      primaryAction: RhythmPrimaryButton(
        label: l10n.onboardingWelcomePrimaryButton,
        onPressed: onContinue,
      ),
    );
  }
}

/// 欢迎页价值卡正文，只负责排版标题与说明，容器样式交给共享卡片。
class _BenefitCardBody extends StatelessWidget {
  /// 创建价值卡正文。
  const _BenefitCardBody({required this.title, required this.description});

  /// 卡片标题。
  final String title;

  /// 卡片说明。
  final String description;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: textTheme.titleMedium?.copyWith(
            fontFamily: 'Geist',
            fontWeight: FontWeight.w700,
            color: colorScheme.onSurface,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          description,
          style: textTheme.bodyMedium?.copyWith(
            fontFamily: 'Geist',
            fontWeight: FontWeight.w500,
            color: colorScheme.onSurfaceVariant,
            height: 1.4,
          ),
        ),
      ],
    );
  }
}
