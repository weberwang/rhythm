// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'today_snapshot.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TodaySnapshot {

 String? get displayName; TodayLastNightSummary get lastNight; TodayTonightGoalSummary get tonightGoal; TodayRecoverySummary get recovery; TodayQuickRecordSummary get quickRecord; TodayTrendSummary get trend;
/// Create a copy of TodaySnapshot
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TodaySnapshotCopyWith<TodaySnapshot> get copyWith => _$TodaySnapshotCopyWithImpl<TodaySnapshot>(this as TodaySnapshot, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TodaySnapshot&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.lastNight, lastNight) || other.lastNight == lastNight)&&(identical(other.tonightGoal, tonightGoal) || other.tonightGoal == tonightGoal)&&(identical(other.recovery, recovery) || other.recovery == recovery)&&(identical(other.quickRecord, quickRecord) || other.quickRecord == quickRecord)&&(identical(other.trend, trend) || other.trend == trend));
}


@override
int get hashCode => Object.hash(runtimeType,displayName,lastNight,tonightGoal,recovery,quickRecord,trend);

@override
String toString() {
  return 'TodaySnapshot(displayName: $displayName, lastNight: $lastNight, tonightGoal: $tonightGoal, recovery: $recovery, quickRecord: $quickRecord, trend: $trend)';
}


}

/// @nodoc
abstract mixin class $TodaySnapshotCopyWith<$Res>  {
  factory $TodaySnapshotCopyWith(TodaySnapshot value, $Res Function(TodaySnapshot) _then) = _$TodaySnapshotCopyWithImpl;
@useResult
$Res call({
 String? displayName, TodayLastNightSummary lastNight, TodayTonightGoalSummary tonightGoal, TodayRecoverySummary recovery, TodayQuickRecordSummary quickRecord, TodayTrendSummary trend
});


$TodayLastNightSummaryCopyWith<$Res> get lastNight;$TodayTonightGoalSummaryCopyWith<$Res> get tonightGoal;$TodayRecoverySummaryCopyWith<$Res> get recovery;$TodayQuickRecordSummaryCopyWith<$Res> get quickRecord;$TodayTrendSummaryCopyWith<$Res> get trend;

}
/// @nodoc
class _$TodaySnapshotCopyWithImpl<$Res>
    implements $TodaySnapshotCopyWith<$Res> {
  _$TodaySnapshotCopyWithImpl(this._self, this._then);

  final TodaySnapshot _self;
  final $Res Function(TodaySnapshot) _then;

/// Create a copy of TodaySnapshot
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? displayName = freezed,Object? lastNight = null,Object? tonightGoal = null,Object? recovery = null,Object? quickRecord = null,Object? trend = null,}) {
  return _then(_self.copyWith(
displayName: freezed == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String?,lastNight: null == lastNight ? _self.lastNight : lastNight // ignore: cast_nullable_to_non_nullable
as TodayLastNightSummary,tonightGoal: null == tonightGoal ? _self.tonightGoal : tonightGoal // ignore: cast_nullable_to_non_nullable
as TodayTonightGoalSummary,recovery: null == recovery ? _self.recovery : recovery // ignore: cast_nullable_to_non_nullable
as TodayRecoverySummary,quickRecord: null == quickRecord ? _self.quickRecord : quickRecord // ignore: cast_nullable_to_non_nullable
as TodayQuickRecordSummary,trend: null == trend ? _self.trend : trend // ignore: cast_nullable_to_non_nullable
as TodayTrendSummary,
  ));
}
/// Create a copy of TodaySnapshot
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TodayLastNightSummaryCopyWith<$Res> get lastNight {
  
  return $TodayLastNightSummaryCopyWith<$Res>(_self.lastNight, (value) {
    return _then(_self.copyWith(lastNight: value));
  });
}/// Create a copy of TodaySnapshot
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TodayTonightGoalSummaryCopyWith<$Res> get tonightGoal {
  
  return $TodayTonightGoalSummaryCopyWith<$Res>(_self.tonightGoal, (value) {
    return _then(_self.copyWith(tonightGoal: value));
  });
}/// Create a copy of TodaySnapshot
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TodayRecoverySummaryCopyWith<$Res> get recovery {
  
  return $TodayRecoverySummaryCopyWith<$Res>(_self.recovery, (value) {
    return _then(_self.copyWith(recovery: value));
  });
}/// Create a copy of TodaySnapshot
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TodayQuickRecordSummaryCopyWith<$Res> get quickRecord {
  
  return $TodayQuickRecordSummaryCopyWith<$Res>(_self.quickRecord, (value) {
    return _then(_self.copyWith(quickRecord: value));
  });
}/// Create a copy of TodaySnapshot
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TodayTrendSummaryCopyWith<$Res> get trend {
  
  return $TodayTrendSummaryCopyWith<$Res>(_self.trend, (value) {
    return _then(_self.copyWith(trend: value));
  });
}
}


/// Adds pattern-matching-related methods to [TodaySnapshot].
extension TodaySnapshotPatterns on TodaySnapshot {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TodaySnapshot value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TodaySnapshot() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TodaySnapshot value)  $default,){
final _that = this;
switch (_that) {
case _TodaySnapshot():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TodaySnapshot value)?  $default,){
final _that = this;
switch (_that) {
case _TodaySnapshot() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? displayName,  TodayLastNightSummary lastNight,  TodayTonightGoalSummary tonightGoal,  TodayRecoverySummary recovery,  TodayQuickRecordSummary quickRecord,  TodayTrendSummary trend)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TodaySnapshot() when $default != null:
return $default(_that.displayName,_that.lastNight,_that.tonightGoal,_that.recovery,_that.quickRecord,_that.trend);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? displayName,  TodayLastNightSummary lastNight,  TodayTonightGoalSummary tonightGoal,  TodayRecoverySummary recovery,  TodayQuickRecordSummary quickRecord,  TodayTrendSummary trend)  $default,) {final _that = this;
switch (_that) {
case _TodaySnapshot():
return $default(_that.displayName,_that.lastNight,_that.tonightGoal,_that.recovery,_that.quickRecord,_that.trend);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? displayName,  TodayLastNightSummary lastNight,  TodayTonightGoalSummary tonightGoal,  TodayRecoverySummary recovery,  TodayQuickRecordSummary quickRecord,  TodayTrendSummary trend)?  $default,) {final _that = this;
switch (_that) {
case _TodaySnapshot() when $default != null:
return $default(_that.displayName,_that.lastNight,_that.tonightGoal,_that.recovery,_that.quickRecord,_that.trend);case _:
  return null;

}
}

}

