// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'membership_entitlement.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$MembershipEntitlement {

 MembershipTier get tier; bool get isActive; bool get willRenew; String? get productId; DateTime? get expiresAt; String? get managementUrl;
/// Create a copy of MembershipEntitlement
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MembershipEntitlementCopyWith<MembershipEntitlement> get copyWith => _$MembershipEntitlementCopyWithImpl<MembershipEntitlement>(this as MembershipEntitlement, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MembershipEntitlement&&(identical(other.tier, tier) || other.tier == tier)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.willRenew, willRenew) || other.willRenew == willRenew)&&(identical(other.productId, productId) || other.productId == productId)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt)&&(identical(other.managementUrl, managementUrl) || other.managementUrl == managementUrl));
}


@override
int get hashCode => Object.hash(runtimeType,tier,isActive,willRenew,productId,expiresAt,managementUrl);

@override
String toString() {
  return 'MembershipEntitlement(tier: $tier, isActive: $isActive, willRenew: $willRenew, productId: $productId, expiresAt: $expiresAt, managementUrl: $managementUrl)';
}


}

/// @nodoc
abstract mixin class $MembershipEntitlementCopyWith<$Res>  {
  factory $MembershipEntitlementCopyWith(MembershipEntitlement value, $Res Function(MembershipEntitlement) _then) = _$MembershipEntitlementCopyWithImpl;
@useResult
$Res call({
 MembershipTier tier, bool isActive, bool willRenew, String? productId, DateTime? expiresAt, String? managementUrl
});




}
/// @nodoc
class _$MembershipEntitlementCopyWithImpl<$Res>
    implements $MembershipEntitlementCopyWith<$Res> {
  _$MembershipEntitlementCopyWithImpl(this._self, this._then);

  final MembershipEntitlement _self;
  final $Res Function(MembershipEntitlement) _then;

/// Create a copy of MembershipEntitlement
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? tier = null,Object? isActive = null,Object? willRenew = null,Object? productId = freezed,Object? expiresAt = freezed,Object? managementUrl = freezed,}) {
  return _then(_self.copyWith(
tier: null == tier ? _self.tier : tier // ignore: cast_nullable_to_non_nullable
as MembershipTier,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,willRenew: null == willRenew ? _self.willRenew : willRenew // ignore: cast_nullable_to_non_nullable
as bool,productId: freezed == productId ? _self.productId : productId // ignore: cast_nullable_to_non_nullable
as String?,expiresAt: freezed == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime?,managementUrl: freezed == managementUrl ? _self.managementUrl : managementUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [MembershipEntitlement].
extension MembershipEntitlementPatterns on MembershipEntitlement {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MembershipEntitlement value)?  $default,{TResult Function( _FreeMembershipEntitlement value)?  free,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MembershipEntitlement() when $default != null:
return $default(_that);case _FreeMembershipEntitlement() when free != null:
return free(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MembershipEntitlement value)  $default,{required TResult Function( _FreeMembershipEntitlement value)  free,}){
final _that = this;
switch (_that) {
case _MembershipEntitlement():
return $default(_that);case _FreeMembershipEntitlement():
return free(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MembershipEntitlement value)?  $default,{TResult? Function( _FreeMembershipEntitlement value)?  free,}){
final _that = this;
switch (_that) {
case _MembershipEntitlement() when $default != null:
return $default(_that);case _FreeMembershipEntitlement() when free != null:
return free(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( MembershipTier tier,  bool isActive,  bool willRenew,  String? productId,  DateTime? expiresAt,  String? managementUrl)?  $default,{TResult Function( MembershipTier tier,  bool isActive,  bool willRenew,  String? productId,  DateTime? expiresAt,  String? managementUrl)?  free,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MembershipEntitlement() when $default != null:
return $default(_that.tier,_that.isActive,_that.willRenew,_that.productId,_that.expiresAt,_that.managementUrl);case _FreeMembershipEntitlement() when free != null:
return free(_that.tier,_that.isActive,_that.willRenew,_that.productId,_that.expiresAt,_that.managementUrl);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( MembershipTier tier,  bool isActive,  bool willRenew,  String? productId,  DateTime? expiresAt,  String? managementUrl)  $default,{required TResult Function( MembershipTier tier,  bool isActive,  bool willRenew,  String? productId,  DateTime? expiresAt,  String? managementUrl)  free,}) {final _that = this;
switch (_that) {
case _MembershipEntitlement():
return $default(_that.tier,_that.isActive,_that.willRenew,_that.productId,_that.expiresAt,_that.managementUrl);case _FreeMembershipEntitlement():
return free(_that.tier,_that.isActive,_that.willRenew,_that.productId,_that.expiresAt,_that.managementUrl);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( MembershipTier tier,  bool isActive,  bool willRenew,  String? productId,  DateTime? expiresAt,  String? managementUrl)?  $default,{TResult? Function( MembershipTier tier,  bool isActive,  bool willRenew,  String? productId,  DateTime? expiresAt,  String? managementUrl)?  free,}) {final _that = this;
switch (_that) {
case _MembershipEntitlement() when $default != null:
return $default(_that.tier,_that.isActive,_that.willRenew,_that.productId,_that.expiresAt,_that.managementUrl);case _FreeMembershipEntitlement() when free != null:
return free(_that.tier,_that.isActive,_that.willRenew,_that.productId,_that.expiresAt,_that.managementUrl);case _:
  return null;

}
}

}

/// @nodoc


class _MembershipEntitlement extends MembershipEntitlement {
  const _MembershipEntitlement({required this.tier, this.isActive = false, this.willRenew = false, this.productId, this.expiresAt, this.managementUrl}): super._();
  

@override final  MembershipTier tier;
@override@JsonKey() final  bool isActive;
@override@JsonKey() final  bool willRenew;
@override final  String? productId;
@override final  DateTime? expiresAt;
@override final  String? managementUrl;

/// Create a copy of MembershipEntitlement
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MembershipEntitlementCopyWith<_MembershipEntitlement> get copyWith => __$MembershipEntitlementCopyWithImpl<_MembershipEntitlement>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MembershipEntitlement&&(identical(other.tier, tier) || other.tier == tier)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.willRenew, willRenew) || other.willRenew == willRenew)&&(identical(other.productId, productId) || other.productId == productId)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt)&&(identical(other.managementUrl, managementUrl) || other.managementUrl == managementUrl));
}


@override
int get hashCode => Object.hash(runtimeType,tier,isActive,willRenew,productId,expiresAt,managementUrl);

@override
String toString() {
  return 'MembershipEntitlement(tier: $tier, isActive: $isActive, willRenew: $willRenew, productId: $productId, expiresAt: $expiresAt, managementUrl: $managementUrl)';
}


}

/// @nodoc
abstract mixin class _$MembershipEntitlementCopyWith<$Res> implements $MembershipEntitlementCopyWith<$Res> {
  factory _$MembershipEntitlementCopyWith(_MembershipEntitlement value, $Res Function(_MembershipEntitlement) _then) = __$MembershipEntitlementCopyWithImpl;
@override @useResult
$Res call({
 MembershipTier tier, bool isActive, bool willRenew, String? productId, DateTime? expiresAt, String? managementUrl
});




}
/// @nodoc
class __$MembershipEntitlementCopyWithImpl<$Res>
    implements _$MembershipEntitlementCopyWith<$Res> {
  __$MembershipEntitlementCopyWithImpl(this._self, this._then);

  final _MembershipEntitlement _self;
  final $Res Function(_MembershipEntitlement) _then;

/// Create a copy of MembershipEntitlement
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? tier = null,Object? isActive = null,Object? willRenew = null,Object? productId = freezed,Object? expiresAt = freezed,Object? managementUrl = freezed,}) {
  return _then(_MembershipEntitlement(
tier: null == tier ? _self.tier : tier // ignore: cast_nullable_to_non_nullable
as MembershipTier,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,willRenew: null == willRenew ? _self.willRenew : willRenew // ignore: cast_nullable_to_non_nullable
as bool,productId: freezed == productId ? _self.productId : productId // ignore: cast_nullable_to_non_nullable
as String?,expiresAt: freezed == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime?,managementUrl: freezed == managementUrl ? _self.managementUrl : managementUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class _FreeMembershipEntitlement extends MembershipEntitlement {
  const _FreeMembershipEntitlement({this.tier = MembershipTier.free, this.isActive = false, this.willRenew = false, this.productId, this.expiresAt, this.managementUrl}): super._();
  

@override@JsonKey() final  MembershipTier tier;
@override@JsonKey() final  bool isActive;
@override@JsonKey() final  bool willRenew;
@override final  String? productId;
@override final  DateTime? expiresAt;
@override final  String? managementUrl;

/// Create a copy of MembershipEntitlement
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FreeMembershipEntitlementCopyWith<_FreeMembershipEntitlement> get copyWith => __$FreeMembershipEntitlementCopyWithImpl<_FreeMembershipEntitlement>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FreeMembershipEntitlement&&(identical(other.tier, tier) || other.tier == tier)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.willRenew, willRenew) || other.willRenew == willRenew)&&(identical(other.productId, productId) || other.productId == productId)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt)&&(identical(other.managementUrl, managementUrl) || other.managementUrl == managementUrl));
}


