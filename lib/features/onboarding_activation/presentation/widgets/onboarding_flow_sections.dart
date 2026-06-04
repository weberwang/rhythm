import 'package:flutter/material.dart';
import 'package:rhythm/l10n/app_localizations.dart';

import '../../domain/entities/onboarding_draft.dart';

/// 统一承载 onboarding 页面顶部身份信息，保证每一步都保留清晰的步骤和主题说明。
class OnboardingHeaderSection extends StatelessWidget {
  /// 创建顶部说明区。
  const OnboardingHeaderSection({
    super.key,
    required this.stepLabel,
    required this.title,
    required this.body,
  });

  /// 步骤文案。
  final String stepLabel;

  /// 标题文案。
  final String title;

  /// 说明文案。
  final String body;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          stepLabel,
          style: theme.textTheme.titleMedium?.copyWith(
            color: const Color(0xFF2F6A43),
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 28),
        Text(
          title,
          style: theme.textTheme.displaySmall?.copyWith(
            fontWeight: FontWeight.w600,
            color: theme.colorScheme.onSurface,
          ),
        ),
        const SizedBox(height: 20),
        Text(
          body,
          style: theme.textTheme.headlineSmall?.copyWith(
            color: theme.colorScheme.onSurface.withValues(alpha: 0.72),
            height: 1.35,
          ),
        ),
      ],
    );
  }
}

/// 根据当前步骤切换实际内容区，实现欢迎、进入方式、权限说明、作息设置、提醒和完成页。
class OnboardingStepSection extends StatelessWidget {
  /// 创建步骤内容区。
  const OnboardingStepSection({
    super.key,
    required this.draft,
    required this.onEntryModeSelected,
    required this.onReminderStrategySelected,
    required this.onPickBedtime,
    required this.onPickWakeTime,
  });

  /// 当前激活草稿。
  final OnboardingDraft draft;

  /// 进入方式选择回调。
  final ValueChanged<OnboardingEntryMode> onEntryModeSelected;

  /// 提醒策略选择回调。
  final ValueChanged<OnboardingReminderStrategy> onReminderStrategySelected;

  /// 选择入睡时间回调。
  final VoidCallback onPickBedtime;

  /// 选择起床时间回调。
  final VoidCallback onPickWakeTime;

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context);

    return switch (draft.step) {
      OnboardingStep.welcome => _WelcomeStep(localization: localization),
      OnboardingStep.entryMode => _EntryModeStep(
        localization: localization,
        selectedMode: draft.entryMode,
        onSelected: onEntryModeSelected,
      ),
      OnboardingStep.permissionValue => _PermissionValueStep(
        localization: localization,
      ),
      OnboardingStep.goalSchedule => _GoalScheduleStep(
        localization: localization,
        bedtimeMinutes: draft.bedtimeMinutes,
        wakeTimeMinutes: draft.wakeTimeMinutes,
        onPickBedtime: onPickBedtime,
        onPickWakeTime: onPickWakeTime,
      ),
      OnboardingStep.reminderStrategy => _ReminderStrategyStep(
        localization: localization,
        selectedStrategy: draft.reminderStrategy,
        onSelected: onReminderStrategySelected,
      ),
      OnboardingStep.completion => _CompletionStep(
        localization: localization,
        draft: draft,
      ),
    };
  }
}

/// 提供柔和背景光斑，避免 onboarding 再次退回平面占位背景。
class OnboardingSoftOrb extends StatelessWidget {
  /// 创建背景光斑。
  const OnboardingSoftOrb({
    super.key,
    required this.size,
    required this.color,
  });

  /// 光斑尺寸。
  final double size;

  /// 光斑颜色。
  final Color color;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: RadialGradient(
            colors: [color, color.withValues(alpha: 0)],
          ),
        ),
      ),
    );
  }
}

/// 统一承载底部主操作，保证每一步都只有一个明确主目标。
class OnboardingBottomActionBar extends StatelessWidget {
  /// 创建底部操作区。
  const OnboardingBottomActionBar({
    super.key,
    required this.showBack,
    required this.backLabel,
    required this.primaryLabel,
    required this.onBack,
    required this.onPrimary,
    required this.isLoading,
  });

  /// 是否显示返回按钮。
  final bool showBack;

  /// 返回文案。
  final String backLabel;

  /// 主按钮文案。
  final String primaryLabel;

  /// 返回回调。
  final VoidCallback onBack;

