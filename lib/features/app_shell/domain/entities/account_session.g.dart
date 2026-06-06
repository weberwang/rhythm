// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_session.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AppAccountSession _$AppAccountSessionFromJson(Map<String, dynamic> json) =>
    _AppAccountSession(
      mode: $enumDecode(_$AppAccountSessionModeEnumMap, json['mode']),
      provider: $enumDecodeNullable(
        _$AppAccountProviderEnumMap,
        json['provider'],
      ),
      displayName: json['displayName'] as String?,
      email: json['email'] as String?,
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$AppAccountSessionToJson(_AppAccountSession instance) =>
    <String, dynamic>{
      'mode': _$AppAccountSessionModeEnumMap[instance.mode]!,
      'provider': _$AppAccountProviderEnumMap[instance.provider],
      'displayName': instance.displayName,
      'email': instance.email,
      'updatedAt': instance.updatedAt.toIso8601String(),
    };

const _$AppAccountSessionModeEnumMap = {
  AppAccountSessionMode.anonymous: 'anonymous',
  AppAccountSessionMode.connected: 'connected',
};

const _$AppAccountProviderEnumMap = {
  AppAccountProvider.apple: 'apple',
  AppAccountProvider.google: 'google',
};
