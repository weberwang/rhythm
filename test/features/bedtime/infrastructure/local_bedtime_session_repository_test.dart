import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rhythm/core/storage/rhythm_database.dart';
import 'package:rhythm/features/bedtime/domain/entities/bedtime_session_draft.dart';
import 'package:rhythm/features/bedtime/domain/entities/bedtime_session_record.dart';
import 'package:rhythm/features/bedtime/infrastructure/repositories/local_bedtime_session_repository.dart';

/// 验证 bedtime session 仓储会真实保留草稿和完成态，而不是页面临时状态。
void main() {
  test('LocalBedtimeSessionRepository persists and restores latest session', () async {
    final database = RhythmDatabase.forTesting(NativeDatabase.memory());
    final repository = LocalBedtimeSessionRepository(database);
    addTearDown(database.close);

    final sessionDate = DateTime(2026, 6, 6);
    final draft = BedtimeSessionRecord(
      sessionDate: sessionDate,
      selectedChoice: BedtimeStatusChoice.needWindDown,
      entrySource: BedtimeEntrySource.notification,
      isCompleted: false,
      updatedAt: DateTime(2026, 6, 6, 22, 50),
    );

    expect(await repository.readSessionForDate(sessionDate), isNull);

    await repository.saveSession(draft);
    final restoredDraft = await repository.readSessionForDate(sessionDate);
    expect(restoredDraft, isNotNull);
    expect(restoredDraft!.selectedChoice, BedtimeStatusChoice.needWindDown);
    expect(restoredDraft.isCompleted, isFalse);

    await repository.saveSession(
      draft.copyWith(
        selectedChoice: BedtimeStatusChoice.readyToSleep,
        isCompleted: true,
        updatedAt: DateTime(2026, 6, 6, 23, 5),
      ),
    );
    final restoredCompleted = await repository.readSessionForDate(sessionDate);
    expect(restoredCompleted, isNotNull);
    expect(restoredCompleted!.selectedChoice, BedtimeStatusChoice.readyToSleep);
    expect(restoredCompleted.isCompleted, isTrue);
  });
}
