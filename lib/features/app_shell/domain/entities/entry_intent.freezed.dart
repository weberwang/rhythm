// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'entry_intent.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
EntryIntent _$EntryIntentFromJson(
  Map<String, dynamic> json
) {
        switch (json['runtimeType']) {
                  case 'appOpen':
          return AppOpenEntryIntent.fromJson(
            json
          );
                case 'notification':
          return NotificationEntryIntent.fromJson(
            json
          );
                case 'homeWidget':
          return HomeWidgetEntryIntent.fromJson(
            json
          );
        
          default:
            throw CheckedFromJsonException(
  json,
  'runtimeType',
  'EntryIntent',
  'Invalid union type "${json['runtimeType']}"!'
);
        }
      
}

/// @nodoc
mixin _$EntryIntent {



  /// Serializes this EntryIntent to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EntryIntent);
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'EntryIntent()';
}


}

/// @nodoc
class $EntryIntentCopyWith<$Res>  {
$EntryIntentCopyWith(EntryIntent _, $Res Function(EntryIntent) __);
}


/// Adds pattern-matching-related methods to [EntryIntent].
extension EntryIntentPatterns on EntryIntent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( AppOpenEntryIntent value)?  appOpen,TResult Function( NotificationEntryIntent value)?  notification,TResult Function( HomeWidgetEntryIntent value)?  homeWidget,required TResult orElse(),}){
final _that = this;
switch (_that) {
case AppOpenEntryIntent() when appOpen != null:
return appOpen(_that);case NotificationEntryIntent() when notification != null:
return notification(_that);case HomeWidgetEntryIntent() when homeWidget != null:
return homeWidget(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( AppOpenEntryIntent value)  appOpen,required TResult Function( NotificationEntryIntent value)  notification,required TResult Function( HomeWidgetEntryIntent value)  homeWidget,}){
final _that = this;
switch (_that) {
case AppOpenEntryIntent():
return appOpen(_that);case NotificationEntryIntent():
return notification(_that);case HomeWidgetEntryIntent():
return homeWidget(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( AppOpenEntryIntent value)?  appOpen,TResult? Function( NotificationEntryIntent value)?  notification,TResult? Function( HomeWidgetEntryIntent value)?  homeWidget,}){
final _that = this;
switch (_that) {
case AppOpenEntryIntent() when appOpen != null:
return appOpen(_that);case NotificationEntryIntent() when notification != null:
return notification(_that);case HomeWidgetEntryIntent() when homeWidget != null:
return homeWidget(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  appOpen,TResult Function( String target)?  notification,TResult Function( String target)?  homeWidget,required TResult orElse(),}) {final _that = this;
switch (_that) {
case AppOpenEntryIntent() when appOpen != null:
return appOpen();case NotificationEntryIntent() when notification != null:
return notification(_that.target);case HomeWidgetEntryIntent() when homeWidget != null:
return homeWidget(_that.target);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  appOpen,required TResult Function( String target)  notification,required TResult Function( String target)  homeWidget,}) {final _that = this;
switch (_that) {
case AppOpenEntryIntent():
return appOpen();case NotificationEntryIntent():
return notification(_that.target);case HomeWidgetEntryIntent():
return homeWidget(_that.target);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  appOpen,TResult? Function( String target)?  notification,TResult? Function( String target)?  homeWidget,}) {final _that = this;
switch (_that) {
case AppOpenEntryIntent() when appOpen != null:
return appOpen();case NotificationEntryIntent() when notification != null:
return notification(_that.target);case HomeWidgetEntryIntent() when homeWidget != null:
return homeWidget(_that.target);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class AppOpenEntryIntent implements EntryIntent {
  const AppOpenEntryIntent({final  String? $type}): $type = $type ?? 'appOpen';
  factory AppOpenEntryIntent.fromJson(Map<String, dynamic> json) => _$AppOpenEntryIntentFromJson(json);



@JsonKey(name: 'runtimeType')
final String $type;



@override
Map<String, dynamic> toJson() {
  return _$AppOpenEntryIntentToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AppOpenEntryIntent);
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'EntryIntent.appOpen()';
}


}




/// @nodoc
@JsonSerializable()

class NotificationEntryIntent implements EntryIntent {
  const NotificationEntryIntent({required this.target, final  String? $type}): $type = $type ?? 'notification';
  factory NotificationEntryIntent.fromJson(Map<String, dynamic> json) => _$NotificationEntryIntentFromJson(json);

 final  String target;

@JsonKey(name: 'runtimeType')
final String $type;


/// Create a copy of EntryIntent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NotificationEntryIntentCopyWith<NotificationEntryIntent> get copyWith => _$NotificationEntryIntentCopyWithImpl<NotificationEntryIntent>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$NotificationEntryIntentToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NotificationEntryIntent&&(identical(other.target, target) || other.target == target));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,target);

@override
String toString() {
  return 'EntryIntent.notification(target: $target)';
}


}

/// @nodoc
abstract mixin class $NotificationEntryIntentCopyWith<$Res> implements $EntryIntentCopyWith<$Res> {
  factory $NotificationEntryIntentCopyWith(NotificationEntryIntent value, $Res Function(NotificationEntryIntent) _then) = _$NotificationEntryIntentCopyWithImpl;
@useResult
$Res call({
 String target
});




}
/// @nodoc
class _$NotificationEntryIntentCopyWithImpl<$Res>
    implements $NotificationEntryIntentCopyWith<$Res> {
  _$NotificationEntryIntentCopyWithImpl(this._self, this._then);

  final NotificationEntryIntent _self;
  final $Res Function(NotificationEntryIntent) _then;

/// Create a copy of EntryIntent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? target = null,}) {
  return _then(NotificationEntryIntent(
target: null == target ? _self.target : target // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
@JsonSerializable()

class HomeWidgetEntryIntent implements EntryIntent {
  const HomeWidgetEntryIntent({required this.target, final  String? $type}): $type = $type ?? 'homeWidget';
  factory HomeWidgetEntryIntent.fromJson(Map<String, dynamic> json) => _$HomeWidgetEntryIntentFromJson(json);

 final  String target;

@JsonKey(name: 'runtimeType')
final String $type;


/// Create a copy of EntryIntent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HomeWidgetEntryIntentCopyWith<HomeWidgetEntryIntent> get copyWith => _$HomeWidgetEntryIntentCopyWithImpl<HomeWidgetEntryIntent>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$HomeWidgetEntryIntentToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HomeWidgetEntryIntent&&(identical(other.target, target) || other.target == target));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,target);

@override
String toString() {
  return 'EntryIntent.homeWidget(target: $target)';
}


}

/// @nodoc
abstract mixin class $HomeWidgetEntryIntentCopyWith<$Res> implements $EntryIntentCopyWith<$Res> {
  factory $HomeWidgetEntryIntentCopyWith(HomeWidgetEntryIntent value, $Res Function(HomeWidgetEntryIntent) _then) = _$HomeWidgetEntryIntentCopyWithImpl;
@useResult
$Res call({
 String target
});




}
/// @nodoc
class _$HomeWidgetEntryIntentCopyWithImpl<$Res>
    implements $HomeWidgetEntryIntentCopyWith<$Res> {
  _$HomeWidgetEntryIntentCopyWithImpl(this._self, this._then);

  final HomeWidgetEntryIntent _self;
  final $Res Function(HomeWidgetEntryIntent) _then;

/// Create a copy of EntryIntent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? target = null,}) {
  return _then(HomeWidgetEntryIntent(
target: null == target ? _self.target : target // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
