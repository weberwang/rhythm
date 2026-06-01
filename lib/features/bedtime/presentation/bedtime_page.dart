import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rhythm/app/router/app_router.dart';
import 'package:rhythm/app/router/secondary_navigation.dart';
import 'package:rhythm/core/presentation/widgets/rhythm_primary_button.dart';
import 'package:rhythm/features/bedtime/application/bedtime_controller.dart';
import 'package:rhythm/features/bedtime/application/bedtime_view_state.dart';
import 'package:rhythm/features/bedtime/domain/bedtime_action.dart';
import 'package:rhythm/features/bedtime/domain/bedtime_status.dart';
import 'package:rhythm/features/sleep_records/domain/sleep_delay_tag_rules.dart';
import 'package:rhythm/l10n/app_localizations.dart';
import 'package:rhythm/shared/presentation/theme/rhythm_theme_extensions.dart';

/// 睡前模式主页面，按 Pencil 稿重组成倒计时主卡、状态卡、动作建议卡和辅助卡组。
class BedtimePage extends HookConsumerWidget {
  /// 创建睡前模式页。
  const BedtimePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final stateAsync = ref.watch(bedtimeControllerProvider);

    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            const Color(0xFFF6F8FC),
            Theme.of(context).scaffoldBackgroundColor,
          ],
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
        child: stateAsync.when(
          data: (state) => _BedtimePageBody(state: state, l10n: l10n),
          loading: () => _BedtimeViewport(
            child: _BedtimeGlassCard(
              title: l10n.bedtimeCountdownTitle,
              description: l10n.bedtimeHeroSubtitle,
              child: const Padding(
                padding: EdgeInsets.only(top: 20),
                child: Center(child: CircularProgressIndicator()),
              ),
            ),
          ),
          error: (error, stackTrace) =>
              _BedtimeViewport(child: _BedtimeGoalMissingCard(l10n: l10n)),
        ),
      ),
    );
  }
}

/// 页内状态分发器，只处理 ready 与空态编排，不把区块细节堆回根页面。
class _BedtimePageBody extends HookConsumerWidget {
  /// 创建页面内容体。
  const _BedtimePageBody({required this.state, required this.l10n});

  final BedtimeViewState state;
  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    switch (state.status) {
      case BedtimeViewStatus.loading:
        return _BedtimeViewport(
          child: _BedtimeGlassCard(
            title: l10n.bedtimeCountdownTitle,
            description: l10n.bedtimeHeroSubtitle,
            child: const Padding(
              padding: EdgeInsets.only(top: 20),
              child: Center(child: CircularProgressIndicator()),
            ),
          ),
        );
      case BedtimeViewStatus.goalMissing:
      case BedtimeViewStatus.notificationPermissionMissing:
        return _BedtimeViewport(child: _BedtimeGoalMissingCard(l10n: l10n));
      case BedtimeViewStatus.ready:
        final controller = ref.read(bedtimeControllerProvider.notifier);
        final selectedStatus = state.selectedStatus ?? state.recommendedStatus!;
        final actions = state.actions.take(2).toList(growable: false);
        final showLikelyLateWarning =
            selectedStatus == BedtimeStatus.likelyLate ||
            state.recommendedStatus == BedtimeStatus.likelyLate;

        return _BedtimeViewport(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _BedtimeHeroCard(
                minutesUntilTarget: state.minutesUntilTarget,
                l10n: l10n,
              ),
              const SizedBox(height: 18),
              _BedtimeStatusCard(
                l10n: l10n,
                selectedStatus: selectedStatus,
                showLikelyLateWarning: showLikelyLateWarning,
                onSelected: controller.selectStatus,
              ),
              const SizedBox(height: 18),
              _BedtimeActionCard(
                l10n: l10n,
                selectedStatus: selectedStatus,
                actions: actions,
                onPrimaryPressed: actions.isEmpty
                    ? null
                    : () => controller.completeAction(actions.first),
              ),
              const SizedBox(height: 18),
              _BedtimeOptionalTagsCard(l10n: l10n),
              const SizedBox(height: 18),
              _BedtimeTrendCard(l10n: l10n),
            ],
          ),
        );
    }
  }
}

