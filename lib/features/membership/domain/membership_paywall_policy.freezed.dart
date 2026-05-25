// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'membership_paywall_policy.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$MembershipAccessResult {

 PaywallEntryContext get entryContext; bool get isBlocked; DateTime? get freeHistoryStartDate;
/// Create a copy of MembershipAccessResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MembershipAccessResultCopyWith<MembershipAccessResult> get copyWith => _$MembershipAccessResultCopyWithImpl<MembershipAccessResult>(this as MembershipAccessResult, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MembershipAccessResult&&(identical(other.entryContext, entryContext) || other.entryContext == entryContext)&&(identical(other.isBlocked, isBlocked) || other.isBlocked == isBlocked)&&(identical(other.freeHistoryStartDate, freeHistoryStartDate) || other.freeHistoryStartDate == freeHistoryStartDate));
}


@override
int get hashCode => Object.hash(runtimeType,entryContext,isBlocked,freeHistoryStartDate);

@override
String toString() {
  return 'MembershipAccessResult(entryContext: $entryContext, isBlocked: $isBlocked, freeHistoryStartDate: $freeHistoryStartDate)';
}


}

/// @nodoc
abstract mixin class $MembershipAccessResultCopyWith<$Res>  {
  factory $MembershipAccessResultCopyWith(MembershipAccessResult value, $Res Function(MembershipAccessResult) _then) = _$MembershipAccessResultCopyWithImpl;
@useResult
$Res call({
 PaywallEntryContext entryContext, bool isBlocked, DateTime? freeHistoryStartDate
});




}
/// @nodoc
class _$MembershipAccessResultCopyWithImpl<$Res>
    implements $MembershipAccessResultCopyWith<$Res> {
  _$MembershipAccessResultCopyWithImpl(this._self, this._then);

  final MembershipAccessResult _self;
  final $Res Function(MembershipAccessResult) _then;

/// Create a copy of MembershipAccessResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? entryContext = null,Object? isBlocked = null,Object? freeHistoryStartDate = freezed,}) {
  return _then(_self.copyWith(
entryContext: null == entryContext ? _self.entryContext : entryContext // ignore: cast_nullable_to_non_nullable
as PaywallEntryContext,isBlocked: null == isBlocked ? _self.isBlocked : isBlocked // ignore: cast_nullable_to_non_nullable
as bool,freeHistoryStartDate: freezed == freeHistoryStartDate ? _self.freeHistoryStartDate : freeHistoryStartDate // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [MembershipAccessResult].
extension MembershipAccessResultPatterns on MembershipAccessResult {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MembershipAccessResult value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MembershipAccessResult() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MembershipAccessResult value)  $default,){
final _that = this;
switch (_that) {
case _MembershipAccessResult():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MembershipAccessResult value)?  $default,){
final _that = this;
switch (_that) {
case _MembershipAccessResult() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( PaywallEntryContext entryContext,  bool isBlocked,  DateTime? freeHistoryStartDate)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MembershipAccessResult() when $default != null:
return $default(_that.entryContext,_that.isBlocked,_that.freeHistoryStartDate);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( PaywallEntryContext entryContext,  bool isBlocked,  DateTime? freeHistoryStartDate)  $default,) {final _that = this;
switch (_that) {
case _MembershipAccessResult():
return $default(_that.entryContext,_that.isBlocked,_that.freeHistoryStartDate);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( PaywallEntryContext entryContext,  bool isBlocked,  DateTime? freeHistoryStartDate)?  $default,) {final _that = this;
switch (_that) {
case _MembershipAccessResult() when $default != null:
return $default(_that.entryContext,_that.isBlocked,_that.freeHistoryStartDate);case _:
  return null;

}
}

}

/// @nodoc


class _MembershipAccessResult extends MembershipAccessResult {
  const _MembershipAccessResult({required this.entryContext, required this.isBlocked, this.freeHistoryStartDate}): super._();
  

@override final  PaywallEntryContext entryContext;
@override final  bool isBlocked;
@override final  DateTime? freeHistoryStartDate;

/// Create a copy of MembershipAccessResult
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MembershipAccessResultCopyWith<_MembershipAccessResult> get copyWith => __$MembershipAccessResultCopyWithImpl<_MembershipAccessResult>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MembershipAccessResult&&(identical(other.entryContext, entryContext) || other.entryContext == entryContext)&&(identical(other.isBlocked, isBlocked) || other.isBlocked == isBlocked)&&(identical(other.freeHistoryStartDate, freeHistoryStartDate) || other.freeHistoryStartDate == freeHistoryStartDate));
}


@override
int get hashCode => Object.hash(runtimeType,entryContext,isBlocked,freeHistoryStartDate);

@override
String toString() {
  return 'MembershipAccessResult(entryContext: $entryContext, isBlocked: $isBlocked, freeHistoryStartDate: $freeHistoryStartDate)';
}


}

/// @nodoc
abstract mixin class _$MembershipAccessResultCopyWith<$Res> implements $MembershipAccessResultCopyWith<$Res> {
  factory _$MembershipAccessResultCopyWith(_MembershipAccessResult value, $Res Function(_MembershipAccessResult) _then) = __$MembershipAccessResultCopyWithImpl;
@override @useResult
$Res call({
 PaywallEntryContext entryContext, bool isBlocked, DateTime? freeHistoryStartDate
});




}
/// @nodoc
class __$MembershipAccessResultCopyWithImpl<$Res>
    implements _$MembershipAccessResultCopyWith<$Res> {
  __$MembershipAccessResultCopyWithImpl(this._self, this._then);

  final _MembershipAccessResult _self;
  final $Res Function(_MembershipAccessResult) _then;

/// Create a copy of MembershipAccessResult
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? entryContext = null,Object? isBlocked = null,Object? freeHistoryStartDate = freezed,}) {
  return _then(_MembershipAccessResult(
entryContext: null == entryContext ? _self.entryContext : entryContext // ignore: cast_nullable_to_non_nullable
as PaywallEntryContext,isBlocked: null == isBlocked ? _self.isBlocked : isBlocked // ignore: cast_nullable_to_non_nullable
as bool,freeHistoryStartDate: freezed == freeHistoryStartDate ? _self.freeHistoryStartDate : freeHistoryStartDate // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
