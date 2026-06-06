// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'bedtime_session_record.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$BedtimeSessionRecord {

 DateTime get sessionDate; BedtimeStatusChoice? get selectedChoice; BedtimeEntrySource get entrySource; bool get isCompleted; DateTime get updatedAt;
/// Create a copy of BedtimeSessionRecord
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BedtimeSessionRecordCopyWith<BedtimeSessionRecord> get copyWith => _$BedtimeSessionRecordCopyWithImpl<BedtimeSessionRecord>(this as BedtimeSessionRecord, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BedtimeSessionRecord&&(identical(other.sessionDate, sessionDate) || other.sessionDate == sessionDate)&&(identical(other.selectedChoice, selectedChoice) || other.selectedChoice == selectedChoice)&&(identical(other.entrySource, entrySource) || other.entrySource == entrySource)&&(identical(other.isCompleted, isCompleted) || other.isCompleted == isCompleted)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}


@override
int get hashCode => Object.hash(runtimeType,sessionDate,selectedChoice,entrySource,isCompleted,updatedAt);

@override
String toString() {
  return 'BedtimeSessionRecord(sessionDate: $sessionDate, selectedChoice: $selectedChoice, entrySource: $entrySource, isCompleted: $isCompleted, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $BedtimeSessionRecordCopyWith<$Res>  {
  factory $BedtimeSessionRecordCopyWith(BedtimeSessionRecord value, $Res Function(BedtimeSessionRecord) _then) = _$BedtimeSessionRecordCopyWithImpl;
@useResult
$Res call({
 DateTime sessionDate, BedtimeStatusChoice? selectedChoice, BedtimeEntrySource entrySource, bool isCompleted, DateTime updatedAt
});




}
/// @nodoc
class _$BedtimeSessionRecordCopyWithImpl<$Res>
    implements $BedtimeSessionRecordCopyWith<$Res> {
  _$BedtimeSessionRecordCopyWithImpl(this._self, this._then);

  final BedtimeSessionRecord _self;
  final $Res Function(BedtimeSessionRecord) _then;

/// Create a copy of BedtimeSessionRecord
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? sessionDate = null,Object? selectedChoice = freezed,Object? entrySource = null,Object? isCompleted = null,Object? updatedAt = null,}) {
  return _then(_self.copyWith(
sessionDate: null == sessionDate ? _self.sessionDate : sessionDate // ignore: cast_nullable_to_non_nullable
as DateTime,selectedChoice: freezed == selectedChoice ? _self.selectedChoice : selectedChoice // ignore: cast_nullable_to_non_nullable
as BedtimeStatusChoice?,entrySource: null == entrySource ? _self.entrySource : entrySource // ignore: cast_nullable_to_non_nullable
as BedtimeEntrySource,isCompleted: null == isCompleted ? _self.isCompleted : isCompleted // ignore: cast_nullable_to_non_nullable
as bool,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [BedtimeSessionRecord].
extension BedtimeSessionRecordPatterns on BedtimeSessionRecord {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BedtimeSessionRecord value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BedtimeSessionRecord() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BedtimeSessionRecord value)  $default,){
final _that = this;
switch (_that) {
case _BedtimeSessionRecord():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BedtimeSessionRecord value)?  $default,){
final _that = this;
switch (_that) {
case _BedtimeSessionRecord() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( DateTime sessionDate,  BedtimeStatusChoice? selectedChoice,  BedtimeEntrySource entrySource,  bool isCompleted,  DateTime updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BedtimeSessionRecord() when $default != null:
return $default(_that.sessionDate,_that.selectedChoice,_that.entrySource,_that.isCompleted,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( DateTime sessionDate,  BedtimeStatusChoice? selectedChoice,  BedtimeEntrySource entrySource,  bool isCompleted,  DateTime updatedAt)  $default,) {final _that = this;
switch (_that) {
case _BedtimeSessionRecord():
return $default(_that.sessionDate,_that.selectedChoice,_that.entrySource,_that.isCompleted,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( DateTime sessionDate,  BedtimeStatusChoice? selectedChoice,  BedtimeEntrySource entrySource,  bool isCompleted,  DateTime updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _BedtimeSessionRecord() when $default != null:
return $default(_that.sessionDate,_that.selectedChoice,_that.entrySource,_that.isCompleted,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc


class _BedtimeSessionRecord implements BedtimeSessionRecord {
  const _BedtimeSessionRecord({required this.sessionDate, required this.selectedChoice, required this.entrySource, required this.isCompleted, required this.updatedAt});
  

@override final  DateTime sessionDate;
@override final  BedtimeStatusChoice? selectedChoice;
@override final  BedtimeEntrySource entrySource;
@override final  bool isCompleted;
@override final  DateTime updatedAt;

/// Create a copy of BedtimeSessionRecord
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BedtimeSessionRecordCopyWith<_BedtimeSessionRecord> get copyWith => __$BedtimeSessionRecordCopyWithImpl<_BedtimeSessionRecord>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BedtimeSessionRecord&&(identical(other.sessionDate, sessionDate) || other.sessionDate == sessionDate)&&(identical(other.selectedChoice, selectedChoice) || other.selectedChoice == selectedChoice)&&(identical(other.entrySource, entrySource) || other.entrySource == entrySource)&&(identical(other.isCompleted, isCompleted) || other.isCompleted == isCompleted)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}


@override
int get hashCode => Object.hash(runtimeType,sessionDate,selectedChoice,entrySource,isCompleted,updatedAt);

@override
String toString() {
  return 'BedtimeSessionRecord(sessionDate: $sessionDate, selectedChoice: $selectedChoice, entrySource: $entrySource, isCompleted: $isCompleted, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$BedtimeSessionRecordCopyWith<$Res> implements $BedtimeSessionRecordCopyWith<$Res> {
  factory _$BedtimeSessionRecordCopyWith(_BedtimeSessionRecord value, $Res Function(_BedtimeSessionRecord) _then) = __$BedtimeSessionRecordCopyWithImpl;
@override @useResult
$Res call({
 DateTime sessionDate, BedtimeStatusChoice? selectedChoice, BedtimeEntrySource entrySource, bool isCompleted, DateTime updatedAt
});




}
/// @nodoc
class __$BedtimeSessionRecordCopyWithImpl<$Res>
    implements _$BedtimeSessionRecordCopyWith<$Res> {
  __$BedtimeSessionRecordCopyWithImpl(this._self, this._then);

  final _BedtimeSessionRecord _self;
  final $Res Function(_BedtimeSessionRecord) _then;

/// Create a copy of BedtimeSessionRecord
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? sessionDate = null,Object? selectedChoice = freezed,Object? entrySource = null,Object? isCompleted = null,Object? updatedAt = null,}) {
  return _then(_BedtimeSessionRecord(
sessionDate: null == sessionDate ? _self.sessionDate : sessionDate // ignore: cast_nullable_to_non_nullable
as DateTime,selectedChoice: freezed == selectedChoice ? _self.selectedChoice : selectedChoice // ignore: cast_nullable_to_non_nullable
as BedtimeStatusChoice?,entrySource: null == entrySource ? _self.entrySource : entrySource // ignore: cast_nullable_to_non_nullable
as BedtimeEntrySource,isCompleted: null == isCompleted ? _self.isCompleted : isCompleted // ignore: cast_nullable_to_non_nullable
as bool,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
