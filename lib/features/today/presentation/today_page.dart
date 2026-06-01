import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rhythm/app/router/app_router.dart';
import 'package:rhythm/app/router/secondary_navigation.dart';
import 'package:rhythm/core/presentation/widgets/rhythm_primary_button.dart';
import 'package:rhythm/features/today/domain/today_summary.dart';
import 'package:rhythm/features/today/presentation/widgets/sections/today_quick_actions_section.dart';
import 'package:rhythm/features/today/presentation/widgets/sections/today_trend_section.dart';
import 'package:rhythm/l10n/app_localizations.dart';
import 'package:rhythm/shared/presentation/theme/rhythm_theme_extensions.dart';

import '../application/today_controller.dart';
import '../application/today_view_state.dart';
import '../domain/today_primary_action.dart';

/// 今日页无权限状态插图资产路径，集中维护避免错误态和业务态引用不一致。
const _todayPermissionEmptyIllustrationAsset =
    'assets/images/today_permission_empty_illustration_v3.png';

/// 今日页入口，按 Pencil 稿重组为主结果卡、行动卡、恢复卡、快捷记录卡和趋势卡。
class TodayPage extends HookConsumerWidget {
  /// 创建今日页。
  const TodayPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final stateAsync = ref.watch(todayControllerProvider);

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
          data: (state) => _TodayPageBody(
            state: state,
            l10n: l10n,
            onOpenGoalSetup: () =>
                context.pushSecondary(onboardingGoalSetupPath),
            onOpenPermissionHelp: () => context.go(sleepRecordsHubPath),
            // 今日页进入手动补录属于二级流转，必须保留来源页返回栈。
            onManualRecord: () => context.pushSecondary(manualSleepRecordPath),
            onOpenBedtime: () => context.go(RhythmTab.bedtime.path),
            onOpenRecovery: () => context.go(RhythmTab.insights.path),
            onOpenRecordsHub: () => context.go(sleepRecordsHubPath),
          ),
          loading: () => _TodayPageViewport(
            child: _TodayStatusCard(
              icon: Icons.nightlight_round,
              title: l10n.todayPageTitle,
              description: l10n.todayCardDescription,
              child: const Padding(
                padding: EdgeInsets.only(top: 20),
                child: Center(child: CircularProgressIndicator()),
              ),
            ),
          ),
          error: (error, stackTrace) => _TodayPageViewport(
            child: _TodayEmptyCard(
              icon: Icons.health_and_safety_outlined,
              title: l10n.todayPermissionFailedTitle,
              description:
                  l10n.sleepRecordsHubStatusPermissionRequiredDescription,
              buttonLabel: l10n.todayPermissionFailedPrimaryAction,
              illustrationAsset: _todayPermissionEmptyIllustrationAsset,
              onPressed: () => context.go(sleepRecordsHubPath),
            ),
          ),
        ),
      ),
    );
  }
}

/// 今日页内容体，只承接状态分发与页面级路由动作。
class _TodayPageBody extends StatelessWidget {
  /// 创建内容体。
  const _TodayPageBody({
    required this.state,
    required this.l10n,
    required this.onOpenGoalSetup,
    required this.onOpenPermissionHelp,
    required this.onManualRecord,
    required this.onOpenBedtime,
    required this.onOpenRecovery,
    required this.onOpenRecordsHub,
  });

  final TodayViewState state;
  final AppLocalizations l10n;
  final VoidCallback onOpenGoalSetup;
  final VoidCallback onOpenPermissionHelp;
  final VoidCallback onManualRecord;
  final VoidCallback onOpenBedtime;
  final VoidCallback onOpenRecovery;
  final VoidCallback onOpenRecordsHub;

