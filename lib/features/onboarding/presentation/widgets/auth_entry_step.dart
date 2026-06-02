import 'package:flutter/material.dart';
import 'package:rhythm/core/presentation/widgets/rhythm_primary_button.dart';
import 'package:rhythm/core/presentation/widgets/rhythm_secondary_button.dart';
import 'package:rhythm/core/presentation/widgets/rhythm_surface_card.dart';
import 'package:rhythm/features/onboarding/domain/onboarding_draft.dart';
import 'package:rhythm/features/onboarding/presentation/widgets/onboarding_step_scaffold.dart';
import 'package:rhythm/l10n/app_localizations.dart';

/// 登录选择页，保留匿名与 Google 进入路径，并把 Apple 信息收敛成轻提示。
class AuthEntryStep extends StatelessWidget {
  /// 创建登录选择页。
  const AuthEntryStep({
    super.key,
    required this.onSelectAuthOption,
  });

  /// 选择某种进入方式。
  final ValueChanged<OnboardingAuthOption> onSelectAuthOption;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final footerHint = [
      l10n.onboardingAuthAppleDescription,
      l10n.onboardingAuthGoogleDescription,
    ].join(' · ');

    return OnboardingStepScaffold(
      eyebrow: l10n.onboardingStepTwoEyebrow,
      title: l10n.onboardingAuthTitle,
      description: l10n.onboardingAuthDescription,
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RhythmSurfaceCard(
            tone: RhythmSurfaceCardTone.soft,
            child: _AuthInfoCardBody(
              title: l10n.onboardingAuthAppleLabel,
              description: l10n.onboardingAuthAppleDescription,
            ),
          ),
          const SizedBox(height: 12),
          RhythmSurfaceCard(
            tone: RhythmSurfaceCardTone.soft,
            child: _AuthInfoCardBody(
              title: l10n.onboardingAuthGoogleLabel,
              description: l10n.onboardingAuthGoogleDescription,
            ),
          ),
        ],
      ),
      footer: _AuthFooterHint(text: footerHint),
      secondaryAction: RhythmSecondaryButton(
        label: l10n.onboardingAuthGoogleButton,
        onPressed: () => onSelectAuthOption(OnboardingAuthOption.google),
      ),
      // 设计稿这一版只把 Google 暴露为次按钮，Apple 相关信息收敛到提示文案里。
      primaryAction: RhythmPrimaryButton(
        label: l10n.onboardingAuthAnonymousButton,
        onPressed: () => onSelectAuthOption(OnboardingAuthOption.anonymous),
      ),
    );
  }
}

/// 登录页浅提示卡正文，负责承载单组标题与说明。
class _AuthInfoCardBody extends StatelessWidget {
  /// 创建浅提示卡正文。
  const _AuthInfoCardBody({
    required this.title,
    required this.description,
  });

  /// 标题。
  final String title;

  /// 说明。
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
          style: textTheme.titleSmall?.copyWith(
            fontFamily: 'Geist',
            fontWeight: FontWeight.w700,
            color: colorScheme.onSurface,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          description,
          style: textTheme.bodySmall?.copyWith(
            fontFamily: 'Geist',
            fontWeight: FontWeight.w500,
            color: colorScheme.onSurfaceVariant,
            height: 1.35,
          ),
        ),
      ],
    );
  }
}

/// 登录页底部轻提示，用更轻的语气承接“先匿名、后绑定”的心智。
class _AuthFooterHint extends StatelessWidget {
  /// 创建底部轻提示。
  const _AuthFooterHint({required this.text});

  /// 提示文案。
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.bodySmall?.copyWith(
        fontFamily: 'Geist',
        fontWeight: FontWeight.w500,
        height: 1.35,
        color: const Color(0xFF7A9A80),
      ),
    );
  }
}
