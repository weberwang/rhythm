import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rhythm/features/app_shell/application/providers/current_entry_intent_provider.dart';
import 'package:rhythm/features/app_shell/domain/entities/entry_intent.dart';
import 'package:rhythm/features/bedtime/application/providers/bedtime_session_repository_provider.dart';
import 'package:rhythm/features/bedtime/application/providers/bedtime_session_controller.dart';
import 'package:rhythm/features/bedtime/domain/entities/bedtime_session_draft.dart';
import 'package:rhythm/features/bedtime/domain/entities/bedtime_session_record.dart';
import 'package:rhythm/features/bedtime/domain/repositories/bedtime_session_repository.dart';
import 'package:rhythm/features/sleep_data_core/application/providers/goal_schedule_repository_provider.dart';
import 'package:rhythm/features/sleep_data_core/application/providers/reminder_preference_repository_provider.dart';
import 'package:rhythm/features/sleep_data_core/domain/entities/goal_schedule.dart';
import 'package:rhythm/features/sleep_data_core/domain/entities/reminder_preference.dart';
import 'package:rhythm/features/sleep_data_core/domain/repositories/goal_schedule_repository.dart';
import 'package:rhythm/features/sleep_data_core/domain/repositories/reminder_preference_repository.dart';

/// 用内存作息仓储稳定 bedtime 倒计时输入，避免测试依赖真实本地库。
class _FakeGoalScheduleRepository implements GoalScheduleRepository {
  _FakeGoalScheduleRepository(this._schedule);

  GoalSchedule? _schedule;

  @override
  Future<GoalSchedule?> readActiveSchedule() async => _schedule;

  @override
  Future<void> saveActiveSchedule(GoalSchedule schedule) async {
    _schedule = schedule;
  }
}

/// 用内存 session 仓储验证 bedtime 会把草稿和完成态写回，而不是只停在页面状态。
class _FakeBedtimeSessionRepository implements BedtimeSessionRepository {
  BedtimeSessionRecord? stored;

  @override
  Future<BedtimeSessionRecord?> readSessionForDate(DateTime sessionDate) async {
    if (stored == null) {
      return null;
    }
    final normalized = DateTime(
      sessionDate.year,
      sessionDate.month,
      sessionDate.day,
    );
    if (stored!.sessionDate != normalized) {
      return null;
    }
    return stored;
  }

  @override
  Future<void> saveSession(BedtimeSessionRecord record) async {
    stored = record;
  }
}

/// 用内存提醒偏好仓储锁定 bedtime 对“提醒已开/未开”的读取结果。
class _FakeReminderPreferenceRepository
    implements ReminderPreferenceRepository {
  _FakeReminderPreferenceRepository(this.value);

  ReminderPreference? value;

  @override
  Future<ReminderPreference?> readReminderPreference() async => value;

  @override
  Future<void> saveReminderPreference(ReminderPreference preference) async {
    value = preference;
  }
}

/// 验证 bedtime session 控制器会根据状态选择切换单一行动建议，而不是退回占位页。
void main() {
  test(
    'bedtime session controller prioritizes delay recovery action',
    () async {
      final sessionRepository = _FakeBedtimeSessionRepository();
      final container = ProviderContainer(
        overrides: [
          goalScheduleRepositoryProvider.overrideWithValue(
            _FakeGoalScheduleRepository(
              GoalSchedule(
                id: 'fixture',
                bedtimeMinutes: 23 * 60,
                wakeTimeMinutes: 7 * 60,
                createdAt: DateTime(2026, 6, 6),
              ),
            ),
          ),
          bedtimeSessionRepositoryProvider.overrideWithValue(sessionRepository),
          reminderPreferenceRepositoryProvider.overrideWithValue(
            _FakeReminderPreferenceRepository(ReminderPreference.gentle),
          ),
          bedtimeNowProvider.overrideWithValue(DateTime(2026, 6, 6, 23, 35)),
        ],
      );
      addTearDown(container.dispose);

      container
          .read(currentEntryIntentProvider.notifier)
          .setIntent(const EntryIntent.notification(target: 'bedtime'));

      final initial = await container.read(
        bedtimeSessionControllerProvider.future,
      );
      expect(initial.currentState, BedtimeSessionState.likelyDelay);
      expect(initial.selectedChoice, isNull);

      await container
          .read(bedtimeSessionControllerProvider.notifier)
          .selectChoice(BedtimeStatusChoice.likelyDelay);

      final updated = container
          .read(bedtimeSessionControllerProvider)
          .requireValue;
      expect(updated.selectedChoice, BedtimeStatusChoice.likelyDelay);
      expect(updated.actionKind, BedtimeActionKind.protectWakeUp);
      expect(updated.entrySource, BedtimeEntrySource.notification);
      expect(updated.reminderState, BedtimeReminderState.enabled);
      expect(sessionRepository.stored, isNotNull);
      expect(
        sessionRepository.stored!.selectedChoice,
        BedtimeStatusChoice.likelyDelay,
      );
      expect(sessionRepository.stored!.isCompleted, isFalse);
    },
  );

  test(
    'bedtime session controller restores stored draft and writes completion',
    () async {
      final sessionRepository = _FakeBedtimeSessionRepository()
        ..stored = BedtimeSessionRecord(
          sessionDate: DateTime(2026, 6, 6),
          selectedChoice: BedtimeStatusChoice.needWindDown,
          entrySource: BedtimeEntrySource.homeWidget,
          isCompleted: false,
          updatedAt: DateTime(2026, 6, 6, 22, 10),
        );
      final container = ProviderContainer(
        overrides: [
          goalScheduleRepositoryProvider.overrideWithValue(
            _FakeGoalScheduleRepository(
              GoalSchedule(
                id: 'fixture',
                bedtimeMinutes: 23 * 60,
                wakeTimeMinutes: 7 * 60,
                createdAt: DateTime(2026, 6, 6),
              ),
            ),
          ),
          bedtimeSessionRepositoryProvider.overrideWithValue(sessionRepository),
          reminderPreferenceRepositoryProvider.overrideWithValue(
            _FakeReminderPreferenceRepository(ReminderPreference.disabled),
          ),
          bedtimeNowProvider.overrideWithValue(DateTime(2026, 6, 6, 22, 20)),
        ],
      );
      addTearDown(container.dispose);

      final restored = await container.read(
        bedtimeSessionControllerProvider.future,
      );
      expect(restored.selectedChoice, BedtimeStatusChoice.needWindDown);
      expect(restored.entrySource, BedtimeEntrySource.homeWidget);
      expect(restored.reminderState, BedtimeReminderState.disabled);
      expect(restored.isSessionRestored, isTrue);

      await container
          .read(bedtimeSessionControllerProvider.notifier)
          .completePrimaryAction();

      final completed = container
          .read(bedtimeSessionControllerProvider)
          .requireValue;
      expect(completed.currentState, BedtimeSessionState.sessionCompleted);
      expect(completed.isSessionRestored, isFalse);
      expect(sessionRepository.stored, isNotNull);
      expect(sessionRepository.stored!.isCompleted, isTrue);
    },
  );
}
