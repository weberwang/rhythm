import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rhythm/l10n/app_localizations.dart';

import '../../application/providers/bedtime_session_controller.dart';
import '../../domain/entities/bedtime_session_draft.dart';
import '../widgets/bedtime_page_sections.dart';
import '../widgets/bedtime_page_style.dart';

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
      backgroundColor: BedtimePageStyle.pageBackground,
      appBar: AppBar(
        toolbarHeight: 8,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      body: Stack(
        children: [
          const BedtimeDecorativeBackground(),
          SafeArea(
            child: sessionAsync.when(
              data: (draft) => _BedtimeScrollContent(draft: draft),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (_, _) =>
                  _BedtimeErrorState(body: localization.bedtimeBody),
            ),
          ),
        ],
      ),
      bottomNavigationBar: sessionAsync.maybeWhen(
        data: (draft) => SafeArea(
          top: false,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 22),
            child: FilledButton(
              key: const Key('bedtime-primary-action'),
              onPressed:
                  draft.currentState == BedtimeSessionState.sessionCompleted
                  ? null
                  : () => ref
                        .read(bedtimeSessionControllerProvider.notifier)
                        .completePrimaryAction(),
              style: FilledButton.styleFrom(
                minimumSize: const Size.fromHeight(58),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(22),
                ),
              ),
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

/// 页面滚动主体只负责按冻结信息层级拼装区块，不处理业务推导。
class _BedtimeScrollContent extends StatelessWidget {
  /// 创建滚动主体。
  const _BedtimeScrollContent({required this.draft});

  /// 当前会话草稿。
  final BedtimeSessionDraft draft;

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context);
    final reminderEnabled = draft.reminderState == BedtimeReminderState.enabled;
    final compactLayout = MediaQuery.sizeOf(context).height < 980;

    return SingleChildScrollView(
      key: const Key('bedtime-scroll-view'),
      padding: EdgeInsets.fromLTRB(20, compactLayout ? 8 : 12, 20, 96),
      child: Column(
        children: [
          BedtimeHeroCard(
            title: localization.bedtimeTitle,
            subtitle: _heroSubtitle(localization, draft),
            countdownLabel: _countdownLabel(localization, draft),
            countdownValue: _countdownValue(localization, draft),
            caption: _supportingText(localization, draft),
            progress: _countdownProgress(draft),
            completed:
                draft.currentState == BedtimeSessionState.sessionCompleted,
            compact: compactLayout,
          ),
          SizedBox(height: compactLayout ? 14 : 22),
          BedtimeTargetCard(
            bedtimeLabel: draft.targetBedtimeLabel,
            wakeTimeLabel: draft.wakeTimeLabel,
            targetLabel: localization.bedtimeTargetBedtimeLabel,
            wakeLabel: localization.bedtimeTargetWakeLabel,
            compact: compactLayout,
          ),
          SizedBox(height: compactLayout ? 14 : 22),
          if (draft.isSessionRestored || !reminderEnabled) ...[
            if (draft.isSessionRestored) ...[
              BedtimeInfoBanner(
                bannerKey: const Key('bedtime-restored-banner'),
                icon: Icons.history_toggle_off_rounded,
                body: localization.bedtimeRestoredSessionBody,
                tint: const Color(0xFFE9F4F1),
                foreground: BedtimePageStyle.accent,
              ),
              SizedBox(height: compactLayout ? 10 : 14),
            ],
            BedtimeInfoBanner(
              bannerKey: const Key('bedtime-reminder-chip'),
              icon: reminderEnabled
                  ? Icons.notifications_active_outlined
                  : Icons.notifications_off_outlined,
              body: reminderEnabled
                  ? localization.bedtimeReminderEnabledBody(
                      draft.targetBedtimeLabel,
                    )
                  : localization.bedtimeReminderDisabledBody,
              tint: reminderEnabled
                  ? const Color(0xFFF0FAFA)
                  : const Color(0xFFF4F7F8),
              foreground: reminderEnabled
                  ? BedtimePageStyle.accent
                  : BedtimePageStyle.body,
            ),
            SizedBox(height: compactLayout ? 12 : 18),
          ],
          BedtimeChoiceGrid(
            sectionTitle: localization.bedtimeChoiceSectionTitle,
            selectedChoice: draft.selectedChoice,
            onSelect: (choice) => _selectChoice(context, choice),
            readyTitle: localization.bedtimeChoiceReadyTitle,
            windDownTitle: localization.bedtimeChoiceWindDownTitle,
            delayTitle: localization.bedtimeChoiceDelayTitle,
            compact: compactLayout,
          ),
          SizedBox(height: compactLayout ? 16 : 22),
          BedtimeActionCard(
            sectionTitle: localization.bedtimeActionSectionTitle,
            title: _actionTitle(localization, draft.actionKind),
            body: _actionBody(localization, draft.actionKind),
            icon: _actionIcon(draft.actionKind),
            accentColor: _actionAccent(draft.actionKind),
            completed:
                draft.currentState == BedtimeSessionState.sessionCompleted,
            compact: compactLayout,
          ),
          if (!draft.isSessionRestored && reminderEnabled) ...[
            SizedBox(height: compactLayout ? 12 : 16),
            BedtimeInfoBanner(
              bannerKey: const Key('bedtime-reminder-chip'),
              icon: Icons.notifications_active_outlined,
              body: localization.bedtimeReminderEnabledBody(
                draft.targetBedtimeLabel,
              ),
              tint: const Color(0xFFF0FAFA),
              foreground: BedtimePageStyle.accent,
            ),
          ],
        ],
      ),
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

/// 错误态维持单任务页面的克制反馈，不回退到实现占位文案。
class _BedtimeErrorState extends StatelessWidget {
  /// 创建错误态。
  const _BedtimeErrorState({required this.body});

  /// 说明文案。
  final String body;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 28),
        child: Text(
          body,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: BedtimePageStyle.body,
            height: 1.5,
          ),
        ),
      ),
    );
  }
}