/// @nodoc


class _TodaySnapshot implements TodaySnapshot {
  const _TodaySnapshot({this.displayName, required this.lastNight, required this.tonightGoal, required this.recovery, required this.quickRecord, required this.trend});
  

@override final  String? displayName;
@override final  TodayLastNightSummary lastNight;
@override final  TodayTonightGoalSummary tonightGoal;
@override final  TodayRecoverySummary recovery;
@override final  TodayQuickRecordSummary quickRecord;
@override final  TodayTrendSummary trend;

/// Create a copy of TodaySnapshot
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TodaySnapshotCopyWith<_TodaySnapshot> get copyWith => __$TodaySnapshotCopyWithImpl<_TodaySnapshot>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TodaySnapshot&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.lastNight, lastNight) || other.lastNight == lastNight)&&(identical(other.tonightGoal, tonightGoal) || other.tonightGoal == tonightGoal)&&(identical(other.recovery, recovery) || other.recovery == recovery)&&(identical(other.quickRecord, quickRecord) || other.quickRecord == quickRecord)&&(identical(other.trend, trend) || other.trend == trend));
}


@override
int get hashCode => Object.hash(runtimeType,displayName,lastNight,tonightGoal,recovery,quickRecord,trend);

@override
String toString() {
  return 'TodaySnapshot(displayName: $displayName, lastNight: $lastNight, tonightGoal: $tonightGoal, recovery: $recovery, quickRecord: $quickRecord, trend: $trend)';
}


}

/// @nodoc
abstract mixin class _$TodaySnapshotCopyWith<$Res> implements $TodaySnapshotCopyWith<$Res> {
  factory _$TodaySnapshotCopyWith(_TodaySnapshot value, $Res Function(_TodaySnapshot) _then) = __$TodaySnapshotCopyWithImpl;
@override @useResult
$Res call({
 String? displayName, TodayLastNightSummary lastNight, TodayTonightGoalSummary tonightGoal, TodayRecoverySummary recovery, TodayQuickRecordSummary quickRecord, TodayTrendSummary trend
});


@override $TodayLastNightSummaryCopyWith<$Res> get lastNight;@override $TodayTonightGoalSummaryCopyWith<$Res> get tonightGoal;@override $TodayRecoverySummaryCopyWith<$Res> get recovery;@override $TodayQuickRecordSummaryCopyWith<$Res> get quickRecord;@override $TodayTrendSummaryCopyWith<$Res> get trend;

}
/// @nodoc
class __$TodaySnapshotCopyWithImpl<$Res>
    implements _$TodaySnapshotCopyWith<$Res> {
  __$TodaySnapshotCopyWithImpl(this._self, this._then);

  final _TodaySnapshot _self;
  final $Res Function(_TodaySnapshot) _then;

/// Create a copy of TodaySnapshot
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? displayName = freezed,Object? lastNight = null,Object? tonightGoal = null,Object? recovery = null,Object? quickRecord = null,Object? trend = null,}) {
  return _then(_TodaySnapshot(
displayName: freezed == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String?,lastNight: null == lastNight ? _self.lastNight : lastNight // ignore: cast_nullable_to_non_nullable
as TodayLastNightSummary,tonightGoal: null == tonightGoal ? _self.tonightGoal : tonightGoal // ignore: cast_nullable_to_non_nullable
as TodayTonightGoalSummary,recovery: null == recovery ? _self.recovery : recovery // ignore: cast_nullable_to_non_nullable
as TodayRecoverySummary,quickRecord: null == quickRecord ? _self.quickRecord : quickRecord // ignore: cast_nullable_to_non_nullable
as TodayQuickRecordSummary,trend: null == trend ? _self.trend : trend // ignore: cast_nullable_to_non_nullable
as TodayTrendSummary,
  ));
}

/// Create a copy of TodaySnapshot
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TodayLastNightSummaryCopyWith<$Res> get lastNight {
  
  return $TodayLastNightSummaryCopyWith<$Res>(_self.lastNight, (value) {
    return _then(_self.copyWith(lastNight: value));
  });
}/// Create a copy of TodaySnapshot
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TodayTonightGoalSummaryCopyWith<$Res> get tonightGoal {
  
  return $TodayTonightGoalSummaryCopyWith<$Res>(_self.tonightGoal, (value) {
    return _then(_self.copyWith(tonightGoal: value));
  });
}/// Create a copy of TodaySnapshot
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TodayRecoverySummaryCopyWith<$Res> get recovery {
  
  return $TodayRecoverySummaryCopyWith<$Res>(_self.recovery, (value) {
    return _then(_self.copyWith(recovery: value));
  });
}/// Create a copy of TodaySnapshot
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TodayQuickRecordSummaryCopyWith<$Res> get quickRecord {
  
  return $TodayQuickRecordSummaryCopyWith<$Res>(_self.quickRecord, (value) {
    return _then(_self.copyWith(quickRecord: value));
  });
}/// Create a copy of TodaySnapshot
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TodayTrendSummaryCopyWith<$Res> get trend {
  
  return $TodayTrendSummaryCopyWith<$Res>(_self.trend, (value) {
    return _then(_self.copyWith(trend: value));
  });
}
}

/// @nodoc
mixin _$TodayLastNightSummary {

 TodayLastNightStatus get status; String get scoreLabel; String get primaryMetricLabel; String get primaryMetricValue; String get secondaryMetricLabel; String get secondaryMetricValue; String get tertiaryMetricLabel; String get tertiaryMetricValue;
/// Create a copy of TodayLastNightSummary
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TodayLastNightSummaryCopyWith<TodayLastNightSummary> get copyWith => _$TodayLastNightSummaryCopyWithImpl<TodayLastNightSummary>(this as TodayLastNightSummary, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TodayLastNightSummary&&(identical(other.status, status) || other.status == status)&&(identical(other.scoreLabel, scoreLabel) || other.scoreLabel == scoreLabel)&&(identical(other.primaryMetricLabel, primaryMetricLabel) || other.primaryMetricLabel == primaryMetricLabel)&&(identical(other.primaryMetricValue, primaryMetricValue) || other.primaryMetricValue == primaryMetricValue)&&(identical(other.secondaryMetricLabel, secondaryMetricLabel) || other.secondaryMetricLabel == secondaryMetricLabel)&&(identical(other.secondaryMetricValue, secondaryMetricValue) || other.secondaryMetricValue == secondaryMetricValue)&&(identical(other.tertiaryMetricLabel, tertiaryMetricLabel) || other.tertiaryMetricLabel == tertiaryMetricLabel)&&(identical(other.tertiaryMetricValue, tertiaryMetricValue) || other.tertiaryMetricValue == tertiaryMetricValue));
}


