// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'widget_snapshot.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$WidgetSnapshot {

 WidgetSnapshotState get state; String? get targetBedtimeLabel; int? get minutesToTarget; String? get lastNightStatusLabel; Uri get entryUri;
/// Create a copy of WidgetSnapshot
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WidgetSnapshotCopyWith<WidgetSnapshot> get copyWith => _$WidgetSnapshotCopyWithImpl<WidgetSnapshot>(this as WidgetSnapshot, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WidgetSnapshot&&(identical(other.state, state) || other.state == state)&&(identical(other.targetBedtimeLabel, targetBedtimeLabel) || other.targetBedtimeLabel == targetBedtimeLabel)&&(identical(other.minutesToTarget, minutesToTarget) || other.minutesToTarget == minutesToTarget)&&(identical(other.lastNightStatusLabel, lastNightStatusLabel) || other.lastNightStatusLabel == lastNightStatusLabel)&&(identical(other.entryUri, entryUri) || other.entryUri == entryUri));
}


@override
int get hashCode => Object.hash(runtimeType,state,targetBedtimeLabel,minutesToTarget,lastNightStatusLabel,entryUri);

@override
String toString() {
  return 'WidgetSnapshot(state: $state, targetBedtimeLabel: $targetBedtimeLabel, minutesToTarget: $minutesToTarget, lastNightStatusLabel: $lastNightStatusLabel, entryUri: $entryUri)';
}


}

/// @nodoc
abstract mixin class $WidgetSnapshotCopyWith<$Res>  {
  factory $WidgetSnapshotCopyWith(WidgetSnapshot value, $Res Function(WidgetSnapshot) _then) = _$WidgetSnapshotCopyWithImpl;
@useResult
$Res call({
 WidgetSnapshotState state, String? targetBedtimeLabel, int? minutesToTarget, String? lastNightStatusLabel, Uri entryUri
});




}
/// @nodoc
class _$WidgetSnapshotCopyWithImpl<$Res>
    implements $WidgetSnapshotCopyWith<$Res> {
  _$WidgetSnapshotCopyWithImpl(this._self, this._then);

  final WidgetSnapshot _self;
  final $Res Function(WidgetSnapshot) _then;

/// Create a copy of WidgetSnapshot
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? state = null,Object? targetBedtimeLabel = freezed,Object? minutesToTarget = freezed,Object? lastNightStatusLabel = freezed,Object? entryUri = null,}) {
  return _then(_self.copyWith(
state: null == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as WidgetSnapshotState,targetBedtimeLabel: freezed == targetBedtimeLabel ? _self.targetBedtimeLabel : targetBedtimeLabel // ignore: cast_nullable_to_non_nullable
as String?,minutesToTarget: freezed == minutesToTarget ? _self.minutesToTarget : minutesToTarget // ignore: cast_nullable_to_non_nullable
as int?,lastNightStatusLabel: freezed == lastNightStatusLabel ? _self.lastNightStatusLabel : lastNightStatusLabel // ignore: cast_nullable_to_non_nullable
as String?,entryUri: null == entryUri ? _self.entryUri : entryUri // ignore: cast_nullable_to_non_nullable
as Uri,
  ));
}

}


