// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'bedtime_session_draft.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$BedtimeSessionDraft {

 BedtimeSessionState get currentState; String get targetBedtimeLabel; String get wakeTimeLabel; int get minutesToTarget; BedtimeEntrySource get entrySource; BedtimeStatusChoice? get selectedChoice; BedtimeActionKind get actionKind; BedtimeReminderState get reminderState; bool get isSessionRestored;
/// Create a copy of BedtimeSessionDraft
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BedtimeSessionDraftCopyWith<BedtimeSessionDraft> get copyWith => _$BedtimeSessionDraftCopyWithImpl<BedtimeSessionDraft>(this as BedtimeSessionDraft, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BedtimeSessionDraft&&(identical(other.currentState, currentState) || other.currentState == currentState)&&(identical(other.targetBedtimeLabel, targetBedtimeLabel) || other.targetBedtimeLabel == targetBedtimeLabel)&&(identical(other.wakeTimeLabel, wakeTimeLabel) || other.wakeTimeLabel == wakeTimeLabel)&&(identical(other.minutesToTarget, minutesToTarget) || other.minutesToTarget == minutesToTarget)&&(identical(other.entrySource, entrySource) || other.entrySource == entrySource)&&(identical(other.selectedChoice, selectedChoice) || other.selectedChoice == selectedChoice)&&(identical(other.actionKind, actionKind) || other.actionKind == actionKind)&&(identical(other.reminderState, reminderState) || other.reminderState == reminderState)&&(identical(other.isSessionRestored, isSessionRestored) || other.isSessionRestored == isSessionRestored));
}


@override
int get hashCode => Object.hash(runtimeType,currentState,targetBedtimeLabel,wakeTimeLabel,minutesToTarget,entrySource,selectedChoice,actionKind,reminderState,isSessionRestored);

@override
String toString() {
  return 'BedtimeSessionDraft(currentState: $currentState, targetBedtimeLabel: $targetBedtimeLabel, wakeTimeLabel: $wakeTimeLabel, minutesToTarget: $minutesToTarget, entrySource: $entrySource, selectedChoice: $selectedChoice, actionKind: $actionKind, reminderState: $reminderState, isSessionRestored: $isSessionRestored)';
}


}

