import 'dart:async';

import 'package:intl/intl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../app_shell/application/providers/current_entry_intent_provider.dart';
import '../../../app_shell/domain/entities/entry_intent.dart';
import '../../../sleep_data_core/application/providers/goal_schedule_repository_provider.dart';
import '../../../sleep_data_core/domain/entities/goal_schedule.dart';
import '../../domain/entities/bedtime_session_draft.dart';
import '../../domain/entities/bedtime_session_record.dart';
import 'bedtime_session_repository_provider.dart';

part 'bedtime_session_controller.g.dart';

/// 暴露当前时间，便于睡前页测试稳定控制倒计时。
@Riverpod(keepAlive: true)
DateTime bedtimeNow(Ref ref) {
  return DateTime.now();
}

/// 睡前会话控制器负责收敛倒计时、状态选择和单一动作建议。
@riverpod
class BedtimeSessionController extends _$BedtimeSessionController {
  /// 构建最小睡前会话草稿，先服务真实页面而不引入复杂仓储。
  @override
  FutureOr<BedtimeSessionDraft> build() async {
    final scheduleRepository = ref.watch(goalScheduleRepositoryProvider);
    final sessionRepository = ref.watch(bedtimeSessionRepositoryProvider);
    final schedule =
        await scheduleRepository.readActiveSchedule() ?? _fallbackSchedule();
    final now = ref.watch(bedtimeNowProvider);
    final entryIntent = ref.watch(currentEntryIntentProvider);
    final sessionDate = _resolveSessionDate(now: now, schedule: schedule);
    final restoredSession = await sessionRepository.readSessionForDate(sessionDate);

    return _buildDraft(
      schedule: schedule,
      now: now,
      entryIntent: entryIntent,
      selectedChoice: restoredSession?.selectedChoice,
      restoredEntrySource: restoredSession?.entrySource,
      isCompleted: restoredSession?.isCompleted ?? false,
    );
  }

  /// 记录用户的今晚判断，并立刻切换单一动作建议。
  Future<void> selectChoice(BedtimeStatusChoice choice) async {
    final currentDraft = await future;
    final now = ref.read(bedtimeNowProvider);
    final schedule = _restoreScheduleFromDraft(currentDraft);
    final sessionDate = _resolveSessionDate(now: now, schedule: schedule);
    final repository = ref.read(bedtimeSessionRepositoryProvider);

    await repository.saveSession(
      BedtimeSessionRecord(
        sessionDate: sessionDate,
        selectedChoice: choice,
        entrySource: currentDraft.entrySource,
        isCompleted: false,
        updatedAt: now,
      ),
    );

    state = AsyncData(
      _buildDraft(
        schedule: schedule,
        now: now,
        entryIntent: ref.read(currentEntryIntentProvider),
        selectedChoice: choice,
        restoredEntrySource: currentDraft.entrySource,
        isCompleted: false,
      ),
    );
  }

  /// 把当前会话切到完成态，保证页面不会回退成多按钮复杂表单。
  Future<void> completePrimaryAction() async {
    final currentDraft = await future;
    final now = ref.read(bedtimeNowProvider);
    final schedule = _restoreScheduleFromDraft(currentDraft);
    final sessionDate = _resolveSessionDate(now: now, schedule: schedule);
    final repository = ref.read(bedtimeSessionRepositoryProvider);

    await repository.saveSession(
      BedtimeSessionRecord(
        sessionDate: sessionDate,
        selectedChoice: currentDraft.selectedChoice,
        entrySource: currentDraft.entrySource,
        isCompleted: true,
        updatedAt: now,
      ),
    );

    state = AsyncData(
      _buildDraft(
        schedule: schedule,
        now: now,
        entryIntent: ref.read(currentEntryIntentProvider),
        selectedChoice: currentDraft.selectedChoice,
        restoredEntrySource: currentDraft.entrySource,
        isCompleted: true,
      ),
    );
  }
}

/// 当前没有目标作息时，睡前页仍需给出稳定锚点，避免页面断裂。
GoalSchedule _fallbackSchedule() {
  return GoalSchedule(
    id: 'fallback-bedtime',
    bedtimeMinutes: 23 * 60,
    wakeTimeMinutes: 7 * 60,
    createdAt: DateTime.now(),
  );
}

