// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'entry_intent.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppOpenEntryIntent _$AppOpenEntryIntentFromJson(Map<String, dynamic> json) =>
    AppOpenEntryIntent($type: json['runtimeType'] as String?);

Map<String, dynamic> _$AppOpenEntryIntentToJson(AppOpenEntryIntent instance) =>
    <String, dynamic>{'runtimeType': instance.$type};

NotificationEntryIntent _$NotificationEntryIntentFromJson(
  Map<String, dynamic> json,
) => NotificationEntryIntent(
  target: json['target'] as String,
  $type: json['runtimeType'] as String?,
);

Map<String, dynamic> _$NotificationEntryIntentToJson(
  NotificationEntryIntent instance,
) => <String, dynamic>{
  'target': instance.target,
  'runtimeType': instance.$type,
};

HomeWidgetEntryIntent _$HomeWidgetEntryIntentFromJson(
  Map<String, dynamic> json,
) => HomeWidgetEntryIntent(
  target: json['target'] as String,
  $type: json['runtimeType'] as String?,
);

Map<String, dynamic> _$HomeWidgetEntryIntentToJson(
  HomeWidgetEntryIntent instance,
) => <String, dynamic>{
  'target': instance.target,
  'runtimeType': instance.$type,
};
