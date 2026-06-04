// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_failure.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AppFailure {

 String get message;
/// Create a copy of AppFailure
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AppFailureCopyWith<AppFailure> get copyWith => _$AppFailureCopyWithImpl<AppFailure>(this as AppFailure, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AppFailure&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'AppFailure(message: $message)';
}


}

/// @nodoc
abstract mixin class $AppFailureCopyWith<$Res>  {
  factory $AppFailureCopyWith(AppFailure value, $Res Function(AppFailure) _then) = _$AppFailureCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$AppFailureCopyWithImpl<$Res>
    implements $AppFailureCopyWith<$Res> {
  _$AppFailureCopyWithImpl(this._self, this._then);

  final AppFailure _self;
  final $Res Function(AppFailure) _then;

/// Create a copy of AppFailure
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? message = null,}) {
  return _then(_self.copyWith(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [AppFailure].
extension AppFailurePatterns on AppFailure {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( UnknownAppFailure value)?  unknown,TResult Function( StorageAppFailure value)?  storage,TResult Function( NetworkAppFailure value)?  network,required TResult orElse(),}){
final _that = this;
switch (_that) {
case UnknownAppFailure() when unknown != null:
return unknown(_that);case StorageAppFailure() when storage != null:
return storage(_that);case NetworkAppFailure() when network != null:
return network(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( UnknownAppFailure value)  unknown,required TResult Function( StorageAppFailure value)  storage,required TResult Function( NetworkAppFailure value)  network,}){
final _that = this;
switch (_that) {
case UnknownAppFailure():
return unknown(_that);case StorageAppFailure():
return storage(_that);case NetworkAppFailure():
return network(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( UnknownAppFailure value)?  unknown,TResult? Function( StorageAppFailure value)?  storage,TResult? Function( NetworkAppFailure value)?  network,}){
final _that = this;
switch (_that) {
case UnknownAppFailure() when unknown != null:
return unknown(_that);case StorageAppFailure() when storage != null:
return storage(_that);case NetworkAppFailure() when network != null:
return network(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String message)?  unknown,TResult Function( String message)?  storage,TResult Function( String message)?  network,required TResult orElse(),}) {final _that = this;
switch (_that) {
case UnknownAppFailure() when unknown != null:
return unknown(_that.message);case StorageAppFailure() when storage != null:
return storage(_that.message);case NetworkAppFailure() when network != null:
return network(_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String message)  unknown,required TResult Function( String message)  storage,required TResult Function( String message)  network,}) {final _that = this;
switch (_that) {
case UnknownAppFailure():
return unknown(_that.message);case StorageAppFailure():
return storage(_that.message);case NetworkAppFailure():
return network(_that.message);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String message)?  unknown,TResult? Function( String message)?  storage,TResult? Function( String message)?  network,}) {final _that = this;
switch (_that) {
case UnknownAppFailure() when unknown != null:
return unknown(_that.message);case StorageAppFailure() when storage != null:
return storage(_that.message);case NetworkAppFailure() when network != null:
return network(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class UnknownAppFailure implements AppFailure {
  const UnknownAppFailure({required this.message});
  

@override final  String message;

/// Create a copy of AppFailure
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UnknownAppFailureCopyWith<UnknownAppFailure> get copyWith => _$UnknownAppFailureCopyWithImpl<UnknownAppFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UnknownAppFailure&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'AppFailure.unknown(message: $message)';
}


}

/// @nodoc
abstract mixin class $UnknownAppFailureCopyWith<$Res> implements $AppFailureCopyWith<$Res> {
  factory $UnknownAppFailureCopyWith(UnknownAppFailure value, $Res Function(UnknownAppFailure) _then) = _$UnknownAppFailureCopyWithImpl;
@override @useResult
$Res call({
 String message
});




}
/// @nodoc
class _$UnknownAppFailureCopyWithImpl<$Res>
    implements $UnknownAppFailureCopyWith<$Res> {
  _$UnknownAppFailureCopyWithImpl(this._self, this._then);

  final UnknownAppFailure _self;
  final $Res Function(UnknownAppFailure) _then;

/// Create a copy of AppFailure
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(UnknownAppFailure(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class StorageAppFailure implements AppFailure {
  const StorageAppFailure({required this.message});
  

@override final  String message;

/// Create a copy of AppFailure
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StorageAppFailureCopyWith<StorageAppFailure> get copyWith => _$StorageAppFailureCopyWithImpl<StorageAppFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StorageAppFailure&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'AppFailure.storage(message: $message)';
}


}

/// @nodoc
abstract mixin class $StorageAppFailureCopyWith<$Res> implements $AppFailureCopyWith<$Res> {
  factory $StorageAppFailureCopyWith(StorageAppFailure value, $Res Function(StorageAppFailure) _then) = _$StorageAppFailureCopyWithImpl;
@override @useResult
$Res call({
 String message
});




}
/// @nodoc
class _$StorageAppFailureCopyWithImpl<$Res>
    implements $StorageAppFailureCopyWith<$Res> {
  _$StorageAppFailureCopyWithImpl(this._self, this._then);

  final StorageAppFailure _self;
  final $Res Function(StorageAppFailure) _then;

/// Create a copy of AppFailure
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(StorageAppFailure(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class NetworkAppFailure implements AppFailure {
  const NetworkAppFailure({required this.message});
  

@override final  String message;

/// Create a copy of AppFailure
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NetworkAppFailureCopyWith<NetworkAppFailure> get copyWith => _$NetworkAppFailureCopyWithImpl<NetworkAppFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NetworkAppFailure&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'AppFailure.network(message: $message)';
}


}

/// @nodoc
abstract mixin class $NetworkAppFailureCopyWith<$Res> implements $AppFailureCopyWith<$Res> {
  factory $NetworkAppFailureCopyWith(NetworkAppFailure value, $Res Function(NetworkAppFailure) _then) = _$NetworkAppFailureCopyWithImpl;
@override @useResult
$Res call({
 String message
});




}
/// @nodoc
class _$NetworkAppFailureCopyWithImpl<$Res>
    implements $NetworkAppFailureCopyWith<$Res> {
  _$NetworkAppFailureCopyWithImpl(this._self, this._then);

  final NetworkAppFailure _self;
  final $Res Function(NetworkAppFailure) _then;

/// Create a copy of AppFailure
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(NetworkAppFailure(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