  /// 主操作回调。
  final VoidCallback? onPrimary;

  /// 是否处于提交中。
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
        child: Row(
          children: [
            if (showBack)
              TextButton(onPressed: onBack, child: Text(backLabel))
            else
              const SizedBox(width: 88),
            const SizedBox(width: 12),
            Expanded(
              child: FilledButton(
                onPressed: isLoading ? null : onPrimary,
                style: FilledButton.styleFrom(
                  minimumSize: const Size.fromHeight(64),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(28),
                  ),
                ),
                child: isLoading
                    ? const SizedBox(
                        width: 22,
                        height: 22,
                        child: CircularProgressIndicator(strokeWidth: 2.4),
                      )
                    : Text(primaryLabel),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// 统一承载带柔和投影的大卡片，保持 welcome 与设置页的视觉层级一致。
class OnboardingLandscapeCard extends StatelessWidget {
  /// 创建柔和卡片。
  const OnboardingLandscapeCard({super.key, required this.child});

  /// 卡片内容。
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.88),
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: const Color(0xFFDDE6D6)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x140D2E32),
            blurRadius: 28,
            offset: Offset(0, 16),
          ),
        ],
      ),
      child: Padding(padding: const EdgeInsets.all(24), child: child),
    );
  }
}

/// 把 welcome 与说明区的价值点统一成一行一义，便于后续替换真实图标或插图。
class OnboardingBenefitRow extends StatelessWidget {
  /// 创建价值点行。
  const OnboardingBenefitRow({
    super.key,
    required this.icon,
    required this.title,
    required this.body,
  });

  /// 图标。
  final IconData icon;

  /// 标题。
  final String title;

  /// 说明文案。
  final String body;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            color: theme.colorScheme.secondary.withValues(alpha: 0.42),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: theme.colorScheme.primary),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: theme.textTheme.titleLarge?.copyWith(
                  color: theme.colorScheme.onSurface,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                body,
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.74),
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/// 把进入方式与提醒策略统一为可选卡片，避免后续能力接入时再次重写容器结构。
class OnboardingSelectableModeCard extends StatelessWidget {
  /// 创建可选卡片。
  const OnboardingSelectableModeCard({
    super.key,
    required this.title,
    required this.body,
    required this.selected,
    required this.onTap,
  });

  /// 标题。
  final String title;

  /// 说明文案。
  final String body;

  /// 当前是否选中。
  final bool selected;

  /// 点击回调。
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(24),
        onTap: onTap,
        child: Ink(
          decoration: BoxDecoration(
            color: selected
                ? theme.colorScheme.primary.withValues(alpha: 0.10)
                : Colors.white.withValues(alpha: 0.80),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: selected
                  ? theme.colorScheme.primary
                  : const Color(0xFFDDE6D6),
              width: selected ? 1.5 : 1,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  selected ? Icons.check_circle : Icons.circle_outlined,
                  color: selected
                      ? theme.colorScheme.primary
                      : theme.colorScheme.onSurface.withValues(alpha: 0.48),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        body,
                        style: theme.textTheme.bodyLarge?.copyWith(
                          color: theme.colorScheme.onSurface.withValues(
                            alpha: 0.72,
                          ),
                          height: 1.4,
                        ),
                      ),
                    ],
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

/// 统一承载作息时间选择入口，避免目标设置页退化成复杂设置列表。
class OnboardingTimeChoiceTile extends StatelessWidget {
  /// 创建时间选择项。
  const OnboardingTimeChoiceTile({
    super.key,
    required this.title,
    required this.value,
    required this.onTap,
  });

  /// 标题。
  final String title;

  /// 已选值。
  final String value;

  /// 点击回调。
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(value, style: theme.textTheme.headlineSmall),
                ],
              ),
            ),
            const Icon(Icons.chevron_right_rounded),
          ],
        ),
      ),
    );
  }
}

/// 还原欢迎页的价值结构，避免再次退回占位卡片。
class _WelcomeStep extends StatelessWidget {
  /// 创建欢迎页内容。
  const _WelcomeStep({required this.localization});

