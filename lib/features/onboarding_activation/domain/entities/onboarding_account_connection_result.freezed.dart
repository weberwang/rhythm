// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'onboarding_account_connection_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$OnboardingAccountConnectionResult {

 OnboardingAccountProvider get provider; OnboardingAccountConnectionStatus get status; String? get displayName; String? get email;
/// Create a copy of OnboardingAccountConnectionResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OnboardingAccountConnectionResultCopyWith<OnboardingAccountConnectionResult> get copyWith => _$OnboardingAccountConnectionResultCopyWithImpl<OnboardingAccountConnectionResult>(this as OnboardingAccountConnectionResult, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OnboardingAccountConnectionResult&&(identical(other.provider, provider) || other.provider == provider)&&(identical(other.status, status) || other.status == status)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.email, email) || other.email == email));
}


@override
int get hashCode => Object.hash(runtimeType,provider,status,displayName,email);

@override
String toString() {
  return 'OnboardingAccountConnectionResult(provider: $provider, status: $status, displayName: $displayName, email: $email)';
}


}

/// @nodoc
abstract mixin class $OnboardingAccountConnectionResultCopyWith<$Res>  {
  factory $OnboardingAccountConnectionResultCopyWith(OnboardingAccountConnectionResult value, $Res Function(OnboardingAccountConnectionResult) _then) = _$OnboardingAccountConnectionResultCopyWithImpl;
@useResult
$Res call({
 OnboardingAccountProvider provider, OnboardingAccountConnectionStatus status, String? displayName, String? email
});




}
/// @nodoc
class _$OnboardingAccountConnectionResultCopyWithImpl<$Res>
    implements $OnboardingAccountConnectionResultCopyWith<$Res> {
  _$OnboardingAccountConnectionResultCopyWithImpl(this._self, this._then);

  final OnboardingAccountConnectionResult _self;
  final $Res Function(OnboardingAccountConnectionResult) _then;

/// Create a copy of OnboardingAccountConnectionResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? provider = null,Object? status = null,Object? displayName = freezed,Object? email = freezed,}) {
  return _then(_self.copyWith(
provider: null == provider ? _self.provider : provider // ignore: cast_nullable_to_non_nullable
as OnboardingAccountProvider,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as OnboardingAccountConnectionStatus,displayName: freezed == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String?,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [OnboardingAccountConnectionResult].
extension OnboardingAccountConnectionResultPatterns on OnboardingAccountConnectionResult {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OnboardingAccountConnectionResult value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OnboardingAccountConnectionResult() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OnboardingAccountConnectionResult value)  $default,){
final _that = this;
switch (_that) {
case _OnboardingAccountConnectionResult():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OnboardingAccountConnectionResult value)?  $default,){
final _that = this;
switch (_that) {
case _OnboardingAccountConnectionResult() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( OnboardingAccountProvider provider,  OnboardingAccountConnectionStatus status,  String? displayName,  String? email)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OnboardingAccountConnectionResult() when $default != null:
return $default(_that.provider,_that.status,_that.displayName,_that.email);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( OnboardingAccountProvider provider,  OnboardingAccountConnectionStatus status,  String? displayName,  String? email)  $default,) {final _that = this;
switch (_that) {
case _OnboardingAccountConnectionResult():
return $default(_that.provider,_that.status,_that.displayName,_that.email);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( OnboardingAccountProvider provider,  OnboardingAccountConnectionStatus status,  String? displayName,  String? email)?  $default,) {final _that = this;
switch (_that) {
case _OnboardingAccountConnectionResult() when $default != null:
return $default(_that.provider,_that.status,_that.displayName,_that.email);case _:
  return null;

}
}

}

/// @nodoc


class _OnboardingAccountConnectionResult implements OnboardingAccountConnectionResult {
  const _OnboardingAccountConnectionResult({required this.provider, required this.status, this.displayName, this.email});
  

@override final  OnboardingAccountProvider provider;
@override final  OnboardingAccountConnectionStatus status;
@override final  String? displayName;
@override final  String? email;

/// Create a copy of OnboardingAccountConnectionResult
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OnboardingAccountConnectionResultCopyWith<_OnboardingAccountConnectionResult> get copyWith => __$OnboardingAccountConnectionResultCopyWithImpl<_OnboardingAccountConnectionResult>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OnboardingAccountConnectionResult&&(identical(other.provider, provider) || other.provider == provider)&&(identical(other.status, status) || other.status == status)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.email, email) || other.email == email));
}


@override
int get hashCode => Object.hash(runtimeType,provider,status,displayName,email);

@override
String toString() {
  return 'OnboardingAccountConnectionResult(provider: $provider, status: $status, displayName: $displayName, email: $email)';
}


}

/// @nodoc
abstract mixin class _$OnboardingAccountConnectionResultCopyWith<$Res> implements $OnboardingAccountConnectionResultCopyWith<$Res> {
  factory _$OnboardingAccountConnectionResultCopyWith(_OnboardingAccountConnectionResult value, $Res Function(_OnboardingAccountConnectionResult) _then) = __$OnboardingAccountConnectionResultCopyWithImpl;
@override @useResult
$Res call({
 OnboardingAccountProvider provider, OnboardingAccountConnectionStatus status, String? displayName, String? email
});




}
/// @nodoc
class __$OnboardingAccountConnectionResultCopyWithImpl<$Res>
    implements _$OnboardingAccountConnectionResultCopyWith<$Res> {
  __$OnboardingAccountConnectionResultCopyWithImpl(this._self, this._then);

  final _OnboardingAccountConnectionResult _self;
  final $Res Function(_OnboardingAccountConnectionResult) _then;

/// Create a copy of OnboardingAccountConnectionResult
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? provider = null,Object? status = null,Object? displayName = freezed,Object? email = freezed,}) {
  return _then(_OnboardingAccountConnectionResult(
provider: null == provider ? _self.provider : provider // ignore: cast_nullable_to_non_nullable
as OnboardingAccountProvider,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as OnboardingAccountConnectionStatus,displayName: freezed == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String?,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
