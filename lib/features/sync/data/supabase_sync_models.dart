import '../../goal_schedule/domain/goal_schedule_settings.dart';
import '../../sleep_records/domain/sleep_record.dart';
import '../../sleep_records/domain/sleep_record_confidence.dart';
import '../../sleep_records/domain/sleep_record_source.dart';
import '../../sleep_records/domain/sleep_delay_tag_snapshot.dart';
import '../domain/sync_queue_item.dart';

/// 表示远端目标作息行，负责在领域模型与 Supabase JSON 之间做边界映射。
class SyncGoalSettingsRemoteModel {
  /// 创建远端目标作息模型。
  const SyncGoalSettingsRemoteModel({
    required this.userId,
    required this.targetBedtimeMinutes,
    required this.targetWakeMinutes,
    required this.lateThresholdMinutes,
    required this.dayStartMinutes,
    required this.updatedAt,
  });

  /// 当前匿名云身份对应的用户 ID。
  final String userId;

  /// 目标入睡分钟值。
  final int targetBedtimeMinutes;

  /// 目标起床分钟值。
  final int targetWakeMinutes;

  /// 晚睡阈值分钟值。
  final int lateThresholdMinutes;

  /// 一天起始分钟值。
  final int dayStartMinutes;

  /// 远端更新时间。
  final DateTime updatedAt;

  /// 从本地目标作息构造远端 DTO，统一补齐当前用户身份。
  factory SyncGoalSettingsRemoteModel.fromDomain({
    required String userId,
    required GoalScheduleSettings settings,
  }) {
    return SyncGoalSettingsRemoteModel(
      userId: userId,
      targetBedtimeMinutes: settings.targetBedtimeMinutes,
      targetWakeMinutes: settings.targetWakeMinutes,
      lateThresholdMinutes: settings.lateThresholdMinutes,
      dayStartMinutes: settings.dayStartMinutes,
      updatedAt: (settings.updatedAt ?? DateTime.now().toUtc()).toUtc(),
    );
  }

  /// 从远端 JSON 恢复目标作息模型。
  factory SyncGoalSettingsRemoteModel.fromJson(Map<String, Object?> json) {
    return SyncGoalSettingsRemoteModel(
      userId: json['user_id']! as String,
      targetBedtimeMinutes: json['target_bedtime_minutes']! as int,
      targetWakeMinutes: json['target_wake_minutes']! as int,
      lateThresholdMinutes: json['late_threshold_minutes']! as int,
      dayStartMinutes: json['day_start_minutes']! as int,
      updatedAt: DateTime.parse(json['updated_at']! as String).toUtc(),
    );
  }

  /// 转成领域目标作息，供本地回写复用。
  GoalScheduleSettings toDomain() {
    return GoalScheduleSettings(
      targetBedtimeMinutes: targetBedtimeMinutes,
      targetWakeMinutes: targetWakeMinutes,
      lateThresholdMinutes: lateThresholdMinutes,
      dayStartMinutes: dayStartMinutes,
      updatedAt: updatedAt,
    );
  }

  /// 转成 Supabase 可写入的 JSON 结构。
  Map<String, Object?> toJson() => <String, Object?>{
        'user_id': userId,
        'target_bedtime_minutes': targetBedtimeMinutes,
        'target_wake_minutes': targetWakeMinutes,
        'late_threshold_minutes': lateThresholdMinutes,
        'day_start_minutes': dayStartMinutes,
        'updated_at': updatedAt.toIso8601String(),
      };
}

/// 表示远端睡眠记录行，负责领域模型与 Supabase JSON 的双向映射。
class SyncSleepRecordRemoteModel {
  /// 创建远端睡眠记录模型。
  const SyncSleepRecordRemoteModel({
    required this.id,
    required this.userId,
    required this.recordDate,
    required this.fellAsleepAt,
    required this.wokeUpAt,
    required this.durationMinutes,
    required this.source,
    required this.confidence,
    required this.timezone,
    required this.isUserEdited,
    required this.sourceRecordId,
    required this.createdAt,
    required this.updatedAt,
  });

  /// 记录主键。
  final String id;

  /// 当前用户 ID。
  final String userId;

  /// 业务归属日。
  final DateTime recordDate;

  /// 入睡时间。
  final DateTime fellAsleepAt;

  /// 起床时间。
  final DateTime wokeUpAt;

  /// 睡眠时长分钟值。
  final int durationMinutes;

  /// 记录来源。
  final SleepRecordSource source;

  /// 可信度。
  final SleepRecordConfidence confidence;

  /// 时区名称。
  final String timezone;

  /// 是否为用户编辑结果。
  final bool isUserEdited;

  /// 被修正原始记录 ID。
  final String? sourceRecordId;

  /// 创建时间。
  final DateTime createdAt;

  /// 更新时间。
  final DateTime updatedAt;

  /// 从领域睡眠记录构造远端 DTO。
  factory SyncSleepRecordRemoteModel.fromDomain({
    required String userId,
    required SleepRecord record,
  }) {
    return SyncSleepRecordRemoteModel(
      id: record.id,
      userId: userId,
      recordDate: DateTime.utc(
        record.recordDate.year,
        record.recordDate.month,
        record.recordDate.day,
      ),
      fellAsleepAt: record.fellAsleepAt.toUtc(),
      wokeUpAt: record.wokeUpAt.toUtc(),
      durationMinutes: record.durationMinutes,
      source: record.source,
      confidence: record.confidence,
      timezone: record.timezone,
      isUserEdited: record.isUserEdited,
      sourceRecordId: record.sourceRecordId,
      createdAt: record.createdAt.toUtc(),
      updatedAt: record.updatedAt.toUtc(),
    );
  }

