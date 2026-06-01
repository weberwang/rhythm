import 'package:flutter/material.dart';
import 'package:rhythm/l10n/app_localizations.dart';
import 'package:rhythm/shared/presentation/theme/rhythm_theme_extensions.dart';

/// 欢迎价值页，按 Pencil 的首屏结构展示品牌语义、三步说明和单一主入口。
class OnboardingWelcomeStep extends StatelessWidget {
  /// 创建欢迎页。
  const OnboardingWelcomeStep({super.key, required this.onContinue});

  /// 继续到下一步。
  final VoidCallback onContinue;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              theme.colorScheme.surface.withValues(alpha: 0.98),
              theme.scaffoldBackgroundColor,
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 12),
                _WelcomeHeroCard(
                  eyebrow: l10n.onboardingStepOneEyebrow,
                  title: l10n.onboardingWelcomeTitle,
                  description: l10n.onboardingWelcomeDescription,
                  durationHint: l10n.onboardingWelcomeQuickDuration,
                ),
                const SizedBox(height: 24),
                _WelcomeChecklistCard(
                  title: l10n.onboardingWelcomeChecklistTitle,
                  primaryButtonLabel: l10n.onboardingWelcomePrimaryButton,
                  onContinue: onContinue,
                  steps: [
                    _WelcomeStepData(
                      index: '1',
                      title: l10n.onboardingWelcomeBulletAuthTitle,
                      description: l10n.onboardingWelcomeBulletAuthDescription,
                      backgroundColor: const Color(0xFFF8FAFF),
                      badgeColor: const Color(0xFFEEF3FF),
                      badgeForeground: const Color(0xFF5868A8),
                      borderColor: const Color(0xFFE7ECF6),
                    ),
                    _WelcomeStepData(
                      index: '2',
                      title: l10n.onboardingWelcomeBulletHealthTitle,
                      description:
                          l10n.onboardingWelcomeBulletHealthDescription,
                      backgroundColor: const Color(0xFFFCFBF8),
                      badgeColor: const Color(0xFFF7EFD7),
                      badgeForeground: const Color(0xFF7C6946),
                      borderColor: const Color(0xFFEEE7D8),
                    ),
                    _WelcomeStepData(
                      index: '3',
                      title: l10n.onboardingWelcomeBulletGoalTitle,
                      description: l10n.onboardingWelcomeBulletGoalDescription,
                      backgroundColor: const Color(0xFFF8F7FB),
                      badgeColor: const Color(0xFFF0ECFA),
                      badgeForeground: const Color(0xFF6D5F95),
                      borderColor: const Color(0xFFECE8F4),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 7,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.4),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Text(
                      l10n.onboardingAuthAnonymousButton,
                      style: textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  l10n.onboardingWelcomeFooterNote,
                  textAlign: TextAlign.center,
                  style: textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant.withValues(
                      alpha: 0.76,
                    ),
                    height: 1.45,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// 欢迎页顶部 Hero，承接夜色品牌感与首步提示。
class _WelcomeHeroCard extends StatelessWidget {
  const _WelcomeHeroCard({
    required this.eyebrow,
    required this.title,
    required this.description,
    required this.durationHint,
  });

  final String eyebrow;
  final String title;
  final String description;
  final String durationHint;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final heroTokens = theme.extension<RhythmHeroThemeExtension>();
    final textTheme = theme.textTheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: heroTokens?.gradient,
        color: theme.colorScheme.primary,
        borderRadius: BorderRadius.circular(32),
        border: Border.all(
          color:
              heroTokens?.borderColor ??
              theme.colorScheme.outlineVariant.withValues(alpha: 0.3),
        ),
        boxShadow: [
          BoxShadow(
            color: theme.colorScheme.shadow.withValues(alpha: 0.14),
            blurRadius: 42,
            offset: const Offset(0, 24),
          ),
          BoxShadow(
            color: theme.colorScheme.shadow.withValues(alpha: 0.1),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 34,
                height: 34,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.14),
                  borderRadius: BorderRadius.circular(17),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.18),
                  ),
                ),
                alignment: Alignment.center,
                child: const Icon(
                  Icons.nightlight_round,
                  size: 18,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  eyebrow,
                  style: textTheme.labelSmall?.copyWith(
                    color: const Color(0xFFF4F6FF),
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          Text(
            title,
            style: textTheme.displaySmall?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w500,
              height: 1.04,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            description,
            style: textTheme.bodyMedium?.copyWith(
              color: const Color(0xFFEEF2FF),
              height: 1.45,
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: Colors.white.withValues(alpha: 0.15)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.schedule_rounded,
                  size: 14,
                  color: Colors.white,
                ),
                const SizedBox(width: 8),
                Text(
                  durationHint,
                  style: textTheme.labelSmall?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 22),
          const _WelcomeIllustrationCard(),
        ],
      ),
    );
  }
}