@override
int get hashCode => Object.hash(runtimeType,status,scoreLabel,primaryMetricLabel,primaryMetricValue,secondaryMetricLabel,secondaryMetricValue,tertiaryMetricLabel,tertiaryMetricValue);

@override
String toString() {
  return 'TodayLastNightSummary(status: $status, scoreLabel: $scoreLabel, primaryMetricLabel: $primaryMetricLabel, primaryMetricValue: $primaryMetricValue, secondaryMetricLabel: $secondaryMetricLabel, secondaryMetricValue: $secondaryMetricValue, tertiaryMetricLabel: $tertiaryMetricLabel, tertiaryMetricValue: $tertiaryMetricValue)';
}


}

/// @nodoc
abstract mixin class $TodayLastNightSummaryCopyWith<$Res>  {
  factory $TodayLastNightSummaryCopyWith(TodayLastNightSummary value, $Res Function(TodayLastNightSummary) _then) = _$TodayLastNightSummaryCopyWithImpl;
@useResult
$Res call({
 TodayLastNightStatus status, String scoreLabel, String primaryMetricLabel, String primaryMetricValue, String secondaryMetricLabel, String secondaryMetricValue, String tertiaryMetricLabel, String tertiaryMetricValue
});




}
/// @nodoc
class _$TodayLastNightSummaryCopyWithImpl<$Res>
    implements $TodayLastNightSummaryCopyWith<$Res> {
  _$TodayLastNightSummaryCopyWithImpl(this._self, this._then);

  final TodayLastNightSummary _self;
  final $Res Function(TodayLastNightSummary) _then;

/// Create a copy of TodayLastNightSummary
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? scoreLabel = null,Object? primaryMetricLabel = null,Object? primaryMetricValue = null,Object? secondaryMetricLabel = null,Object? secondaryMetricValue = null,Object? tertiaryMetricLabel = null,Object? tertiaryMetricValue = null,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as TodayLastNightStatus,scoreLabel: null == scoreLabel ? _self.scoreLabel : scoreLabel // ignore: cast_nullable_to_non_nullable
as String,primaryMetricLabel: null == primaryMetricLabel ? _self.primaryMetricLabel : primaryMetricLabel // ignore: cast_nullable_to_non_nullable
as String,primaryMetricValue: null == primaryMetricValue ? _self.primaryMetricValue : primaryMetricValue // ignore: cast_nullable_to_non_nullable
as String,secondaryMetricLabel: null == secondaryMetricLabel ? _self.secondaryMetricLabel : secondaryMetricLabel // ignore: cast_nullable_to_non_nullable
as String,secondaryMetricValue: null == secondaryMetricValue ? _self.secondaryMetricValue : secondaryMetricValue // ignore: cast_nullable_to_non_nullable
as String,tertiaryMetricLabel: null == tertiaryMetricLabel ? _self.tertiaryMetricLabel : tertiaryMetricLabel // ignore: cast_nullable_to_non_nullable
as String,tertiaryMetricValue: null == tertiaryMetricValue ? _self.tertiaryMetricValue : tertiaryMetricValue // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [TodayLastNightSummary].
extension TodayLastNightSummaryPatterns on TodayLastNightSummary {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TodayLastNightSummary value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TodayLastNightSummary() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TodayLastNightSummary value)  $default,){
final _that = this;
switch (_that) {
case _TodayLastNightSummary():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TodayLastNightSummary value)?  $default,){
final _that = this;
switch (_that) {
case _TodayLastNightSummary() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( TodayLastNightStatus status,  String scoreLabel,  String primaryMetricLabel,  String primaryMetricValue,  String secondaryMetricLabel,  String secondaryMetricValue,  String tertiaryMetricLabel,  String tertiaryMetricValue)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TodayLastNightSummary() when $default != null:
return $default(_that.status,_that.scoreLabel,_that.primaryMetricLabel,_that.primaryMetricValue,_that.secondaryMetricLabel,_that.secondaryMetricValue,_that.tertiaryMetricLabel,_that.tertiaryMetricValue);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( TodayLastNightStatus status,  String scoreLabel,  String primaryMetricLabel,  String primaryMetricValue,  String secondaryMetricLabel,  String secondaryMetricValue,  String tertiaryMetricLabel,  String tertiaryMetricValue)  $default,) {final _that = this;
switch (_that) {
case _TodayLastNightSummary():
return $default(_that.status,_that.scoreLabel,_that.primaryMetricLabel,_that.primaryMetricValue,_that.secondaryMetricLabel,_that.secondaryMetricValue,_that.tertiaryMetricLabel,_that.tertiaryMetricValue);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( TodayLastNightStatus status,  String scoreLabel,  String primaryMetricLabel,  String primaryMetricValue,  String secondaryMetricLabel,  String secondaryMetricValue,  String tertiaryMetricLabel,  String tertiaryMetricValue)?  $default,) {final _that = this;
switch (_that) {
case _TodayLastNightSummary() when $default != null:
return $default(_that.status,_that.scoreLabel,_that.primaryMetricLabel,_that.primaryMetricValue,_that.secondaryMetricLabel,_that.secondaryMetricValue,_that.tertiaryMetricLabel,_that.tertiaryMetricValue);case _:
  return null;

}
}

}

/// @nodoc


class _TodayLastNightSummary implements TodayLastNightSummary {
  const _TodayLastNightSummary({required this.status, required this.scoreLabel, required this.primaryMetricLabel, required this.primaryMetricValue, required this.secondaryMetricLabel, required this.secondaryMetricValue, required this.tertiaryMetricLabel, required this.tertiaryMetricValue});
  

@override final  TodayLastNightStatus status;
@override final  String scoreLabel;
@override final  String primaryMetricLabel;
@override final  String primaryMetricValue;
@override final  String secondaryMetricLabel;
@override final  String secondaryMetricValue;
@override final  String tertiaryMetricLabel;
@override final  String tertiaryMetricValue;

/// Create a copy of TodayLastNightSummary
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TodayLastNightSummaryCopyWith<_TodayLastNightSummary> get copyWith => __$TodayLastNightSummaryCopyWithImpl<_TodayLastNightSummary>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TodayLastNightSummary&&(identical(other.status, status) || other.status == status)&&(identical(other.scoreLabel, scoreLabel) || other.scoreLabel == scoreLabel)&&(identical(other.primaryMetricLabel, primaryMetricLabel) || other.primaryMetricLabel == primaryMetricLabel)&&(identical(other.primaryMetricValue, primaryMetricValue) || other.primaryMetricValue == primaryMetricValue)&&(identical(other.secondaryMetricLabel, secondaryMetricLabel) || other.secondaryMetricLabel == secondaryMetricLabel)&&(identical(other.secondaryMetricValue, secondaryMetricValue) || other.secondaryMetricValue == secondaryMetricValue)&&(identical(other.tertiaryMetricLabel, tertiaryMetricLabel) || other.tertiaryMetricLabel == tertiaryMetricLabel)&&(identical(other.tertiaryMetricValue, tertiaryMetricValue) || other.tertiaryMetricValue == tertiaryMetricValue));
}


