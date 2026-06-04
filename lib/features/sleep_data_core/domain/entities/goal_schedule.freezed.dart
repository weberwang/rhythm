// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'goal_schedule.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$GoalSchedule {

 String get id; int get bedtimeMinutes; int get wakeTimeMinutes; DateTime get createdAt;
/// Create a copy of GoalSchedule
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GoalScheduleCopyWith<GoalSchedule> get copyWith => _$GoalScheduleCopyWithImpl<GoalSchedule>(this as GoalSchedule, _$identity);

  /// Serializes this GoalSchedule to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GoalSchedule&&(identical(other.id, id) || other.id == id)&&(identical(other.bedtimeMinutes, bedtimeMinutes) || other.bedtimeMinutes == bedtimeMinutes)&&(identical(other.wakeTimeMinutes, wakeTimeMinutes) || other.wakeTimeMinutes == wakeTimeMinutes)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,bedtimeMinutes,wakeTimeMinutes,createdAt);

@override
String toString() {
  return 'GoalSchedule(id: $id, bedtimeMinutes: $bedtimeMinutes, wakeTimeMinutes: $wakeTimeMinutes, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $GoalScheduleCopyWith<$Res>  {
  factory $GoalScheduleCopyWith(GoalSchedule value, $Res Function(GoalSchedule) _then) = _$GoalScheduleCopyWithImpl;
@useResult
$Res call({
 String id, int bedtimeMinutes, int wakeTimeMinutes, DateTime createdAt
});




}
/// @nodoc
class _$GoalScheduleCopyWithImpl<$Res>
    implements $GoalScheduleCopyWith<$Res> {
  _$GoalScheduleCopyWithImpl(this._self, this._then);

  final GoalSchedule _self;
  final $Res Function(GoalSchedule) _then;

/// Create a copy of GoalSchedule
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? bedtimeMinutes = null,Object? wakeTimeMinutes = null,Object? createdAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,bedtimeMinutes: null == bedtimeMinutes ? _self.bedtimeMinutes : bedtimeMinutes // ignore: cast_nullable_to_non_nullable
as int,wakeTimeMinutes: null == wakeTimeMinutes ? _self.wakeTimeMinutes : wakeTimeMinutes // ignore: cast_nullable_to_non_nullable
as int,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [GoalSchedule].
extension GoalSchedulePatterns on GoalSchedule {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GoalSchedule value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GoalSchedule() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GoalSchedule value)  $default,){
final _that = this;
switch (_that) {
case _GoalSchedule():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GoalSchedule value)?  $default,){
final _that = this;
switch (_that) {
case _GoalSchedule() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  int bedtimeMinutes,  int wakeTimeMinutes,  DateTime createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GoalSchedule() when $default != null:
return $default(_that.id,_that.bedtimeMinutes,_that.wakeTimeMinutes,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  int bedtimeMinutes,  int wakeTimeMinutes,  DateTime createdAt)  $default,) {final _that = this;
switch (_that) {
case _GoalSchedule():
return $default(_that.id,_that.bedtimeMinutes,_that.wakeTimeMinutes,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  int bedtimeMinutes,  int wakeTimeMinutes,  DateTime createdAt)?  $default,) {final _that = this;
switch (_that) {
case _GoalSchedule() when $default != null:
return $default(_that.id,_that.bedtimeMinutes,_that.wakeTimeMinutes,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _GoalSchedule implements GoalSchedule {
  const _GoalSchedule({required this.id, required this.bedtimeMinutes, required this.wakeTimeMinutes, required this.createdAt});
  factory _GoalSchedule.fromJson(Map<String, dynamic> json) => _$GoalScheduleFromJson(json);

@override final  String id;
@override final  int bedtimeMinutes;
@override final  int wakeTimeMinutes;
@override final  DateTime createdAt;

/// Create a copy of GoalSchedule
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GoalScheduleCopyWith<_GoalSchedule> get copyWith => __$GoalScheduleCopyWithImpl<_GoalSchedule>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$GoalScheduleToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GoalSchedule&&(identical(other.id, id) || other.id == id)&&(identical(other.bedtimeMinutes, bedtimeMinutes) || other.bedtimeMinutes == bedtimeMinutes)&&(identical(other.wakeTimeMinutes, wakeTimeMinutes) || other.wakeTimeMinutes == wakeTimeMinutes)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,bedtimeMinutes,wakeTimeMinutes,createdAt);

@override
String toString() {
  return 'GoalSchedule(id: $id, bedtimeMinutes: $bedtimeMinutes, wakeTimeMinutes: $wakeTimeMinutes, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$GoalScheduleCopyWith<$Res> implements $GoalScheduleCopyWith<$Res> {
  factory _$GoalScheduleCopyWith(_GoalSchedule value, $Res Function(_GoalSchedule) _then) = __$GoalScheduleCopyWithImpl;
@override @useResult
$Res call({
 String id, int bedtimeMinutes, int wakeTimeMinutes, DateTime createdAt
});




}
/// @nodoc
class __$GoalScheduleCopyWithImpl<$Res>
    implements _$GoalScheduleCopyWith<$Res> {
  __$GoalScheduleCopyWithImpl(this._self, this._then);

  final _GoalSchedule _self;
  final $Res Function(_GoalSchedule) _then;

/// Create a copy of GoalSchedule
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? bedtimeMinutes = null,Object? wakeTimeMinutes = null,Object? createdAt = null,}) {
  return _then(_GoalSchedule(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,bedtimeMinutes: null == bedtimeMinutes ? _self.bedtimeMinutes : bedtimeMinutes // ignore: cast_nullable_to_non_nullable
as int,wakeTimeMinutes: null == wakeTimeMinutes ? _self.wakeTimeMinutes : wakeTimeMinutes // ignore: cast_nullable_to_non_nullable
as int,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
