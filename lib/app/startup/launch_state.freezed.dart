// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'launch_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$LaunchSnapshot {

 LaunchDestination get destination; EntryIntent get entryIntent;
/// Create a copy of LaunchSnapshot
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LaunchSnapshotCopyWith<LaunchSnapshot> get copyWith => _$LaunchSnapshotCopyWithImpl<LaunchSnapshot>(this as LaunchSnapshot, _$identity);

  /// Serializes this LaunchSnapshot to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LaunchSnapshot&&(identical(other.destination, destination) || other.destination == destination)&&(identical(other.entryIntent, entryIntent) || other.entryIntent == entryIntent));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,destination,entryIntent);

@override
String toString() {
  return 'LaunchSnapshot(destination: $destination, entryIntent: $entryIntent)';
}


}

/// @nodoc
abstract mixin class $LaunchSnapshotCopyWith<$Res>  {
  factory $LaunchSnapshotCopyWith(LaunchSnapshot value, $Res Function(LaunchSnapshot) _then) = _$LaunchSnapshotCopyWithImpl;
@useResult
$Res call({
 LaunchDestination destination, EntryIntent entryIntent
});


$EntryIntentCopyWith<$Res> get entryIntent;

}
/// @nodoc
class _$LaunchSnapshotCopyWithImpl<$Res>
    implements $LaunchSnapshotCopyWith<$Res> {
  _$LaunchSnapshotCopyWithImpl(this._self, this._then);

  final LaunchSnapshot _self;
  final $Res Function(LaunchSnapshot) _then;

/// Create a copy of LaunchSnapshot
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? destination = null,Object? entryIntent = null,}) {
  return _then(_self.copyWith(
destination: null == destination ? _self.destination : destination // ignore: cast_nullable_to_non_nullable
as LaunchDestination,entryIntent: null == entryIntent ? _self.entryIntent : entryIntent // ignore: cast_nullable_to_non_nullable
as EntryIntent,
  ));
}
/// Create a copy of LaunchSnapshot
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EntryIntentCopyWith<$Res> get entryIntent {
  
  return $EntryIntentCopyWith<$Res>(_self.entryIntent, (value) {
    return _then(_self.copyWith(entryIntent: value));
  });
}
}


/// Adds pattern-matching-related methods to [LaunchSnapshot].
extension LaunchSnapshotPatterns on LaunchSnapshot {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LaunchSnapshot value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LaunchSnapshot() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LaunchSnapshot value)  $default,){
final _that = this;
switch (_that) {
case _LaunchSnapshot():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LaunchSnapshot value)?  $default,){
final _that = this;
switch (_that) {
case _LaunchSnapshot() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( LaunchDestination destination,  EntryIntent entryIntent)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LaunchSnapshot() when $default != null:
return $default(_that.destination,_that.entryIntent);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( LaunchDestination destination,  EntryIntent entryIntent)  $default,) {final _that = this;
switch (_that) {
case _LaunchSnapshot():
return $default(_that.destination,_that.entryIntent);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( LaunchDestination destination,  EntryIntent entryIntent)?  $default,) {final _that = this;
switch (_that) {
case _LaunchSnapshot() when $default != null:
return $default(_that.destination,_that.entryIntent);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LaunchSnapshot implements LaunchSnapshot {
  const _LaunchSnapshot({required this.destination, required this.entryIntent});
  factory _LaunchSnapshot.fromJson(Map<String, dynamic> json) => _$LaunchSnapshotFromJson(json);

@override final  LaunchDestination destination;
@override final  EntryIntent entryIntent;

/// Create a copy of LaunchSnapshot
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LaunchSnapshotCopyWith<_LaunchSnapshot> get copyWith => __$LaunchSnapshotCopyWithImpl<_LaunchSnapshot>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LaunchSnapshotToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LaunchSnapshot&&(identical(other.destination, destination) || other.destination == destination)&&(identical(other.entryIntent, entryIntent) || other.entryIntent == entryIntent));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,destination,entryIntent);

@override
String toString() {
  return 'LaunchSnapshot(destination: $destination, entryIntent: $entryIntent)';
}


}

/// @nodoc
abstract mixin class _$LaunchSnapshotCopyWith<$Res> implements $LaunchSnapshotCopyWith<$Res> {
  factory _$LaunchSnapshotCopyWith(_LaunchSnapshot value, $Res Function(_LaunchSnapshot) _then) = __$LaunchSnapshotCopyWithImpl;
@override @useResult
$Res call({
 LaunchDestination destination, EntryIntent entryIntent
});


@override $EntryIntentCopyWith<$Res> get entryIntent;

}
/// @nodoc
class __$LaunchSnapshotCopyWithImpl<$Res>
    implements _$LaunchSnapshotCopyWith<$Res> {
  __$LaunchSnapshotCopyWithImpl(this._self, this._then);

  final _LaunchSnapshot _self;
  final $Res Function(_LaunchSnapshot) _then;

/// Create a copy of LaunchSnapshot
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? destination = null,Object? entryIntent = null,}) {
  return _then(_LaunchSnapshot(
destination: null == destination ? _self.destination : destination // ignore: cast_nullable_to_non_nullable
as LaunchDestination,entryIntent: null == entryIntent ? _self.entryIntent : entryIntent // ignore: cast_nullable_to_non_nullable
as EntryIntent,
  ));
}

/// Create a copy of LaunchSnapshot
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EntryIntentCopyWith<$Res> get entryIntent {
  
  return $EntryIntentCopyWith<$Res>(_self.entryIntent, (value) {
    return _then(_self.copyWith(entryIntent: value));
  });
}
}

// dart format on
