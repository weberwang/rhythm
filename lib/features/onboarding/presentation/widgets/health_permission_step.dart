import 'package:flutter/material.dart';
import 'package:rhythm/features/onboarding/domain/onboarding_draft.dart';
import 'package:rhythm/l10n/app_localizations.dart';
import 'package:rhythm/shared/presentation/widgets/composites/rhythm_glass_panel.dart';
import 'package:rhythm/shared/presentation/widgets/composites/rhythm_onboarding_action_card.dart';
import 'package:rhythm/shared/presentation/theme/rhythm_theme_extensions.dart';

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
    final theme = Theme.of(context);
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
          child: Column(
            children: [
              const SizedBox(height: 18),
              _PermissionHeroCard(
                title: l10n.onboardingHealthTitle,
                description: l10n.onboardingHealthDescription,
              ),
              const SizedBox(height: 18),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      _PermissionInfoPanel(
                        panelTitle: l10n.onboardingHealthBenefitTitle,
                        panelDescription:
                            l10n.onboardingHealthBenefitDescription,
                        child: Column(
                          children: [
                            _InfoRow(
                              icon: Icons.nightlight_round,
                              backgroundColor: const Color(0xFFF9FBFF),
                              title: l10n.onboardingHealthReadTitle,
                              description: l10n.onboardingHealthReadDescription,
                            ),
                            const SizedBox(height: 12),
                            _InfoRow(
                              icon: Icons.shield_outlined,
                              backgroundColor: const Color(0xFFFBFCFD),
                              title: l10n.onboardingHealthProtectTitle,
                              description:
                                  l10n.onboardingHealthProtectDescription,
                            ),
                            const SizedBox(height: 12),
                            _InfoRow(
                              icon: Icons.auto_awesome_rounded,
                              backgroundColor: const Color(0xFFFCFBF8),
                              title: l10n.onboardingHealthOutcomeTitle,
                              description:
                                  l10n.onboardingHealthOutcomeDescription,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        l10n.onboardingHealthFooterNote,
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
              const SizedBox(height: 16),
              RhythmOnboardingActionCard(
                primaryLabel: l10n.onboardingHealthUnderstandFirstButton,
                secondaryLabel: l10n.onboardingHealthSkipButton,
                onPrimary: onAuthorize,
                onSecondary: onSkip,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// 授权页顶部 Hero，更贴近 Pencil 中“徽记 + 标题 + 说明”的结构。
class _PermissionHeroCard extends StatelessWidget {
  /// 创建权限 Hero。
  const _PermissionHeroCard({required this.title, required this.description});

  /// 标题。
  final String title;

  /// 说明。
  final String description;

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
            color: theme.colorScheme.shadow.withValues(alpha: 0.12),
            blurRadius: 26,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
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
              const SizedBox(width: 14),
              Expanded(
                child: Text(
                  title,
                  style: textTheme.headlineMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    height: 1.08,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            description,
            style: textTheme.bodyMedium?.copyWith(
              color: const Color(0xFFEEF2FF),
              height: 1.45,
            ),
          ),
        ],
      ),
    );
  }
}

/// 承载授权说明卡大面板，统一“标题 + 说明 + 条目列表 + 当前模式提示”的节奏。
class _PermissionInfoPanel extends StatelessWidget {
  /// 创建说明面板。
  const _PermissionInfoPanel({
    required this.panelTitle,
    required this.panelDescription,
    required this.child,
  });

  /// 面板标题。
  final String panelTitle;

  /// 面板说明。
  final String panelDescription;

  /// 条目区内容。
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return RhythmGlassPanel(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            panelTitle,
            style: textTheme.titleMedium?.copyWith(
              color: theme.colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            panelDescription,
            style: textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 18),
          child,
        ],
      ),
    );
  }
}

/// 权限页的信息条目。
class _InfoRow extends StatelessWidget {
  /// 创建信息条目。
  const _InfoRow({
    required this.icon,
    required this.backgroundColor,
    required this.title,
    required this.description,
  });

  /// 前置图标。
  final IconData icon;

  /// 条目底色。
  final Color backgroundColor;

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
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: colorScheme.outlineVariant),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: colorScheme.surface,
              borderRadius: BorderRadius.circular(18),
            ),
            alignment: Alignment.center,
            child: Icon(icon, size: 18, color: colorScheme.onSurface),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: textTheme.labelLarge?.copyWith(
                    color: colorScheme.onSurface,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: textTheme.bodySmall?.copyWith(
                    color: colorScheme.onSurfaceVariant,
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
