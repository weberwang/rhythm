// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'membership_snapshot.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$MembershipPlan {

 String get packageId; MembershipTier get tier; String get priceLabel; bool get isRecommended; bool get isTrialEligible;
/// Create a copy of MembershipPlan
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MembershipPlanCopyWith<MembershipPlan> get copyWith => _$MembershipPlanCopyWithImpl<MembershipPlan>(this as MembershipPlan, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MembershipPlan&&(identical(other.packageId, packageId) || other.packageId == packageId)&&(identical(other.tier, tier) || other.tier == tier)&&(identical(other.priceLabel, priceLabel) || other.priceLabel == priceLabel)&&(identical(other.isRecommended, isRecommended) || other.isRecommended == isRecommended)&&(identical(other.isTrialEligible, isTrialEligible) || other.isTrialEligible == isTrialEligible));
}


@override
int get hashCode => Object.hash(runtimeType,packageId,tier,priceLabel,isRecommended,isTrialEligible);

@override
String toString() {
  return 'MembershipPlan(packageId: $packageId, tier: $tier, priceLabel: $priceLabel, isRecommended: $isRecommended, isTrialEligible: $isTrialEligible)';
}


}

/// @nodoc
abstract mixin class $MembershipPlanCopyWith<$Res>  {
  factory $MembershipPlanCopyWith(MembershipPlan value, $Res Function(MembershipPlan) _then) = _$MembershipPlanCopyWithImpl;
@useResult
$Res call({
 String packageId, MembershipTier tier, String priceLabel, bool isRecommended, bool isTrialEligible
});




}
/// @nodoc
class _$MembershipPlanCopyWithImpl<$Res>
    implements $MembershipPlanCopyWith<$Res> {
  _$MembershipPlanCopyWithImpl(this._self, this._then);

  final MembershipPlan _self;
  final $Res Function(MembershipPlan) _then;

/// Create a copy of MembershipPlan
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? packageId = null,Object? tier = null,Object? priceLabel = null,Object? isRecommended = null,Object? isTrialEligible = null,}) {
  return _then(_self.copyWith(
packageId: null == packageId ? _self.packageId : packageId // ignore: cast_nullable_to_non_nullable
as String,tier: null == tier ? _self.tier : tier // ignore: cast_nullable_to_non_nullable
as MembershipTier,priceLabel: null == priceLabel ? _self.priceLabel : priceLabel // ignore: cast_nullable_to_non_nullable
as String,isRecommended: null == isRecommended ? _self.isRecommended : isRecommended // ignore: cast_nullable_to_non_nullable
as bool,isTrialEligible: null == isTrialEligible ? _self.isTrialEligible : isTrialEligible // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [MembershipPlan].
extension MembershipPlanPatterns on MembershipPlan {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MembershipPlan value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MembershipPlan() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MembershipPlan value)  $default,){
final _that = this;
switch (_that) {
case _MembershipPlan():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MembershipPlan value)?  $default,){
final _that = this;
switch (_that) {
case _MembershipPlan() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String packageId,  MembershipTier tier,  String priceLabel,  bool isRecommended,  bool isTrialEligible)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MembershipPlan() when $default != null:
return $default(_that.packageId,_that.tier,_that.priceLabel,_that.isRecommended,_that.isTrialEligible);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String packageId,  MembershipTier tier,  String priceLabel,  bool isRecommended,  bool isTrialEligible)  $default,) {final _that = this;
switch (_that) {
case _MembershipPlan():
return $default(_that.packageId,_that.tier,_that.priceLabel,_that.isRecommended,_that.isTrialEligible);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String packageId,  MembershipTier tier,  String priceLabel,  bool isRecommended,  bool isTrialEligible)?  $default,) {final _that = this;
switch (_that) {
case _MembershipPlan() when $default != null:
return $default(_that.packageId,_that.tier,_that.priceLabel,_that.isRecommended,_that.isTrialEligible);case _:
  return null;

}
}

}

/// @nodoc


