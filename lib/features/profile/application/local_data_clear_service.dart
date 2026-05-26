import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rhythm/app/bootstrap/launch_state_provider.dart';
import 'package:rhythm/data/local/rhythm_database.dart';
import 'package:rhythm/features/goal_schedule/data/goal_schedule_settings_repository.dart';
import 'package:rhythm/features/widget_bridge/data/home_widget_gateway.dart';
import 'package:rhythm/features/widget_bridge/domain/widget_snapshot.dart';
import 'package:shared_preferences/shared_preferences.dart';

final Uri _clearedWidgetEntryUri = Uri.parse(
  'rhythm://today?source=local_data_cleared',
);

/// 负责清空业务本地数据，统一收口数据库、目标配置和小组件快照的删除边界。
class LocalDataClearService {
  /// 创建本地数据清理服务。
  LocalDataClearService({
    required RhythmDatabase database,
    required SharedPreferences sharedPreferences,
    required HomeWidgetGateway homeWidgetGateway,
  }) : _database = database,
       _sharedPreferences = sharedPreferences,
       _homeWidgetGateway = homeWidgetGateway;

  final RhythmDatabase _database;
  final SharedPreferences _sharedPreferences;
  final HomeWidgetGateway _homeWidgetGateway;

  /// 清空所有业务本地数据，但保留语言、主题、引导状态和登录相关状态。
  Future<void> clearBusinessLocalData() async {
    await _database.transaction(() async {
      await _database.delete(_database.sleepDelayTags).go();
      await _database.delete(_database.sleepRecords).go();
    });

    await Future.wait(<Future<bool>>[
      _sharedPreferences.remove(
        SharedPreferencesGoalScheduleSettingsRepository.targetBedtimeMinutesKey,
      ),
      _sharedPreferences.remove(
        SharedPreferencesGoalScheduleSettingsRepository.targetWakeMinutesKey,
      ),
      _sharedPreferences.remove(
        SharedPreferencesGoalScheduleSettingsRepository.lateThresholdMinutesKey,
      ),
      _sharedPreferences.remove(
        SharedPreferencesGoalScheduleSettingsRepository.dayStartMinutesKey,
      ),
      _sharedPreferences.remove(
        SharedPreferencesGoalScheduleSettingsRepository.updatedAtKey,
      ),
    ]);

    // 统一覆盖成目标缺失快照并触发刷新，避免桌面小组件继续显示上一次写入的业务数据。
    await _homeWidgetGateway.saveSnapshot(
      WidgetSnapshot.goalMissing(entryUri: _clearedWidgetEntryUri),
    );
    await _homeWidgetGateway.refresh();
  }
}

/// 提供本地数据清理服务，页面层只负责触发，不直接理解底层持久化结构。
final localDataClearServiceProvider = Provider<LocalDataClearService>((ref) {
  return LocalDataClearService(
    database: ref.watch(rhythmDatabaseProvider),
    sharedPreferences: ref.watch(sharedPreferencesProvider),
    homeWidgetGateway: ref.watch(homeWidgetGatewayProvider),
  );
});