  @override
  Widget build(BuildContext context) {
    switch (state.status) {
      case TodayViewStatus.loading:
        return _TodayPageViewport(
          child: _TodayStatusCard(
            icon: Icons.nightlight_round,
            title: l10n.todayPageTitle,
            description: l10n.todayCardDescription,
            child: const Padding(
              padding: EdgeInsets.only(top: 20),
              child: Center(child: CircularProgressIndicator()),
            ),
          ),
        );
      case TodayViewStatus.goalMissing:
        return _TodayPageViewport(
          child: _TodayEmptyCard(
            icon: Icons.schedule_outlined,
            title: l10n.todayGoalMissingTitle,
            description: l10n.todayCardDescription,
            buttonLabel: l10n.todayGoalMissingPrimaryAction,
            onPressed: onOpenGoalSetup,
          ),
        );
      case TodayViewStatus.permissionFailed:
        return _TodayPageViewport(
          child: _TodayEmptyCard(
            icon: Icons.health_and_safety_outlined,
            title: l10n.todayPermissionFailedTitle,
            description:
                l10n.sleepRecordsHubStatusPermissionRequiredDescription,
            buttonLabel: l10n.todayPermissionFailedPrimaryAction,
            illustrationAsset: _todayPermissionEmptyIllustrationAsset,
            onPressed: onOpenPermissionHelp,
          ),
        );
      case TodayViewStatus.empty:
        return _TodayPageViewport(
          child: _TodayEmptyCard(
            icon: Icons.bedtime_outlined,
            title: l10n.todayEmptyTitle,
            description: l10n.todayCardDescription,
            buttonLabel: l10n.todayEmptyPrimaryAction,
            onPressed: onManualRecord,
          ),
        );
      case TodayViewStatus.ready:
        final summary = state.summary!;
        return _TodayReadyView(
          summary: summary,
          l10n: l10n,
          prioritizeRecoveryCard: state.prioritizeRecoveryCard,
          onPrimaryAction: _primaryActionHandler(summary.primaryAction),
          onManualRecord: onManualRecord,
          onEditRecord: onOpenRecordsHub,
          onOpenRecordsHub: onOpenRecordsHub,
          onOpenRecovery: onOpenRecovery,
        );
    }
  }

  /// 主行动仍沿用现有业务分流，避免视觉重构时顺手改掉流程语义。
  VoidCallback _primaryActionHandler(TodayPrimaryAction action) {
    switch (action) {
      case TodayPrimaryAction.enterBedtimeMode:
        return onOpenBedtime;
      case TodayPrimaryAction.manualRecord:
        return onManualRecord;
      case TodayPrimaryAction.openPermissionHelp:
        return onOpenPermissionHelp;
      case TodayPrimaryAction.openGoalSetup:
        return onOpenGoalSetup;
      case TodayPrimaryAction.viewRecoveryPlan:
        return onOpenRecovery;
    }
  }
}

/// Ready 态页面主体，按设计稿顺序串联各个内容区块。
class _TodayReadyView extends StatelessWidget {
  /// 创建 ready 态主体。
  const _TodayReadyView({
    required this.summary,
    required this.l10n,
    required this.prioritizeRecoveryCard,
    required this.onPrimaryAction,
    required this.onManualRecord,
    required this.onEditRecord,
    required this.onOpenRecordsHub,
    required this.onOpenRecovery,
  });

  final TodaySummary summary;
  final AppLocalizations l10n;
  final bool prioritizeRecoveryCard;
  final VoidCallback onPrimaryAction;
  final VoidCallback onManualRecord;
  final VoidCallback onEditRecord;
  final VoidCallback onOpenRecordsHub;
  final VoidCallback onOpenRecovery;

  @override
  Widget build(BuildContext context) {
    return _TodayPageViewport(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _TodayHeroCard(summary: summary, l10n: l10n),
          const SizedBox(height: 18),
          _TodayActionCard(
            summary: summary,
            l10n: l10n,
            onPressed: onPrimaryAction,
          ),
          if (prioritizeRecoveryCard || summary.showRecoveryCard) ...[
            const SizedBox(height: 18),
            _TodayRecoveryCard(
              summary: summary,
              l10n: l10n,
              onPressed: onOpenRecovery,
            ),
          ],
          const SizedBox(height: 18),
          TodayQuickActionsSection(
            onManualRecord: onManualRecord,
            onEditRecord: onEditRecord,
            onOpenRecordsHub: onOpenRecordsHub,
          ),
          const SizedBox(height: 18),
          TodayTrendSection(offsets: summary.trendOffsets),
        ],
      ),
    );
  }
}

/// 统一承接滚动与底部留白，避免各状态视图重复处理页面边距。
class _TodayPageViewport extends StatelessWidget {
  /// 创建页面视口。
  const _TodayPageViewport({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            // 空态内容本身不长时也要吃满可用高度，避免卡片下方露出大块页面背景。
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: child,
            ),
          ),
        );
      },
    );
  }
}

/// 顶部结果主卡，承接昨晚状态、趋势方向与品牌氛围。
class _TodayHeroCard extends StatelessWidget {
  /// 创建顶部结果主卡。
  const _TodayHeroCard({required this.summary, required this.l10n});

