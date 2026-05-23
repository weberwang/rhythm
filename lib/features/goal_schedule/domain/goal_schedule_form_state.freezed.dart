// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'goal_schedule_form_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$GoalScheduleFormState {

 int get bedtimeHour; int get bedtimeMinute; int get wakeHour; int get wakeMinute; int get lateThresholdMinutes; int get dayStartHour; int get dayStartMinute; GoalScheduleValidationError? get wakeTimeError;
/// Create a copy of GoalScheduleFormState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GoalScheduleFormStateCopyWith<GoalScheduleFormState> get copyWith => _$GoalScheduleFormStateCopyWithImpl<GoalScheduleFormState>(this as GoalScheduleFormState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GoalScheduleFormState&&(identical(other.bedtimeHour, bedtimeHour) || other.bedtimeHour == bedtimeHour)&&(identical(other.bedtimeMinute, bedtimeMinute) || other.bedtimeMinute == bedtimeMinute)&&(identical(other.wakeHour, wakeHour) || other.wakeHour == wakeHour)&&(identical(other.wakeMinute, wakeMinute) || other.wakeMinute == wakeMinute)&&(identical(other.lateThresholdMinutes, lateThresholdMinutes) || other.lateThresholdMinutes == lateThresholdMinutes)&&(identical(other.dayStartHour, dayStartHour) || other.dayStartHour == dayStartHour)&&(identical(other.dayStartMinute, dayStartMinute) || other.dayStartMinute == dayStartMinute)&&(identical(other.wakeTimeError, wakeTimeError) || other.wakeTimeError == wakeTimeError));
}


@override
int get hashCode => Object.hash(runtimeType,bedtimeHour,bedtimeMinute,wakeHour,wakeMinute,lateThresholdMinutes,dayStartHour,dayStartMinute,wakeTimeError);

@override
String toString() {
  return 'GoalScheduleFormState(bedtimeHour: $bedtimeHour, bedtimeMinute: $bedtimeMinute, wakeHour: $wakeHour, wakeMinute: $wakeMinute, lateThresholdMinutes: $lateThresholdMinutes, dayStartHour: $dayStartHour, dayStartMinute: $dayStartMinute, wakeTimeError: $wakeTimeError)';
}


}

/// @nodoc
abstract mixin class $GoalScheduleFormStateCopyWith<$Res>  {
  factory $GoalScheduleFormStateCopyWith(GoalScheduleFormState value, $Res Function(GoalScheduleFormState) _then) = _$GoalScheduleFormStateCopyWithImpl;
@useResult
$Res call({
 int bedtimeHour, int bedtimeMinute, int wakeHour, int wakeMinute, int lateThresholdMinutes, int dayStartHour, int dayStartMinute, GoalScheduleValidationError? wakeTimeError
});




}
/// @nodoc
class _$GoalScheduleFormStateCopyWithImpl<$Res>
    implements $GoalScheduleFormStateCopyWith<$Res> {
  _$GoalScheduleFormStateCopyWithImpl(this._self, this._then);

  final GoalScheduleFormState _self;
  final $Res Function(GoalScheduleFormState) _then;

/// Create a copy of GoalScheduleFormState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? bedtimeHour = null,Object? bedtimeMinute = null,Object? wakeHour = null,Object? wakeMinute = null,Object? lateThresholdMinutes = null,Object? dayStartHour = null,Object? dayStartMinute = null,Object? wakeTimeError = freezed,}) {
  return _then(_self.copyWith(
bedtimeHour: null == bedtimeHour ? _self.bedtimeHour : bedtimeHour // ignore: cast_nullable_to_non_nullable
as int,bedtimeMinute: null == bedtimeMinute ? _self.bedtimeMinute : bedtimeMinute // ignore: cast_nullable_to_non_nullable
as int,wakeHour: null == wakeHour ? _self.wakeHour : wakeHour // ignore: cast_nullable_to_non_nullable
as int,wakeMinute: null == wakeMinute ? _self.wakeMinute : wakeMinute // ignore: cast_nullable_to_non_nullable
as int,lateThresholdMinutes: null == lateThresholdMinutes ? _self.lateThresholdMinutes : lateThresholdMinutes // ignore: cast_nullable_to_non_nullable
as int,dayStartHour: null == dayStartHour ? _self.dayStartHour : dayStartHour // ignore: cast_nullable_to_non_nullable
as int,dayStartMinute: null == dayStartMinute ? _self.dayStartMinute : dayStartMinute // ignore: cast_nullable_to_non_nullable
as int,wakeTimeError: freezed == wakeTimeError ? _self.wakeTimeError : wakeTimeError // ignore: cast_nullable_to_non_nullable
as GoalScheduleValidationError?,
  ));
}

}


