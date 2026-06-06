import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rhythm/l10n/app_localizations.dart';

import '../../domain/entities/onboarding_account_connection_result.dart';
import '../../domain/entities/onboarding_draft.dart';
import '../../domain/entities/onboarding_widget_guide.dart';
import 'onboarding_flow_primitives.dart';

/// 根据当前步骤切换实际内容区，实现欢迎、进入方式、权限说明、作息设置、提醒、小组件和完成页。
class OnboardingStepSection extends StatelessWidget {
  /// 创建步骤内容区。
  const OnboardingStepSection({
    super.key,
    required this.draft,
    required this.widgetGuideAsync,
    required this.onEntryModeSelected,
    required this.onAccountProviderSelected,
    required this.onReminderStrategySelected,
    required this.onPickBedtime,
    required this.onPickWakeTime,
  });

  /// 当前激活草稿。
  final OnboardingDraft draft;

  /// 当前平台的小组件引导快照。
  final AsyncValue<OnboardingWidgetGuide> widgetGuideAsync;

  /// 进入方式选择回调。
  final ValueChanged<OnboardingEntryMode> onEntryModeSelected;

  /// 账号提供方选择回调。
  final ValueChanged<OnboardingAccountProvider> onAccountProviderSelected;

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
        selectedAccountProvider: draft.selectedAccountProvider,
        accountConnection: draft.accountConnection,
        onSelected: onEntryModeSelected,
        onAccountProviderSelected: onAccountProviderSelected,
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
      OnboardingStep.widgetGuide => _WidgetGuideStep(
        localization: localization,
        widgetGuideAsync: widgetGuideAsync,
      ),
      OnboardingStep.completion => _CompletionStep(
        localization: localization,
        draft: draft,
      ),
    };
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
    required this.selectedAccountProvider,
    required this.accountConnection,
    required this.onSelected,
    required this.onAccountProviderSelected,
  });

  /// 当前语言资源。
  final AppLocalizations localization;

  /// 当前已选进入方式。
  final OnboardingEntryMode? selectedMode;

  /// 当前已选账号提供方。
  final OnboardingAccountProvider? selectedAccountProvider;

  /// 最近一次账号连接结果。
  final OnboardingAccountConnectionResult? accountConnection;

  /// 选择进入方式回调。
  final ValueChanged<OnboardingEntryMode> onSelected;

  /// 选择账号提供方回调。
  final ValueChanged<OnboardingAccountProvider> onAccountProviderSelected;

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
          title: localization.onboardingEntryAppleTitle,
          body: localization.onboardingEntryAppleBody,
          selected:
              selectedMode == OnboardingEntryMode.account &&
              selectedAccountProvider == OnboardingAccountProvider.apple,
          onTap: () => onAccountProviderSelected(OnboardingAccountProvider.apple),
        ),
        const SizedBox(height: 16),
        OnboardingSelectableModeCard(
          title: localization.onboardingEntryGoogleTitle,
          body: localization.onboardingEntryGoogleBody,
          selected:
              selectedMode == OnboardingEntryMode.account &&
              selectedAccountProvider == OnboardingAccountProvider.google,
          onTap: () =>
              onAccountProviderSelected(OnboardingAccountProvider.google),
        ),
        if (accountConnection != null &&
            accountConnection!.status !=
                OnboardingAccountConnectionStatus.success) ...[
          const SizedBox(height: 20),
          _EntryModeFeedbackCard(
            localization: localization,
            connection: accountConnection!,
          ),
        ],
      ],
    );
  }
}

/// 在登录尝试失败或不可用时给出内联反馈，避免页面无反馈地停在原地。
class _EntryModeFeedbackCard extends StatelessWidget {
  /// 创建 entry step 反馈卡片。
  const _EntryModeFeedbackCard({
    required this.localization,
    required this.connection,
  });

  /// 当前语言资源。
  final AppLocalizations localization;

  /// 最近一次连接结果。
  final OnboardingAccountConnectionResult connection;

