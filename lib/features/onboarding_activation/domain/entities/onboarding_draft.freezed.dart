// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'onboarding_draft.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$OnboardingDraft {

 OnboardingStep get step; int get bedtimeMinutes; int get wakeTimeMinutes; OnboardingEntryMode? get entryMode; OnboardingReminderStrategy? get reminderStrategy;
/// Create a copy of OnboardingDraft
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OnboardingDraftCopyWith<OnboardingDraft> get copyWith => _$OnboardingDraftCopyWithImpl<OnboardingDraft>(this as OnboardingDraft, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OnboardingDraft&&(identical(other.step, step) || other.step == step)&&(identical(other.bedtimeMinutes, bedtimeMinutes) || other.bedtimeMinutes == bedtimeMinutes)&&(identical(other.wakeTimeMinutes, wakeTimeMinutes) || other.wakeTimeMinutes == wakeTimeMinutes)&&(identical(other.entryMode, entryMode) || other.entryMode == entryMode)&&(identical(other.reminderStrategy, reminderStrategy) || other.reminderStrategy == reminderStrategy));
}


@override
int get hashCode => Object.hash(runtimeType,step,bedtimeMinutes,wakeTimeMinutes,entryMode,reminderStrategy);

@override
String toString() {
  return 'OnboardingDraft(step: $step, bedtimeMinutes: $bedtimeMinutes, wakeTimeMinutes: $wakeTimeMinutes, entryMode: $entryMode, reminderStrategy: $reminderStrategy)';
}


}

/// @nodoc
abstract mixin class $OnboardingDraftCopyWith<$Res>  {
  factory $OnboardingDraftCopyWith(OnboardingDraft value, $Res Function(OnboardingDraft) _then) = _$OnboardingDraftCopyWithImpl;
@useResult
$Res call({
 OnboardingStep step, int bedtimeMinutes, int wakeTimeMinutes, OnboardingEntryMode? entryMode, OnboardingReminderStrategy? reminderStrategy
});




}
/// @nodoc
class _$OnboardingDraftCopyWithImpl<$Res>
    implements $OnboardingDraftCopyWith<$Res> {
  _$OnboardingDraftCopyWithImpl(this._self, this._then);

  final OnboardingDraft _self;
  final $Res Function(OnboardingDraft) _then;

/// Create a copy of OnboardingDraft
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? step = null,Object? bedtimeMinutes = null,Object? wakeTimeMinutes = null,Object? entryMode = freezed,Object? reminderStrategy = freezed,}) {
  return _then(_self.copyWith(
step: null == step ? _self.step : step // ignore: cast_nullable_to_non_nullable
as OnboardingStep,bedtimeMinutes: null == bedtimeMinutes ? _self.bedtimeMinutes : bedtimeMinutes // ignore: cast_nullable_to_non_nullable
as int,wakeTimeMinutes: null == wakeTimeMinutes ? _self.wakeTimeMinutes : wakeTimeMinutes // ignore: cast_nullable_to_non_nullable
as int,entryMode: freezed == entryMode ? _self.entryMode : entryMode // ignore: cast_nullable_to_non_nullable
as OnboardingEntryMode?,reminderStrategy: freezed == reminderStrategy ? _self.reminderStrategy : reminderStrategy // ignore: cast_nullable_to_non_nullable
as OnboardingReminderStrategy?,
  ));
}

}


