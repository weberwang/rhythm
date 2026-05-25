import 'package:flutter/material.dart';
import 'package:rhythm/core/presentation/widgets/rhythm_primary_button.dart';
import 'package:rhythm/core/presentation/widgets/rhythm_secondary_button.dart';
import 'package:rhythm/features/onboarding/domain/onboarding_draft.dart';
import 'package:rhythm/features/onboarding/presentation/widgets/onboarding_step_scaffold.dart';
import 'package:rhythm/l10n/app_localizations.dart';

/// 登录选择页，提供匿名进入和后续绑定的入口。
class AuthEntryStep extends StatelessWidget {
  /// 创建登录选择页。
  const AuthEntryStep({super.key, required this.onSelectAuthOption});

  /// 选择某种进入方式。
  final ValueChanged<OnboardingAuthOption> onSelectAuthOption;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return OnboardingStepScaffold(
      eyebrow: l10n.onboardingStepTwoEyebrow,
      title: l10n.onboardingAuthTitle,
      description: l10n.onboardingAuthDescription,
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _AuthInfoCard(
            title: l10n.onboardingAuthAppleLabel,
            description: l10n.onboardingAuthAppleDescription,
          ),
          const SizedBox(height: 12),
          _AuthInfoCard(
            title: l10n.onboardingAuthGoogleLabel,
            description: l10n.onboardingAuthGoogleDescription,
          ),
        ],
      ),
      footer: Row(
        children: [
          Expanded(
            child: RhythmSecondaryButton(
              label: l10n.onboardingAuthLaterButton,
              onPressed: () => onSelectAuthOption(OnboardingAuthOption.apple),
            ),
          ),
        ],
      ),
      secondaryAction: RhythmSecondaryButton(
        label: l10n.onboardingAuthGoogleButton,
        onPressed: () => onSelectAuthOption(OnboardingAuthOption.google),
      ),
      primaryAction: RhythmPrimaryButton(
        label: l10n.onboardingAuthAnonymousButton,
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
