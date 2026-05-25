import 'package:flutter/material.dart';
import 'package:rhythm/core/presentation/widgets/rhythm_primary_button.dart';
import 'package:rhythm/core/presentation/widgets/rhythm_secondary_button.dart';
import 'package:rhythm/features/onboarding/domain/onboarding_draft.dart';
import 'package:rhythm/features/onboarding/presentation/widgets/onboarding_step_scaffold.dart';
import 'package:rhythm/l10n/app_localizations.dart';

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
    final l10n = AppLocalizations.of(context);
    final authSummary = switch (selectedAuthOption) {
      OnboardingAuthOption.apple => l10n.onboardingHealthAppleSummary,
      OnboardingAuthOption.google => l10n.onboardingHealthGoogleSummary,
      OnboardingAuthOption.anonymous => l10n.onboardingHealthAnonymousSummary,
      OnboardingAuthOption.none => l10n.onboardingHealthDefaultSummary,
    };

    return OnboardingStepScaffold(
      eyebrow: l10n.onboardingStepThreeEyebrow,
      title: l10n.onboardingHealthTitle,
      description: l10n.onboardingHealthDescription,
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _InfoCard(
            title: l10n.onboardingHealthAppleSummary,
            description: l10n.onboardingHealthGoogleSummary,
          ),
          const SizedBox(height: 12),
          _InfoCard(
            title: l10n.onboardingHealthAnonymousSummary,
            description: l10n.onboardingHealthDefaultSummary,
          ),
          const SizedBox(height: 12),
          _InfoCard(
            title: l10n.onboardingHealthBenefitTitle,
            description: l10n.onboardingHealthBenefitDescription,
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
        label: l10n.onboardingHealthAuthorizeButton,
        onPressed: onAuthorize,
      ),
      secondaryAction: RhythmSecondaryButton(
        label: l10n.onboardingHealthSkipButton,
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