@override
int get hashCode => Object.hash(runtimeType,tier,isActive,willRenew,productId,expiresAt,managementUrl);

@override
String toString() {
  return 'MembershipEntitlement.free(tier: $tier, isActive: $isActive, willRenew: $willRenew, productId: $productId, expiresAt: $expiresAt, managementUrl: $managementUrl)';
}


}

/// @nodoc
abstract mixin class _$FreeMembershipEntitlementCopyWith<$Res> implements $MembershipEntitlementCopyWith<$Res> {
  factory _$FreeMembershipEntitlementCopyWith(_FreeMembershipEntitlement value, $Res Function(_FreeMembershipEntitlement) _then) = __$FreeMembershipEntitlementCopyWithImpl;
@override @useResult
$Res call({
 MembershipTier tier, bool isActive, bool willRenew, String? productId, DateTime? expiresAt, String? managementUrl
});




}
/// @nodoc
class __$FreeMembershipEntitlementCopyWithImpl<$Res>
    implements _$FreeMembershipEntitlementCopyWith<$Res> {
  __$FreeMembershipEntitlementCopyWithImpl(this._self, this._then);

  final _FreeMembershipEntitlement _self;
  final $Res Function(_FreeMembershipEntitlement) _then;

/// Create a copy of MembershipEntitlement
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? tier = null,Object? isActive = null,Object? willRenew = null,Object? productId = freezed,Object? expiresAt = freezed,Object? managementUrl = freezed,}) {
  return _then(_FreeMembershipEntitlement(
tier: null == tier ? _self.tier : tier // ignore: cast_nullable_to_non_nullable
as MembershipTier,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,willRenew: null == willRenew ? _self.willRenew : willRenew // ignore: cast_nullable_to_non_nullable
as bool,productId: freezed == productId ? _self.productId : productId // ignore: cast_nullable_to_non_nullable
as String?,expiresAt: freezed == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime?,managementUrl: freezed == managementUrl ? _self.managementUrl : managementUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