  final TodaySummary summary;
  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final heroTokens = theme.extension<RhythmHeroThemeExtension>();

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
          color: const Color(0xFF5C68A9),
          borderRadius: BorderRadius.circular(32),
          border: Border.all(
            color:
                heroTokens?.borderColor ?? Colors.white.withValues(alpha: 0.28),
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
                _TodayHeroBadge(
                  icon: summary.showRecoveryCard
                      ? Icons.nightlight_round
                      : Icons.check_circle_outline_rounded,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    l10n.todayStatusSectionTitle,
                    style: textTheme.titleMedium?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                if (summary.isUserConfirmedRecord)
                  _TodayHeroTag(label: l10n.todayStatusUserConfirmed),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              _statusHeadline(summary, l10n),
              style: textTheme.headlineSmall?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                height: 1.08,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              _statusDescription(summary, l10n),
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
}

/// 次级行动卡，展示今晚目标和唯一主行动入口。
class _TodayActionCard extends StatelessWidget {
  /// 创建行动卡。
  const _TodayActionCard({
    required this.summary,
    required this.l10n,
    required this.onPressed,
  });

  final TodaySummary summary;
  final AppLocalizations l10n;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final remainingLabel = _targetStatusLabel(summary.targetBedtimeMinutes);

    return _TodayStatusCard(
      icon: Icons.bedtime_outlined,
      title: l10n.todayActionSectionTitle,
      description: l10n.todayCardTitle,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFFF3F7FF),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: const Color(0xFFDCE7F8)),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l10n.todayActionTargetBedtime(
                          _formatMinutes(summary.targetBedtimeMinutes),
                        ),
                        style: textTheme.titleMedium?.copyWith(
                          color: const Color(0xFF182033),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        l10n.todayCardDescription,
                        style: textTheme.bodySmall?.copyWith(
                          color: const Color(0xFF6F7891),
                          height: 1.45,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    remainingLabel,
                    style: textTheme.labelLarge?.copyWith(
                      color: theme.colorScheme.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          RhythmPrimaryButton(
            label: _labelForAction(summary.primaryAction, l10n),
            onPressed: onPressed,
          ),
        ],
      ),
    );
  }
}

/// 恢复建议卡，只有在节奏需要被拉回时才提升优先级。
class _TodayRecoveryCard extends StatelessWidget {
  /// 创建恢复建议卡。
  const _TodayRecoveryCard({
    required this.summary,
    required this.l10n,
    required this.onPressed,
  });

  final TodaySummary summary;
  final AppLocalizations l10n;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final lateMinutes = summary.sleepOffsetMinutes.abs();

    return _TodayStatusCard(
      icon: Icons.wb_twilight_outlined,
      title: l10n.todayRecoverySectionTitle,
      description: summary.showRecoveryCard
          ? l10n.todayStatusLateDetail(lateMinutes)
          : l10n.todayStatusWithinThreshold,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            l10n.todayRecoveryDescription,
            style: textTheme.bodyMedium?.copyWith(
              color: const Color(0xFF6F7891),
              height: 1.45,
            ),
          ),
          if (summary.primaryAction != TodayPrimaryAction.viewRecoveryPlan) ...[
            const SizedBox(height: 14),
            Align(
              alignment: Alignment.centerLeft,
              child: TextButton(
                onPressed: onPressed,
                child: Text(
                  _labelForAction(TodayPrimaryAction.viewRecoveryPlan, l10n),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

/// 空态卡复用设计稿的卡片语言，而不是回退到简单标题加按钮。
class _TodayEmptyCard extends StatelessWidget {
  /// 创建空态卡。
  const _TodayEmptyCard({
    required this.icon,
    required this.title,
    required this.description,
    required this.buttonLabel,
    required this.onPressed,
    this.illustrationAsset,
  });

  final IconData icon;
  final String title;
  final String description;
  final String buttonLabel;
  final VoidCallback onPressed;

  /// 仅在需要增强空态视觉密度时传入，默认保持其他空态的紧凑结构。
  final String? illustrationAsset;

  /// 构建今日页空态卡片，按状态决定是否展示装饰插图。
  @override
  Widget build(BuildContext context) {
    return _TodayStatusCard(
      icon: icon,
      title: title,
      description: description,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (illustrationAsset != null) ...[
            _TodayPermissionEmptyIllustration(assetPath: illustrationAsset!),
            const SizedBox(height: 18),
          ],
          RhythmPrimaryButton(label: buttonLabel, onPressed: onPressed),
        ],
      ),
    );
  }
}

/// 今日页健康权限缺失状态的装饰插图，负责填充卡片空白但不承载额外文案。
class _TodayPermissionEmptyIllustration extends StatelessWidget {
  /// 创建权限缺失空态插图。
  const _TodayPermissionEmptyIllustration({required this.assetPath});

  /// 项目内图片资产路径。
  final String assetPath;

  /// 渲染装饰图片，排除语义树以避免与空态标题和按钮重复表达。
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 320),
        child: AspectRatio(
          // 生成图是 1024x1536 竖幅，按真实比例承载可避免顶部权限符号被过度裁切。
          aspectRatio: 2 / 3,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: Image.asset(
              assetPath,
              fit: BoxFit.cover,
              excludeFromSemantics: true,
            ),
          ),
        ),
      ),
    );
  }
}

