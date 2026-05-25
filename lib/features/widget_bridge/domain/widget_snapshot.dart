import 'package:freezed_annotation/freezed_annotation.dart';

part 'widget_snapshot.freezed.dart';

/// 定义小组件快照状态，避免页面层和插件层散落裸字符串判断。
enum WidgetSnapshotState {
  /// 具备完整目标与昨晚状态，可正常渲染小组件。
  ready,

  /// 尚未设置目标作息，只能引导用户先补齐目标。
  goalMissing,

  /// 已有目标，但还没有可展示的昨晚结果。
  noData,

  /// 当前仍缺少健康数据权限，不展示昨晚状态细节。
  permissionRequired,
}

/// 承载写入小组件的最小快照，只保留阶段九允许输出的字段。
@freezed
abstract class WidgetSnapshot with _$WidgetSnapshot {
  /// 创建小组件快照实例。
  const factory WidgetSnapshot({
    required WidgetSnapshotState state,
    String? targetBedtimeLabel,
    int? minutesToTarget,
    String? lastNightStatusLabel,
    required Uri entryUri,
  }) = _WidgetSnapshot;

  const WidgetSnapshot._();

  /// 创建目标缺失快照，避免在未完成基础设置前输出伪造数据。
  factory WidgetSnapshot.goalMissing({
    required Uri entryUri,
  }) {
    return WidgetSnapshot(
      state: WidgetSnapshotState.goalMissing,
      entryUri: entryUri,
    );
  }

  /// 创建无数据快照，允许保留今晚目标但不输出昨晚结果。
  factory WidgetSnapshot.noData({
    required String targetBedtimeLabel,
    int? minutesToTarget,
    required Uri entryUri,
  }) {
    return WidgetSnapshot(
      state: WidgetSnapshotState.noData,
      targetBedtimeLabel: targetBedtimeLabel,
      minutesToTarget: minutesToTarget,
      entryUri: entryUri,
    );
  }

  /// 创建权限缺失快照，优先暴露目标信息和权限状态，不输出睡眠细节。
  factory WidgetSnapshot.permissionRequired({
    required String targetBedtimeLabel,
    int? minutesToTarget,
    required Uri entryUri,
  }) {
    return WidgetSnapshot(
      state: WidgetSnapshotState.permissionRequired,
      targetBedtimeLabel: targetBedtimeLabel,
      minutesToTarget: minutesToTarget,
      entryUri: entryUri,
    );
  }

  /// 创建完整快照，用于小组件正常展示必要的晚间摘要。
  factory WidgetSnapshot.ready({
    required String targetBedtimeLabel,
    required int minutesToTarget,
    required String lastNightStatusLabel,
    required Uri entryUri,
  }) {
    return WidgetSnapshot(
      state: WidgetSnapshotState.ready,
      targetBedtimeLabel: targetBedtimeLabel,
      minutesToTarget: minutesToTarget,
      lastNightStatusLabel: lastNightStatusLabel,
      entryUri: entryUri,
    );
  }

  /// 转换为插件层写入键值，统一限制只输出允许暴露的字段。
  Map<String, Object?> toWidgetData() {
    return <String, Object?>{
      'snapshot_state': state.name,
      'target_bedtime_label': targetBedtimeLabel,
      'minutes_to_target': minutesToTarget,
      'last_night_status_label': lastNightStatusLabel,
      'entry_uri': entryUri.toString(),
    };
  }
}