/// Adds pattern-matching-related methods to [GoalScheduleFormState].
extension GoalScheduleFormStatePatterns on GoalScheduleFormState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GoalScheduleFormState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GoalScheduleFormState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GoalScheduleFormState value)  $default,){
final _that = this;
switch (_that) {
case _GoalScheduleFormState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GoalScheduleFormState value)?  $default,){
final _that = this;
switch (_that) {
case _GoalScheduleFormState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int bedtimeHour,  int bedtimeMinute,  int wakeHour,  int wakeMinute,  int lateThresholdMinutes,  int dayStartHour,  int dayStartMinute,  GoalScheduleValidationError? wakeTimeError)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GoalScheduleFormState() when $default != null:
return $default(_that.bedtimeHour,_that.bedtimeMinute,_that.wakeHour,_that.wakeMinute,_that.lateThresholdMinutes,_that.dayStartHour,_that.dayStartMinute,_that.wakeTimeError);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int bedtimeHour,  int bedtimeMinute,  int wakeHour,  int wakeMinute,  int lateThresholdMinutes,  int dayStartHour,  int dayStartMinute,  GoalScheduleValidationError? wakeTimeError)  $default,) {final _that = this;
switch (_that) {
case _GoalScheduleFormState():
return $default(_that.bedtimeHour,_that.bedtimeMinute,_that.wakeHour,_that.wakeMinute,_that.lateThresholdMinutes,_that.dayStartHour,_that.dayStartMinute,_that.wakeTimeError);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int bedtimeHour,  int bedtimeMinute,  int wakeHour,  int wakeMinute,  int lateThresholdMinutes,  int dayStartHour,  int dayStartMinute,  GoalScheduleValidationError? wakeTimeError)?  $default,) {final _that = this;
switch (_that) {
case _GoalScheduleFormState() when $default != null:
return $default(_that.bedtimeHour,_that.bedtimeMinute,_that.wakeHour,_that.wakeMinute,_that.lateThresholdMinutes,_that.dayStartHour,_that.dayStartMinute,_that.wakeTimeError);case _:
  return null;

}
}

}

/// @nodoc


class _GoalScheduleFormState implements GoalScheduleFormState {
  const _GoalScheduleFormState({this.bedtimeHour = 23, this.bedtimeMinute = 30, this.wakeHour = 7, this.wakeMinute = 30, this.lateThresholdMinutes = 30, this.dayStartHour = 4, this.dayStartMinute = 0, this.wakeTimeError});
  

@override@JsonKey() final  int bedtimeHour;
@override@JsonKey() final  int bedtimeMinute;
@override@JsonKey() final  int wakeHour;
@override@JsonKey() final  int wakeMinute;
@override@JsonKey() final  int lateThresholdMinutes;
@override@JsonKey() final  int dayStartHour;
@override@JsonKey() final  int dayStartMinute;
@override final  GoalScheduleValidationError? wakeTimeError;

/// Create a copy of GoalScheduleFormState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GoalScheduleFormStateCopyWith<_GoalScheduleFormState> get copyWith => __$GoalScheduleFormStateCopyWithImpl<_GoalScheduleFormState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GoalScheduleFormState&&(identical(other.bedtimeHour, bedtimeHour) || other.bedtimeHour == bedtimeHour)&&(identical(other.bedtimeMinute, bedtimeMinute) || other.bedtimeMinute == bedtimeMinute)&&(identical(other.wakeHour, wakeHour) || other.wakeHour == wakeHour)&&(identical(other.wakeMinute, wakeMinute) || other.wakeMinute == wakeMinute)&&(identical(other.lateThresholdMinutes, lateThresholdMinutes) || other.lateThresholdMinutes == lateThresholdMinutes)&&(identical(other.dayStartHour, dayStartHour) || other.dayStartHour == dayStartHour)&&(identical(other.dayStartMinute, dayStartMinute) || other.dayStartMinute == dayStartMinute)&&(identical(other.wakeTimeError, wakeTimeError) || other.wakeTimeError == wakeTimeError));
}


