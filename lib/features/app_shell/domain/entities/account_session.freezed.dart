// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'account_session.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AppAccountSession {

 AppAccountSessionMode get mode; AppAccountProvider? get provider; String? get displayName; String? get email; DateTime get updatedAt;
/// Create a copy of AppAccountSession
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AppAccountSessionCopyWith<AppAccountSession> get copyWith => _$AppAccountSessionCopyWithImpl<AppAccountSession>(this as AppAccountSession, _$identity);

  /// Serializes this AppAccountSession to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AppAccountSession&&(identical(other.mode, mode) || other.mode == mode)&&(identical(other.provider, provider) || other.provider == provider)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.email, email) || other.email == email)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,mode,provider,displayName,email,updatedAt);

@override
String toString() {
  return 'AppAccountSession(mode: $mode, provider: $provider, displayName: $displayName, email: $email, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $AppAccountSessionCopyWith<$Res>  {
  factory $AppAccountSessionCopyWith(AppAccountSession value, $Res Function(AppAccountSession) _then) = _$AppAccountSessionCopyWithImpl;
@useResult
$Res call({
 AppAccountSessionMode mode, AppAccountProvider? provider, String? displayName, String? email, DateTime updatedAt
});




}
/// @nodoc
class _$AppAccountSessionCopyWithImpl<$Res>
    implements $AppAccountSessionCopyWith<$Res> {
  _$AppAccountSessionCopyWithImpl(this._self, this._then);

  final AppAccountSession _self;
  final $Res Function(AppAccountSession) _then;

/// Create a copy of AppAccountSession
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? mode = null,Object? provider = freezed,Object? displayName = freezed,Object? email = freezed,Object? updatedAt = null,}) {
  return _then(_self.copyWith(
mode: null == mode ? _self.mode : mode // ignore: cast_nullable_to_non_nullable
as AppAccountSessionMode,provider: freezed == provider ? _self.provider : provider // ignore: cast_nullable_to_non_nullable
as AppAccountProvider?,displayName: freezed == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String?,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [AppAccountSession].
extension AppAccountSessionPatterns on AppAccountSession {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AppAccountSession value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AppAccountSession() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AppAccountSession value)  $default,){
final _that = this;
switch (_that) {
case _AppAccountSession():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AppAccountSession value)?  $default,){
final _that = this;
switch (_that) {
case _AppAccountSession() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( AppAccountSessionMode mode,  AppAccountProvider? provider,  String? displayName,  String? email,  DateTime updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AppAccountSession() when $default != null:
return $default(_that.mode,_that.provider,_that.displayName,_that.email,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( AppAccountSessionMode mode,  AppAccountProvider? provider,  String? displayName,  String? email,  DateTime updatedAt)  $default,) {final _that = this;
switch (_that) {
case _AppAccountSession():
return $default(_that.mode,_that.provider,_that.displayName,_that.email,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( AppAccountSessionMode mode,  AppAccountProvider? provider,  String? displayName,  String? email,  DateTime updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _AppAccountSession() when $default != null:
return $default(_that.mode,_that.provider,_that.displayName,_that.email,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AppAccountSession implements AppAccountSession {
  const _AppAccountSession({required this.mode, this.provider, this.displayName, this.email, required this.updatedAt});
  factory _AppAccountSession.fromJson(Map<String, dynamic> json) => _$AppAccountSessionFromJson(json);

@override final  AppAccountSessionMode mode;
@override final  AppAccountProvider? provider;
@override final  String? displayName;
@override final  String? email;
@override final  DateTime updatedAt;

/// Create a copy of AppAccountSession
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AppAccountSessionCopyWith<_AppAccountSession> get copyWith => __$AppAccountSessionCopyWithImpl<_AppAccountSession>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AppAccountSessionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AppAccountSession&&(identical(other.mode, mode) || other.mode == mode)&&(identical(other.provider, provider) || other.provider == provider)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.email, email) || other.email == email)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,mode,provider,displayName,email,updatedAt);

@override
String toString() {
  return 'AppAccountSession(mode: $mode, provider: $provider, displayName: $displayName, email: $email, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$AppAccountSessionCopyWith<$Res> implements $AppAccountSessionCopyWith<$Res> {
  factory _$AppAccountSessionCopyWith(_AppAccountSession value, $Res Function(_AppAccountSession) _then) = __$AppAccountSessionCopyWithImpl;
@override @useResult
$Res call({
 AppAccountSessionMode mode, AppAccountProvider? provider, String? displayName, String? email, DateTime updatedAt
});




}
/// @nodoc
class __$AppAccountSessionCopyWithImpl<$Res>
    implements _$AppAccountSessionCopyWith<$Res> {
  __$AppAccountSessionCopyWithImpl(this._self, this._then);

  final _AppAccountSession _self;
  final $Res Function(_AppAccountSession) _then;

/// Create a copy of AppAccountSession
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? mode = null,Object? provider = freezed,Object? displayName = freezed,Object? email = freezed,Object? updatedAt = null,}) {
  return _then(_AppAccountSession(
mode: null == mode ? _self.mode : mode // ignore: cast_nullable_to_non_nullable
as AppAccountSessionMode,provider: freezed == provider ? _self.provider : provider // ignore: cast_nullable_to_non_nullable
as AppAccountProvider?,displayName: freezed == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String?,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
