// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'view_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$HomeScreenState {

/// 地震データ（未取得はnull）
 EarthquakeResponse? get earthquakeResponse;/// 選択中の都道府県コード（未選択はnull）
 String? get selectedPrefecture;/// エラーメッセージ
 String? get errorMessage;
/// Create a copy of HomeScreenState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HomeScreenStateCopyWith<HomeScreenState> get copyWith => _$HomeScreenStateCopyWithImpl<HomeScreenState>(this as HomeScreenState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HomeScreenState&&(identical(other.earthquakeResponse, earthquakeResponse) || other.earthquakeResponse == earthquakeResponse)&&(identical(other.selectedPrefecture, selectedPrefecture) || other.selectedPrefecture == selectedPrefecture)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,earthquakeResponse,selectedPrefecture,errorMessage);

@override
String toString() {
  return 'HomeScreenState(earthquakeResponse: $earthquakeResponse, selectedPrefecture: $selectedPrefecture, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class $HomeScreenStateCopyWith<$Res>  {
  factory $HomeScreenStateCopyWith(HomeScreenState value, $Res Function(HomeScreenState) _then) = _$HomeScreenStateCopyWithImpl;
@useResult
$Res call({
 EarthquakeResponse? earthquakeResponse, String? selectedPrefecture, String? errorMessage
});


$EarthquakeResponseCopyWith<$Res>? get earthquakeResponse;

}
/// @nodoc
class _$HomeScreenStateCopyWithImpl<$Res>
    implements $HomeScreenStateCopyWith<$Res> {
  _$HomeScreenStateCopyWithImpl(this._self, this._then);

  final HomeScreenState _self;
  final $Res Function(HomeScreenState) _then;

/// Create a copy of HomeScreenState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? earthquakeResponse = freezed,Object? selectedPrefecture = freezed,Object? errorMessage = freezed,}) {
  return _then(_self.copyWith(
earthquakeResponse: freezed == earthquakeResponse ? _self.earthquakeResponse : earthquakeResponse // ignore: cast_nullable_to_non_nullable
as EarthquakeResponse?,selectedPrefecture: freezed == selectedPrefecture ? _self.selectedPrefecture : selectedPrefecture // ignore: cast_nullable_to_non_nullable
as String?,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of HomeScreenState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EarthquakeResponseCopyWith<$Res>? get earthquakeResponse {
    if (_self.earthquakeResponse == null) {
    return null;
  }

  return $EarthquakeResponseCopyWith<$Res>(_self.earthquakeResponse!, (value) {
    return _then(_self.copyWith(earthquakeResponse: value));
  });
}
}


/// Adds pattern-matching-related methods to [HomeScreenState].
extension HomeScreenStatePatterns on HomeScreenState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HomeScreenState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HomeScreenState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HomeScreenState value)  $default,){
final _that = this;
switch (_that) {
case _HomeScreenState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HomeScreenState value)?  $default,){
final _that = this;
switch (_that) {
case _HomeScreenState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( EarthquakeResponse? earthquakeResponse,  String? selectedPrefecture,  String? errorMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HomeScreenState() when $default != null:
return $default(_that.earthquakeResponse,_that.selectedPrefecture,_that.errorMessage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( EarthquakeResponse? earthquakeResponse,  String? selectedPrefecture,  String? errorMessage)  $default,) {final _that = this;
switch (_that) {
case _HomeScreenState():
return $default(_that.earthquakeResponse,_that.selectedPrefecture,_that.errorMessage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( EarthquakeResponse? earthquakeResponse,  String? selectedPrefecture,  String? errorMessage)?  $default,) {final _that = this;
switch (_that) {
case _HomeScreenState() when $default != null:
return $default(_that.earthquakeResponse,_that.selectedPrefecture,_that.errorMessage);case _:
  return null;

}
}

}

/// @nodoc


class _HomeScreenState implements HomeScreenState {
  const _HomeScreenState({this.earthquakeResponse, this.selectedPrefecture, this.errorMessage});
  

/// 地震データ（未取得はnull）
@override final  EarthquakeResponse? earthquakeResponse;
/// 選択中の都道府県コード（未選択はnull）
@override final  String? selectedPrefecture;
/// エラーメッセージ
@override final  String? errorMessage;

/// Create a copy of HomeScreenState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HomeScreenStateCopyWith<_HomeScreenState> get copyWith => __$HomeScreenStateCopyWithImpl<_HomeScreenState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HomeScreenState&&(identical(other.earthquakeResponse, earthquakeResponse) || other.earthquakeResponse == earthquakeResponse)&&(identical(other.selectedPrefecture, selectedPrefecture) || other.selectedPrefecture == selectedPrefecture)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,earthquakeResponse,selectedPrefecture,errorMessage);

@override
String toString() {
  return 'HomeScreenState(earthquakeResponse: $earthquakeResponse, selectedPrefecture: $selectedPrefecture, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class _$HomeScreenStateCopyWith<$Res> implements $HomeScreenStateCopyWith<$Res> {
  factory _$HomeScreenStateCopyWith(_HomeScreenState value, $Res Function(_HomeScreenState) _then) = __$HomeScreenStateCopyWithImpl;
@override @useResult
$Res call({
 EarthquakeResponse? earthquakeResponse, String? selectedPrefecture, String? errorMessage
});


@override $EarthquakeResponseCopyWith<$Res>? get earthquakeResponse;

}
/// @nodoc
class __$HomeScreenStateCopyWithImpl<$Res>
    implements _$HomeScreenStateCopyWith<$Res> {
  __$HomeScreenStateCopyWithImpl(this._self, this._then);

  final _HomeScreenState _self;
  final $Res Function(_HomeScreenState) _then;

/// Create a copy of HomeScreenState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? earthquakeResponse = freezed,Object? selectedPrefecture = freezed,Object? errorMessage = freezed,}) {
  return _then(_HomeScreenState(
earthquakeResponse: freezed == earthquakeResponse ? _self.earthquakeResponse : earthquakeResponse // ignore: cast_nullable_to_non_nullable
as EarthquakeResponse?,selectedPrefecture: freezed == selectedPrefecture ? _self.selectedPrefecture : selectedPrefecture // ignore: cast_nullable_to_non_nullable
as String?,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of HomeScreenState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EarthquakeResponseCopyWith<$Res>? get earthquakeResponse {
    if (_self.earthquakeResponse == null) {
    return null;
  }

  return $EarthquakeResponseCopyWith<$Res>(_self.earthquakeResponse!, (value) {
    return _then(_self.copyWith(earthquakeResponse: value));
  });
}
}

// dart format on
