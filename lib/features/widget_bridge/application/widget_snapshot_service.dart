import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:rhythm/core/time/time_context_provider.dart';
import 'package:rhythm/features/goal_schedule/application/goal_schedule_providers.dart';
import 'package:rhythm/features/goal_schedule/domain/goal_schedule_settings.dart';
import 'package:rhythm/features/sleep_records/application/effective_sleep_record_provider.dart';
import 'package:rhythm/features/sleep_records/application/sleep_record_providers.dart';
import 'package:rhythm/features/sleep_records/domain/effective_sleep_record.dart';
import 'package:rhythm/features/sleep_records/domain/health_platform_state.dart';

import '../domain/widget_snapshot.dart';

part 'widget_snapshot_service.g.dart';

/// 组装小组件快照的领域服务，只负责最小字段裁剪与隐私边界控制。
class WidgetSnapshotService {
  /// 创建小组件快照服务。
  const WidgetSnapshotService();

  /// 构建当前小组件快照，统一收口目标、权限与昨晚状态派生逻辑。
  WidgetSnapshot buildSnapshot({
    required GoalScheduleSettings? goalSettings,
    required List<EffectiveSleepRecord> records,
    required HealthPlatformState healthPlatformState,
    required DateTime now,
    required Uri entryUri,
  }) {
    if (goalSettings == null) {
      return WidgetSnapshot.goalMissing(entryUri: entryUri);
    }

    final targetBedtimeLabel = _formatClock(goalSettings.targetBedtimeMinutes);
    final minutesToTarget = _calculateMinutesToTarget(
      goalSettings.targetBedtimeMinutes,
      now,
    );
    final requiresPermissionAction =
        !healthPlatformState.canReadData &&
        (healthPlatformState.canRequestAccess ||
            healthPlatformState.canInstallProvider);

    if (requiresPermissionAction) {
      return WidgetSnapshot.permissionRequired(
        targetBedtimeLabel: targetBedtimeLabel,
        minutesToTarget: minutesToTarget,
        entryUri: entryUri,
      );
    }

    if (records.isEmpty) {
      return WidgetSnapshot.noData(
        targetBedtimeLabel: targetBedtimeLabel,
        minutesToTarget: minutesToTarget,
        entryUri: entryUri,
      );
    }

    return WidgetSnapshot.ready(
      targetBedtimeLabel: targetBedtimeLabel,
      minutesToTarget: minutesToTarget,
      lastNightStatusLabel: _buildLastNightStatusLabel(
        settings: goalSettings,
        record: _latestRecord(records),
      ),
      entryUri: entryUri,
    );
  }

  /// 生成默认写入小组件的睡前模式入口，保持插件参数不泄漏到页面层。
  Uri bedtimeEntryUri() {
    return Uri.parse('rhythm://bedtime?source=widget_bedtime_shortcut');
  }

  EffectiveSleepRecord _latestRecord(List<EffectiveSleepRecord> records) {
    return records.reduce((left, right) {
      return left.recordDate.isAfter(right.recordDate) ? left : right;
    });
  }

  String _buildLastNightStatusLabel({
    required GoalScheduleSettings settings,
    required EffectiveSleepRecord record,
  }) {
    final targetBedtime = DateTime.utc(
      record.recordDate.year,
      record.recordDate.month,
      record.recordDate.day,
      settings.targetBedtimeMinutes ~/ 60,
      settings.targetBedtimeMinutes % 60,
    );
    final offset = record.fellAsleepAt.difference(targetBedtime).inMinutes;

    if (offset > 0) {
      return '昨晚晚 $offset 分钟';
    }
    if (offset < 0) {
      return '昨晚早 ${offset.abs()} 分钟';
    }
    return '昨晚准点';
  }

  int _calculateMinutesToTarget(int targetBedtimeMinutes, DateTime now) {
    final target = now.isUtc
        ? DateTime.utc(
            now.year,
            now.month,
            now.day,
            targetBedtimeMinutes ~/ 60,
            targetBedtimeMinutes % 60,
          )
        : DateTime(
            now.year,
            now.month,
            now.day,
            targetBedtimeMinutes ~/ 60,
            targetBedtimeMinutes % 60,
          );
    return target.difference(now).inMinutes;
  }

  String _formatClock(int totalMinutes) {
    final hour = (totalMinutes ~/ 60).toString().padLeft(2, '0');
    final minute = (totalMinutes % 60).toString().padLeft(2, '0');
    return '$hour:$minute';
  }
}

/// 提供小组件快照服务，避免显示层直接关心实例装配。
@riverpod
WidgetSnapshotService widgetSnapshotService(Ref ref) {
  return const WidgetSnapshotService();
}

/// 聚合当前目标、权限与有效记录，向小组件设置页输出可展示快照。
@riverpod
Future<WidgetSnapshot> widgetThemeSnapshot(Ref ref) async {
  final service = ref.watch(widgetSnapshotServiceProvider);
  final goalSettings = await ref.watch(savedGoalScheduleSettingsProvider.future);
  final records = await ref.watch(recentEffectiveSleepRecordsProvider.future);
  final healthPlatformState = await ref.watch(healthPlatformStateProvider.future);
  final now = ref.watch(timeContextProvider).now;

  return service.buildSnapshot(
    goalSettings: goalSettings,
    records: records,
    healthPlatformState: healthPlatformState,
    now: now,
    entryUri: service.bedtimeEntryUri(),
  );
}
