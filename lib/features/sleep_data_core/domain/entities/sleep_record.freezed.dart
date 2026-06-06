// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sleep_record.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SleepRecord {

 String get id; DateTime get sleepDate; int get bedtimeMinutes; int get wakeTimeMinutes; SleepRecordSource get source; SleepRecordConfidence get confidence; bool get isManuallyAdjusted; String? get note; DateTime get createdAt;
/// Create a copy of SleepRecord
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SleepRecordCopyWith<SleepRecord> get copyWith => _$SleepRecordCopyWithImpl<SleepRecord>(this as SleepRecord, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SleepRecord&&(identical(other.id, id) || other.id == id)&&(identical(other.sleepDate, sleepDate) || other.sleepDate == sleepDate)&&(identical(other.bedtimeMinutes, bedtimeMinutes) || other.bedtimeMinutes == bedtimeMinutes)&&(identical(other.wakeTimeMinutes, wakeTimeMinutes) || other.wakeTimeMinutes == wakeTimeMinutes)&&(identical(other.source, source) || other.source == source)&&(identical(other.confidence, confidence) || other.confidence == confidence)&&(identical(other.isManuallyAdjusted, isManuallyAdjusted) || other.isManuallyAdjusted == isManuallyAdjusted)&&(identical(other.note, note) || other.note == note)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,sleepDate,bedtimeMinutes,wakeTimeMinutes,source,confidence,isManuallyAdjusted,note,createdAt);

