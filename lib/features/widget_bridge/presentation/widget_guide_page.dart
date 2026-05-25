import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rhythm/app/router/app_router.dart';
import 'package:rhythm/l10n/app_localizations.dart';

/// 首次引导后的小组件价值页，帮助用户理解桌面存在感但不强迫立刻添加。
class WidgetGuidePage extends HookConsumerWidget {
  /// 创建小组件引导页。
  const WidgetGuidePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 12),
              _GuidePill(text: l10n.widgetGuideEyebrow),
              const SizedBox(height: 8),
              Text(
                l10n.widgetGuideTitle,
                style: textTheme.headlineMedium?.copyWith(
                  fontFamily: 'Funnel Sans',
                  fontWeight: FontWeight.w700,
                  height: 1.08,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                l10n.widgetGuideDescription,
                style: textTheme.bodyLarge?.copyWith(
                  fontFamily: 'Geist',
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 18),
              const _GuidePreviewCard(),
              const SizedBox(height: 18),
              _GuideStepsCard(
                steps: [
                  l10n.widgetGuideStepAdd,
                  l10n.widgetGuideStepChoose,
                  l10n.widgetGuideStepPlace,
                ],
              ),
              const Spacer(),
              FilledButton(
                onPressed: () => context.go(RhythmTab.today.path),
                style: FilledButton.styleFrom(
                  minimumSize: const Size.fromHeight(54),
                ),
                child: Text(l10n.widgetGuidePrimaryButton),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// 顶部引导胶囊，统一承载阶段九的价值提示语。
class _GuidePill extends StatelessWidget {
  /// 创建引导胶囊。
  const _GuidePill({required this.text});

  /// 胶囊文案。
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
      decoration: BoxDecoration(
        color: const Color(0xFFD7E7DA),
        borderRadius: BorderRadius.circular(9999),
      ),
      child: Text(
        text,
        style: Theme.of(context).textTheme.labelLarge?.copyWith(
          color: const Color(0xFF4A6B52),
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

/// 小组件预览卡，用固定示意内容帮助用户理解桌面信息层级。
class _GuidePreviewCard extends StatelessWidget {
  /// 创建预览卡。
  const _GuidePreviewCard();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final textTheme = Theme.of(context).textTheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFF1B3A28),
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
          Text(
            l10n.widgetGuidePreviewTitle,
            style: textTheme.labelLarge?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.widgetGuidePreviewRemaining,
                      style: textTheme.headlineSmall?.copyWith(
                        color: Colors.white,
                        fontFamily: 'IBM Plex Mono',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      l10n.widgetGuidePreviewSummary,
                      style: textTheme.bodySmall?.copyWith(
                        color: const Color(0xFFD7E7DA),
                        height: 1.35,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              const _PreviewBlocks(),
            ],
          ),
        ],
      ),
    );
  }
}

/// 预览卡右侧占位块，仅用于模拟桌面上额外信息块的视觉层级。
class _PreviewBlocks extends StatelessWidget {
  /// 创建占位块集合。
  const _PreviewBlocks();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        _PreviewBlock(height: 46),
        SizedBox(height: 8),
        _PreviewBlock(height: 26),
        SizedBox(height: 8),
        _PreviewBlock(height: 58),
      ],
    );
  }
}

/// 预览卡单个占位块。
class _PreviewBlock extends StatelessWidget {
  /// 创建单个占位块。
  const _PreviewBlock({required this.height});

  /// 占位块高度。
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 90,
      height: height,
      decoration: BoxDecoration(
        color: const Color(0xFF2C5F3B),
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }
}

/// 添加步骤卡，集中承载“如何把小组件加到桌面”的三条说明。
class _GuideStepsCard extends StatelessWidget {
  /// 创建步骤卡。
  const _GuideStepsCard({required this.steps});

  /// 步骤文案。
  final List<String> steps;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
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
          for (var index = 0; index < steps.length; index++) ...[
            Text(
              steps[index],
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
                height: 1.35,
              ),
            ),
            if (index != steps.length - 1) const SizedBox(height: 10),
          ],
        ],
      ),
    );
  }
}
