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
      title: '先把节奏跑起来',
      description: '用更温和的方式，帮你把作息慢慢拨正。',
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _BenefitCard(
            title: '看清节律',
            description: '昨晚结果、今晚目标和 7 日变化放在同一屏里。',
          ),
          const SizedBox(height: 12),
          _BenefitCard(
            title: '降低负担',
            description: '不要求长记录，原因标签点一下就够。',
          ),
          const SizedBox(height: 12),
          _BenefitCard(
            title: '给出恢复路径',
            description: '晚睡后先告诉你怎么轻一点回正。',
          ),
        ],
      ),
      primaryAction: RhythmPrimaryButton(
        label: '开始建立我的作息目标',
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