/// @nodoc
abstract mixin class $BedtimeSessionDraftCopyWith<$Res>  {
  factory $BedtimeSessionDraftCopyWith(BedtimeSessionDraft value, $Res Function(BedtimeSessionDraft) _then) = _$BedtimeSessionDraftCopyWithImpl;
@useResult
$Res call({
 BedtimeSessionState currentState, String targetBedtimeLabel, String wakeTimeLabel, int minutesToTarget, BedtimeEntrySource entrySource, BedtimeStatusChoice? selectedChoice, BedtimeActionKind actionKind, BedtimeReminderState reminderState, bool isSessionRestored
});




}
/// @nodoc
class _$BedtimeSessionDraftCopyWithImpl<$Res>
    implements $BedtimeSessionDraftCopyWith<$Res> {
  _$BedtimeSessionDraftCopyWithImpl(this._self, this._then);

  final BedtimeSessionDraft _self;
  final $Res Function(BedtimeSessionDraft) _then;

/// Create a copy of BedtimeSessionDraft
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? currentState = null,Object? targetBedtimeLabel = null,Object? wakeTimeLabel = null,Object? minutesToTarget = null,Object? entrySource = null,Object? selectedChoice = freezed,Object? actionKind = null,Object? reminderState = null,Object? isSessionRestored = null,}) {
  return _then(_self.copyWith(
currentState: null == currentState ? _self.currentState : currentState // ignore: cast_nullable_to_non_nullable
as BedtimeSessionState,targetBedtimeLabel: null == targetBedtimeLabel ? _self.targetBedtimeLabel : targetBedtimeLabel // ignore: cast_nullable_to_non_nullable
as String,wakeTimeLabel: null == wakeTimeLabel ? _self.wakeTimeLabel : wakeTimeLabel // ignore: cast_nullable_to_non_nullable
as String,minutesToTarget: null == minutesToTarget ? _self.minutesToTarget : minutesToTarget // ignore: cast_nullable_to_non_nullable
as int,entrySource: null == entrySource ? _self.entrySource : entrySource // ignore: cast_nullable_to_non_nullable
as BedtimeEntrySource,selectedChoice: freezed == selectedChoice ? _self.selectedChoice : selectedChoice // ignore: cast_nullable_to_non_nullable
as BedtimeStatusChoice?,actionKind: null == actionKind ? _self.actionKind : actionKind // ignore: cast_nullable_to_non_nullable
as BedtimeActionKind,reminderState: null == reminderState ? _self.reminderState : reminderState // ignore: cast_nullable_to_non_nullable
as BedtimeReminderState,isSessionRestored: null == isSessionRestored ? _self.isSessionRestored : isSessionRestored // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [BedtimeSessionDraft].
extension BedtimeSessionDraftPatterns on BedtimeSessionDraft {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BedtimeSessionDraft value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BedtimeSessionDraft() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BedtimeSessionDraft value)  $default,){
final _that = this;
switch (_that) {
case _BedtimeSessionDraft():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BedtimeSessionDraft value)?  $default,){
final _that = this;
switch (_that) {
case _BedtimeSessionDraft() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( BedtimeSessionState currentState,  String targetBedtimeLabel,  String wakeTimeLabel,  int minutesToTarget,  BedtimeEntrySource entrySource,  BedtimeStatusChoice? selectedChoice,  BedtimeActionKind actionKind,  BedtimeReminderState reminderState,  bool isSessionRestored)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BedtimeSessionDraft() when $default != null:
return $default(_that.currentState,_that.targetBedtimeLabel,_that.wakeTimeLabel,_that.minutesToTarget,_that.entrySource,_that.selectedChoice,_that.actionKind,_that.reminderState,_that.isSessionRestored);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( BedtimeSessionState currentState,  String targetBedtimeLabel,  String wakeTimeLabel,  int minutesToTarget,  BedtimeEntrySource entrySource,  BedtimeStatusChoice? selectedChoice,  BedtimeActionKind actionKind,  BedtimeReminderState reminderState,  bool isSessionRestored)  $default,) {final _that = this;
switch (_that) {
case _BedtimeSessionDraft():
return $default(_that.currentState,_that.targetBedtimeLabel,_that.wakeTimeLabel,_that.minutesToTarget,_that.entrySource,_that.selectedChoice,_that.actionKind,_that.reminderState,_that.isSessionRestored);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( BedtimeSessionState currentState,  String targetBedtimeLabel,  String wakeTimeLabel,  int minutesToTarget,  BedtimeEntrySource entrySource,  BedtimeStatusChoice? selectedChoice,  BedtimeActionKind actionKind,  BedtimeReminderState reminderState,  bool isSessionRestored)?  $default,) {final _that = this;
switch (_that) {
case _BedtimeSessionDraft() when $default != null:
return $default(_that.currentState,_that.targetBedtimeLabel,_that.wakeTimeLabel,_that.minutesToTarget,_that.entrySource,_that.selectedChoice,_that.actionKind,_that.reminderState,_that.isSessionRestored);case _:
  return null;

}
}

}

/// @nodoc


class _BedtimeSessionDraft implements BedtimeSessionDraft {
  const _BedtimeSessionDraft({required this.currentState, required this.targetBedtimeLabel, required this.wakeTimeLabel, required this.minutesToTarget, required this.entrySource, required this.selectedChoice, required this.actionKind, required this.reminderState, this.isSessionRestored = false});
  

@override final  BedtimeSessionState currentState;
@override final  String targetBedtimeLabel;
@override final  String wakeTimeLabel;
@override final  int minutesToTarget;
@override final  BedtimeEntrySource entrySource;
@override final  BedtimeStatusChoice? selectedChoice;
@override final  BedtimeActionKind actionKind;
@override final  BedtimeReminderState reminderState;
@override@JsonKey() final  bool isSessionRestored;

/// Create a copy of BedtimeSessionDraft
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BedtimeSessionDraftCopyWith<_BedtimeSessionDraft> get copyWith => __$BedtimeSessionDraftCopyWithImpl<_BedtimeSessionDraft>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BedtimeSessionDraft&&(identical(other.currentState, currentState) || other.currentState == currentState)&&(identical(other.targetBedtimeLabel, targetBedtimeLabel) || other.targetBedtimeLabel == targetBedtimeLabel)&&(identical(other.wakeTimeLabel, wakeTimeLabel) || other.wakeTimeLabel == wakeTimeLabel)&&(identical(other.minutesToTarget, minutesToTarget) || other.minutesToTarget == minutesToTarget)&&(identical(other.entrySource, entrySource) || other.entrySource == entrySource)&&(identical(other.selectedChoice, selectedChoice) || other.selectedChoice == selectedChoice)&&(identical(other.actionKind, actionKind) || other.actionKind == actionKind)&&(identical(other.reminderState, reminderState) || other.reminderState == reminderState)&&(identical(other.isSessionRestored, isSessionRestored) || other.isSessionRestored == isSessionRestored));
}


@override
int get hashCode => Object.hash(runtimeType,currentState,targetBedtimeLabel,wakeTimeLabel,minutesToTarget,entrySource,selectedChoice,actionKind,reminderState,isSessionRestored);

@override
String toString() {
  return 'BedtimeSessionDraft(currentState: $currentState, targetBedtimeLabel: $targetBedtimeLabel, wakeTimeLabel: $wakeTimeLabel, minutesToTarget: $minutesToTarget, entrySource: $entrySource, selectedChoice: $selectedChoice, actionKind: $actionKind, reminderState: $reminderState, isSessionRestored: $isSessionRestored)';
}


}

/// @nodoc
abstract mixin class _$BedtimeSessionDraftCopyWith<$Res> implements $BedtimeSessionDraftCopyWith<$Res> {
  factory _$BedtimeSessionDraftCopyWith(_BedtimeSessionDraft value, $Res Function(_BedtimeSessionDraft) _then) = __$BedtimeSessionDraftCopyWithImpl;
@override @useResult
$Res call({
 BedtimeSessionState currentState, String targetBedtimeLabel, String wakeTimeLabel, int minutesToTarget, BedtimeEntrySource entrySource, BedtimeStatusChoice? selectedChoice, BedtimeActionKind actionKind, BedtimeReminderState reminderState, bool isSessionRestored
});




}
/// @nodoc
class __$BedtimeSessionDraftCopyWithImpl<$Res>
    implements _$BedtimeSessionDraftCopyWith<$Res> {
  __$BedtimeSessionDraftCopyWithImpl(this._self, this._then);

  final _BedtimeSessionDraft _self;
  final $Res Function(_BedtimeSessionDraft) _then;

/// Create a copy of BedtimeSessionDraft
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? currentState = null,Object? targetBedtimeLabel = null,Object? wakeTimeLabel = null,Object? minutesToTarget = null,Object? entrySource = null,Object? selectedChoice = freezed,Object? actionKind = null,Object? reminderState = null,Object? isSessionRestored = null,}) {
  return _then(_BedtimeSessionDraft(
currentState: null == currentState ? _self.currentState : currentState // ignore: cast_nullable_to_non_nullable
as BedtimeSessionState,targetBedtimeLabel: null == targetBedtimeLabel ? _self.targetBedtimeLabel : targetBedtimeLabel // ignore: cast_nullable_to_non_nullable
as String,wakeTimeLabel: null == wakeTimeLabel ? _self.wakeTimeLabel : wakeTimeLabel // ignore: cast_nullable_to_non_nullable
as String,minutesToTarget: null == minutesToTarget ? _self.minutesToTarget : minutesToTarget // ignore: cast_nullable_to_non_nullable
as int,entrySource: null == entrySource ? _self.entrySource : entrySource // ignore: cast_nullable_to_non_nullable
as BedtimeEntrySource,selectedChoice: freezed == selectedChoice ? _self.selectedChoice : selectedChoice // ignore: cast_nullable_to_non_nullable
as BedtimeStatusChoice?,actionKind: null == actionKind ? _self.actionKind : actionKind // ignore: cast_nullable_to_non_nullable
as BedtimeActionKind,reminderState: null == reminderState ? _self.reminderState : reminderState // ignore: cast_nullable_to_non_nullable
as BedtimeReminderState,isSessionRestored: null == isSessionRestored ? _self.isSessionRestored : isSessionRestored // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
