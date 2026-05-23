// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'onboarding_flow_controller.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$OnboardingFlowState {

 OnboardingFlowStep get step; OnboardingDraft get draft;
/// Create a copy of OnboardingFlowState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OnboardingFlowStateCopyWith<OnboardingFlowState> get copyWith => _$OnboardingFlowStateCopyWithImpl<OnboardingFlowState>(this as OnboardingFlowState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OnboardingFlowState&&(identical(other.step, step) || other.step == step)&&(identical(other.draft, draft) || other.draft == draft));
}


@override
int get hashCode => Object.hash(runtimeType,step,draft);

@override
String toString() {
  return 'OnboardingFlowState(step: $step, draft: $draft)';
}


}

/// @nodoc
abstract mixin class $OnboardingFlowStateCopyWith<$Res>  {
  factory $OnboardingFlowStateCopyWith(OnboardingFlowState value, $Res Function(OnboardingFlowState) _then) = _$OnboardingFlowStateCopyWithImpl;
@useResult
$Res call({
 OnboardingFlowStep step, OnboardingDraft draft
});


$OnboardingDraftCopyWith<$Res> get draft;

}
/// @nodoc
class _$OnboardingFlowStateCopyWithImpl<$Res>
    implements $OnboardingFlowStateCopyWith<$Res> {
  _$OnboardingFlowStateCopyWithImpl(this._self, this._then);

  final OnboardingFlowState _self;
  final $Res Function(OnboardingFlowState) _then;

/// Create a copy of OnboardingFlowState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? step = null,Object? draft = null,}) {
  return _then(_self.copyWith(
step: null == step ? _self.step : step // ignore: cast_nullable_to_non_nullable
as OnboardingFlowStep,draft: null == draft ? _self.draft : draft // ignore: cast_nullable_to_non_nullable
as OnboardingDraft,
  ));
}
/// Create a copy of OnboardingFlowState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$OnboardingDraftCopyWith<$Res> get draft {
  
  return $OnboardingDraftCopyWith<$Res>(_self.draft, (value) {
    return _then(_self.copyWith(draft: value));
  });
}
}


/// Adds pattern-matching-related methods to [OnboardingFlowState].
extension OnboardingFlowStatePatterns on OnboardingFlowState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OnboardingFlowState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OnboardingFlowState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OnboardingFlowState value)  $default,){
final _that = this;
switch (_that) {
case _OnboardingFlowState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OnboardingFlowState value)?  $default,){
final _that = this;
switch (_that) {
case _OnboardingFlowState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( OnboardingFlowStep step,  OnboardingDraft draft)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OnboardingFlowState() when $default != null:
return $default(_that.step,_that.draft);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( OnboardingFlowStep step,  OnboardingDraft draft)  $default,) {final _that = this;
switch (_that) {
case _OnboardingFlowState():
return $default(_that.step,_that.draft);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( OnboardingFlowStep step,  OnboardingDraft draft)?  $default,) {final _that = this;
switch (_that) {
case _OnboardingFlowState() when $default != null:
return $default(_that.step,_that.draft);case _:
  return null;

}
}

}

/// @nodoc


class _OnboardingFlowState implements OnboardingFlowState {
  const _OnboardingFlowState({this.step = OnboardingFlowStep.welcome, this.draft = const OnboardingDraft()});
  

@override@JsonKey() final  OnboardingFlowStep step;
@override@JsonKey() final  OnboardingDraft draft;

/// Create a copy of OnboardingFlowState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OnboardingFlowStateCopyWith<_OnboardingFlowState> get copyWith => __$OnboardingFlowStateCopyWithImpl<_OnboardingFlowState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OnboardingFlowState&&(identical(other.step, step) || other.step == step)&&(identical(other.draft, draft) || other.draft == draft));
}


@override
int get hashCode => Object.hash(runtimeType,step,draft);

@override
String toString() {
  return 'OnboardingFlowState(step: $step, draft: $draft)';
}


}

/// @nodoc
abstract mixin class _$OnboardingFlowStateCopyWith<$Res> implements $OnboardingFlowStateCopyWith<$Res> {
  factory _$OnboardingFlowStateCopyWith(_OnboardingFlowState value, $Res Function(_OnboardingFlowState) _then) = __$OnboardingFlowStateCopyWithImpl;
@override @useResult
$Res call({
 OnboardingFlowStep step, OnboardingDraft draft
});


@override $OnboardingDraftCopyWith<$Res> get draft;

}
/// @nodoc
class __$OnboardingFlowStateCopyWithImpl<$Res>
    implements _$OnboardingFlowStateCopyWith<$Res> {
  __$OnboardingFlowStateCopyWithImpl(this._self, this._then);

  final _OnboardingFlowState _self;
  final $Res Function(_OnboardingFlowState) _then;

/// Create a copy of OnboardingFlowState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? step = null,Object? draft = null,}) {
  return _then(_OnboardingFlowState(
step: null == step ? _self.step : step // ignore: cast_nullable_to_non_nullable
as OnboardingFlowStep,draft: null == draft ? _self.draft : draft // ignore: cast_nullable_to_non_nullable
as OnboardingDraft,
  ));
}

/// Create a copy of OnboardingFlowState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$OnboardingDraftCopyWith<$Res> get draft {
  
  return $OnboardingDraftCopyWith<$Res>(_self.draft, (value) {
    return _then(_self.copyWith(draft: value));
  });
}
}

// dart format on
