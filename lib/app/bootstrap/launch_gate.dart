import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rhythm/core/presentation/widgets/rhythm_page_hero.dart';
import 'package:rhythm/core/presentation/widgets/rhythm_page_scaffold.dart';
import 'package:rhythm/core/presentation/widgets/rhythm_surface_card.dart';
import 'package:rhythm/l10n/app_localizations.dart';

import '../router/app_router.dart';
import 'bootstrap_launch_entry.dart';
import 'launch_state_provider.dart';

/// 启动分发页，负责在首屏展示启动状态并沿用既有路由分发逻辑。
class LaunchGate extends HookConsumerWidget {
  /// 创建启动分发页。
  const LaunchGate({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final completed = ref.watch(onboardingCompletedProvider);
    final launchEntry = ref.watch(bootstrapLaunchEntryProvider);
    final l10n = AppLocalizations.of(context);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!context.mounted) {
        return;
      }
      if (launchEntry.target == BootstrapEntryTarget.today) {
        context.go(RhythmTab.today.path);
        return;
      }
      if (launchEntry.target == BootstrapEntryTarget.bedtime) {
        context.go(bedtimeModePath);
        return;
      }
      // 保留原有首帧后分发节奏，避免在 build 阶段直接触发路由跳转。
      context.go(completed ? RhythmTab.today.path : onboardingWelcomePath);
    });

    return RhythmPageScaffold(
      backgroundColor: const Color(0xFFF5F3EE),
      hero: RhythmPageHero(
        eyebrow: l10n.launchGateEyebrow,
        title: l10n.launchGateTitle,
        description: l10n.launchGateDescription,
      ),
      body: RhythmSurfaceCard(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(strokeWidth: 2.6),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: _LaunchStatusContent(
                title: l10n.launchGateStatusTitle,
                description: l10n.launchGateStatusDescription,
              ),
            ),
          ],
        ),
      ),
      primaryAction: const SizedBox.shrink(),
    );
  }
}

/// 启动卡片里的状态文案区，单独拆出以保持首屏结构清晰。
class _LaunchStatusContent extends StatelessWidget {
  /// 创建启动状态文案区。
  const _LaunchStatusContent({
    required this.title,
    required this.description,
  });

  /// 状态标题。
  final String title;

  /// 状态说明。
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
            height: 1.4,
            color: colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}