@override
int get hashCode => Object.hash(runtimeType,status,scoreLabel,primaryMetricLabel,primaryMetricValue,secondaryMetricLabel,secondaryMetricValue,tertiaryMetricLabel,tertiaryMetricValue);

@override
String toString() {
  return 'TodayLastNightSummary(status: $status, scoreLabel: $scoreLabel, primaryMetricLabel: $primaryMetricLabel, primaryMetricValue: $primaryMetricValue, secondaryMetricLabel: $secondaryMetricLabel, secondaryMetricValue: $secondaryMetricValue, tertiaryMetricLabel: $tertiaryMetricLabel, tertiaryMetricValue: $tertiaryMetricValue)';
}


}

/// @nodoc
abstract mixin class _$TodayLastNightSummaryCopyWith<$Res> implements $TodayLastNightSummaryCopyWith<$Res> {
  factory _$TodayLastNightSummaryCopyWith(_TodayLastNightSummary value, $Res Function(_TodayLastNightSummary) _then) = __$TodayLastNightSummaryCopyWithImpl;
@override @useResult
$Res call({
 TodayLastNightStatus status, String scoreLabel, String primaryMetricLabel, String primaryMetricValue, String secondaryMetricLabel, String secondaryMetricValue, String tertiaryMetricLabel, String tertiaryMetricValue
});




}
/// @nodoc
class __$TodayLastNightSummaryCopyWithImpl<$Res>
    implements _$TodayLastNightSummaryCopyWith<$Res> {
  __$TodayLastNightSummaryCopyWithImpl(this._self, this._then);

  final _TodayLastNightSummary _self;
  final $Res Function(_TodayLastNightSummary) _then;

/// Create a copy of TodayLastNightSummary
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? scoreLabel = null,Object? primaryMetricLabel = null,Object? primaryMetricValue = null,Object? secondaryMetricLabel = null,Object? secondaryMetricValue = null,Object? tertiaryMetricLabel = null,Object? tertiaryMetricValue = null,}) {
  return _then(_TodayLastNightSummary(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as TodayLastNightStatus,scoreLabel: null == scoreLabel ? _self.scoreLabel : scoreLabel // ignore: cast_nullable_to_non_nullable
as String,primaryMetricLabel: null == primaryMetricLabel ? _self.primaryMetricLabel : primaryMetricLabel // ignore: cast_nullable_to_non_nullable
as String,primaryMetricValue: null == primaryMetricValue ? _self.primaryMetricValue : primaryMetricValue // ignore: cast_nullable_to_non_nullable
as String,secondaryMetricLabel: null == secondaryMetricLabel ? _self.secondaryMetricLabel : secondaryMetricLabel // ignore: cast_nullable_to_non_nullable
as String,secondaryMetricValue: null == secondaryMetricValue ? _self.secondaryMetricValue : secondaryMetricValue // ignore: cast_nullable_to_non_nullable
as String,tertiaryMetricLabel: null == tertiaryMetricLabel ? _self.tertiaryMetricLabel : tertiaryMetricLabel // ignore: cast_nullable_to_non_nullable
as String,tertiaryMetricValue: null == tertiaryMetricValue ? _self.tertiaryMetricValue : tertiaryMetricValue // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
mixin _$TodayTonightGoalSummary {

 int get bedtimeMinutes; int get wakeTimeMinutes; int get windDownMinutes; String get bedtimeLabel; String get wakeTimeLabel; String get windDownLabel;
/// Create a copy of TodayTonightGoalSummary
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TodayTonightGoalSummaryCopyWith<TodayTonightGoalSummary> get copyWith => _$TodayTonightGoalSummaryCopyWithImpl<TodayTonightGoalSummary>(this as TodayTonightGoalSummary, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TodayTonightGoalSummary&&(identical(other.bedtimeMinutes, bedtimeMinutes) || other.bedtimeMinutes == bedtimeMinutes)&&(identical(other.wakeTimeMinutes, wakeTimeMinutes) || other.wakeTimeMinutes == wakeTimeMinutes)&&(identical(other.windDownMinutes, windDownMinutes) || other.windDownMinutes == windDownMinutes)&&(identical(other.bedtimeLabel, bedtimeLabel) || other.bedtimeLabel == bedtimeLabel)&&(identical(other.wakeTimeLabel, wakeTimeLabel) || other.wakeTimeLabel == wakeTimeLabel)&&(identical(other.windDownLabel, windDownLabel) || other.windDownLabel == windDownLabel));
}


@override
int get hashCode => Object.hash(runtimeType,bedtimeMinutes,wakeTimeMinutes,windDownMinutes,bedtimeLabel,wakeTimeLabel,windDownLabel);

@override
String toString() {
  return 'TodayTonightGoalSummary(bedtimeMinutes: $bedtimeMinutes, wakeTimeMinutes: $wakeTimeMinutes, windDownMinutes: $windDownMinutes, bedtimeLabel: $bedtimeLabel, wakeTimeLabel: $wakeTimeLabel, windDownLabel: $windDownLabel)';
}


}

/// @nodoc
abstract mixin class $TodayTonightGoalSummaryCopyWith<$Res>  {
  factory $TodayTonightGoalSummaryCopyWith(TodayTonightGoalSummary value, $Res Function(TodayTonightGoalSummary) _then) = _$TodayTonightGoalSummaryCopyWithImpl;
@useResult
$Res call({
 int bedtimeMinutes, int wakeTimeMinutes, int windDownMinutes, String bedtimeLabel, String wakeTimeLabel, String windDownLabel
});




}
/// @nodoc
class _$TodayTonightGoalSummaryCopyWithImpl<$Res>
    implements $TodayTonightGoalSummaryCopyWith<$Res> {
  _$TodayTonightGoalSummaryCopyWithImpl(this._self, this._then);

  final TodayTonightGoalSummary _self;
  final $Res Function(TodayTonightGoalSummary) _then;

/// Create a copy of TodayTonightGoalSummary
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? bedtimeMinutes = null,Object? wakeTimeMinutes = null,Object? windDownMinutes = null,Object? bedtimeLabel = null,Object? wakeTimeLabel = null,Object? windDownLabel = null,}) {
  return _then(_self.copyWith(
bedtimeMinutes: null == bedtimeMinutes ? _self.bedtimeMinutes : bedtimeMinutes // ignore: cast_nullable_to_non_nullable
as int,wakeTimeMinutes: null == wakeTimeMinutes ? _self.wakeTimeMinutes : wakeTimeMinutes // ignore: cast_nullable_to_non_nullable
as int,windDownMinutes: null == windDownMinutes ? _self.windDownMinutes : windDownMinutes // ignore: cast_nullable_to_non_nullable
as int,bedtimeLabel: null == bedtimeLabel ? _self.bedtimeLabel : bedtimeLabel // ignore: cast_nullable_to_non_nullable
as String,wakeTimeLabel: null == wakeTimeLabel ? _self.wakeTimeLabel : wakeTimeLabel // ignore: cast_nullable_to_non_nullable
as String,windDownLabel: null == windDownLabel ? _self.windDownLabel : windDownLabel // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [TodayTonightGoalSummary].
extension TodayTonightGoalSummaryPatterns on TodayTonightGoalSummary {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TodayTonightGoalSummary value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TodayTonightGoalSummary() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TodayTonightGoalSummary value)  $default,){
final _that = this;
switch (_that) {
case _TodayTonightGoalSummary():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TodayTonightGoalSummary value)?  $default,){
final _that = this;
switch (_that) {
case _TodayTonightGoalSummary() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int bedtimeMinutes,  int wakeTimeMinutes,  int windDownMinutes,  String bedtimeLabel,  String wakeTimeLabel,  String windDownLabel)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TodayTonightGoalSummary() when $default != null:
return $default(_that.bedtimeMinutes,_that.wakeTimeMinutes,_that.windDownMinutes,_that.bedtimeLabel,_that.wakeTimeLabel,_that.windDownLabel);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int bedtimeMinutes,  int wakeTimeMinutes,  int windDownMinutes,  String bedtimeLabel,  String wakeTimeLabel,  String windDownLabel)  $default,) {final _that = this;
switch (_that) {
case _TodayTonightGoalSummary():
return $default(_that.bedtimeMinutes,_that.wakeTimeMinutes,_that.windDownMinutes,_that.bedtimeLabel,_that.wakeTimeLabel,_that.windDownLabel);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int bedtimeMinutes,  int wakeTimeMinutes,  int windDownMinutes,  String bedtimeLabel,  String wakeTimeLabel,  String windDownLabel)?  $default,) {final _that = this;
switch (_that) {
case _TodayTonightGoalSummary() when $default != null:
return $default(_that.bedtimeMinutes,_that.wakeTimeMinutes,_that.windDownMinutes,_that.bedtimeLabel,_that.wakeTimeLabel,_that.windDownLabel);case _:
  return null;

}
}

}

/// @nodoc


class _TodayTonightGoalSummary implements TodayTonightGoalSummary {
  const _TodayTonightGoalSummary({required this.bedtimeMinutes, required this.wakeTimeMinutes, required this.windDownMinutes, required this.bedtimeLabel, required this.wakeTimeLabel, required this.windDownLabel});
  

@override final  int bedtimeMinutes;
@override final  int wakeTimeMinutes;
@override final  int windDownMinutes;
@override final  String bedtimeLabel;
@override final  String wakeTimeLabel;
@override final  String windDownLabel;

/// Create a copy of TodayTonightGoalSummary
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TodayTonightGoalSummaryCopyWith<_TodayTonightGoalSummary> get copyWith => __$TodayTonightGoalSummaryCopyWithImpl<_TodayTonightGoalSummary>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TodayTonightGoalSummary&&(identical(other.bedtimeMinutes, bedtimeMinutes) || other.bedtimeMinutes == bedtimeMinutes)&&(identical(other.wakeTimeMinutes, wakeTimeMinutes) || other.wakeTimeMinutes == wakeTimeMinutes)&&(identical(other.windDownMinutes, windDownMinutes) || other.windDownMinutes == windDownMinutes)&&(identical(other.bedtimeLabel, bedtimeLabel) || other.bedtimeLabel == bedtimeLabel)&&(identical(other.wakeTimeLabel, wakeTimeLabel) || other.wakeTimeLabel == wakeTimeLabel)&&(identical(other.windDownLabel, windDownLabel) || other.windDownLabel == windDownLabel));
}


