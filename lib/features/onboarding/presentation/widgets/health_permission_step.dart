import 'package:flutter/material.dart';
import 'package:rhythm/core/presentation/widgets/rhythm_primary_button.dart';
import 'package:rhythm/core/presentation/widgets/rhythm_secondary_button.dart';
import 'package:rhythm/core/presentation/widgets/rhythm_surface_card.dart';
import 'package:rhythm/features/onboarding/domain/onboarding_draft.dart';
import 'package:rhythm/features/onboarding/presentation/widgets/onboarding_step_scaffold.dart';
import 'package:rhythm/l10n/app_localizations.dart';

/// 健康权限说明页，只负责说明价值和分流，不接入真实系统权限请求。
class HealthPermissionStep extends StatelessWidget {
  /// 创建权限说明页。
  const HealthPermissionStep({
    super.key,
    this.selectedAuthOption = OnboardingAuthOption.none,
    required this.onAuthorize,
    required this.onSkip,
  });

  /// 当前选择的登录方式。
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
      OnboardingAuthOption.email => l10n.onboardingHealthDefaultSummary,
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
          RhythmSurfaceCard(
            child: _InfoCardBody(
              title: l10n.onboardingHealthAppleSummary,
              description: l10n.onboardingHealthGoogleSummary,
            ),
          ),
          const SizedBox(height: 12),
          RhythmSurfaceCard(
            child: _InfoCardBody(
              title: l10n.onboardingHealthAnonymousSummary,
              description: l10n.onboardingHealthDefaultSummary,
            ),
          ),
          const SizedBox(height: 12),
          RhythmSurfaceCard(
            child: _InfoCardBody(
              title: l10n.onboardingHealthBenefitTitle,
              description: l10n.onboardingHealthBenefitDescription,
              supplementTitle: l10n.onboardingHealthCurrentStageTitle,
              supplementDescription: [
                authSummary,
                l10n.onboardingHealthCurrentStageDescription,
              ].join('\n'),
            ),
          ),
        ],
      ),
      secondaryAction: RhythmSecondaryButton(
        label: l10n.onboardingHealthSkipButton,
        onPressed: onSkip,
      ),
      primaryAction: RhythmPrimaryButton(
        label: l10n.onboardingHealthAuthorizeButton,
        onPressed: onAuthorize,
      ),
    );
  }
}

/// 权限页信息卡正文，支持附加当前阶段说明等补充信息。
class _InfoCardBody extends StatelessWidget {
  /// 创建信息卡正文。
  const _InfoCardBody({
    required this.title,
    required this.description,
    this.supplementTitle,
    this.supplementDescription,
  });

  /// 标题。
  final String title;

  /// 说明。
  final String description;

  /// 补充标题。
  final String? supplementTitle;

  /// 补充说明。
  final String? supplementDescription;

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
        if (supplementTitle != null && supplementDescription != null) ...[
          const SizedBox(height: 14),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: const Color(0xFFEEF4EA),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  supplementTitle!,
                  style: textTheme.titleSmall?.copyWith(
                    fontFamily: 'Geist',
                    fontWeight: FontWeight.w700,
                    color: colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: 6),
                // 将当前认证方式映射进卡片里，避免说明页与用户刚做出的选择脱节。
                Text(
                  supplementDescription!,
                  style: textTheme.bodySmall?.copyWith(
                    fontFamily: 'Geist',
                    fontWeight: FontWeight.w500,
                    color: colorScheme.onSurfaceVariant,
                    height: 1.35,
                  ),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }
}