/// Hero 底部改成单一插画底卡，避免把欢迎首屏拆成偏营销式的三栏卡片。
class _WelcomeIllustrationCard extends StatelessWidget {
  const _WelcomeIllustrationCard();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      width: double.infinity,
      height: 130,
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(26),
        border: Border.all(color: Colors.white.withValues(alpha: 0.14)),
      ),
      child: Stack(
        children: [
          Positioned(
            top: 18,
            left: 18,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.14),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.white.withValues(alpha: 0.18)),
              ),
              child: Text(
                '23:30',
                style: textTheme.labelLarge?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          Positioned(
            top: 20,
            right: 18,
            child: Container(
              width: 34,
              height: 34,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.14),
                borderRadius: BorderRadius.circular(17),
                border: Border.all(color: Colors.white.withValues(alpha: 0.18)),
              ),
              alignment: Alignment.center,
              child: const Icon(
                Icons.nightlight_round,
                size: 18,
                color: Colors.white,
              ),
            ),
          ),
          Positioned(
            left: 18,
            right: 18,
            bottom: 18,
            child: Row(
              children: const [
                Expanded(
                  child: _IllustrationMetricCard(
                    icon: Icons.nightlight_round,
                    tint: Color(0x22EEF3FF),
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: _IllustrationMetricCard(
                    icon: Icons.auto_awesome_rounded,
                    tint: Color(0x22FFFFFF),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// 插画底卡里的轻量信息块，只负责传达“记录与提醒”的产品语义。
class _IllustrationMetricCard extends StatelessWidget {
  const _IllustrationMetricCard({required this.icon, required this.tint});

  final IconData icon;
  final Color tint;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 54,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: tint,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.white.withValues(alpha: 0.14)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 16, color: Colors.white.withValues(alpha: 0.92)),
          const Spacer(),
          Container(
            width: 44,
            height: 6,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.84),
              borderRadius: BorderRadius.circular(3),
            ),
          ),
          const SizedBox(height: 6),
          Container(
            width: 72,
            height: 6,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.5),
              borderRadius: BorderRadius.circular(3),
            ),
          ),
        ],
      ),
    );
  }
}

/// 欢迎页内容卡，统一承接三个步骤说明和唯一主按钮。
class _WelcomeChecklistCard extends StatelessWidget {
  const _WelcomeChecklistCard({
    required this.title,
    required this.primaryButtonLabel,
    required this.onContinue,
    required this.steps,
  });

  final String title;
  final String primaryButtonLabel;
  final VoidCallback onContinue;
  final List<_WelcomeStepData> steps;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.84),
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: const Color(0x80FFFFFF)),
        boxShadow: [
          BoxShadow(
            color: theme.colorScheme.shadow.withValues(alpha: 0.07),
            blurRadius: 32,
            offset: const Offset(0, 16),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            title,
            style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 16),
          for (var index = 0; index < steps.length; index++) ...[
            _WelcomeStepCard(data: steps[index]),
            if (index != steps.length - 1) const SizedBox(height: 10),
          ],
          const SizedBox(height: 16),
          FilledButton(onPressed: onContinue, child: Text(primaryButtonLabel)),
        ],
      ),
    );
  }
}

/// 单个步骤说明卡，复刻 Pencil 里的编号胶囊和两行文案结构。
class _WelcomeStepCard extends StatelessWidget {
  const _WelcomeStepCard({required this.data});

  final _WelcomeStepData data;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: data.backgroundColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: data.borderColor),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              color: data.badgeColor,
              borderRadius: BorderRadius.circular(14),
            ),
            alignment: Alignment.center,
            child: Text(
              data.index,
              style: textTheme.labelMedium?.copyWith(
                color: data.badgeForeground,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data.title,
                  style: textTheme.labelLarge?.copyWith(
                    color: const Color(0xFF182033),
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  data.description,
                  style: textTheme.bodySmall?.copyWith(
                    color: const Color(0xFF6F7891),
                    height: 1.35,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// 欢迎页步骤卡静态配置。
class _WelcomeStepData {
  const _WelcomeStepData({
    required this.index,
    required this.title,
    required this.description,
    required this.backgroundColor,
    required this.badgeColor,
    required this.badgeForeground,
    required this.borderColor,
  });

  final String index;
  final String title;
  final String description;
  final Color backgroundColor;
  final Color badgeColor;
  final Color badgeForeground;
  final Color borderColor;
}
