// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'goal_schedule.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_GoalSchedule _$GoalScheduleFromJson(Map<String, dynamic> json) =>
    _GoalSchedule(
      id: json['id'] as String,
      bedtimeMinutes: (json['bedtimeMinutes'] as num).toInt(),
      wakeTimeMinutes: (json['wakeTimeMinutes'] as num).toInt(),
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$GoalScheduleToJson(_GoalSchedule instance) =>
    <String, dynamic>{
      'id': instance.id,
      'bedtimeMinutes': instance.bedtimeMinutes,
      'wakeTimeMinutes': instance.wakeTimeMinutes,
      'createdAt': instance.createdAt.toIso8601String(),
    };