@override
int get hashCode => Object.hash(runtimeType,bedtimeMinutes,wakeTimeMinutes,windDownMinutes,bedtimeLabel,wakeTimeLabel,windDownLabel);

@override
String toString() {
  return 'TodayTonightGoalSummary(bedtimeMinutes: $bedtimeMinutes, wakeTimeMinutes: $wakeTimeMinutes, windDownMinutes: $windDownMinutes, bedtimeLabel: $bedtimeLabel, wakeTimeLabel: $wakeTimeLabel, windDownLabel: $windDownLabel)';
}


}

/// @nodoc
abstract mixin class _$TodayTonightGoalSummaryCopyWith<$Res> implements $TodayTonightGoalSummaryCopyWith<$Res> {
  factory _$TodayTonightGoalSummaryCopyWith(_TodayTonightGoalSummary value, $Res Function(_TodayTonightGoalSummary) _then) = __$TodayTonightGoalSummaryCopyWithImpl;
@override @useResult
$Res call({
 int bedtimeMinutes, int wakeTimeMinutes, int windDownMinutes, String bedtimeLabel, String wakeTimeLabel, String windDownLabel
});




}
/// @nodoc
class __$TodayTonightGoalSummaryCopyWithImpl<$Res>
    implements _$TodayTonightGoalSummaryCopyWith<$Res> {
  __$TodayTonightGoalSummaryCopyWithImpl(this._self, this._then);

  final _TodayTonightGoalSummary _self;
  final $Res Function(_TodayTonightGoalSummary) _then;

/// Create a copy of TodayTonightGoalSummary
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? bedtimeMinutes = null,Object? wakeTimeMinutes = null,Object? windDownMinutes = null,Object? bedtimeLabel = null,Object? wakeTimeLabel = null,Object? windDownLabel = null,}) {
  return _then(_TodayTonightGoalSummary(
bedtimeMinutes: null == bedtimeMinutes ? _self.bedtimeMinutes : bedtimeMinutes // ignore: cast_nullable_to_non_nullable
as int,wakeTimeMinutes: null == wakeTimeMinutes ? _self.wakeTimeMinutes : wakeTimeMinutes // ignore: cast_nullable_to_non_nullable
as int,windDownMinutes: null == windDownMinutes ? _self.windDownMinutes : windDownMinutes // ignore: cast_nullable_to_non_nullable
as int,bedtimeLabel: null == bedtimeLabel ? _self.bedtimeLabel : bedtimeLabel // ignore: cast_nullable_to_non_nullable
as String,wakeTimeLabel: null == wakeTimeLabel ? _self.wakeTimeLabel : wakeTimeLabel // ignore: cast_nullable_to_non_nullable
as String,windDownLabel: null == windDownLabel ? _self.windDownLabel : windDownLabel // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
mixin _$TodayRecoverySummary {

 TodayRecoveryStatus get status;
/// Create a copy of TodayRecoverySummary
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TodayRecoverySummaryCopyWith<TodayRecoverySummary> get copyWith => _$TodayRecoverySummaryCopyWithImpl<TodayRecoverySummary>(this as TodayRecoverySummary, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TodayRecoverySummary&&(identical(other.status, status) || other.status == status));
}


@override
int get hashCode => Object.hash(runtimeType,status);

@override
String toString() {
  return 'TodayRecoverySummary(status: $status)';
}


}

/// @nodoc
abstract mixin class $TodayRecoverySummaryCopyWith<$Res>  {
  factory $TodayRecoverySummaryCopyWith(TodayRecoverySummary value, $Res Function(TodayRecoverySummary) _then) = _$TodayRecoverySummaryCopyWithImpl;
@useResult
$Res call({
 TodayRecoveryStatus status
});




}
/// @nodoc
class _$TodayRecoverySummaryCopyWithImpl<$Res>
    implements $TodayRecoverySummaryCopyWith<$Res> {
  _$TodayRecoverySummaryCopyWithImpl(this._self, this._then);

  final TodayRecoverySummary _self;
  final $Res Function(TodayRecoverySummary) _then;

/// Create a copy of TodayRecoverySummary
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as TodayRecoveryStatus,
  ));
}

}


