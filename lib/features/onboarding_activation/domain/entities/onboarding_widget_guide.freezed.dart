// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'onboarding_widget_guide.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$OnboardingWidgetGuide {

 OnboardingWidgetGuideSupport get support; int get installedWidgetCount; bool get canRequestPin;
/// Create a copy of OnboardingWidgetGuide
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OnboardingWidgetGuideCopyWith<OnboardingWidgetGuide> get copyWith => _$OnboardingWidgetGuideCopyWithImpl<OnboardingWidgetGuide>(this as OnboardingWidgetGuide, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OnboardingWidgetGuide&&(identical(other.support, support) || other.support == support)&&(identical(other.installedWidgetCount, installedWidgetCount) || other.installedWidgetCount == installedWidgetCount)&&(identical(other.canRequestPin, canRequestPin) || other.canRequestPin == canRequestPin));
}


@override
int get hashCode => Object.hash(runtimeType,support,installedWidgetCount,canRequestPin);

@override
String toString() {
  return 'OnboardingWidgetGuide(support: $support, installedWidgetCount: $installedWidgetCount, canRequestPin: $canRequestPin)';
}


}

/// @nodoc
abstract mixin class $OnboardingWidgetGuideCopyWith<$Res>  {
  factory $OnboardingWidgetGuideCopyWith(OnboardingWidgetGuide value, $Res Function(OnboardingWidgetGuide) _then) = _$OnboardingWidgetGuideCopyWithImpl;
@useResult
$Res call({
 OnboardingWidgetGuideSupport support, int installedWidgetCount, bool canRequestPin
});




}
/// @nodoc
class _$OnboardingWidgetGuideCopyWithImpl<$Res>
    implements $OnboardingWidgetGuideCopyWith<$Res> {
  _$OnboardingWidgetGuideCopyWithImpl(this._self, this._then);

  final OnboardingWidgetGuide _self;
  final $Res Function(OnboardingWidgetGuide) _then;

/// Create a copy of OnboardingWidgetGuide
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? support = null,Object? installedWidgetCount = null,Object? canRequestPin = null,}) {
  return _then(_self.copyWith(
support: null == support ? _self.support : support // ignore: cast_nullable_to_non_nullable
as OnboardingWidgetGuideSupport,installedWidgetCount: null == installedWidgetCount ? _self.installedWidgetCount : installedWidgetCount // ignore: cast_nullable_to_non_nullable
as int,canRequestPin: null == canRequestPin ? _self.canRequestPin : canRequestPin // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [OnboardingWidgetGuide].
extension OnboardingWidgetGuidePatterns on OnboardingWidgetGuide {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OnboardingWidgetGuide value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OnboardingWidgetGuide() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OnboardingWidgetGuide value)  $default,){
final _that = this;
switch (_that) {
case _OnboardingWidgetGuide():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OnboardingWidgetGuide value)?  $default,){
final _that = this;
switch (_that) {
case _OnboardingWidgetGuide() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( OnboardingWidgetGuideSupport support,  int installedWidgetCount,  bool canRequestPin)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OnboardingWidgetGuide() when $default != null:
return $default(_that.support,_that.installedWidgetCount,_that.canRequestPin);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( OnboardingWidgetGuideSupport support,  int installedWidgetCount,  bool canRequestPin)  $default,) {final _that = this;
switch (_that) {
case _OnboardingWidgetGuide():
return $default(_that.support,_that.installedWidgetCount,_that.canRequestPin);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( OnboardingWidgetGuideSupport support,  int installedWidgetCount,  bool canRequestPin)?  $default,) {final _that = this;
switch (_that) {
case _OnboardingWidgetGuide() when $default != null:
return $default(_that.support,_that.installedWidgetCount,_that.canRequestPin);case _:
  return null;

}
}

}

/// @nodoc


class _OnboardingWidgetGuide implements OnboardingWidgetGuide {
  const _OnboardingWidgetGuide({required this.support, required this.installedWidgetCount, required this.canRequestPin});
  

@override final  OnboardingWidgetGuideSupport support;
@override final  int installedWidgetCount;
@override final  bool canRequestPin;

/// Create a copy of OnboardingWidgetGuide
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OnboardingWidgetGuideCopyWith<_OnboardingWidgetGuide> get copyWith => __$OnboardingWidgetGuideCopyWithImpl<_OnboardingWidgetGuide>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OnboardingWidgetGuide&&(identical(other.support, support) || other.support == support)&&(identical(other.installedWidgetCount, installedWidgetCount) || other.installedWidgetCount == installedWidgetCount)&&(identical(other.canRequestPin, canRequestPin) || other.canRequestPin == canRequestPin));
}


@override
int get hashCode => Object.hash(runtimeType,support,installedWidgetCount,canRequestPin);

@override
String toString() {
  return 'OnboardingWidgetGuide(support: $support, installedWidgetCount: $installedWidgetCount, canRequestPin: $canRequestPin)';
}


}

/// @nodoc
abstract mixin class _$OnboardingWidgetGuideCopyWith<$Res> implements $OnboardingWidgetGuideCopyWith<$Res> {
  factory _$OnboardingWidgetGuideCopyWith(_OnboardingWidgetGuide value, $Res Function(_OnboardingWidgetGuide) _then) = __$OnboardingWidgetGuideCopyWithImpl;
@override @useResult
$Res call({
 OnboardingWidgetGuideSupport support, int installedWidgetCount, bool canRequestPin
});




}
/// @nodoc
class __$OnboardingWidgetGuideCopyWithImpl<$Res>
    implements _$OnboardingWidgetGuideCopyWith<$Res> {
  __$OnboardingWidgetGuideCopyWithImpl(this._self, this._then);

  final _OnboardingWidgetGuide _self;
  final $Res Function(_OnboardingWidgetGuide) _then;

/// Create a copy of OnboardingWidgetGuide
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? support = null,Object? installedWidgetCount = null,Object? canRequestPin = null,}) {
  return _then(_OnboardingWidgetGuide(
support: null == support ? _self.support : support // ignore: cast_nullable_to_non_nullable
as OnboardingWidgetGuideSupport,installedWidgetCount: null == installedWidgetCount ? _self.installedWidgetCount : installedWidgetCount // ignore: cast_nullable_to_non_nullable
as int,canRequestPin: null == canRequestPin ? _self.canRequestPin : canRequestPin // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
