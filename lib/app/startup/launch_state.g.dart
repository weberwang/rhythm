// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'launch_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_LaunchSnapshot _$LaunchSnapshotFromJson(Map<String, dynamic> json) =>
    _LaunchSnapshot(
      destination: $enumDecode(_$LaunchDestinationEnumMap, json['destination']),
      entryIntent: EntryIntent.fromJson(
        json['entryIntent'] as Map<String, dynamic>,
      ),
    );

Map<String, dynamic> _$LaunchSnapshotToJson(_LaunchSnapshot instance) =>
    <String, dynamic>{
      'destination': _$LaunchDestinationEnumMap[instance.destination]!,
      'entryIntent': instance.entryIntent,
    };

const _$LaunchDestinationEnumMap = {
  LaunchDestination.onboarding: 'onboarding',
  LaunchDestination.shell: 'shell',
};