/// 把草稿中的展示值回收为最小 schedule，避免控制器重复持有平行状态。
GoalSchedule _restoreScheduleFromDraft(BedtimeSessionDraft draft) {
  return GoalSchedule(
    id: 'draft-restored',
    bedtimeMinutes: _parseTimeLabel(draft.targetBedtimeLabel),
    wakeTimeMinutes: _parseTimeLabel(draft.wakeTimeLabel),
    createdAt: DateTime.now(),
  );
}

/// 基于目标作息、当前时间和会话选择生成最小睡前页草稿。
BedtimeSessionDraft _buildDraft({
  required GoalSchedule schedule,
  required DateTime now,
  required EntryIntent entryIntent,
  required BedtimeStatusChoice? selectedChoice,
  required BedtimeEntrySource? restoredEntrySource,
  required bool isCompleted,
}) {
  final minutesToTarget = _calculateMinutesToTarget(
    now: now,
    targetMinutes: schedule.bedtimeMinutes,
  );
  final isDelay =
      minutesToTarget < -15 ||
      selectedChoice == BedtimeStatusChoice.likelyDelay;
  final currentState = isCompleted
      ? BedtimeSessionState.sessionCompleted
      : isDelay
      ? BedtimeSessionState.likelyDelay
      : BedtimeSessionState.beforeTarget;

  final actionTitle = switch (selectedChoice) {
    BedtimeStatusChoice.readyToSleep => BedtimeActionKind.startWindDown,
    BedtimeStatusChoice.needWindDown => BedtimeActionKind.putPhoneAway,
    BedtimeStatusChoice.likelyDelay => BedtimeActionKind.protectWakeUp,
    null =>
      currentState == BedtimeSessionState.likelyDelay
          ? BedtimeActionKind.protectWakeUp
          : BedtimeActionKind.startWindDown,
  };

  return BedtimeSessionDraft(
    currentState: currentState,
    targetBedtimeLabel: _formatMinutes(schedule.bedtimeMinutes),
    wakeTimeLabel: _formatMinutes(schedule.wakeTimeMinutes),
    minutesToTarget: minutesToTarget,
    entrySource: restoredEntrySource ?? _entrySource(entryIntent),
    selectedChoice: selectedChoice,
    actionKind: isCompleted ? BedtimeActionKind.completed : actionTitle,
    reminderEnabled: true,
  );
}

/// 在凌晨仍应归属昨晚会话，避免跨午夜后把未完成草稿切到新的一天。
DateTime _resolveSessionDate({
  required DateTime now,
  required GoalSchedule schedule,
}) {
  final currentMinutes = now.hour * 60 + now.minute;
  if (currentMinutes <= schedule.wakeTimeMinutes) {
    final previousDay = now.subtract(const Duration(days: 1));
    return DateTime(previousDay.year, previousDay.month, previousDay.day);
  }
  return DateTime(now.year, now.month, now.day);
}

/// 跨午夜统一计算离目标的分钟差，正值代表尚未到点，负值代表已经晚于目标。
int _calculateMinutesToTarget({
  required DateTime now,
  required int targetMinutes,
}) {
  final currentMinutes = now.hour * 60 + now.minute;
  var diff = targetMinutes - currentMinutes;
  if (diff > 12 * 60) {
    diff -= Duration.minutesPerDay;
  } else if (diff < -12 * 60) {
    diff += Duration.minutesPerDay;
  }
  return diff;
}

/// 睡前页只需要一个可读时间标签，避免显示层重复拼接时间格式。
String _formatMinutes(int totalMinutes) {
  final normalizedMinutes =
      ((totalMinutes % Duration.minutesPerDay) + Duration.minutesPerDay) %
      Duration.minutesPerDay;
  final hours = normalizedMinutes ~/ 60;
  final minutes = normalizedMinutes % 60;
  return DateFormat('h:mm a').format(DateTime(2026, 1, 1, hours, minutes));
}

/// 把已格式化的时间标签回读成分钟，服务控制器内部的最小状态回放。
int _parseTimeLabel(String label) {
  final parsed = DateFormat('h:mm a').parse(label);
  return parsed.hour * 60 + parsed.minute;
}

/// 统一把入口意图转换成睡前页顶部说明，避免页面直接解释 union 结构。
BedtimeEntrySource _entrySource(EntryIntent entryIntent) {
  return switch (entryIntent) {
    AppOpenEntryIntent() => BedtimeEntrySource.appOpen,
    NotificationEntryIntent() => BedtimeEntrySource.notification,
    HomeWidgetEntryIntent() => BedtimeEntrySource.homeWidget,
  };
}