/// Adds pattern-matching-related methods to [TodayRecoverySummary].
extension TodayRecoverySummaryPatterns on TodayRecoverySummary {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TodayRecoverySummary value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TodayRecoverySummary() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TodayRecoverySummary value)  $default,){
final _that = this;
switch (_that) {
case _TodayRecoverySummary():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TodayRecoverySummary value)?  $default,){
final _that = this;
switch (_that) {
case _TodayRecoverySummary() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( TodayRecoveryStatus status)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TodayRecoverySummary() when $default != null:
return $default(_that.status);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( TodayRecoveryStatus status)  $default,) {final _that = this;
switch (_that) {
case _TodayRecoverySummary():
return $default(_that.status);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( TodayRecoveryStatus status)?  $default,) {final _that = this;
switch (_that) {
case _TodayRecoverySummary() when $default != null:
return $default(_that.status);case _:
  return null;

}
}

}

/// @nodoc


class _TodayRecoverySummary implements TodayRecoverySummary {
  const _TodayRecoverySummary({required this.status});
  

@override final  TodayRecoveryStatus status;

/// Create a copy of TodayRecoverySummary
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TodayRecoverySummaryCopyWith<_TodayRecoverySummary> get copyWith => __$TodayRecoverySummaryCopyWithImpl<_TodayRecoverySummary>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TodayRecoverySummary&&(identical(other.status, status) || other.status == status));
}


@override
int get hashCode => Object.hash(runtimeType,status);

@override
String toString() {
  return 'TodayRecoverySummary(status: $status)';
}


}

/// @nodoc
abstract mixin class _$TodayRecoverySummaryCopyWith<$Res> implements $TodayRecoverySummaryCopyWith<$Res> {
  factory _$TodayRecoverySummaryCopyWith(_TodayRecoverySummary value, $Res Function(_TodayRecoverySummary) _then) = __$TodayRecoverySummaryCopyWithImpl;
@override @useResult
$Res call({
 TodayRecoveryStatus status
});




}
/// @nodoc
class __$TodayRecoverySummaryCopyWithImpl<$Res>
    implements _$TodayRecoverySummaryCopyWith<$Res> {
  __$TodayRecoverySummaryCopyWithImpl(this._self, this._then);

  final _TodayRecoverySummary _self;
  final $Res Function(_TodayRecoverySummary) _then;

/// Create a copy of TodayRecoverySummary
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,}) {
  return _then(_TodayRecoverySummary(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as TodayRecoveryStatus,
  ));
}


}

/// @nodoc
mixin _$TodayQuickRecordSummary {

 TodayQuickRecordStatus get status;
/// Create a copy of TodayQuickRecordSummary
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TodayQuickRecordSummaryCopyWith<TodayQuickRecordSummary> get copyWith => _$TodayQuickRecordSummaryCopyWithImpl<TodayQuickRecordSummary>(this as TodayQuickRecordSummary, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TodayQuickRecordSummary&&(identical(other.status, status) || other.status == status));
}


@override
int get hashCode => Object.hash(runtimeType,status);

@override
String toString() {
  return 'TodayQuickRecordSummary(status: $status)';
}


}

