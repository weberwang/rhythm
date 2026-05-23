// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'reminder_settings_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ReminderSettingsState {

 bool get softReminderEnabled; bool get targetReminderEnabled; bool get weeklyReportEnabled; int get leadMinutes;
/// Create a copy of ReminderSettingsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReminderSettingsStateCopyWith<ReminderSettingsState> get copyWith => _$ReminderSettingsStateCopyWithImpl<ReminderSettingsState>(this as ReminderSettingsState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReminderSettingsState&&(identical(other.softReminderEnabled, softReminderEnabled) || other.softReminderEnabled == softReminderEnabled)&&(identical(other.targetReminderEnabled, targetReminderEnabled) || other.targetReminderEnabled == targetReminderEnabled)&&(identical(other.weeklyReportEnabled, weeklyReportEnabled) || other.weeklyReportEnabled == weeklyReportEnabled)&&(identical(other.leadMinutes, leadMinutes) || other.leadMinutes == leadMinutes));
}


@override
int get hashCode => Object.hash(runtimeType,softReminderEnabled,targetReminderEnabled,weeklyReportEnabled,leadMinutes);

@override
String toString() {
  return 'ReminderSettingsState(softReminderEnabled: $softReminderEnabled, targetReminderEnabled: $targetReminderEnabled, weeklyReportEnabled: $weeklyReportEnabled, leadMinutes: $leadMinutes)';
}


}

/// @nodoc
abstract mixin class $ReminderSettingsStateCopyWith<$Res>  {
  factory $ReminderSettingsStateCopyWith(ReminderSettingsState value, $Res Function(ReminderSettingsState) _then) = _$ReminderSettingsStateCopyWithImpl;
@useResult
$Res call({
 bool softReminderEnabled, bool targetReminderEnabled, bool weeklyReportEnabled, int leadMinutes
});




}
/// @nodoc
class _$ReminderSettingsStateCopyWithImpl<$Res>
    implements $ReminderSettingsStateCopyWith<$Res> {
  _$ReminderSettingsStateCopyWithImpl(this._self, this._then);

  final ReminderSettingsState _self;
  final $Res Function(ReminderSettingsState) _then;

/// Create a copy of ReminderSettingsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? softReminderEnabled = null,Object? targetReminderEnabled = null,Object? weeklyReportEnabled = null,Object? leadMinutes = null,}) {
  return _then(_self.copyWith(
softReminderEnabled: null == softReminderEnabled ? _self.softReminderEnabled : softReminderEnabled // ignore: cast_nullable_to_non_nullable
as bool,targetReminderEnabled: null == targetReminderEnabled ? _self.targetReminderEnabled : targetReminderEnabled // ignore: cast_nullable_to_non_nullable
as bool,weeklyReportEnabled: null == weeklyReportEnabled ? _self.weeklyReportEnabled : weeklyReportEnabled // ignore: cast_nullable_to_non_nullable
as bool,leadMinutes: null == leadMinutes ? _self.leadMinutes : leadMinutes // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [ReminderSettingsState].
extension ReminderSettingsStatePatterns on ReminderSettingsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ReminderSettingsState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ReminderSettingsState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ReminderSettingsState value)  $default,){
final _that = this;
switch (_that) {
case _ReminderSettingsState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ReminderSettingsState value)?  $default,){
final _that = this;
switch (_that) {
case _ReminderSettingsState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool softReminderEnabled,  bool targetReminderEnabled,  bool weeklyReportEnabled,  int leadMinutes)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ReminderSettingsState() when $default != null:
return $default(_that.softReminderEnabled,_that.targetReminderEnabled,_that.weeklyReportEnabled,_that.leadMinutes);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool softReminderEnabled,  bool targetReminderEnabled,  bool weeklyReportEnabled,  int leadMinutes)  $default,) {final _that = this;
switch (_that) {
case _ReminderSettingsState():
return $default(_that.softReminderEnabled,_that.targetReminderEnabled,_that.weeklyReportEnabled,_that.leadMinutes);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool softReminderEnabled,  bool targetReminderEnabled,  bool weeklyReportEnabled,  int leadMinutes)?  $default,) {final _that = this;
switch (_that) {
case _ReminderSettingsState() when $default != null:
return $default(_that.softReminderEnabled,_that.targetReminderEnabled,_that.weeklyReportEnabled,_that.leadMinutes);case _:
  return null;

}
}

}

/// @nodoc


class _ReminderSettingsState implements ReminderSettingsState {
  const _ReminderSettingsState({this.softReminderEnabled = true, this.targetReminderEnabled = false, this.weeklyReportEnabled = true, this.leadMinutes = 45});
  

@override@JsonKey() final  bool softReminderEnabled;
@override@JsonKey() final  bool targetReminderEnabled;
@override@JsonKey() final  bool weeklyReportEnabled;
@override@JsonKey() final  int leadMinutes;

/// Create a copy of ReminderSettingsState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReminderSettingsStateCopyWith<_ReminderSettingsState> get copyWith => __$ReminderSettingsStateCopyWithImpl<_ReminderSettingsState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ReminderSettingsState&&(identical(other.softReminderEnabled, softReminderEnabled) || other.softReminderEnabled == softReminderEnabled)&&(identical(other.targetReminderEnabled, targetReminderEnabled) || other.targetReminderEnabled == targetReminderEnabled)&&(identical(other.weeklyReportEnabled, weeklyReportEnabled) || other.weeklyReportEnabled == weeklyReportEnabled)&&(identical(other.leadMinutes, leadMinutes) || other.leadMinutes == leadMinutes));
}


@override
int get hashCode => Object.hash(runtimeType,softReminderEnabled,targetReminderEnabled,weeklyReportEnabled,leadMinutes);

@override
String toString() {
  return 'ReminderSettingsState(softReminderEnabled: $softReminderEnabled, targetReminderEnabled: $targetReminderEnabled, weeklyReportEnabled: $weeklyReportEnabled, leadMinutes: $leadMinutes)';
}


}

/// @nodoc
abstract mixin class _$ReminderSettingsStateCopyWith<$Res> implements $ReminderSettingsStateCopyWith<$Res> {
  factory _$ReminderSettingsStateCopyWith(_ReminderSettingsState value, $Res Function(_ReminderSettingsState) _then) = __$ReminderSettingsStateCopyWithImpl;
@override @useResult
$Res call({
 bool softReminderEnabled, bool targetReminderEnabled, bool weeklyReportEnabled, int leadMinutes
});




}
/// @nodoc
class __$ReminderSettingsStateCopyWithImpl<$Res>
    implements _$ReminderSettingsStateCopyWith<$Res> {
  __$ReminderSettingsStateCopyWithImpl(this._self, this._then);

  final _ReminderSettingsState _self;
  final $Res Function(_ReminderSettingsState) _then;

/// Create a copy of ReminderSettingsState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? softReminderEnabled = null,Object? targetReminderEnabled = null,Object? weeklyReportEnabled = null,Object? leadMinutes = null,}) {
  return _then(_ReminderSettingsState(
softReminderEnabled: null == softReminderEnabled ? _self.softReminderEnabled : softReminderEnabled // ignore: cast_nullable_to_non_nullable
as bool,targetReminderEnabled: null == targetReminderEnabled ? _self.targetReminderEnabled : targetReminderEnabled // ignore: cast_nullable_to_non_nullable
as bool,weeklyReportEnabled: null == weeklyReportEnabled ? _self.weeklyReportEnabled : weeklyReportEnabled // ignore: cast_nullable_to_non_nullable
as bool,leadMinutes: null == leadMinutes ? _self.leadMinutes : leadMinutes // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
