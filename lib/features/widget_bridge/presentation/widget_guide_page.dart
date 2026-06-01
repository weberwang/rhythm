import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rhythm/app/router/app_router.dart';
import 'package:rhythm/l10n/app_localizations.dart';
import 'package:rhythm/shared/presentation/theme/rhythm_theme_extensions.dart';
import 'package:rhythm/shared/presentation/widgets/composites/rhythm_onboarding_action_card.dart';

/// 首次引导后的小组件价值页，按 Pencil 稿展示桌面预览与两段式动作。
class WidgetGuidePage extends HookConsumerWidget {
  /// 创建小组件引导页。
  const WidgetGuidePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                _WidgetGuideHeroCard(
                  title: l10n.widgetGuideTitle,
                  description: l10n.widgetGuideDescription,
                ),
                const SizedBox(height: 24),
                _WidgetGuidePreviewPanel(
                  title: l10n.widgetGuidePreviewPanelTitle,
                  description: l10n.widgetGuidePreviewPanelDescription,
                  note: l10n.widgetGuidePreviewPanelNote,
                ),
                const SizedBox(height: 24),
                RhythmOnboardingActionCard(
                  primaryLabel: l10n.widgetGuidePrimaryButton,
                  secondaryLabel: l10n.widgetGuideSecondaryButton,
                  onPrimary: () => context.go(profileWidgetThemePath),
                  onSecondary: () => context.go(RhythmTab.today.path),
                ),
                const SizedBox(height: 16),
                Text(
                  l10n.widgetGuideBottomNote,
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

/// 顶部 Hero 卡，承接桌面存在感的品牌语义。
class _WidgetGuideHeroCard extends StatelessWidget {
  const _WidgetGuideHeroCard({required this.title, required this.description});

  final String title;
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
                  style: textTheme.headlineSmall?.copyWith(
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

/// 小组件预览区，按设计稿展示主卡、副卡和补充说明。
class _WidgetGuidePreviewPanel extends StatelessWidget {
  const _WidgetGuidePreviewPanel({
    required this.title,
    required this.description,
    required this.note,
  });

  final String title;
  final String description;
  final String note;

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
              height: 1.5,
            ),
          ),
          const SizedBox(height: 18),
          const _WidgetPreviewPrimaryCard(),
          const SizedBox(height: 14),
          const _WidgetPreviewSecondaryCard(),
          const SizedBox(height: 14),
          Text(
            note,
            style: textTheme.bodySmall?.copyWith(
              color: const Color(0xFF8D97AE),
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}

/// 主预览卡，模拟桌面上最核心的小组件信息层级。
class _WidgetPreviewPrimaryCard extends StatelessWidget {
  const _WidgetPreviewPrimaryCard();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final textTheme = Theme.of(context).textTheme;

    return Container(
      height: 156,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF4F5E9A), Color(0xFF7D8BCB)],
        ),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0x55FFFFFF)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.widgetGuidePrimaryCardLabel,
                  style: textTheme.bodySmall?.copyWith(
                    color: const Color(0xFFF2F5FF),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  l10n.widgetGuidePrimaryCardValue,
                  style: textTheme.displaySmall?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  l10n.widgetGuidePrimaryCardDescription,
                  style: textTheme.bodySmall?.copyWith(
                    color: const Color(0xFFEAF0FF),
                    height: 1.35,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(13),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(13),
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.18),
                      ),
                    ),
                    child: Text(
                      l10n.widgetGuidePrimaryCardBadge,
                      style: textTheme.labelSmall?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
              const Spacer(),
              const _WidgetPreviewTrendBars(),
            ],
          ),
        ],
      ),
    );
  }
}

/// 预览卡右下角的趋势条，复刻设计稿里的轻量趋势感。
class _WidgetPreviewTrendBars extends StatelessWidget {
  const _WidgetPreviewTrendBars();

  @override
  Widget build(BuildContext context) {
    const bars = <(double, Color)>[
      (18, Color(0x66FFFFFF)),
      (24, Color(0x88FFFFFF)),
      (30, Color(0xAAFFFFFF)),
      (22, Color(0x77FFFFFF)),
      (34, Color(0xFFF1C98A)),
    ];

    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        for (var index = 0; index < bars.length; index++) ...[
          Container(
            width: 12,
            height: bars[index].$1,
            decoration: BoxDecoration(
              color: bars[index].$2,
              borderRadius: BorderRadius.circular(6),
            ),
          ),
          if (index != bars.length - 1) const SizedBox(width: 8),
        ],
      ],
    );
  }
}

/// 副预览卡，展示更轻的一层桌面摘要。
class _WidgetPreviewSecondaryCard extends StatelessWidget {
  const _WidgetPreviewSecondaryCard();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final textTheme = Theme.of(context).textTheme;

    return Container(
      height: 84,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFF),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: const Color(0xFFE8EDF8)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.widgetGuideSecondaryCardLabel,
                  style: textTheme.bodySmall?.copyWith(
                    color: const Color(0xFF6F7891),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  l10n.widgetGuideSecondaryCardValue,
                  style: textTheme.headlineSmall?.copyWith(
                    color: const Color(0xFF182033),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 72,
            height: 36,
            decoration: BoxDecoration(
              color: const Color(0xFFEEF3FF),
              borderRadius: BorderRadius.circular(18),
            ),
            alignment: Alignment.center,
            child: Text(
              l10n.widgetGuideSecondaryCardStatus,
              style: textTheme.labelSmall?.copyWith(
                color: const Color(0xFF4F5E9A),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
