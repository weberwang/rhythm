import 'bedtime_status.dart';

/// 记录用户一次进入睡前模式后的交互结果，供后续洞察与恢复建议读取。
class BedtimeSession {
  /// 创建睡前模式会话。
  const BedtimeSession({
    required this.id,
    required this.startedAt,
    required this.targetBedtime,
    required this.createdAt,
    this.selectedStatus,
    this.selectedAt,
    this.completedActionName,
  });

  /// 会话主键。
  final String id;

  /// 用户进入睡前模式的时间。
  final DateTime startedAt;

  /// 当晚目标入睡时间。
  final DateTime targetBedtime;

  /// 用户当前已选择的状态；如果还未选择则为空。
  final BedtimeStatus? selectedStatus;

  /// 状态选择时间；如果还未选择则为空。
  final DateTime? selectedAt;

  /// 已完成动作的稳定名称；如果尚未点击动作则为空。
  final String? completedActionName;

  /// 会话创建时间。
  final DateTime createdAt;

  /// 复制当前会话并应用指定字段修改。
  BedtimeSession copyWith({
    BedtimeStatus? selectedStatus,
    DateTime? selectedAt,
    String? completedActionName,
  }) {
    return BedtimeSession(
      id: id,
      startedAt: startedAt,
      targetBedtime: targetBedtime,
      selectedStatus: selectedStatus ?? this.selectedStatus,
      selectedAt: selectedAt ?? this.selectedAt,
      completedActionName: completedActionName ?? this.completedActionName,
      createdAt: createdAt,
    );
  }
}