/// 计算 hero 顶部的短副标题，避免让正文承担页面结构锚点。
String _heroSubtitle(AppLocalizations localization, BedtimeSessionDraft draft) {
  return switch (draft.currentState) {
    BedtimeSessionState.beforeTarget => localization.bedtimeBeforeTargetBody(
      draft.targetBedtimeLabel,
    ),
    BedtimeSessionState.likelyDelay => localization.bedtimeAfterTargetHeadline(
      draft.minutesToTarget.abs(),
    ),
    BedtimeSessionState.sessionCompleted => localization.bedtimeCompletedBody(
      draft.wakeTimeLabel,
    ),
  };
}

/// 倒计时环上方短标签只表达当下状态，不重复大段说明。
String _countdownLabel(
  AppLocalizations localization,
  BedtimeSessionDraft draft,
) {
  return switch (draft.currentState) {
    BedtimeSessionState.beforeTarget => localization.bedtimeTargetBedtimeLabel,
    BedtimeSessionState.likelyDelay => localization.bedtimeChoiceDelayTitle,
    BedtimeSessionState.sessionCompleted =>
      localization.bedtimePrimaryActionCompleted,
  };
}

/// 将分钟差映射成固定宽度时间，保证首屏主数值稳定对齐。
String _countdownValue(
  AppLocalizations localization,
  BedtimeSessionDraft draft,
) {
  if (draft.currentState == BedtimeSessionState.sessionCompleted) {
    return localization.bedtimeCountdownCompletedValue;
  }

  final minutes = draft.minutesToTarget.abs();
  final hours = minutes ~/ 60;
  final remainingMinutes = minutes % 60;
  final sign = draft.currentState == BedtimeSessionState.likelyDelay ? '+' : '';
  return '$sign${hours.toString().padLeft(2, '0')}:${remainingMinutes.toString().padLeft(2, '0')}';
}

/// 用一个受控比例近似冻结稿圆环，不把业务状态直接暴露成复杂进度规则。
double _countdownProgress(BedtimeSessionDraft draft) {
  return switch (draft.currentState) {
    BedtimeSessionState.sessionCompleted => 1,
    BedtimeSessionState.beforeTarget => (draft.minutesToTarget / 180).clamp(
      0.22,
      0.92,
    ),
    BedtimeSessionState.likelyDelay =>
      ((draft.minutesToTarget.abs() + 45) / 180).clamp(0.38, 0.95),
  };
}

/// 睡前页补充说明保持单段，避免页面再膨胀成说明列表。
String _supportingText(
  AppLocalizations localization,
  BedtimeSessionDraft draft,
) {
  return switch (draft.currentState) {
    BedtimeSessionState.sessionCompleted =>
      localization.bedtimeCompletedHeadline,
    BedtimeSessionState.likelyDelay => localization.bedtimeDelayBody(
      draft.wakeTimeLabel,
    ),
    BedtimeSessionState.beforeTarget =>
      localization.bedtimeBeforeTargetHeadline(draft.minutesToTarget),
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

/// 不同行动类型映射成稳定图标，避免动作卡每次都重新发明视觉语言。
IconData _actionIcon(BedtimeActionKind actionKind) {
  return switch (actionKind) {
    BedtimeActionKind.startWindDown => Icons.self_improvement_rounded,
    BedtimeActionKind.putPhoneAway => Icons.phone_iphone_rounded,
    BedtimeActionKind.protectWakeUp => Icons.alarm_rounded,
    BedtimeActionKind.completed => Icons.check_circle_rounded,
  };
}

/// 动作卡强调色随动作语义切换，但仍维持同一视觉系统。
Color _actionAccent(BedtimeActionKind actionKind) {
  return switch (actionKind) {
    BedtimeActionKind.startWindDown => BedtimePageStyle.accent,
    BedtimeActionKind.putPhoneAway => const Color(0xFFFF8C72),
    BedtimeActionKind.protectWakeUp => const Color(0xFF5E7F92),
    BedtimeActionKind.completed => BedtimePageStyle.accent,
  };
}