/// @nodoc
abstract mixin class $TodayQuickRecordSummaryCopyWith<$Res>  {
  factory $TodayQuickRecordSummaryCopyWith(TodayQuickRecordSummary value, $Res Function(TodayQuickRecordSummary) _then) = _$TodayQuickRecordSummaryCopyWithImpl;
@useResult
$Res call({
 TodayQuickRecordStatus status
});




}
/// @nodoc
class _$TodayQuickRecordSummaryCopyWithImpl<$Res>
    implements $TodayQuickRecordSummaryCopyWith<$Res> {
  _$TodayQuickRecordSummaryCopyWithImpl(this._self, this._then);

  final TodayQuickRecordSummary _self;
  final $Res Function(TodayQuickRecordSummary) _then;

/// Create a copy of TodayQuickRecordSummary
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as TodayQuickRecordStatus,
  ));
}

}


/// Adds pattern-matching-related methods to [TodayQuickRecordSummary].
extension TodayQuickRecordSummaryPatterns on TodayQuickRecordSummary {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TodayQuickRecordSummary value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TodayQuickRecordSummary() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TodayQuickRecordSummary value)  $default,){
final _that = this;
switch (_that) {
case _TodayQuickRecordSummary():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TodayQuickRecordSummary value)?  $default,){
final _that = this;
switch (_that) {
case _TodayQuickRecordSummary() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( TodayQuickRecordStatus status)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TodayQuickRecordSummary() when $default != null:
return $default(_that.status);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( TodayQuickRecordStatus status)  $default,) {final _that = this;
switch (_that) {
case _TodayQuickRecordSummary():
return $default(_that.status);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( TodayQuickRecordStatus status)?  $default,) {final _that = this;
switch (_that) {
case _TodayQuickRecordSummary() when $default != null:
return $default(_that.status);case _:
  return null;

}
}

}

/// @nodoc


class _TodayQuickRecordSummary implements TodayQuickRecordSummary {
  const _TodayQuickRecordSummary({required this.status});
  

@override final  TodayQuickRecordStatus status;

/// Create a copy of TodayQuickRecordSummary
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TodayQuickRecordSummaryCopyWith<_TodayQuickRecordSummary> get copyWith => __$TodayQuickRecordSummaryCopyWithImpl<_TodayQuickRecordSummary>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TodayQuickRecordSummary&&(identical(other.status, status) || other.status == status));
}


@override
int get hashCode => Object.hash(runtimeType,status);

@override
String toString() {
  return 'TodayQuickRecordSummary(status: $status)';
}


}

/// @nodoc
abstract mixin class _$TodayQuickRecordSummaryCopyWith<$Res> implements $TodayQuickRecordSummaryCopyWith<$Res> {
  factory _$TodayQuickRecordSummaryCopyWith(_TodayQuickRecordSummary value, $Res Function(_TodayQuickRecordSummary) _then) = __$TodayQuickRecordSummaryCopyWithImpl;
@override @useResult
$Res call({
 TodayQuickRecordStatus status
});




}
/// @nodoc
class __$TodayQuickRecordSummaryCopyWithImpl<$Res>
    implements _$TodayQuickRecordSummaryCopyWith<$Res> {
  __$TodayQuickRecordSummaryCopyWithImpl(this._self, this._then);

  final _TodayQuickRecordSummary _self;
  final $Res Function(_TodayQuickRecordSummary) _then;

/// Create a copy of TodayQuickRecordSummary
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,}) {
  return _then(_TodayQuickRecordSummary(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as TodayQuickRecordStatus,
  ));
}


}

/// @nodoc
mixin _$TodayTrendSummary {

 TodayTrendStatus get status; List<TodayTrendPoint> get points; int? get averageScore;
/// Create a copy of TodayTrendSummary
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TodayTrendSummaryCopyWith<TodayTrendSummary> get copyWith => _$TodayTrendSummaryCopyWithImpl<TodayTrendSummary>(this as TodayTrendSummary, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TodayTrendSummary&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other.points, points)&&(identical(other.averageScore, averageScore) || other.averageScore == averageScore));
}


@override
int get hashCode => Object.hash(runtimeType,status,const DeepCollectionEquality().hash(points),averageScore);

@override
String toString() {
  return 'TodayTrendSummary(status: $status, points: $points, averageScore: $averageScore)';
}


}

/// @nodoc
abstract mixin class $TodayTrendSummaryCopyWith<$Res>  {
  factory $TodayTrendSummaryCopyWith(TodayTrendSummary value, $Res Function(TodayTrendSummary) _then) = _$TodayTrendSummaryCopyWithImpl;
@useResult
$Res call({
 TodayTrendStatus status, List<TodayTrendPoint> points, int? averageScore
});




}
/// @nodoc
class _$TodayTrendSummaryCopyWithImpl<$Res>
    implements $TodayTrendSummaryCopyWith<$Res> {
  _$TodayTrendSummaryCopyWithImpl(this._self, this._then);

  final TodayTrendSummary _self;
  final $Res Function(TodayTrendSummary) _then;

/// Create a copy of TodayTrendSummary
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? points = null,Object? averageScore = freezed,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as TodayTrendStatus,points: null == points ? _self.points : points // ignore: cast_nullable_to_non_nullable
as List<TodayTrendPoint>,averageScore: freezed == averageScore ? _self.averageScore : averageScore // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [TodayTrendSummary].
extension TodayTrendSummaryPatterns on TodayTrendSummary {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TodayTrendSummary value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TodayTrendSummary() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TodayTrendSummary value)  $default,){
final _that = this;
switch (_that) {
case _TodayTrendSummary():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TodayTrendSummary value)?  $default,){
final _that = this;
switch (_that) {
case _TodayTrendSummary() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( TodayTrendStatus status,  List<TodayTrendPoint> points,  int? averageScore)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TodayTrendSummary() when $default != null:
return $default(_that.status,_that.points,_that.averageScore);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( TodayTrendStatus status,  List<TodayTrendPoint> points,  int? averageScore)  $default,) {final _that = this;
switch (_that) {
case _TodayTrendSummary():
return $default(_that.status,_that.points,_that.averageScore);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( TodayTrendStatus status,  List<TodayTrendPoint> points,  int? averageScore)?  $default,) {final _that = this;
switch (_that) {
case _TodayTrendSummary() when $default != null:
return $default(_that.status,_that.points,_that.averageScore);case _:
  return null;

}
}

}

/// @nodoc


class _TodayTrendSummary implements TodayTrendSummary {
  const _TodayTrendSummary({required this.status, required final  List<TodayTrendPoint> points, required this.averageScore}): _points = points;
  

@override final  TodayTrendStatus status;
 final  List<TodayTrendPoint> _points;
@override List<TodayTrendPoint> get points {
  if (_points is EqualUnmodifiableListView) return _points;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_points);
}

@override final  int? averageScore;

/// Create a copy of TodayTrendSummary
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TodayTrendSummaryCopyWith<_TodayTrendSummary> get copyWith => __$TodayTrendSummaryCopyWithImpl<_TodayTrendSummary>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TodayTrendSummary&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other._points, _points)&&(identical(other.averageScore, averageScore) || other.averageScore == averageScore));
}