/// Adds pattern-matching-related methods to [WidgetSnapshot].
extension WidgetSnapshotPatterns on WidgetSnapshot {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WidgetSnapshot value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WidgetSnapshot() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WidgetSnapshot value)  $default,){
final _that = this;
switch (_that) {
case _WidgetSnapshot():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WidgetSnapshot value)?  $default,){
final _that = this;
switch (_that) {
case _WidgetSnapshot() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( WidgetSnapshotState state,  String? targetBedtimeLabel,  int? minutesToTarget,  String? lastNightStatusLabel,  Uri entryUri)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WidgetSnapshot() when $default != null:
return $default(_that.state,_that.targetBedtimeLabel,_that.minutesToTarget,_that.lastNightStatusLabel,_that.entryUri);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( WidgetSnapshotState state,  String? targetBedtimeLabel,  int? minutesToTarget,  String? lastNightStatusLabel,  Uri entryUri)  $default,) {final _that = this;
switch (_that) {
case _WidgetSnapshot():
return $default(_that.state,_that.targetBedtimeLabel,_that.minutesToTarget,_that.lastNightStatusLabel,_that.entryUri);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( WidgetSnapshotState state,  String? targetBedtimeLabel,  int? minutesToTarget,  String? lastNightStatusLabel,  Uri entryUri)?  $default,) {final _that = this;
switch (_that) {
case _WidgetSnapshot() when $default != null:
return $default(_that.state,_that.targetBedtimeLabel,_that.minutesToTarget,_that.lastNightStatusLabel,_that.entryUri);case _:
  return null;

}
}

}

/// @nodoc


class _WidgetSnapshot extends WidgetSnapshot {
  const _WidgetSnapshot({required this.state, this.targetBedtimeLabel, this.minutesToTarget, this.lastNightStatusLabel, required this.entryUri}): super._();
  

@override final  WidgetSnapshotState state;
@override final  String? targetBedtimeLabel;
@override final  int? minutesToTarget;
@override final  String? lastNightStatusLabel;
@override final  Uri entryUri;

/// Create a copy of WidgetSnapshot
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WidgetSnapshotCopyWith<_WidgetSnapshot> get copyWith => __$WidgetSnapshotCopyWithImpl<_WidgetSnapshot>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WidgetSnapshot&&(identical(other.state, state) || other.state == state)&&(identical(other.targetBedtimeLabel, targetBedtimeLabel) || other.targetBedtimeLabel == targetBedtimeLabel)&&(identical(other.minutesToTarget, minutesToTarget) || other.minutesToTarget == minutesToTarget)&&(identical(other.lastNightStatusLabel, lastNightStatusLabel) || other.lastNightStatusLabel == lastNightStatusLabel)&&(identical(other.entryUri, entryUri) || other.entryUri == entryUri));
}


@override
int get hashCode => Object.hash(runtimeType,state,targetBedtimeLabel,minutesToTarget,lastNightStatusLabel,entryUri);

@override
String toString() {
  return 'WidgetSnapshot(state: $state, targetBedtimeLabel: $targetBedtimeLabel, minutesToTarget: $minutesToTarget, lastNightStatusLabel: $lastNightStatusLabel, entryUri: $entryUri)';
}


}

/// @nodoc
abstract mixin class _$WidgetSnapshotCopyWith<$Res> implements $WidgetSnapshotCopyWith<$Res> {
  factory _$WidgetSnapshotCopyWith(_WidgetSnapshot value, $Res Function(_WidgetSnapshot) _then) = __$WidgetSnapshotCopyWithImpl;
@override @useResult
$Res call({
 WidgetSnapshotState state, String? targetBedtimeLabel, int? minutesToTarget, String? lastNightStatusLabel, Uri entryUri
});




}
/// @nodoc
class __$WidgetSnapshotCopyWithImpl<$Res>
    implements _$WidgetSnapshotCopyWith<$Res> {
  __$WidgetSnapshotCopyWithImpl(this._self, this._then);

  final _WidgetSnapshot _self;
  final $Res Function(_WidgetSnapshot) _then;

/// Create a copy of WidgetSnapshot
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? state = null,Object? targetBedtimeLabel = freezed,Object? minutesToTarget = freezed,Object? lastNightStatusLabel = freezed,Object? entryUri = null,}) {
  return _then(_WidgetSnapshot(
state: null == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as WidgetSnapshotState,targetBedtimeLabel: freezed == targetBedtimeLabel ? _self.targetBedtimeLabel : targetBedtimeLabel // ignore: cast_nullable_to_non_nullable
as String?,minutesToTarget: freezed == minutesToTarget ? _self.minutesToTarget : minutesToTarget // ignore: cast_nullable_to_non_nullable
as int?,lastNightStatusLabel: freezed == lastNightStatusLabel ? _self.lastNightStatusLabel : lastNightStatusLabel // ignore: cast_nullable_to_non_nullable
as String?,entryUri: null == entryUri ? _self.entryUri : entryUri // ignore: cast_nullable_to_non_nullable
as Uri,
  ));
}


}

// dart format on