@override
String toString() {
  return 'SleepRecord(id: $id, sleepDate: $sleepDate, bedtimeMinutes: $bedtimeMinutes, wakeTimeMinutes: $wakeTimeMinutes, source: $source, confidence: $confidence, isManuallyAdjusted: $isManuallyAdjusted, note: $note, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $SleepRecordCopyWith<$Res>  {
  factory $SleepRecordCopyWith(SleepRecord value, $Res Function(SleepRecord) _then) = _$SleepRecordCopyWithImpl;
@useResult
$Res call({
 String id, DateTime sleepDate, int bedtimeMinutes, int wakeTimeMinutes, SleepRecordSource source, SleepRecordConfidence confidence, bool isManuallyAdjusted, String? note, DateTime createdAt
});




}
/// @nodoc
class _$SleepRecordCopyWithImpl<$Res>
    implements $SleepRecordCopyWith<$Res> {
  _$SleepRecordCopyWithImpl(this._self, this._then);

  final SleepRecord _self;
  final $Res Function(SleepRecord) _then;

/// Create a copy of SleepRecord
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? sleepDate = null,Object? bedtimeMinutes = null,Object? wakeTimeMinutes = null,Object? source = null,Object? confidence = null,Object? isManuallyAdjusted = null,Object? note = freezed,Object? createdAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,sleepDate: null == sleepDate ? _self.sleepDate : sleepDate // ignore: cast_nullable_to_non_nullable
as DateTime,bedtimeMinutes: null == bedtimeMinutes ? _self.bedtimeMinutes : bedtimeMinutes // ignore: cast_nullable_to_non_nullable
as int,wakeTimeMinutes: null == wakeTimeMinutes ? _self.wakeTimeMinutes : wakeTimeMinutes // ignore: cast_nullable_to_non_nullable
as int,source: null == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as SleepRecordSource,confidence: null == confidence ? _self.confidence : confidence // ignore: cast_nullable_to_non_nullable
as SleepRecordConfidence,isManuallyAdjusted: null == isManuallyAdjusted ? _self.isManuallyAdjusted : isManuallyAdjusted // ignore: cast_nullable_to_non_nullable
as bool,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [SleepRecord].
extension SleepRecordPatterns on SleepRecord {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SleepRecord value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SleepRecord() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SleepRecord value)  $default,){
final _that = this;
switch (_that) {
case _SleepRecord():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SleepRecord value)?  $default,){
final _that = this;
switch (_that) {
case _SleepRecord() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  DateTime sleepDate,  int bedtimeMinutes,  int wakeTimeMinutes,  SleepRecordSource source,  SleepRecordConfidence confidence,  bool isManuallyAdjusted,  String? note,  DateTime createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SleepRecord() when $default != null:
return $default(_that.id,_that.sleepDate,_that.bedtimeMinutes,_that.wakeTimeMinutes,_that.source,_that.confidence,_that.isManuallyAdjusted,_that.note,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  DateTime sleepDate,  int bedtimeMinutes,  int wakeTimeMinutes,  SleepRecordSource source,  SleepRecordConfidence confidence,  bool isManuallyAdjusted,  String? note,  DateTime createdAt)  $default,) {final _that = this;
switch (_that) {
case _SleepRecord():
return $default(_that.id,_that.sleepDate,_that.bedtimeMinutes,_that.wakeTimeMinutes,_that.source,_that.confidence,_that.isManuallyAdjusted,_that.note,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  DateTime sleepDate,  int bedtimeMinutes,  int wakeTimeMinutes,  SleepRecordSource source,  SleepRecordConfidence confidence,  bool isManuallyAdjusted,  String? note,  DateTime createdAt)?  $default,) {final _that = this;
switch (_that) {
case _SleepRecord() when $default != null:
return $default(_that.id,_that.sleepDate,_that.bedtimeMinutes,_that.wakeTimeMinutes,_that.source,_that.confidence,_that.isManuallyAdjusted,_that.note,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc


class _SleepRecord implements SleepRecord {
  const _SleepRecord({required this.id, required this.sleepDate, required this.bedtimeMinutes, required this.wakeTimeMinutes, required this.source, required this.confidence, required this.isManuallyAdjusted, required this.note, required this.createdAt});
  

@override final  String id;
@override final  DateTime sleepDate;
@override final  int bedtimeMinutes;
@override final  int wakeTimeMinutes;
@override final  SleepRecordSource source;
@override final  SleepRecordConfidence confidence;
@override final  bool isManuallyAdjusted;
@override final  String? note;
@override final  DateTime createdAt;

/// Create a copy of SleepRecord
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SleepRecordCopyWith<_SleepRecord> get copyWith => __$SleepRecordCopyWithImpl<_SleepRecord>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SleepRecord&&(identical(other.id, id) || other.id == id)&&(identical(other.sleepDate, sleepDate) || other.sleepDate == sleepDate)&&(identical(other.bedtimeMinutes, bedtimeMinutes) || other.bedtimeMinutes == bedtimeMinutes)&&(identical(other.wakeTimeMinutes, wakeTimeMinutes) || other.wakeTimeMinutes == wakeTimeMinutes)&&(identical(other.source, source) || other.source == source)&&(identical(other.confidence, confidence) || other.confidence == confidence)&&(identical(other.isManuallyAdjusted, isManuallyAdjusted) || other.isManuallyAdjusted == isManuallyAdjusted)&&(identical(other.note, note) || other.note == note)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,sleepDate,bedtimeMinutes,wakeTimeMinutes,source,confidence,isManuallyAdjusted,note,createdAt);

@override
String toString() {
  return 'SleepRecord(id: $id, sleepDate: $sleepDate, bedtimeMinutes: $bedtimeMinutes, wakeTimeMinutes: $wakeTimeMinutes, source: $source, confidence: $confidence, isManuallyAdjusted: $isManuallyAdjusted, note: $note, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$SleepRecordCopyWith<$Res> implements $SleepRecordCopyWith<$Res> {
  factory _$SleepRecordCopyWith(_SleepRecord value, $Res Function(_SleepRecord) _then) = __$SleepRecordCopyWithImpl;
@override @useResult
$Res call({
 String id, DateTime sleepDate, int bedtimeMinutes, int wakeTimeMinutes, SleepRecordSource source, SleepRecordConfidence confidence, bool isManuallyAdjusted, String? note, DateTime createdAt
});




}
/// @nodoc
class __$SleepRecordCopyWithImpl<$Res>
    implements _$SleepRecordCopyWith<$Res> {
  __$SleepRecordCopyWithImpl(this._self, this._then);

  final _SleepRecord _self;
  final $Res Function(_SleepRecord) _then;

/// Create a copy of SleepRecord
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? sleepDate = null,Object? bedtimeMinutes = null,Object? wakeTimeMinutes = null,Object? source = null,Object? confidence = null,Object? isManuallyAdjusted = null,Object? note = freezed,Object? createdAt = null,}) {
  return _then(_SleepRecord(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,sleepDate: null == sleepDate ? _self.sleepDate : sleepDate // ignore: cast_nullable_to_non_nullable
as DateTime,bedtimeMinutes: null == bedtimeMinutes ? _self.bedtimeMinutes : bedtimeMinutes // ignore: cast_nullable_to_non_nullable
as int,wakeTimeMinutes: null == wakeTimeMinutes ? _self.wakeTimeMinutes : wakeTimeMinutes // ignore: cast_nullable_to_non_nullable
as int,source: null == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as SleepRecordSource,confidence: null == confidence ? _self.confidence : confidence // ignore: cast_nullable_to_non_nullable
as SleepRecordConfidence,isManuallyAdjusted: null == isManuallyAdjusted ? _self.isManuallyAdjusted : isManuallyAdjusted // ignore: cast_nullable_to_non_nullable
as bool,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
