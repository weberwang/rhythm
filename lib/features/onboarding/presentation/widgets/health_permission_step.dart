import 'package:flutter/material.dart';
import 'package:rhythm/core/presentation/widgets/rhythm_primary_button.dart';
import 'package:rhythm/core/presentation/widgets/rhythm_secondary_button.dart';
import 'package:rhythm/features/onboarding/domain/onboarding_draft.dart';
import 'package:rhythm/features/onboarding/presentation/widgets/onboarding_step_scaffold.dart';
import 'package:rhythm/l10n/app_localizations.dart';

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
            title: l10n.onboardingHealthBenefitTitle,
            description: l10n.onboardingHealthBenefitDescription,
          ),
          const SizedBox(height: 12),
          _InfoCard(
            title: l10n.onboardingHealthCurrentStageTitle,
            description: l10n.onboardingHealthCurrentStageDescription,
          ),
          const SizedBox(height: 16),
          Text(authSummary),
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