  @override
  Widget build(BuildContext context) {
    return OnboardingLandscapeCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            _titleForStatus(),
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 12),
          Text(
            _bodyForStatus(),
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(height: 1.4),
          ),
        ],
      ),
    );
  }

  /// 根据登录结果选择标题，区分取消、不可用和失败三类恢复路径。
  String _titleForStatus() {
    return switch (connection.status) {
      OnboardingAccountConnectionStatus.cancelled =>
        localization.onboardingEntryAuthCancelledTitle,
      OnboardingAccountConnectionStatus.unavailable =>
        localization.onboardingEntryAuthUnavailableTitle,
      OnboardingAccountConnectionStatus.failed =>
        localization.onboardingEntryAuthFailedTitle,
      OnboardingAccountConnectionStatus.idle ||
      OnboardingAccountConnectionStatus.success =>
        localization.onboardingEntryAuthFailedTitle,
    };
  }

  /// 根据登录结果选择正文，明确用户可重试或改走本地优先路径。
  String _bodyForStatus() {
    return switch (connection.status) {
      OnboardingAccountConnectionStatus.cancelled =>
        localization.onboardingEntryAuthCancelledBody,
      OnboardingAccountConnectionStatus.unavailable =>
        localization.onboardingEntryAuthUnavailableBody,
      OnboardingAccountConnectionStatus.failed =>
        localization.onboardingEntryAuthFailedBody,
      OnboardingAccountConnectionStatus.idle ||
      OnboardingAccountConnectionStatus.success =>
        localization.onboardingEntryAuthFailedBody,
    };
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

/// 承载小组件价值说明与平台降级文案，保证第 6 步不再缺失。
class _WidgetGuideStep extends StatelessWidget {
  /// 创建小组件引导页。
  const _WidgetGuideStep({
    required this.localization,
    required this.widgetGuideAsync,
  });

  /// 当前语言资源。
  final AppLocalizations localization;

  /// 当前平台的小组件引导快照。
  final AsyncValue<OnboardingWidgetGuide> widgetGuideAsync;

  @override
  Widget build(BuildContext context) {
    return OnboardingLandscapeCard(
      child: widgetGuideAsync.when(
        data: (guide) => Column(
          children: [
            OnboardingBenefitRow(
              icon: Icons.widgets_outlined,
              title: _titleForGuide(localization, guide),
              body: _bodyForGuide(localization, guide),
            ),
            const Divider(height: 28),
            OnboardingBenefitRow(
              icon: Icons.bolt_outlined,
              title: localization.onboardingWidgetGuideBaseTitle,
              body: localization.onboardingWidgetGuideBaseBody,
            ),
          ],
        ),
        loading: () => const Padding(
          padding: EdgeInsets.symmetric(vertical: 32),
          child: Center(child: CircularProgressIndicator()),
        ),
        error: (error, stackTrace) => Column(
          children: [
            OnboardingBenefitRow(
              icon: Icons.widgets_outlined,
              title: localization.onboardingWidgetGuideUnavailableTitle,
              body: localization.onboardingWidgetGuideUnavailableBody,
            ),
            const Divider(height: 28),
            OnboardingBenefitRow(
              icon: Icons.bolt_outlined,
              title: localization.onboardingWidgetGuideBaseTitle,
              body: localization.onboardingWidgetGuideBaseBody,
            ),
          ],
        ),
      ),
    );
  }

  /// 根据平台快照生成稳定的小组件标题，避免页面层散落条件分支。
  String _titleForGuide(
    AppLocalizations localization,
    OnboardingWidgetGuide guide,
  ) {
    return switch (guide.support) {
      OnboardingWidgetGuideSupport.supported =>
        localization.onboardingWidgetGuideSupportedTitle,
      OnboardingWidgetGuideSupport.manualOnly =>
        localization.onboardingWidgetGuideManualTitle,
      OnboardingWidgetGuideSupport.unavailable =>
        localization.onboardingWidgetGuideUnavailableTitle,
    };
  }

  /// 根据平台快照生成说明文案，显式承接 supported / manual / unavailable 三条降级路径。
  String _bodyForGuide(
    AppLocalizations localization,
    OnboardingWidgetGuide guide,
  ) {
    return switch (guide.support) {
      OnboardingWidgetGuideSupport.supported =>
        localization.onboardingWidgetGuideSupportedBody,
      OnboardingWidgetGuideSupport.manualOnly =>
        localization.onboardingWidgetGuideManualBody,
      OnboardingWidgetGuideSupport.unavailable =>
        localization.onboardingWidgetGuideUnavailableBody,
    };
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
            value: _entrySummaryValue(localization, draft),
          ),
          const SizedBox(height: 16),
          _SummaryRow(
            label: localization.onboardingCompletionReminderLabel,
            value: draft.reminderStrategy == OnboardingReminderStrategy.none
                ? localization.onboardingReminderNoneTitle
                : localization.onboardingReminderGentleTitle,
          ),
          const SizedBox(height: 16),
          _SummaryRow(
            label: localization.onboardingCompletionHealthLabel,
            value: _healthPermissionValue(localization, draft.permissionStatus),
          ),
        ],
      ),
    );
  }

  /// 把权限结果翻译成完成页摘要，确保用户知道是否已经授权或走了降级路径。
  String _healthPermissionValue(
    AppLocalizations localization,
    OnboardingHealthPermissionStatus permissionStatus,
  ) {
    return switch (permissionStatus) {
      OnboardingHealthPermissionStatus.granted =>
        localization.onboardingPermissionStatusGranted,
      OnboardingHealthPermissionStatus.denied ||
      OnboardingHealthPermissionStatus.notRequested =>
        localization.onboardingPermissionStatusDeferred,
      OnboardingHealthPermissionStatus.unavailable =>
        localization.onboardingPermissionStatusUnavailable,
    };
  }

  /// 把进入方式翻译成完成页摘要，优先展示真实账号提供方而不是泛化的同步文案。
  String _entrySummaryValue(
    AppLocalizations localization,
    OnboardingDraft draft,
  ) {
    if (draft.entryMode == OnboardingEntryMode.localFirst) {
      return localization.onboardingEntryLocalTitle;
    }

    return switch (draft.accountConnection?.provider) {
      OnboardingAccountProvider.apple => localization.onboardingEntryAppleTitle,
      OnboardingAccountProvider.google =>
        localization.onboardingEntryGoogleTitle,
      null => localization.onboardingEntryLocalTitle,
    };
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
