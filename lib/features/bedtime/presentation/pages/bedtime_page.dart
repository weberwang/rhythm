import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rhythm/l10n/app_localizations.dart';

import '../../application/providers/bedtime_session_controller.dart';
import '../../domain/entities/bedtime_session_draft.dart';

/// 睡前页负责承接“今晚判断 -> 选择 -> 执行”的单任务焦点。
class BedtimePage extends HookConsumerWidget {
  /// 创建睡前页。
  const BedtimePage({super.key});

  /// 睡前页路由路径。
  static const String routePath = '/bedtime';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localization = AppLocalizations.of(context);
    final sessionAsync = ref.watch(bedtimeSessionControllerProvider);

    return Scaffold(
      appBar: AppBar(title: Text(localization.bedtimeTitle)),
      body: SafeArea(
        child: sessionAsync.when(
          data: (draft) => _BedtimeContent(draft: draft),
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (_, _) => Center(child: Text(localization.bedtimeBody)),
        ),
      ),
      bottomNavigationBar: sessionAsync.maybeWhen(
        data: (draft) => SafeArea(
          top: false,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
            child: FilledButton(
              onPressed:
                  draft.currentState == BedtimeSessionState.sessionCompleted
                  ? null
                  : () => ref
                        .read(bedtimeSessionControllerProvider.notifier)
                        .completePrimaryAction(),
              child: Text(
                draft.currentState == BedtimeSessionState.sessionCompleted
                    ? localization.bedtimePrimaryActionCompleted
                    : localization.bedtimePrimaryActionLabel,
              ),
            ),
          ),
        ),
        orElse: () => null,
      ),
    );
  }
}

/// 睡前页主内容严格围绕单一决策路径，不扩展成复杂追踪仪表盘。
class _BedtimeContent extends StatelessWidget {
  /// 创建主内容。
  const _BedtimeContent({required this.draft});