/// Adds pattern-matching-related methods to [OnboardingDraft].
extension OnboardingDraftPatterns on OnboardingDraft {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OnboardingDraft value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OnboardingDraft() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OnboardingDraft value)  $default,){
final _that = this;
switch (_that) {
case _OnboardingDraft():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OnboardingDraft value)?  $default,){
final _that = this;
switch (_that) {
case _OnboardingDraft() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( OnboardingStep step,  int bedtimeMinutes,  int wakeTimeMinutes,  OnboardingEntryMode? entryMode,  OnboardingReminderStrategy? reminderStrategy)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OnboardingDraft() when $default != null:
return $default(_that.step,_that.bedtimeMinutes,_that.wakeTimeMinutes,_that.entryMode,_that.reminderStrategy);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( OnboardingStep step,  int bedtimeMinutes,  int wakeTimeMinutes,  OnboardingEntryMode? entryMode,  OnboardingReminderStrategy? reminderStrategy)  $default,) {final _that = this;
switch (_that) {
case _OnboardingDraft():
return $default(_that.step,_that.bedtimeMinutes,_that.wakeTimeMinutes,_that.entryMode,_that.reminderStrategy);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( OnboardingStep step,  int bedtimeMinutes,  int wakeTimeMinutes,  OnboardingEntryMode? entryMode,  OnboardingReminderStrategy? reminderStrategy)?  $default,) {final _that = this;
switch (_that) {
case _OnboardingDraft() when $default != null:
return $default(_that.step,_that.bedtimeMinutes,_that.wakeTimeMinutes,_that.entryMode,_that.reminderStrategy);case _:
  return null;

}
}

}

/// @nodoc


class _OnboardingDraft implements OnboardingDraft {
  const _OnboardingDraft({required this.step, required this.bedtimeMinutes, required this.wakeTimeMinutes, this.entryMode, this.reminderStrategy});
  

@override final  OnboardingStep step;
@override final  int bedtimeMinutes;
@override final  int wakeTimeMinutes;
@override final  OnboardingEntryMode? entryMode;
@override final  OnboardingReminderStrategy? reminderStrategy;

/// Create a copy of OnboardingDraft
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OnboardingDraftCopyWith<_OnboardingDraft> get copyWith => __$OnboardingDraftCopyWithImpl<_OnboardingDraft>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OnboardingDraft&&(identical(other.step, step) || other.step == step)&&(identical(other.bedtimeMinutes, bedtimeMinutes) || other.bedtimeMinutes == bedtimeMinutes)&&(identical(other.wakeTimeMinutes, wakeTimeMinutes) || other.wakeTimeMinutes == wakeTimeMinutes)&&(identical(other.entryMode, entryMode) || other.entryMode == entryMode)&&(identical(other.reminderStrategy, reminderStrategy) || other.reminderStrategy == reminderStrategy));
}


@override
int get hashCode => Object.hash(runtimeType,step,bedtimeMinutes,wakeTimeMinutes,entryMode,reminderStrategy);

@override
String toString() {
  return 'OnboardingDraft(step: $step, bedtimeMinutes: $bedtimeMinutes, wakeTimeMinutes: $wakeTimeMinutes, entryMode: $entryMode, reminderStrategy: $reminderStrategy)';
}


}

/// @nodoc
abstract mixin class _$OnboardingDraftCopyWith<$Res> implements $OnboardingDraftCopyWith<$Res> {
  factory _$OnboardingDraftCopyWith(_OnboardingDraft value, $Res Function(_OnboardingDraft) _then) = __$OnboardingDraftCopyWithImpl;
@override @useResult
$Res call({
 OnboardingStep step, int bedtimeMinutes, int wakeTimeMinutes, OnboardingEntryMode? entryMode, OnboardingReminderStrategy? reminderStrategy
});




}
/// @nodoc
class __$OnboardingDraftCopyWithImpl<$Res>
    implements _$OnboardingDraftCopyWith<$Res> {
  __$OnboardingDraftCopyWithImpl(this._self, this._then);

  final _OnboardingDraft _self;
  final $Res Function(_OnboardingDraft) _then;

/// Create a copy of OnboardingDraft
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? step = null,Object? bedtimeMinutes = null,Object? wakeTimeMinutes = null,Object? entryMode = freezed,Object? reminderStrategy = freezed,}) {
  return _then(_OnboardingDraft(
step: null == step ? _self.step : step // ignore: cast_nullable_to_non_nullable
as OnboardingStep,bedtimeMinutes: null == bedtimeMinutes ? _self.bedtimeMinutes : bedtimeMinutes // ignore: cast_nullable_to_non_nullable
as int,wakeTimeMinutes: null == wakeTimeMinutes ? _self.wakeTimeMinutes : wakeTimeMinutes // ignore: cast_nullable_to_non_nullable
as int,entryMode: freezed == entryMode ? _self.entryMode : entryMode // ignore: cast_nullable_to_non_nullable
as OnboardingEntryMode?,reminderStrategy: freezed == reminderStrategy ? _self.reminderStrategy : reminderStrategy // ignore: cast_nullable_to_non_nullable
as OnboardingReminderStrategy?,
  ));
}


}

// dart format on
