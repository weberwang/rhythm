import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rhythm/features/goal_schedule/domain/goal_schedule_settings.dart';
import 'package:rhythm/features/sleep_records/domain/effective_sleep_record.dart';
import 'package:rhythm/features/sleep_records/domain/health_platform_state.dart';
import 'package:rhythm/features/sleep_records/domain/sleep_record_confidence.dart';
import 'package:rhythm/features/sleep_records/domain/sleep_record_source.dart';
import 'package:rhythm/features/widget_bridge/application/widget_snapshot_service.dart';
import 'package:rhythm/features/widget_bridge/domain/widget_snapshot.dart';
import 'package:rhythm/l10n/app_localizations.dart';

/// 验证小组件快照服务会按阶段九口径裁剪展示信息。
void main() {
  const settings = GoalScheduleSettings(
    targetBedtimeMinutes: 23 * 60 + 30,
    targetWakeMinutes: 7 * 60 + 30,
    lateThresholdMinutes: 30,
    dayStartMinutes: 4 * 60,
  );
  const service = WidgetSnapshotService();
  final zhL10n = lookupAppLocalizations(const Locale('zh'));
  final enL10n = lookupAppLocalizations(const Locale('en'));
  final bedtimeEntry = Uri.parse(
    'rhythm://bedtime?source=widget_bedtime_shortcut',
  );
  final todayEntry = Uri.parse('rhythm://today?source=widget_today');

  EffectiveSleepRecord buildRecord({
    required DateTime recordDate,
    required DateTime fellAsleepAt,
    bool isUserConfirmed = false,
  }) {
    return EffectiveSleepRecord(
      recordId: 'record',
      recordDate: recordDate,
      fellAsleepAt: fellAsleepAt,
      wokeUpAt: fellAsleepAt.add(const Duration(hours: 8)),
      durationMinutes: 8 * 60,
      source: SleepRecordSource.manual,
      confidence: SleepRecordConfidence.high,
      timezone: 'Asia/Shanghai',
      isUserConfirmed: isUserConfirmed,
      sourceRecordId: null,
    );
  }

  test('有目标和昨晚记录时生成完整快照', () {
    final snapshot = service.buildSnapshot(
      goalSettings: settings,
      records: <EffectiveSleepRecord>[
        buildRecord(
          recordDate: DateTime.utc(2026, 5, 24),
          fellAsleepAt: DateTime.utc(2026, 5, 24, 23, 56),
        ),
      ],
      healthPlatformState: HealthPlatformState.iosAvailable(),
      now: DateTime.utc(2026, 5, 25, 22, 38),
      entryUri: bedtimeEntry,
      l10n: zhL10n,
    );

    expect(snapshot.state, WidgetSnapshotState.ready);
    expect(snapshot.targetBedtimeLabel, '23:30');
    expect(snapshot.minutesToTarget, 52);
    expect(snapshot.lastNightStatusLabel, '昨晚晚 26 分钟');
    expect(snapshot.entryUri, bedtimeEntry);
  });

  test('无目标时返回目标缺失快照', () {
    final snapshot = service.buildSnapshot(
      goalSettings: null,
      records: const <EffectiveSleepRecord>[],
      healthPlatformState: HealthPlatformState.iosAvailable(),
      now: DateTime.utc(2026, 5, 25, 22, 38),
      entryUri: todayEntry,
      l10n: zhL10n,
    );

    expect(snapshot.state, WidgetSnapshotState.goalMissing);
    expect(snapshot.targetBedtimeLabel, isNull);
    expect(snapshot.minutesToTarget, isNull);
    expect(snapshot.lastNightStatusLabel, isNull);
  });

  test('无数据时返回无数据快照并保留今晚目标', () {
    final snapshot = service.buildSnapshot(
      goalSettings: settings,
      records: const <EffectiveSleepRecord>[],
      healthPlatformState: HealthPlatformState.iosAvailable(),
      now: DateTime.utc(2026, 5, 25, 22, 38),
      entryUri: todayEntry,
      l10n: zhL10n,
    );

    expect(snapshot.state, WidgetSnapshotState.noData);
    expect(snapshot.targetBedtimeLabel, '23:30');
    expect(snapshot.minutesToTarget, 52);
    expect(snapshot.lastNightStatusLabel, isNull);
  });

  test('未授权时优先返回权限缺失快照', () {
    final snapshot = service.buildSnapshot(
      goalSettings: settings,
      records: <EffectiveSleepRecord>[
        buildRecord(
          recordDate: DateTime.utc(2026, 5, 24),
          fellAsleepAt: DateTime.utc(2026, 5, 24, 23, 56),
        ),
      ],
      healthPlatformState: HealthPlatformState.iosPermissionRequired(),
      now: DateTime.utc(2026, 5, 25, 22, 38),
      entryUri: todayEntry,
      l10n: zhL10n,
    );

    expect(snapshot.state, WidgetSnapshotState.permissionRequired);
    expect(snapshot.targetBedtimeLabel, '23:30');
    expect(snapshot.minutesToTarget, 52);
    expect(snapshot.lastNightStatusLabel, isNull);
  });

  test('隐私过滤不输出过细睡眠数据', () {
    final snapshot = service.buildSnapshot(
      goalSettings: settings,
      records: <EffectiveSleepRecord>[
        buildRecord(
          recordDate: DateTime.utc(2026, 5, 24),
          fellAsleepAt: DateTime.utc(2026, 5, 24, 23, 20),
        ),
      ],
      healthPlatformState: HealthPlatformState.iosAvailable(),
      now: DateTime.utc(2026, 5, 25, 22, 38),
      entryUri: bedtimeEntry,
      l10n: zhL10n,
    );

    expect(snapshot.state, WidgetSnapshotState.ready);
    expect(snapshot.lastNightStatusLabel, '昨晚早 10 分钟');
    expect(snapshot.toWidgetData().keys, <String>{
      'snapshot_state',
      'target_bedtime_label',
      'minutes_to_target',
      'last_night_status_label',
      'entry_uri',
    });
    expect(
      snapshot.toWidgetData().values.any((value) => '$value'.contains('8')),
      isFalse,
    );
    expect(
      snapshot.toWidgetData().values.any(
        (value) => '$value'.contains('Asia/Shanghai'),
      ),
      isFalse,
    );
  });

  test('英文环境下昨晚状态文案使用英文', () {
    final snapshot = service.buildSnapshot(
      goalSettings: settings,
      records: <EffectiveSleepRecord>[
        buildRecord(
          recordDate: DateTime.utc(2026, 5, 24),
          fellAsleepAt: DateTime.utc(2026, 5, 24, 23, 56),
        ),
      ],
      healthPlatformState: HealthPlatformState.iosAvailable(),
      now: DateTime.utc(2026, 5, 25, 22, 38),
      entryUri: bedtimeEntry,
      l10n: enL10n,
    );

    expect(snapshot.lastNightStatusLabel, '26 minutes later last night');
  });
}