  /// 当前语言资源。
  final AppLocalizations localization;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Column(
            children: [
              Icon(
                Icons.nightlight_round,
                size: 42,
                color: theme.colorScheme.primary,
              ),
              const SizedBox(height: 12),
              Text(
                'Rhythm',
                style: theme.textTheme.headlineLarge?.copyWith(
                  color: theme.colorScheme.onSurface,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 28),
        OnboardingLandscapeCard(
          child: Column(
            children: [
              OnboardingBenefitRow(
                icon: Icons.notifications_active_outlined,
                title: localization.onboardingBenefitReminderTitle,
                body: localization.onboardingBenefitReminderBody,
              ),
              const Divider(height: 28),
              OnboardingBenefitRow(
                icon: Icons.spa_outlined,
                title: localization.onboardingBenefitRoutineTitle,
                body: localization.onboardingBenefitRoutineBody,
              ),
              const Divider(height: 28),
              OnboardingBenefitRow(
                icon: Icons.bar_chart_outlined,
                title: localization.onboardingBenefitTrackingTitle,
                body: localization.onboardingBenefitTrackingBody,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/// 实现进入方式选择页，先完成本地激活，再为后续账号同步预留分流。
class _EntryModeStep extends StatelessWidget {
  /// 创建进入方式页。
  const _EntryModeStep({
    required this.localization,
    required this.selectedMode,
    required this.onSelected,
  });

  /// 当前语言资源。
  final AppLocalizations localization;

  /// 当前已选进入方式。
  final OnboardingEntryMode? selectedMode;

  /// 选择进入方式回调。
  final ValueChanged<OnboardingEntryMode> onSelected;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        OnboardingSelectableModeCard(
          title: localization.onboardingEntryLocalTitle,
          body: localization.onboardingEntryLocalBody,
          selected: selectedMode == OnboardingEntryMode.localFirst,
          onTap: () => onSelected(OnboardingEntryMode.localFirst),
        ),
        const SizedBox(height: 16),
        OnboardingSelectableModeCard(
          title: localization.onboardingEntrySyncLaterTitle,
          body: localization.onboardingEntrySyncLaterBody,
          selected: selectedMode == OnboardingEntryMode.syncLater,
          onTap: () => onSelected(OnboardingEntryMode.syncLater),
        ),
      ],
    );
  }
}

/// 实现权限价值说明页，强调“先理解价值，再决定是否授权”的降级语义。
class _PermissionValueStep extends StatelessWidget {
  /// 创建权限说明页。
  const _PermissionValueStep({required this.localization});

  /// 当前语言资源。
  final AppLocalizations localization;

  @override
  Widget build(BuildContext context) {
    return OnboardingLandscapeCard(
      child: Column(
        children: [
          OnboardingBenefitRow(
            icon: Icons.health_and_safety_outlined,
            title: localization.onboardingPermissionBenefitTitle,
            body: localization.onboardingPermissionBenefitBody,
          ),
          const Divider(height: 28),
          OnboardingBenefitRow(
            icon: Icons.lock_outline_rounded,
            title: localization.onboardingPermissionPrivacyTitle,
            body: localization.onboardingPermissionPrivacyBody,
          ),
          const Divider(height: 28),
          OnboardingBenefitRow(
            icon: Icons.edit_calendar_outlined,
            title: localization.onboardingPermissionFallbackTitle,
            body: localization.onboardingPermissionFallbackBody,
          ),
        ],
      ),
    );
  }
}

/// 实现目标作息选择页，让 onboarding 真正写入用户首个目标作息。
class _GoalScheduleStep extends StatelessWidget {
  /// 创建目标作息页。
  const _GoalScheduleStep({
    required this.localization,
    required this.bedtimeMinutes,
    required this.wakeTimeMinutes,
    required this.onPickBedtime,
    required this.onPickWakeTime,
  });

  /// 当前语言资源。
  final AppLocalizations localization;

  /// 当前目标入睡时间。
  final int bedtimeMinutes;

  /// 当前目标起床时间。
  final int wakeTimeMinutes;

  /// 选择入睡时间回调。
  final VoidCallback onPickBedtime;

  /// 选择起床时间回调。
  final VoidCallback onPickWakeTime;

  @override
  Widget build(BuildContext context) {
    final materialLocalizations = MaterialLocalizations.of(context);

    return OnboardingLandscapeCard(
      child: Column(
        children: [
          OnboardingTimeChoiceTile(
            title: localization.onboardingBedtimeLabel,
            value: materialLocalizations.formatTimeOfDay(
              TimeOfDay(
                hour: bedtimeMinutes ~/ 60 % 24,
                minute: bedtimeMinutes % 60,
              ),
            ),
            onTap: onPickBedtime,
          ),
          const Divider(height: 28),
          OnboardingTimeChoiceTile(
            title: localization.onboardingWakeTimeLabel,
            value: materialLocalizations.formatTimeOfDay(
              TimeOfDay(
                hour: wakeTimeMinutes ~/ 60 % 24,
                minute: wakeTimeMinutes % 60,
              ),
            ),
            onTap: onPickWakeTime,
          ),
          const SizedBox(height: 20),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              localization.onboardingGoalHint,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurface.withValues(
                  alpha: 0.72,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// 实现提醒策略选择页，在不接真实通知插件前先冻结用户的提醒偏好意图。
class _ReminderStrategyStep extends StatelessWidget {
  /// 创建提醒策略页。
  const _ReminderStrategyStep({
    required this.localization,
    required this.selectedStrategy,
    required this.onSelected,
  });

  /// 当前语言资源。
  final AppLocalizations localization;

  /// 当前已选提醒策略。
  final OnboardingReminderStrategy? selectedStrategy;

  /// 选择提醒策略回调。
  final ValueChanged<OnboardingReminderStrategy> onSelected;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        OnboardingSelectableModeCard(
          title: localization.onboardingReminderGentleTitle,
          body: localization.onboardingReminderGentleBody,
          selected: selectedStrategy == OnboardingReminderStrategy.gentle,
          onTap: () => onSelected(OnboardingReminderStrategy.gentle),
        ),
        const SizedBox(height: 16),
        OnboardingSelectableModeCard(
          title: localization.onboardingReminderNoneTitle,
          body: localization.onboardingReminderNoneBody,
          selected: selectedStrategy == OnboardingReminderStrategy.none,
          onTap: () => onSelected(OnboardingReminderStrategy.none),
        ),
      ],
    );
  }
}

/// 实现完成过渡页，让用户在进入主壳前看到本轮激活已准备好的关键结果。
class _CompletionStep extends StatelessWidget {
  /// 创建完成过渡页。
  const _CompletionStep({
    required this.localization,
    required this.draft,
  });

  /// 当前语言资源。
  final AppLocalizations localization;

  /// 当前激活草稿。
  final OnboardingDraft draft;

  @override
  Widget build(BuildContext context) {
    final materialLocalizations = MaterialLocalizations.of(context);
    final bedtime = materialLocalizations.formatTimeOfDay(
      TimeOfDay(
        hour: draft.bedtimeMinutes ~/ 60 % 24,
        minute: draft.bedtimeMinutes % 60,
      ),
    );
    final wake = materialLocalizations.formatTimeOfDay(
      TimeOfDay(
        hour: draft.wakeTimeMinutes ~/ 60 % 24,
        minute: draft.wakeTimeMinutes % 60,
      ),
    );

    return OnboardingLandscapeCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          OnboardingBenefitRow(
            icon: Icons.check_circle_outline,
            title: localization.onboardingCompletionSummaryTitle,
            body: localization.onboardingCompletionSummaryBody,
          ),
          const Divider(height: 28),
          _SummaryRow(
            label: localization.onboardingCompletionScheduleLabel,
            value: localization.onboardingCompletionScheduleValue(
              bedtime,
              wake,
            ),
          ),
          const SizedBox(height: 16),
          _SummaryRow(
            label: localization.onboardingCompletionEntryLabel,
            value: draft.entryMode == OnboardingEntryMode.syncLater
                ? localization.onboardingEntrySyncLaterTitle
                : localization.onboardingEntryLocalTitle,
          ),
          const SizedBox(height: 16),
          _SummaryRow(
            label: localization.onboardingCompletionReminderLabel,
            value: draft.reminderStrategy == OnboardingReminderStrategy.none
                ? localization.onboardingReminderNoneTitle
                : localization.onboardingReminderGentleTitle,
          ),
        ],
      ),
    );
  }
}

/// 统一展示完成页的结果摘要行，保持完成态信息层级稳定。
class _SummaryRow extends StatelessWidget {
  /// 创建摘要行。
  const _SummaryRow({required this.label, required this.value});

  /// 左侧标签。
  final String label;

  /// 右侧值。
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Text(
            label,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Text(
            value,
            textAlign: TextAlign.right,
            style: theme.textTheme.bodyLarge?.copyWith(
              color: theme.colorScheme.onSurface.withValues(alpha: 0.74),
              height: 1.35,
            ),
          ),
        ),
      ],
    );
  }
}