  /// 当前会话草稿。
  final BedtimeSessionDraft draft;

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context);
    final theme = Theme.of(context);

    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 8),
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(28),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                theme.colorScheme.primary.withValues(alpha: 0.12),
                theme.colorScheme.surface,
              ],
            ),
            border: Border.all(color: theme.colorScheme.outlineVariant),
          ),
          padding: const EdgeInsets.fromLTRB(22, 22, 22, 22),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _entrySourceLabel(localization, draft.entrySource),
                style: theme.textTheme.labelLarge?.copyWith(
                  color: theme.colorScheme.primary,
                ),
              ),
              const SizedBox(height: 14),
              Text(
                _headlineText(localization, draft),
                style: theme.textTheme.headlineMedium,
              ),
              const SizedBox(height: 10),
              Text(
                _supportingText(localization, draft),
                style: theme.textTheme.bodyLarge,
              ),
              const SizedBox(height: 18),
              Row(
                children: [
                  Expanded(
                    child: _InfoTile(
                      label: localization.bedtimeTargetBedtimeLabel,
                      value: draft.targetBedtimeLabel,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _InfoTile(
                      label: localization.bedtimeTargetWakeLabel,
                      value: draft.wakeTimeLabel,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        Text(
          localization.bedtimeChoiceSectionTitle,
          style: theme.textTheme.titleLarge,
        ),
        const SizedBox(height: 12),
        _ChoiceCard(
          label: localization.bedtimeChoiceReadyTitle,
          body: localization.bedtimeChoiceReadyBody,
          selected: draft.selectedChoice == BedtimeStatusChoice.readyToSleep,
          onTap: () => _selectChoice(context, BedtimeStatusChoice.readyToSleep),
        ),
        const SizedBox(height: 12),
        _ChoiceCard(
          label: localization.bedtimeChoiceWindDownTitle,
          body: localization.bedtimeChoiceWindDownBody,
          selected: draft.selectedChoice == BedtimeStatusChoice.needWindDown,
          onTap: () => _selectChoice(context, BedtimeStatusChoice.needWindDown),
        ),
        const SizedBox(height: 12),
        _ChoiceCard(
          label: localization.bedtimeChoiceDelayTitle,
          body: localization.bedtimeChoiceDelayBody,
          selected: draft.selectedChoice == BedtimeStatusChoice.likelyDelay,
          onTap: () => _selectChoice(context, BedtimeStatusChoice.likelyDelay),
        ),
        const SizedBox(height: 20),
        Text(
          localization.bedtimeActionSectionTitle,
          style: theme.textTheme.titleLarge,
        ),
        const SizedBox(height: 12),
        Container(
          decoration: BoxDecoration(
            color: theme.colorScheme.surfaceContainerLowest,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: theme.colorScheme.outlineVariant),
          ),
          padding: const EdgeInsets.fromLTRB(18, 18, 18, 18),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                backgroundColor: theme.colorScheme.primary.withValues(
                  alpha: 0.12,
                ),
                foregroundColor: theme.colorScheme.primary,
                child: Icon(
                  draft.currentState == BedtimeSessionState.sessionCompleted
                      ? Icons.check_rounded
                      : Icons.nightlight_round,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _actionTitle(localization, draft.actionKind),
                      style: theme.textTheme.titleMedium,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _actionBody(localization, draft.actionKind),
                      style: theme.textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        if (draft.reminderEnabled)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            decoration: BoxDecoration(
              color: theme.colorScheme.primary.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(18),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.notifications_active_outlined,
                  size: 18,
                  color: theme.colorScheme.primary,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    localization.bedtimeReminderEnabledBody(
                      draft.targetBedtimeLabel,
                    ),
                    style: theme.textTheme.bodyMedium,
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }

  /// 用页面层回调承接状态选择，保持交互入口简洁。
  void _selectChoice(BuildContext context, BedtimeStatusChoice choice) {
    final container = ProviderScope.containerOf(context, listen: false);
    container
        .read(bedtimeSessionControllerProvider.notifier)
        .selectChoice(choice);
  }
}

/// 把入口来源映射成显示层文案，避免应用层携带最终展示字符串。
String _entrySourceLabel(
  AppLocalizations localization,
  BedtimeEntrySource source,
) {
  return switch (source) {
    BedtimeEntrySource.appOpen => localization.bedtimeEntryFromToday,
    BedtimeEntrySource.notification =>
      localization.bedtimeEntryFromNotification,
    BedtimeEntrySource.homeWidget => localization.bedtimeEntryFromWidget,
  };
}

/// 睡前页 headline 只负责回答“距离目标还有多久”。
String _headlineText(AppLocalizations localization, BedtimeSessionDraft draft) {
  return switch (draft.currentState) {
    BedtimeSessionState.sessionCompleted =>
      localization.bedtimeCompletedHeadline,
    BedtimeSessionState.likelyDelay => localization.bedtimeAfterTargetHeadline(
      draft.minutesToTarget.abs(),
    ),
    BedtimeSessionState.beforeTarget =>
      localization.bedtimeBeforeTargetHeadline(draft.minutesToTarget),
  };
}

/// 睡前页补充说明保持单段，避免页面再膨胀成说明列表。
String _supportingText(
  AppLocalizations localization,
  BedtimeSessionDraft draft,
) {
  return switch (draft.currentState) {
    BedtimeSessionState.sessionCompleted => localization.bedtimeCompletedBody(
      draft.wakeTimeLabel,
    ),
    BedtimeSessionState.likelyDelay => localization.bedtimeDelayBody(
      draft.wakeTimeLabel,
    ),
    BedtimeSessionState.beforeTarget => localization.bedtimeBeforeTargetBody(
      draft.targetBedtimeLabel,
    ),
  };
}

/// 单一动作标题保持在显示层解析，满足国际化和分层要求。
String _actionTitle(
  AppLocalizations localization,
  BedtimeActionKind actionKind,
) {
  return switch (actionKind) {
    BedtimeActionKind.startWindDown =>
      localization.bedtimeActionStartWindDownTitle,
    BedtimeActionKind.putPhoneAway =>
      localization.bedtimeActionPutPhoneAwayTitle,
    BedtimeActionKind.protectWakeUp =>
      localization.bedtimeActionProtectWakeTitle,
    BedtimeActionKind.completed => localization.bedtimeActionCompletedTitle,
  };
}

/// 单一动作正文保持和标题同源，避免应用层临时拼文案。
String _actionBody(
  AppLocalizations localization,
  BedtimeActionKind actionKind,
) {
  return switch (actionKind) {
    BedtimeActionKind.startWindDown =>
      localization.bedtimeActionStartWindDownBody,
    BedtimeActionKind.putPhoneAway =>
      localization.bedtimeActionPutPhoneAwayBody,
    BedtimeActionKind.protectWakeUp =>
      localization.bedtimeActionProtectWakeBody,
    BedtimeActionKind.completed => localization.bedtimeActionCompletedBody,
  };
}

/// 两个目标时间共用的紧凑信息卡，避免主卡再塞入更多说明结构。
class _InfoTile extends StatelessWidget {
  /// 创建信息卡。
  const _InfoTile({required this.label, required this.value});

  /// 标题。
  final String label;

  /// 值。
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.fromLTRB(14, 14, 14, 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: theme.textTheme.labelLarge),
          const SizedBox(height: 6),
          Text(value, style: theme.textTheme.titleLarge),
        ],
      ),
    );
  }
}

/// 统一三态选择卡片，确保睡前页不会长成复杂多步骤表单。
class _ChoiceCard extends StatelessWidget {
  /// 创建选择卡。
  const _ChoiceCard({
    required this.label,
    required this.body,
    required this.selected,
    required this.onTap,
  });

  /// 选项标题。
  final String label;

  /// 选项说明。
  final String body;

  /// 是否已选中。
  final bool selected;

  /// 点击动作。
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      borderRadius: BorderRadius.circular(24),
      onTap: onTap,
      child: Ink(
        decoration: BoxDecoration(
          color: selected
              ? theme.colorScheme.primary.withValues(alpha: 0.10)
              : theme.colorScheme.surfaceContainerLowest,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: selected
                ? theme.colorScheme.primary
                : theme.colorScheme.outlineVariant,
          ),
        ),
        padding: const EdgeInsets.fromLTRB(18, 18, 18, 18),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              selected
                  ? Icons.radio_button_checked_rounded
                  : Icons.radio_button_off_rounded,
              color: selected
                  ? theme.colorScheme.primary
                  : theme.colorScheme.outline,
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(label, style: theme.textTheme.titleMedium),
                  const SizedBox(height: 8),
                  Text(body, style: theme.textTheme.bodyMedium),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