  /// 从远端 JSON 恢复睡眠记录模型。
  factory SyncSleepRecordRemoteModel.fromJson(Map<String, Object?> json) {
    return SyncSleepRecordRemoteModel(
      id: json['id']! as String,
      userId: json['user_id']! as String,
      recordDate: DateTime.parse(json['record_date']! as String).toUtc(),
      fellAsleepAt: DateTime.parse(json['fell_asleep_at']! as String).toUtc(),
      wokeUpAt: DateTime.parse(json['woke_up_at']! as String).toUtc(),
      durationMinutes: json['duration_minutes']! as int,
      source: SleepRecordSource.values.byName(json['source']! as String),
      confidence: SleepRecordConfidence.values.byName(
        json['confidence']! as String,
      ),
      timezone: json['timezone']! as String,
      isUserEdited: json['is_user_edited']! as bool,
      sourceRecordId: json['source_record_id'] as String?,
      createdAt: DateTime.parse(json['created_at']! as String).toUtc(),
      updatedAt: DateTime.parse(json['updated_at']! as String).toUtc(),
    );
  }

  /// 转成领域睡眠记录，供本地回写与冲突比较复用。
  SleepRecord toDomain() {
    return SleepRecord(
      id: id,
      recordDate: recordDate,
      fellAsleepAt: fellAsleepAt,
      wokeUpAt: wokeUpAt,
      durationMinutes: durationMinutes,
      source: source,
      confidence: confidence,
      timezone: timezone,
      isUserEdited: isUserEdited,
      sourceRecordId: sourceRecordId,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  /// 转成 Supabase 可写入 JSON。
  Map<String, Object?> toJson() => <String, Object?>{
        'id': id,
        'user_id': userId,
        'record_date':
            '${recordDate.year.toString().padLeft(4, '0')}-'
            '${recordDate.month.toString().padLeft(2, '0')}-'
            '${recordDate.day.toString().padLeft(2, '0')}',
        'fell_asleep_at': fellAsleepAt.toIso8601String(),
        'woke_up_at': wokeUpAt.toIso8601String(),
        'duration_minutes': durationMinutes,
        'source': source.name,
        'confidence': confidence.name,
        'timezone': timezone,
        'is_user_edited': isUserEdited,
        'source_record_id': sourceRecordId,
        'created_at': createdAt.toIso8601String(),
        'updated_at': updatedAt.toIso8601String(),
      };
}

/// 表示远端晚睡标签行，负责标签快照与 Supabase JSON 的边界映射。
class SyncSleepDelayTagRemoteModel {
  /// 创建远端晚睡标签模型。
  const SyncSleepDelayTagRemoteModel({
    required this.userId,
    required this.recordDate,
    required this.tags,
    required this.updatedAt,
  });

  /// 当前用户 ID。
  final String userId;

  /// 业务归属日。
  final DateTime recordDate;

  /// 标签集合。
  final List<String> tags;

  /// 更新时间。
  final DateTime updatedAt;

  /// 从本地标签快照构造远端 DTO。
  factory SyncSleepDelayTagRemoteModel.fromDomain({
    required String userId,
    required SleepDelayTagSnapshot snapshot,
  }) {
    return SyncSleepDelayTagRemoteModel(
      userId: userId,
      recordDate: snapshot.recordDate,
      tags: snapshot.tags,
      updatedAt: snapshot.updatedAt.toUtc(),
    );
  }

  /// 从远端 JSON 恢复标签模型。
  factory SyncSleepDelayTagRemoteModel.fromJson(Map<String, Object?> json) {
    final tagsJson = json['tags_json'];
    final tags = tagsJson is List
        ? tagsJson.map((item) => item.toString()).toList(growable: false)
        : const <String>[];
    return SyncSleepDelayTagRemoteModel(
      userId: json['user_id']! as String,
      recordDate: DateTime.parse(json['record_date']! as String).toUtc(),
      tags: tags,
      updatedAt: DateTime.parse(json['updated_at']! as String).toUtc(),
    );
  }

  /// 转成本地标签快照。
  SleepDelayTagSnapshot toDomain() {
    return SleepDelayTagSnapshot(
      recordDate: recordDate,
      tags: tags,
      updatedAt: updatedAt,
    );
  }

  /// 转成 Supabase 可写入 JSON。
  Map<String, Object?> toJson() => <String, Object?>{
        'user_id': userId,
        'record_date':
            '${recordDate.year.toString().padLeft(4, '0')}-'
            '${recordDate.month.toString().padLeft(2, '0')}-'
            '${recordDate.day.toString().padLeft(2, '0')}',
        'tags_json': tags,
        'updated_at': updatedAt.toIso8601String(),
      };
}

/// 统一构造同步项键，避免本地与远端对账时散落相同拼接逻辑。
String syncEntityKey(SyncEntityType entityType, String entityId) {
  return '${entityType.name}:$entityId';
}
