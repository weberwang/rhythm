// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sleep_data_core_status.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SleepDataCoreStatus {

 SleepSourceConfidence get sourceConfidence; SleepSyncStatus get syncStatus; SleepTimezoneContext get timezoneContext;
/// Create a copy of SleepDataCoreStatus
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SleepDataCoreStatusCopyWith<SleepDataCoreStatus> get copyWith => _$SleepDataCoreStatusCopyWithImpl<SleepDataCoreStatus>(this as SleepDataCoreStatus, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SleepDataCoreStatus&&(identical(other.sourceConfidence, sourceConfidence) || other.sourceConfidence == sourceConfidence)&&(identical(other.syncStatus, syncStatus) || other.syncStatus == syncStatus)&&(identical(other.timezoneContext, timezoneContext) || other.timezoneContext == timezoneContext));
}


@override
int get hashCode => Object.hash(runtimeType,sourceConfidence,syncStatus,timezoneContext);

@override
String toString() {
  return 'SleepDataCoreStatus(sourceConfidence: $sourceConfidence, syncStatus: $syncStatus, timezoneContext: $timezoneContext)';
}


}

/// @nodoc
abstract mixin class $SleepDataCoreStatusCopyWith<$Res>  {
  factory $SleepDataCoreStatusCopyWith(SleepDataCoreStatus value, $Res Function(SleepDataCoreStatus) _then) = _$SleepDataCoreStatusCopyWithImpl;
@useResult
$Res call({
 SleepSourceConfidence sourceConfidence, SleepSyncStatus syncStatus, SleepTimezoneContext timezoneContext
});




}
/// @nodoc
class _$SleepDataCoreStatusCopyWithImpl<$Res>
    implements $SleepDataCoreStatusCopyWith<$Res> {
  _$SleepDataCoreStatusCopyWithImpl(this._self, this._then);

  final SleepDataCoreStatus _self;
  final $Res Function(SleepDataCoreStatus) _then;

/// Create a copy of SleepDataCoreStatus
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? sourceConfidence = null,Object? syncStatus = null,Object? timezoneContext = null,}) {
  return _then(_self.copyWith(
sourceConfidence: null == sourceConfidence ? _self.sourceConfidence : sourceConfidence // ignore: cast_nullable_to_non_nullable
as SleepSourceConfidence,syncStatus: null == syncStatus ? _self.syncStatus : syncStatus // ignore: cast_nullable_to_non_nullable
as SleepSyncStatus,timezoneContext: null == timezoneContext ? _self.timezoneContext : timezoneContext // ignore: cast_nullable_to_non_nullable
as SleepTimezoneContext,
  ));
}

}


/// Adds pattern-matching-related methods to [SleepDataCoreStatus].
extension SleepDataCoreStatusPatterns on SleepDataCoreStatus {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SleepDataCoreStatus value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SleepDataCoreStatus() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SleepDataCoreStatus value)  $default,){
final _that = this;
switch (_that) {
case _SleepDataCoreStatus():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SleepDataCoreStatus value)?  $default,){
final _that = this;
switch (_that) {
case _SleepDataCoreStatus() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( SleepSourceConfidence sourceConfidence,  SleepSyncStatus syncStatus,  SleepTimezoneContext timezoneContext)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SleepDataCoreStatus() when $default != null:
return $default(_that.sourceConfidence,_that.syncStatus,_that.timezoneContext);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( SleepSourceConfidence sourceConfidence,  SleepSyncStatus syncStatus,  SleepTimezoneContext timezoneContext)  $default,) {final _that = this;
switch (_that) {
case _SleepDataCoreStatus():
return $default(_that.sourceConfidence,_that.syncStatus,_that.timezoneContext);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( SleepSourceConfidence sourceConfidence,  SleepSyncStatus syncStatus,  SleepTimezoneContext timezoneContext)?  $default,) {final _that = this;
switch (_that) {
case _SleepDataCoreStatus() when $default != null:
return $default(_that.sourceConfidence,_that.syncStatus,_that.timezoneContext);case _:
  return null;

}
}

}

/// @nodoc


class _SleepDataCoreStatus implements SleepDataCoreStatus {
  const _SleepDataCoreStatus({required this.sourceConfidence, required this.syncStatus, required this.timezoneContext});
  

@override final  SleepSourceConfidence sourceConfidence;
@override final  SleepSyncStatus syncStatus;
@override final  SleepTimezoneContext timezoneContext;

/// Create a copy of SleepDataCoreStatus
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SleepDataCoreStatusCopyWith<_SleepDataCoreStatus> get copyWith => __$SleepDataCoreStatusCopyWithImpl<_SleepDataCoreStatus>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SleepDataCoreStatus&&(identical(other.sourceConfidence, sourceConfidence) || other.sourceConfidence == sourceConfidence)&&(identical(other.syncStatus, syncStatus) || other.syncStatus == syncStatus)&&(identical(other.timezoneContext, timezoneContext) || other.timezoneContext == timezoneContext));
}


@override
int get hashCode => Object.hash(runtimeType,sourceConfidence,syncStatus,timezoneContext);

@override
String toString() {
  return 'SleepDataCoreStatus(sourceConfidence: $sourceConfidence, syncStatus: $syncStatus, timezoneContext: $timezoneContext)';
}


}

/// @nodoc
abstract mixin class _$SleepDataCoreStatusCopyWith<$Res> implements $SleepDataCoreStatusCopyWith<$Res> {
  factory _$SleepDataCoreStatusCopyWith(_SleepDataCoreStatus value, $Res Function(_SleepDataCoreStatus) _then) = __$SleepDataCoreStatusCopyWithImpl;
@override @useResult
$Res call({
 SleepSourceConfidence sourceConfidence, SleepSyncStatus syncStatus, SleepTimezoneContext timezoneContext
});




}
/// @nodoc
class __$SleepDataCoreStatusCopyWithImpl<$Res>
    implements _$SleepDataCoreStatusCopyWith<$Res> {
  __$SleepDataCoreStatusCopyWithImpl(this._self, this._then);

  final _SleepDataCoreStatus _self;
  final $Res Function(_SleepDataCoreStatus) _then;

/// Create a copy of SleepDataCoreStatus
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? sourceConfidence = null,Object? syncStatus = null,Object? timezoneContext = null,}) {
  return _then(_SleepDataCoreStatus(
sourceConfidence: null == sourceConfidence ? _self.sourceConfidence : sourceConfidence // ignore: cast_nullable_to_non_nullable
as SleepSourceConfidence,syncStatus: null == syncStatus ? _self.syncStatus : syncStatus // ignore: cast_nullable_to_non_nullable
as SleepSyncStatus,timezoneContext: null == timezoneContext ? _self.timezoneContext : timezoneContext // ignore: cast_nullable_to_non_nullable
as SleepTimezoneContext,
  ));
}


}

// dart format on