@override
int get hashCode => Object.hash(runtimeType,bedtimeHour,bedtimeMinute,wakeHour,wakeMinute,lateThresholdMinutes,dayStartHour,dayStartMinute,wakeTimeError);

@override
String toString() {
  return 'GoalScheduleFormState(bedtimeHour: $bedtimeHour, bedtimeMinute: $bedtimeMinute, wakeHour: $wakeHour, wakeMinute: $wakeMinute, lateThresholdMinutes: $lateThresholdMinutes, dayStartHour: $dayStartHour, dayStartMinute: $dayStartMinute, wakeTimeError: $wakeTimeError)';
}


}

/// @nodoc
abstract mixin class _$GoalScheduleFormStateCopyWith<$Res> implements $GoalScheduleFormStateCopyWith<$Res> {
  factory _$GoalScheduleFormStateCopyWith(_GoalScheduleFormState value, $Res Function(_GoalScheduleFormState) _then) = __$GoalScheduleFormStateCopyWithImpl;
@override @useResult
$Res call({
 int bedtimeHour, int bedtimeMinute, int wakeHour, int wakeMinute, int lateThresholdMinutes, int dayStartHour, int dayStartMinute, GoalScheduleValidationError? wakeTimeError
});




}
/// @nodoc
class __$GoalScheduleFormStateCopyWithImpl<$Res>
    implements _$GoalScheduleFormStateCopyWith<$Res> {
  __$GoalScheduleFormStateCopyWithImpl(this._self, this._then);

  final _GoalScheduleFormState _self;
  final $Res Function(_GoalScheduleFormState) _then;

/// Create a copy of GoalScheduleFormState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? bedtimeHour = null,Object? bedtimeMinute = null,Object? wakeHour = null,Object? wakeMinute = null,Object? lateThresholdMinutes = null,Object? dayStartHour = null,Object? dayStartMinute = null,Object? wakeTimeError = freezed,}) {
  return _then(_GoalScheduleFormState(
bedtimeHour: null == bedtimeHour ? _self.bedtimeHour : bedtimeHour // ignore: cast_nullable_to_non_nullable
as int,bedtimeMinute: null == bedtimeMinute ? _self.bedtimeMinute : bedtimeMinute // ignore: cast_nullable_to_non_nullable
as int,wakeHour: null == wakeHour ? _self.wakeHour : wakeHour // ignore: cast_nullable_to_non_nullable
as int,wakeMinute: null == wakeMinute ? _self.wakeMinute : wakeMinute // ignore: cast_nullable_to_non_nullable
as int,lateThresholdMinutes: null == lateThresholdMinutes ? _self.lateThresholdMinutes : lateThresholdMinutes // ignore: cast_nullable_to_non_nullable
as int,dayStartHour: null == dayStartHour ? _self.dayStartHour : dayStartHour // ignore: cast_nullable_to_non_nullable
as int,dayStartMinute: null == dayStartMinute ? _self.dayStartMinute : dayStartMinute // ignore: cast_nullable_to_non_nullable
as int,wakeTimeError: freezed == wakeTimeError ? _self.wakeTimeError : wakeTimeError // ignore: cast_nullable_to_non_nullable
as GoalScheduleValidationError?,
  ));
}


}

// dart format on