class _MembershipPlan extends MembershipPlan {
  const _MembershipPlan({required this.packageId, required this.tier, required this.priceLabel, this.isRecommended = false, this.isTrialEligible = false}): super._();
  

@override final  String packageId;
@override final  MembershipTier tier;
@override final  String priceLabel;
@override@JsonKey() final  bool isRecommended;
@override@JsonKey() final  bool isTrialEligible;

/// Create a copy of MembershipPlan
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MembershipPlanCopyWith<_MembershipPlan> get copyWith => __$MembershipPlanCopyWithImpl<_MembershipPlan>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MembershipPlan&&(identical(other.packageId, packageId) || other.packageId == packageId)&&(identical(other.tier, tier) || other.tier == tier)&&(identical(other.priceLabel, priceLabel) || other.priceLabel == priceLabel)&&(identical(other.isRecommended, isRecommended) || other.isRecommended == isRecommended)&&(identical(other.isTrialEligible, isTrialEligible) || other.isTrialEligible == isTrialEligible));
}


@override
int get hashCode => Object.hash(runtimeType,packageId,tier,priceLabel,isRecommended,isTrialEligible);

@override
String toString() {
  return 'MembershipPlan(packageId: $packageId, tier: $tier, priceLabel: $priceLabel, isRecommended: $isRecommended, isTrialEligible: $isTrialEligible)';
}


}