@override
int get hashCode => Object.hash(runtimeType,status,const DeepCollectionEquality().hash(_points),averageScore);

@override
String toString() {
  return 'TodayTrendSummary(status: $status, points: $points, averageScore: $averageScore)';
}


}

/// @nodoc
abstract mixin class _$TodayTrendSummaryCopyWith<$Res> implements $TodayTrendSummaryCopyWith<$Res> {
  factory _$TodayTrendSummaryCopyWith(_TodayTrendSummary value, $Res Function(_TodayTrendSummary) _then) = __$TodayTrendSummaryCopyWithImpl;
@override @useResult
$Res call({
 TodayTrendStatus status, List<TodayTrendPoint> points, int? averageScore
});




}
/// @nodoc
class __$TodayTrendSummaryCopyWithImpl<$Res>
    implements _$TodayTrendSummaryCopyWith<$Res> {
  __$TodayTrendSummaryCopyWithImpl(this._self, this._then);

  final _TodayTrendSummary _self;
  final $Res Function(_TodayTrendSummary) _then;

/// Create a copy of TodayTrendSummary
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? points = null,Object? averageScore = freezed,}) {
  return _then(_TodayTrendSummary(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as TodayTrendStatus,points: null == points ? _self._points : points // ignore: cast_nullable_to_non_nullable
as List<TodayTrendPoint>,averageScore: freezed == averageScore ? _self.averageScore : averageScore // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

/// @nodoc
mixin _$TodayTrendPoint {

 String get dayLabel; int get score;
/// Create a copy of TodayTrendPoint
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TodayTrendPointCopyWith<TodayTrendPoint> get copyWith => _$TodayTrendPointCopyWithImpl<TodayTrendPoint>(this as TodayTrendPoint, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TodayTrendPoint&&(identical(other.dayLabel, dayLabel) || other.dayLabel == dayLabel)&&(identical(other.score, score) || other.score == score));
}


@override
int get hashCode => Object.hash(runtimeType,dayLabel,score);

@override
String toString() {
  return 'TodayTrendPoint(dayLabel: $dayLabel, score: $score)';
}


}

/// @nodoc
abstract mixin class $TodayTrendPointCopyWith<$Res>  {
  factory $TodayTrendPointCopyWith(TodayTrendPoint value, $Res Function(TodayTrendPoint) _then) = _$TodayTrendPointCopyWithImpl;
@useResult
$Res call({
 String dayLabel, int score
});




}
/// @nodoc
class _$TodayTrendPointCopyWithImpl<$Res>
    implements $TodayTrendPointCopyWith<$Res> {
  _$TodayTrendPointCopyWithImpl(this._self, this._then);

  final TodayTrendPoint _self;
  final $Res Function(TodayTrendPoint) _then;

/// Create a copy of TodayTrendPoint
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? dayLabel = null,Object? score = null,}) {
  return _then(_self.copyWith(
dayLabel: null == dayLabel ? _self.dayLabel : dayLabel // ignore: cast_nullable_to_non_nullable
as String,score: null == score ? _self.score : score // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [TodayTrendPoint].
extension TodayTrendPointPatterns on TodayTrendPoint {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TodayTrendPoint value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TodayTrendPoint() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TodayTrendPoint value)  $default,){
final _that = this;
switch (_that) {
case _TodayTrendPoint():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TodayTrendPoint value)?  $default,){
final _that = this;
switch (_that) {
case _TodayTrendPoint() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String dayLabel,  int score)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TodayTrendPoint() when $default != null:
return $default(_that.dayLabel,_that.score);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String dayLabel,  int score)  $default,) {final _that = this;
switch (_that) {
case _TodayTrendPoint():
return $default(_that.dayLabel,_that.score);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String dayLabel,  int score)?  $default,) {final _that = this;
switch (_that) {
case _TodayTrendPoint() when $default != null:
return $default(_that.dayLabel,_that.score);case _:
  return null;

}
}

}

/// @nodoc


class _TodayTrendPoint implements TodayTrendPoint {
  const _TodayTrendPoint({required this.dayLabel, required this.score});
  

@override final  String dayLabel;
@override final  int score;

/// Create a copy of TodayTrendPoint
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TodayTrendPointCopyWith<_TodayTrendPoint> get copyWith => __$TodayTrendPointCopyWithImpl<_TodayTrendPoint>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TodayTrendPoint&&(identical(other.dayLabel, dayLabel) || other.dayLabel == dayLabel)&&(identical(other.score, score) || other.score == score));
}


@override
int get hashCode => Object.hash(runtimeType,dayLabel,score);

@override
String toString() {
  return 'TodayTrendPoint(dayLabel: $dayLabel, score: $score)';
}


}

/// @nodoc
abstract mixin class _$TodayTrendPointCopyWith<$Res> implements $TodayTrendPointCopyWith<$Res> {
  factory _$TodayTrendPointCopyWith(_TodayTrendPoint value, $Res Function(_TodayTrendPoint) _then) = __$TodayTrendPointCopyWithImpl;
@override @useResult
$Res call({
 String dayLabel, int score
});




}
/// @nodoc
class __$TodayTrendPointCopyWithImpl<$Res>
    implements _$TodayTrendPointCopyWith<$Res> {
  __$TodayTrendPointCopyWithImpl(this._self, this._then);

  final _TodayTrendPoint _self;
  final $Res Function(_TodayTrendPoint) _then;

/// Create a copy of TodayTrendPoint
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? dayLabel = null,Object? score = null,}) {
  return _then(_TodayTrendPoint(
dayLabel: null == dayLabel ? _self.dayLabel : dayLabel // ignore: cast_nullable_to_non_nullable
as String,score: null == score ? _self.score : score // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