/// 页面统一滚动承载，避免每个状态分支各自处理底部留白。
class _BedtimeViewport extends StatelessWidget {
  /// 创建滚动视口。
  const _BedtimeViewport({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(padding: const EdgeInsets.only(bottom: 12), child: child),
    );
  }
}

/// 顶部倒计时主卡，优先传达离目标还有多久。
class _BedtimeHeroCard extends StatelessWidget {
  /// 创建倒计时主卡。
  const _BedtimeHeroCard({
    required this.minutesUntilTarget,
    required this.l10n,
  });

  final int minutesUntilTarget;
  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final heroTokens = theme.extension<RhythmHeroThemeExtension>();
    final textTheme = theme.textTheme;

    return Card(
      margin: EdgeInsets.zero,
      elevation: 0,
      color: Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
      clipBehavior: Clip.antiAlias,
      child: Container(
        padding: const EdgeInsets.fromLTRB(20, 18, 20, 20),
        decoration: BoxDecoration(
          gradient: heroTokens?.gradient,
          color: theme.colorScheme.primary,
          borderRadius: BorderRadius.circular(32),
          border: Border.all(
            color:
                heroTokens?.borderColor ?? Colors.white.withValues(alpha: 0.3),
          ),
          boxShadow: [
            BoxShadow(
              color: theme.colorScheme.shadow.withValues(alpha: 0.1),
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
                _BedtimeHeroBadge(icon: Icons.nightlight_round),
                const SizedBox(width: 14),
                Expanded(
                  child: Text(
                    _heroTitle(l10n),
                    style: textTheme.headlineSmall?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      height: 1.08,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              l10n.bedtimeHeroSubtitle,
              style: textTheme.bodyMedium?.copyWith(
                color: const Color(0xFFF0F3FF),
                height: 1.45,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Hero 标题直接复用目标时间差本地化，避免额外维护一套倒计时口径。
  String _heroTitle(AppLocalizations l10n) {
    if (minutesUntilTarget >= 0) {
      return l10n.bedtimeTargetDiffAhead(minutesUntilTarget);
    }
    return l10n.bedtimeTargetDiffLate(minutesUntilTarget.abs());
  }
}

/// 中段状态卡，承接今晚状态选择。
class _BedtimeStatusCard extends StatelessWidget {
  /// 创建状态卡。
  const _BedtimeStatusCard({
    required this.l10n,
    required this.selectedStatus,
    required this.showLikelyLateWarning,
    required this.onSelected,
  });

  final AppLocalizations l10n;
  final BedtimeStatus selectedStatus;
  final bool showLikelyLateWarning;
  final ValueChanged<BedtimeStatus> onSelected;

  @override
  Widget build(BuildContext context) {
    return _BedtimeGlassCard(
      title: l10n.bedtimeStatusTitle,
      description: l10n.bedtimeStatusDescription,
      child: Column(
        children: [
          _BedtimeStatusPill(
            label: l10n.bedtimeStatusMoreTime,
            selected: selectedStatus == BedtimeStatus.wantsMoreTime,
            onTap: () => onSelected(BedtimeStatus.wantsMoreTime),
          ),
          const SizedBox(height: 10),
          _BedtimeStatusPill(
            label: l10n.bedtimeStatusReady,
            selected: selectedStatus == BedtimeStatus.readyToSleep,
            onTap: () => onSelected(BedtimeStatus.readyToSleep),
          ),
          if (showLikelyLateWarning) ...[
            const SizedBox(height: 12),
            _BedtimeLikelyLateBanner(
              title: l10n.bedtimeStatusLikelyLate,
              description: l10n.bedtimeActionDescriptionLikelyLate,
            ),
          ],
        ],
      ),
    );
  }
}

/// 动作建议卡，使用主按钮承接最优先动作，再用一段说明解释为什么做它。
class _BedtimeActionCard extends StatelessWidget {
  /// 创建动作建议卡。
  const _BedtimeActionCard({
    required this.l10n,
    required this.selectedStatus,
    required this.actions,
    required this.onPrimaryPressed,
  });

  final AppLocalizations l10n;
  final BedtimeStatus selectedStatus;
  final List<BedtimeAction> actions;
  final VoidCallback? onPrimaryPressed;

  @override
  Widget build(BuildContext context) {
    final primaryAction = actions.isEmpty ? null : actions.first;
    final textTheme = Theme.of(context).textTheme;

    return _BedtimeGlassCard(
      title: l10n.bedtimeActionTitle,
      description: _actionDescription(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (primaryAction != null)
            RhythmPrimaryButton(
              label: _actionLabel(primaryAction.type),
              onPressed: onPrimaryPressed,
            ),
          if (actions.length > 1) ...[
            const SizedBox(height: 14),
            Text(
              _actionLabel(actions[1].type),
              textAlign: TextAlign.center,
              style: textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ],
      ),
    );
  }

  /// 不同状态需要不同解释语气，否则设计稿里的建议卡会退化成通用按钮列表。
  String _actionDescription() {
    switch (selectedStatus) {
      case BedtimeStatus.readyToSleep:
        return l10n.bedtimeActionDescriptionReady;
      case BedtimeStatus.wantsMoreTime:
        return l10n.bedtimeActionDescriptionMoreTime;
      case BedtimeStatus.likelyLate:
        return l10n.bedtimeActionDescriptionLikelyLate;
    }
  }

  /// 保持动作标签和 controller 里的建议类型一一对应。
  String _actionLabel(BedtimeActionType type) {
    switch (type) {
      case BedtimeActionType.dimLights:
        return l10n.bedtimeActionDimLights;
      case BedtimeActionType.putPhoneAway:
        return l10n.bedtimeActionPutPhoneAway;
      case BedtimeActionType.tenMinuteWrapUp:
        return l10n.bedtimeActionTenMinuteWrapUp;
      case BedtimeActionType.closeTonight:
        return l10n.bedtimeActionCloseTonight;
      case BedtimeActionType.planRecoveryTomorrow:
        return l10n.bedtimeActionPlanRecoveryTomorrow;
    }
  }
}

/// 可选标签卡先复用现有默认标签源，让页面有设计稿要求的补记入口密度。
class _BedtimeOptionalTagsCard extends StatelessWidget {
  /// 创建可选标签卡。
  const _BedtimeOptionalTagsCard({required this.l10n});

  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    final tagLabels = SleepDelayTagRules.defaultTags
        .where(
          (tag) =>
              tag.id == 'phone' || tag.id == 'overtime' || tag.id == 'emotion',
        )
        .map((tag) => tag.name)
        .toList(growable: false);

    return _BedtimeGlassCard(
      title: l10n.bedtimeOptionalTagsTitle,
      description: l10n.bedtimeActionDescriptionLikelyLate,
      child: Wrap(
        spacing: 10,
        runSpacing: 10,
        children: [for (final tag in tagLabels) _BedtimeSoftTag(label: tag)],
      ),
    );
  }
}

/// 趋势卡先按设计稿提供轻量趋势感，后续再接真实近 7 天数据。
class _BedtimeTrendCard extends StatelessWidget {
  /// 创建趋势卡。
  const _BedtimeTrendCard({required this.l10n});

  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return _BedtimeGlassCard(
      title: l10n.todayTrendSectionTitle,
      description: l10n.bedtimeTrendDescription,
      child: Row(
        children: [
          Expanded(
            child: Text(
              l10n.bedtimeTrendDescription,
              style: textTheme.bodySmall?.copyWith(
                color: const Color(0xFF6F7891),
                height: 1.35,
              ),
            ),
          ),
          const SizedBox(width: 16),
          const _BedtimeTrendBars(),
        ],
      ),
    );
  }
}

/// 空态卡现在也遵循设计页玻璃卡语言，不再是简单的居中段落。
class _BedtimeGoalMissingCard extends StatelessWidget {
  /// 创建目标缺失空态卡。
  const _BedtimeGoalMissingCard({required this.l10n});

  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    return _BedtimeGlassCard(
      title: l10n.bedtimeGoalMissingTitle,
      description: l10n.bedtimeGoalMissingDescription,
      child: RhythmPrimaryButton(
        label: l10n.bedtimeGoalMissingButton,
        onPressed: () => context.pushSecondary(onboardingGoalSetupPath),
      ),
    );
  }
}

/// 统一玻璃卡容器，保证 bedtime 页面所有区块的光感和内边距一致。
class _BedtimeGlassCard extends StatelessWidget {
  /// 创建玻璃卡。
  const _BedtimeGlassCard({
    required this.title,
    required this.description,
    required this.child,
  });

  final String title;
  final String description;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Card(
      margin: EdgeInsets.zero,
      elevation: 0,
      color: Colors.white.withValues(alpha: 0.82),
      shadowColor: theme.colorScheme.shadow.withValues(alpha: 0.08),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(28),
          border: Border.all(color: Colors.white.withValues(alpha: 0.86)),
          boxShadow: [
            BoxShadow(
              color: theme.colorScheme.shadow.withValues(alpha: 0.06),
              blurRadius: 24,
              offset: const Offset(0, 12),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: textTheme.titleMedium?.copyWith(
                color: const Color(0xFF182033),
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              description,
              style: textTheme.bodySmall?.copyWith(
                color: const Color(0xFF6F7891),
                height: 1.45,
              ),
            ),
            const SizedBox(height: 16),
            child,
          ],
        ),
      ),
    );
  }
}

/// 倒计时 hero 左上的图标胶囊。
class _BedtimeHeroBadge extends StatelessWidget {
  /// 创建 hero 徽记。
  const _BedtimeHeroBadge({required this.icon});

  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 34,
      height: 34,
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(17),
        border: Border.all(color: Colors.white.withValues(alpha: 0.18)),
      ),
      alignment: Alignment.center,
      child: Icon(icon, size: 18, color: Colors.white),
    );
  }
}

/// 状态胶囊以低成本还原设计稿的点选结构。
class _BedtimeStatusPill extends StatelessWidget {
  /// 创建状态胶囊。
  const _BedtimeStatusPill({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = selected ? const Color(0xFF4F5E9A) : const Color(0xFF6F7891);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(17),
        onTap: onTap,
        child: Ink(
          height: 34,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: selected ? const Color(0xFFEEF3FF) : Colors.white,
            borderRadius: BorderRadius.circular(17),
            border: Border.all(
              color: selected
                  ? const Color(0xFFDCE7F8)
                  : const Color(0xFFE7ECF6),
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 16,
                height: 16,
                decoration: BoxDecoration(
                  color: selected ? const Color(0xFF4F5E9A) : Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: selected
                        ? const Color(0xFF4F5E9A)
                        : const Color(0xFFC8D1EA),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  label,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: color,
                    fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// 标签卡内的轻量标签样式。
class _BedtimeSoftTag extends StatelessWidget {
  /// 创建轻量标签。
  const _BedtimeSoftTag({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFF),
        borderRadius: BorderRadius.circular(17),
        border: Border.all(color: const Color(0xFFE7ECF6)),
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
          color: const Color(0xFF6F7891),
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

/// 晚睡风险在设计稿里更像一条警示说明，而不是第三个同级选项。
class _BedtimeLikelyLateBanner extends StatelessWidget {
  /// 创建晚睡警示条。
  const _BedtimeLikelyLateBanner({
    required this.title,
    required this.description,
  });

  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFFCFBF8),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFEDE4D7)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              color: const Color(0xFFF7EFD7),
              borderRadius: BorderRadius.circular(15),
            ),
            alignment: Alignment.center,
            child: const Icon(
              Icons.wb_twilight_outlined,
              size: 16,
              color: Color(0xFF7C6946),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: textTheme.labelLarge?.copyWith(
                    color: const Color(0xFF182033),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
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

/// 趋势条用静态高度保持设计稿里的轻量趋势感，不把页面拖回图表工程化实现。
class _BedtimeTrendBars extends StatelessWidget {
  const _BedtimeTrendBars();

  @override
  Widget build(BuildContext context) {
    const bars = <double>[18, 26, 24, 32, 38];

    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        for (var index = 0; index < bars.length; index++) ...[
          Container(
            width: 12,
            height: bars[index],
            decoration: BoxDecoration(
              color: index == bars.length - 1
                  ? const Color(0xFFF1C98A)
                  : const Color(0xFFBFC8E9),
              borderRadius: BorderRadius.circular(6),
            ),
          ),
          if (index != bars.length - 1) const SizedBox(width: 8),
        ],
      ],
    );
  }
}