/// @nodoc
abstract mixin class _$MembershipPlanCopyWith<$Res> implements $MembershipPlanCopyWith<$Res> {
  factory _$MembershipPlanCopyWith(_MembershipPlan value, $Res Function(_MembershipPlan) _then) = __$MembershipPlanCopyWithImpl;
@override @useResult
$Res call({
 String packageId, MembershipTier tier, String priceLabel, bool isRecommended, bool isTrialEligible
});




}
/// @nodoc
class __$MembershipPlanCopyWithImpl<$Res>
    implements _$MembershipPlanCopyWith<$Res> {
  __$MembershipPlanCopyWithImpl(this._self, this._then);

  final _MembershipPlan _self;
  final $Res Function(_MembershipPlan) _then;

/// Create a copy of MembershipPlan
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? packageId = null,Object? tier = null,Object? priceLabel = null,Object? isRecommended = null,Object? isTrialEligible = null,}) {
  return _then(_MembershipPlan(
packageId: null == packageId ? _self.packageId : packageId // ignore: cast_nullable_to_non_nullable
as String,tier: null == tier ? _self.tier : tier // ignore: cast_nullable_to_non_nullable
as MembershipTier,priceLabel: null == priceLabel ? _self.priceLabel : priceLabel // ignore: cast_nullable_to_non_nullable
as String,isRecommended: null == isRecommended ? _self.isRecommended : isRecommended // ignore: cast_nullable_to_non_nullable
as bool,isTrialEligible: null == isTrialEligible ? _self.isTrialEligible : isTrialEligible // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc
mixin _$MembershipSnapshot {

 bool get isConfigured; MembershipEntitlement get entitlement; List<MembershipPlan> get plans; String? get managementUrl; String? get activeOfferingId;
/// Create a copy of MembershipSnapshot
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MembershipSnapshotCopyWith<MembershipSnapshot> get copyWith => _$MembershipSnapshotCopyWithImpl<MembershipSnapshot>(this as MembershipSnapshot, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MembershipSnapshot&&(identical(other.isConfigured, isConfigured) || other.isConfigured == isConfigured)&&(identical(other.entitlement, entitlement) || other.entitlement == entitlement)&&const DeepCollectionEquality().equals(other.plans, plans)&&(identical(other.managementUrl, managementUrl) || other.managementUrl == managementUrl)&&(identical(other.activeOfferingId, activeOfferingId) || other.activeOfferingId == activeOfferingId));
}


@override
int get hashCode => Object.hash(runtimeType,isConfigured,entitlement,const DeepCollectionEquality().hash(plans),managementUrl,activeOfferingId);

@override
String toString() {
  return 'MembershipSnapshot(isConfigured: $isConfigured, entitlement: $entitlement, plans: $plans, managementUrl: $managementUrl, activeOfferingId: $activeOfferingId)';
}


}

/// @nodoc
abstract mixin class $MembershipSnapshotCopyWith<$Res>  {
  factory $MembershipSnapshotCopyWith(MembershipSnapshot value, $Res Function(MembershipSnapshot) _then) = _$MembershipSnapshotCopyWithImpl;
@useResult
$Res call({
 bool isConfigured, MembershipEntitlement entitlement, List<MembershipPlan> plans, String? managementUrl, String? activeOfferingId
});


$MembershipEntitlementCopyWith<$Res> get entitlement;

}
/// @nodoc
class _$MembershipSnapshotCopyWithImpl<$Res>
    implements $MembershipSnapshotCopyWith<$Res> {
  _$MembershipSnapshotCopyWithImpl(this._self, this._then);

  final MembershipSnapshot _self;
  final $Res Function(MembershipSnapshot) _then;

/// Create a copy of MembershipSnapshot
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isConfigured = null,Object? entitlement = null,Object? plans = null,Object? managementUrl = freezed,Object? activeOfferingId = freezed,}) {
  return _then(_self.copyWith(
isConfigured: null == isConfigured ? _self.isConfigured : isConfigured // ignore: cast_nullable_to_non_nullable
as bool,entitlement: null == entitlement ? _self.entitlement : entitlement // ignore: cast_nullable_to_non_nullable
as MembershipEntitlement,plans: null == plans ? _self.plans : plans // ignore: cast_nullable_to_non_nullable
as List<MembershipPlan>,managementUrl: freezed == managementUrl ? _self.managementUrl : managementUrl // ignore: cast_nullable_to_non_nullable
as String?,activeOfferingId: freezed == activeOfferingId ? _self.activeOfferingId : activeOfferingId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of MembershipSnapshot
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MembershipEntitlementCopyWith<$Res> get entitlement {
  
  return $MembershipEntitlementCopyWith<$Res>(_self.entitlement, (value) {
    return _then(_self.copyWith(entitlement: value));
  });
}
}


/// Adds pattern-matching-related methods to [MembershipSnapshot].
extension MembershipSnapshotPatterns on MembershipSnapshot {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MembershipSnapshot value)?  $default,{TResult Function( _MembershipSnapshotFallback value)?  fallback,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MembershipSnapshot() when $default != null:
return $default(_that);case _MembershipSnapshotFallback() when fallback != null:
return fallback(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MembershipSnapshot value)  $default,{required TResult Function( _MembershipSnapshotFallback value)  fallback,}){
final _that = this;
switch (_that) {
case _MembershipSnapshot():
return $default(_that);case _MembershipSnapshotFallback():
return fallback(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MembershipSnapshot value)?  $default,{TResult? Function( _MembershipSnapshotFallback value)?  fallback,}){
final _that = this;
switch (_that) {
case _MembershipSnapshot() when $default != null:
return $default(_that);case _MembershipSnapshotFallback() when fallback != null:
return fallback(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isConfigured,  MembershipEntitlement entitlement,  List<MembershipPlan> plans,  String? managementUrl,  String? activeOfferingId)?  $default,{TResult Function( bool isConfigured,  MembershipEntitlement entitlement,  List<MembershipPlan> plans,  String? managementUrl,  String? activeOfferingId)?  fallback,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MembershipSnapshot() when $default != null:
return $default(_that.isConfigured,_that.entitlement,_that.plans,_that.managementUrl,_that.activeOfferingId);case _MembershipSnapshotFallback() when fallback != null:
return fallback(_that.isConfigured,_that.entitlement,_that.plans,_that.managementUrl,_that.activeOfferingId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isConfigured,  MembershipEntitlement entitlement,  List<MembershipPlan> plans,  String? managementUrl,  String? activeOfferingId)  $default,{required TResult Function( bool isConfigured,  MembershipEntitlement entitlement,  List<MembershipPlan> plans,  String? managementUrl,  String? activeOfferingId)  fallback,}) {final _that = this;
switch (_that) {
case _MembershipSnapshot():
return $default(_that.isConfigured,_that.entitlement,_that.plans,_that.managementUrl,_that.activeOfferingId);case _MembershipSnapshotFallback():
return fallback(_that.isConfigured,_that.entitlement,_that.plans,_that.managementUrl,_that.activeOfferingId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isConfigured,  MembershipEntitlement entitlement,  List<MembershipPlan> plans,  String? managementUrl,  String? activeOfferingId)?  $default,{TResult? Function( bool isConfigured,  MembershipEntitlement entitlement,  List<MembershipPlan> plans,  String? managementUrl,  String? activeOfferingId)?  fallback,}) {final _that = this;
switch (_that) {
case _MembershipSnapshot() when $default != null:
return $default(_that.isConfigured,_that.entitlement,_that.plans,_that.managementUrl,_that.activeOfferingId);case _MembershipSnapshotFallback() when fallback != null:
return fallback(_that.isConfigured,_that.entitlement,_that.plans,_that.managementUrl,_that.activeOfferingId);case _:
  return null;

}
}

}

/// @nodoc


class _MembershipSnapshot extends MembershipSnapshot {
  const _MembershipSnapshot({required this.isConfigured, required this.entitlement, final  List<MembershipPlan> plans = const <MembershipPlan>[], this.managementUrl, this.activeOfferingId}): _plans = plans,super._();
  

@override final  bool isConfigured;
@override final  MembershipEntitlement entitlement;
 final  List<MembershipPlan> _plans;
@override@JsonKey() List<MembershipPlan> get plans {
  if (_plans is EqualUnmodifiableListView) return _plans;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_plans);
}

@override final  String? managementUrl;
@override final  String? activeOfferingId;

/// Create a copy of MembershipSnapshot
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MembershipSnapshotCopyWith<_MembershipSnapshot> get copyWith => __$MembershipSnapshotCopyWithImpl<_MembershipSnapshot>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MembershipSnapshot&&(identical(other.isConfigured, isConfigured) || other.isConfigured == isConfigured)&&(identical(other.entitlement, entitlement) || other.entitlement == entitlement)&&const DeepCollectionEquality().equals(other._plans, _plans)&&(identical(other.managementUrl, managementUrl) || other.managementUrl == managementUrl)&&(identical(other.activeOfferingId, activeOfferingId) || other.activeOfferingId == activeOfferingId));
}


@override
int get hashCode => Object.hash(runtimeType,isConfigured,entitlement,const DeepCollectionEquality().hash(_plans),managementUrl,activeOfferingId);

@override
String toString() {
  return 'MembershipSnapshot(isConfigured: $isConfigured, entitlement: $entitlement, plans: $plans, managementUrl: $managementUrl, activeOfferingId: $activeOfferingId)';
}


}

/// @nodoc
abstract mixin class _$MembershipSnapshotCopyWith<$Res> implements $MembershipSnapshotCopyWith<$Res> {
  factory _$MembershipSnapshotCopyWith(_MembershipSnapshot value, $Res Function(_MembershipSnapshot) _then) = __$MembershipSnapshotCopyWithImpl;
@override @useResult
$Res call({
 bool isConfigured, MembershipEntitlement entitlement, List<MembershipPlan> plans, String? managementUrl, String? activeOfferingId
});


@override $MembershipEntitlementCopyWith<$Res> get entitlement;

}
/// @nodoc
class __$MembershipSnapshotCopyWithImpl<$Res>
    implements _$MembershipSnapshotCopyWith<$Res> {
  __$MembershipSnapshotCopyWithImpl(this._self, this._then);

  final _MembershipSnapshot _self;
  final $Res Function(_MembershipSnapshot) _then;

/// Create a copy of MembershipSnapshot
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isConfigured = null,Object? entitlement = null,Object? plans = null,Object? managementUrl = freezed,Object? activeOfferingId = freezed,}) {
  return _then(_MembershipSnapshot(
isConfigured: null == isConfigured ? _self.isConfigured : isConfigured // ignore: cast_nullable_to_non_nullable
as bool,entitlement: null == entitlement ? _self.entitlement : entitlement // ignore: cast_nullable_to_non_nullable
as MembershipEntitlement,plans: null == plans ? _self._plans : plans // ignore: cast_nullable_to_non_nullable
as List<MembershipPlan>,managementUrl: freezed == managementUrl ? _self.managementUrl : managementUrl // ignore: cast_nullable_to_non_nullable
as String?,activeOfferingId: freezed == activeOfferingId ? _self.activeOfferingId : activeOfferingId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of MembershipSnapshot
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MembershipEntitlementCopyWith<$Res> get entitlement {
  
  return $MembershipEntitlementCopyWith<$Res>(_self.entitlement, (value) {
    return _then(_self.copyWith(entitlement: value));
  });
}
}

/// @nodoc


class _MembershipSnapshotFallback extends MembershipSnapshot {
  const _MembershipSnapshotFallback({required this.isConfigured, required this.entitlement, final  List<MembershipPlan> plans = const <MembershipPlan>[], this.managementUrl, this.activeOfferingId}): _plans = plans,super._();
  

@override final  bool isConfigured;
@override final  MembershipEntitlement entitlement;
 final  List<MembershipPlan> _plans;
@override@JsonKey() List<MembershipPlan> get plans {
  if (_plans is EqualUnmodifiableListView) return _plans;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_plans);
}

@override final  String? managementUrl;
@override final  String? activeOfferingId;

/// Create a copy of MembershipSnapshot
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MembershipSnapshotFallbackCopyWith<_MembershipSnapshotFallback> get copyWith => __$MembershipSnapshotFallbackCopyWithImpl<_MembershipSnapshotFallback>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MembershipSnapshotFallback&&(identical(other.isConfigured, isConfigured) || other.isConfigured == isConfigured)&&(identical(other.entitlement, entitlement) || other.entitlement == entitlement)&&const DeepCollectionEquality().equals(other._plans, _plans)&&(identical(other.managementUrl, managementUrl) || other.managementUrl == managementUrl)&&(identical(other.activeOfferingId, activeOfferingId) || other.activeOfferingId == activeOfferingId));
}


@override
int get hashCode => Object.hash(runtimeType,isConfigured,entitlement,const DeepCollectionEquality().hash(_plans),managementUrl,activeOfferingId);

@override
String toString() {
  return 'MembershipSnapshot.fallback(isConfigured: $isConfigured, entitlement: $entitlement, plans: $plans, managementUrl: $managementUrl, activeOfferingId: $activeOfferingId)';
}


}

/// @nodoc
abstract mixin class _$MembershipSnapshotFallbackCopyWith<$Res> implements $MembershipSnapshotCopyWith<$Res> {
  factory _$MembershipSnapshotFallbackCopyWith(_MembershipSnapshotFallback value, $Res Function(_MembershipSnapshotFallback) _then) = __$MembershipSnapshotFallbackCopyWithImpl;
@override @useResult
$Res call({
 bool isConfigured, MembershipEntitlement entitlement, List<MembershipPlan> plans, String? managementUrl, String? activeOfferingId
});


@override $MembershipEntitlementCopyWith<$Res> get entitlement;

}
/// @nodoc
class __$MembershipSnapshotFallbackCopyWithImpl<$Res>
    implements _$MembershipSnapshotFallbackCopyWith<$Res> {
  __$MembershipSnapshotFallbackCopyWithImpl(this._self, this._then);

  final _MembershipSnapshotFallback _self;
  final $Res Function(_MembershipSnapshotFallback) _then;

/// Create a copy of MembershipSnapshot
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isConfigured = null,Object? entitlement = null,Object? plans = null,Object? managementUrl = freezed,Object? activeOfferingId = freezed,}) {
  return _then(_MembershipSnapshotFallback(
isConfigured: null == isConfigured ? _self.isConfigured : isConfigured // ignore: cast_nullable_to_non_nullable
as bool,entitlement: null == entitlement ? _self.entitlement : entitlement // ignore: cast_nullable_to_non_nullable
as MembershipEntitlement,plans: null == plans ? _self._plans : plans // ignore: cast_nullable_to_non_nullable
as List<MembershipPlan>,managementUrl: freezed == managementUrl ? _self.managementUrl : managementUrl // ignore: cast_nullable_to_non_nullable
as String?,activeOfferingId: freezed == activeOfferingId ? _self.activeOfferingId : activeOfferingId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of MembershipSnapshot
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MembershipEntitlementCopyWith<$Res> get entitlement {
  
  return $MembershipEntitlementCopyWith<$Res>(_self.entitlement, (value) {
    return _then(_self.copyWith(entitlement: value));
  });
}
}

// dart format on
