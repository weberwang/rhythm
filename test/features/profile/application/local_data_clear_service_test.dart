import 'package:flutter_test/flutter_test.dart';
import 'package:rhythm/data/local/rhythm_database.dart';
import 'package:rhythm/features/goal_schedule/data/goal_schedule_settings_repository.dart';
import 'package:rhythm/features/preferences/data/shared_preferences_app_preferences_repository.dart';
import 'package:rhythm/features/preferences/domain/app_locale_preference.dart';
import 'package:rhythm/features/preferences/domain/app_preferences.dart';
import 'package:rhythm/features/preferences/domain/app_theme_preference.dart';
import 'package:rhythm/features/profile/application/local_data_clear_service.dart';
import 'package:rhythm/features/sleep_records/data/drift_sleep_delay_tag_repository.dart';
import 'package:rhythm/features/sleep_records/data/drift_sleep_record_repository.dart';
import 'package:rhythm/features/sleep_records/domain/sleep_record.dart';
import 'package:rhythm/features/sleep_records/domain/sleep_record_confidence.dart';
import 'package:rhythm/features/sleep_records/domain/sleep_record_source.dart';
import 'package:rhythm/features/widget_bridge/data/home_widget_gateway.dart';
import 'package:rhythm/features/widget_bridge/domain/widget_snapshot.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// 验证清空本地数据只删除业务缓存，不误删应用偏好等非业务状态。
void main() {
  test('清空后会删除记录、标签、目标作息，并保留应用偏好', () async {
    SharedPreferences.setMockInitialValues(<String, Object>{});
    final preferences = await SharedPreferences.getInstance();
    final database = RhythmDatabase.inMemory();
    final recordRepository = DriftSleepRecordRepository(database);
    final tagRepository = DriftSleepDelayTagRepository(database);
    final widgetGateway = _FakeHomeWidgetGateway();
    final service = LocalDataClearService(
      database: database,
      sharedPreferences: preferences,
      homeWidgetGateway: widgetGateway,
    );

    addTearDown(database.close);
    addTearDown(recordRepository.close);

    final appPreferencesRepository =
        SharedPreferencesAppPreferencesRepository(preferences);
    await appPreferencesRepository.save(
      const AppPreferences(
        localePreference: AppLocalePreference.english,
        themePreference: AppThemePreference.dark,
      ),
    );
    await preferences.setInt(
      SharedPreferencesGoalScheduleSettingsRepository.targetBedtimeMinutesKey,
      23 * 60 + 30,
    );
    await preferences.setInt(
      SharedPreferencesGoalScheduleSettingsRepository.targetWakeMinutesKey,
      7 * 60 + 30,
    );
    await preferences.setInt(
      SharedPreferencesGoalScheduleSettingsRepository.lateThresholdMinutesKey,
      30,
    );
    await preferences.setInt(
      SharedPreferencesGoalScheduleSettingsRepository.dayStartMinutesKey,
      4 * 60,
    );
    await preferences.setString(
      SharedPreferencesGoalScheduleSettingsRepository.updatedAtKey,
      DateTime.utc(2026, 5, 26, 1).toIso8601String(),
    );
    await recordRepository.saveRecord(
      SleepRecord(
        id: 'record-1',
        recordDate: DateTime.utc(2026, 5, 25),
        fellAsleepAt: DateTime.utc(2026, 5, 26, 0, 30),
        wokeUpAt: DateTime.utc(2026, 5, 26, 7, 30),
        durationMinutes: 420,
        source: SleepRecordSource.manual,
        confidence: SleepRecordConfidence.high,
        timezone: 'Asia/Shanghai',
        isUserEdited: true,
        sourceRecordId: null,
        createdAt: DateTime.utc(2026, 5, 26, 7, 31),
        updatedAt: DateTime.utc(2026, 5, 26, 7, 31),
      ),
    );
    await tagRepository.saveTags(
      recordDate: DateTime.utc(2026, 5, 25),
      tags: const <String>['加班'],
    );

    await service.clearBusinessLocalData();

    expect(await recordRepository.readAllRecords(), isEmpty);
    expect(
      await tagRepository.readTags(recordDate: DateTime.utc(2026, 5, 25)),
      isEmpty,
    );
    expect(
      preferences.getInt(
        SharedPreferencesGoalScheduleSettingsRepository.targetBedtimeMinutesKey,
      ),
      isNull,
    );
    expect(
      preferences.getInt(
        SharedPreferencesGoalScheduleSettingsRepository.targetWakeMinutesKey,
      ),
      isNull,
    );
    expect(
      preferences.getInt(
        SharedPreferencesGoalScheduleSettingsRepository.lateThresholdMinutesKey,
      ),
      isNull,
    );
    expect(
      preferences.getInt(
        SharedPreferencesGoalScheduleSettingsRepository.dayStartMinutesKey,
      ),
      isNull,
    );
    expect(
      preferences.getString(
        SharedPreferencesGoalScheduleSettingsRepository.updatedAtKey,
      ),
      isNull,
    );
    expect(
      appPreferencesRepository.read(),
      const AppPreferences(
        localePreference: AppLocalePreference.english,
        themePreference: AppThemePreference.dark,
      ),
    );
    expect(widgetGateway.savedSnapshot, isNotNull);
    expect(widgetGateway.savedSnapshot!.state, WidgetSnapshotState.goalMissing);
    expect(widgetGateway.refreshed, isTrue);
  });
}

class _FakeHomeWidgetGateway implements HomeWidgetGateway {
  WidgetSnapshot? savedSnapshot;
  bool refreshed = false;

  @override
  Future<void> saveSnapshot(WidgetSnapshot snapshot) async {
    savedSnapshot = snapshot;
  }

  @override
  Future<void> refresh() async {
    refreshed = true;
  }
}