/// 统一的浅色玻璃卡承载体，保证页面区块在同一视觉体系内收口。
class _TodayStatusCard extends StatelessWidget {
  /// 创建状态卡。
  const _TodayStatusCard({
    required this.icon,
    required this.title,
    required this.description,
    required this.child,
  });

  final IconData icon;
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
            Row(
              children: [
                Container(
                  width: 34,
                  height: 34,
                  decoration: BoxDecoration(
                    color: const Color(0xFFEEF3FF),
                    borderRadius: BorderRadius.circular(17),
                  ),
                  alignment: Alignment.center,
                  child: Icon(icon, size: 18, color: const Color(0xFF4F5E9A)),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    title,
                    style: textTheme.titleMedium?.copyWith(
                      color: const Color(0xFF182033),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              description,
              style: textTheme.bodyMedium?.copyWith(
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

/// Hero 左上图标徽记。
class _TodayHeroBadge extends StatelessWidget {
  /// 创建 Hero 徽记。
  const _TodayHeroBadge({required this.icon});

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

/// Hero 右上状态胶囊。
class _TodayHeroTag extends StatelessWidget {
  /// 创建 Hero 胶囊。
  const _TodayHeroTag({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(13),
        border: Border.all(color: Colors.white.withValues(alpha: 0.18)),
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

/// 统一映射今日页主行动文案，避免页面多个卡片各写一套 switch。
String _labelForAction(TodayPrimaryAction action, AppLocalizations l10n) {
  switch (action) {
    case TodayPrimaryAction.enterBedtimeMode:
      return l10n.todayActionEnterBedtimeMode;
    case TodayPrimaryAction.manualRecord:
      return l10n.todayActionManualRecord;
    case TodayPrimaryAction.openPermissionHelp:
      return l10n.todayActionPermissionHelp;
    case TodayPrimaryAction.openGoalSetup:
      return l10n.todayActionGoalSetup;
    case TodayPrimaryAction.viewRecoveryPlan:
      return l10n.todayActionRecoveryPlan;
  }
}

/// 根据摘要生成结果主标题，优先突出昨晚状态而不是技术字段。
String _statusHeadline(TodaySummary summary, AppLocalizations l10n) {
  final lateMinutes = summary.sleepOffsetMinutes.abs();
  if (summary.sleepOffsetMinutes > 0) {
    return l10n.todayStatusLateBy(lateMinutes);
  }
  if (summary.sleepOffsetMinutes < 0) {
    return l10n.todayStatusEarlyBy(lateMinutes);
  }
  return l10n.todayStatusGoalMet;
}

/// 主卡说明文案保持简短，只解释“为什么今天该这么做”。
String _statusDescription(TodaySummary summary, AppLocalizations l10n) {
  final lateMinutes = summary.sleepOffsetMinutes.abs();
  if (summary.sleepOffsetMinutes > 0) {
    final detail = l10n.todayStatusLateDetail(lateMinutes);
    if (summary.showRecoveryCard) {
      return _joinStatusSentences(l10n, [
        detail,
        l10n.todayRecoveryDescription,
      ]);
    }
    return _joinStatusSentences(l10n, [
      detail,
      l10n.todayStatusWithinThreshold,
    ]);
  }
  if (summary.sleepOffsetMinutes < 0) {
    return _joinStatusSentences(l10n, [
      l10n.todayStatusEarlyBy(lateMinutes),
      l10n.todayStatusWithinThreshold,
    ]);
  }
  return _joinStatusSentences(l10n, [
    l10n.todayStatusGoalMet,
    l10n.todayStatusWithinThreshold,
  ]);
}

/// 将分钟数格式化为页面统一使用的 `HH:mm` 形式。
String _formatMinutes(int minutes) {
  final hour = (minutes ~/ 60).toString().padLeft(2, '0');
  final minute = (minutes % 60).toString().padLeft(2, '0');
  return '$hour:$minute';
}

/// 计算距离目标时间的轻量状态标签，避免页面上再出现第二组长句文案。
String _targetStatusLabel(int targetBedtimeMinutes) {
  final now = TimeOfDay.now();
  final currentMinutes = now.hour * 60 + now.minute;
  final delta = targetBedtimeMinutes - currentMinutes;
  final hours = (delta.abs() ~/ 60).toString().padLeft(2, '0');
  final minutes = (delta.abs() % 60).toString().padLeft(2, '0');
  return '$hours:$minutes';
}

/// 按当前语言拼接短句，避免英文环境出现中文句号。
String _joinStatusSentences(AppLocalizations l10n, List<String> parts) {
  final separator = l10n.localeName.startsWith('zh') ? '。' : '. ';
  final filtered = parts.where((part) => part.trim().isNotEmpty).toList();
  if (filtered.isEmpty) {
    return '';
  }
  final text = filtered.join(separator);
  return l10n.localeName.startsWith('zh') ? '$text。' : '$text.';
}
