import 'package:flutter/material.dart';
import 'package:rhythm/features/onboarding/domain/onboarding_draft.dart';
import 'package:rhythm/l10n/app_localizations.dart';
import 'package:rhythm/shared/presentation/theme/rhythm_theme_extensions.dart';

/// 登录选择页，优先按 Pencil 的首启结构承接三种登录方式和匿名继续入口。
class AuthEntryStep extends StatelessWidget {
  /// 创建登录选择页。
  const AuthEntryStep({super.key, required this.onSelectAuthOption});

  /// 选择某种进入方式。
  final ValueChanged<OnboardingAuthOption> onSelectAuthOption;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              colorScheme.surface.withValues(alpha: 0.98),
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
                _AuthHeroCard(
                  eyebrow: l10n.onboardingAuthEyebrow,
                  title: l10n.onboardingAuthTitle,
                  description: l10n.onboardingAuthDescription,
                ),
                const SizedBox(height: 24),
                _AuthOptionsCard(
                  title: l10n.onboardingAuthOptionsTitle,
                  description: l10n.onboardingAuthOptionsDescription,
                  options: [
                    _AuthOptionData(
                      label: l10n.onboardingAuthLaterButton,
                      badge: 'A',
                      badgeColor: const Color(0xFFEEF2FB),
                      onTap: () =>
                          onSelectAuthOption(OnboardingAuthOption.apple),
                    ),
                    _AuthOptionData(
                      label: l10n.onboardingAuthGoogleButton,
                      badge: 'G',
                      badgeColor: const Color(0xFFF7F0E2),
                      onTap: () =>
                          onSelectAuthOption(OnboardingAuthOption.google),
                    ),
                    _AuthOptionData(
                      label: l10n.onboardingAuthEmailButton,
                      badge: '@',
                      badgeColor: const Color(0xFFE9F4F0),
                      onTap: () =>
                          onSelectAuthOption(OnboardingAuthOption.email),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Align(
                  alignment: Alignment.center,
                  child: _AnonymousEntryPill(
                    label: l10n.onboardingAuthAnonymousButton,
                    foregroundColor: colorScheme.onSurfaceVariant,
                    onTap: () =>
                        onSelectAuthOption(OnboardingAuthOption.anonymous),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  l10n.onboardingAuthFooterNote,
                  textAlign: TextAlign.center,
                  style: textTheme.bodySmall?.copyWith(
                    color: colorScheme.onSurfaceVariant.withValues(alpha: 0.72),
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

/// 登录方式页的夜色 Hero 卡，复刻 Pencil 中“徽记 + 标题 + 插画”的首屏结构。
class _AuthHeroCard extends StatelessWidget {
  /// 创建登录页 Hero 卡。
  const _AuthHeroCard({
    required this.eyebrow,
    required this.title,
    required this.description,
  });

  /// 顶部徽记文案。
  final String eyebrow;

  /// 标题文案。
  final String title;

  /// 说明文案。
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
          _HeroEyebrowRow(text: eyebrow),
          const SizedBox(height: 18),
          Text(
            title,
            style: textTheme.headlineSmall?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w500,
              height: 1.05,
            ),
          ),
          const SizedBox(height: 8),
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

/// 匿名入口保持设计稿里的中置胶囊形式，箭头放在尾部而不是前缀。
class _AnonymousEntryPill extends StatelessWidget {
  const _AnonymousEntryPill({
    required this.label,
    required this.foregroundColor,
    required this.onTap,
  });

  final String label;
  final Color foregroundColor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: onTap,
        child: Ink(
          height: 40,
          padding: const EdgeInsets.symmetric(horizontal: 18),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.4),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                label,
                style: textTheme.labelLarge?.copyWith(
                  color: foregroundColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(width: 8),
              Icon(
                Icons.arrow_forward_rounded,
                size: 16,
                color: foregroundColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// 徽记行保持 Pencil 中“月亮徽记 + 一句轻提示”的视觉锚点。
class _HeroEyebrowRow extends StatelessWidget {
  const _HeroEyebrowRow({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Row(
      children: [
        Container(
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
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            text,
            style: textTheme.labelLarge?.copyWith(
              color: const Color(0xFFFFFFCC),
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}

/// 登录方式面板，承接设计稿中的三条登录入口。
class _AuthOptionsCard extends StatelessWidget {
  const _AuthOptionsCard({
    required this.title,
    required this.description,
    required this.options,
  });

  final String title;
  final String description;
  final List<_AuthOptionData> options;

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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          Text(
            description,
            style: textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 16),
          for (var index = 0; index < options.length; index++) ...[
            _AuthOptionTile(data: options[index]),
            if (index != options.length - 1) const SizedBox(height: 8),
          ],
        ],
      ),
    );
  }
}

/// 单条登录入口统一承接点击区、圆形徽记和箭头。
class _AuthOptionTile extends StatelessWidget {
  const _AuthOptionTile({required this.data});

  final _AuthOptionData data;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return InkWell(
      onTap: data.onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFFDCE3F0)),
          boxShadow: const [
            BoxShadow(
              color: Color(0x08223154),
              blurRadius: 18,
              offset: Offset(0, 8),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: data.badgeColor,
                borderRadius: BorderRadius.circular(18),
              ),
              alignment: Alignment.center,
              child: Text(
                data.badge,
                style: textTheme.titleSmall?.copyWith(
                  color: colorScheme.onSurface,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                data.label,
                style: textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Icon(
              Icons.arrow_forward_rounded,
              size: 18,
              color: colorScheme.onSurfaceVariant,
            ),
          ],
        ),
      ),
    );
  }
}

/// 登录入口静态配置。
class _AuthOptionData {
  const _AuthOptionData({
    required this.label,
    required this.badge,
    required this.badgeColor,
    required this.onTap,
  });

  final String label;
  final String badge;
  final Color badgeColor;
  final VoidCallback onTap;
}
