// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'earthquake.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Epicenter {

 String get name; double get latitude; double get longitude; int get depth;
/// Create a copy of Epicenter
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EpicenterCopyWith<Epicenter> get copyWith => _$EpicenterCopyWithImpl<Epicenter>(this as Epicenter, _$identity);

  /// Serializes this Epicenter to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Epicenter&&(identical(other.name, name) || other.name == name)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.depth, depth) || other.depth == depth));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,latitude,longitude,depth);

@override
String toString() {
  return 'Epicenter(name: $name, latitude: $latitude, longitude: $longitude, depth: $depth)';
}


}

/// @nodoc
abstract mixin class $EpicenterCopyWith<$Res>  {
  factory $EpicenterCopyWith(Epicenter value, $Res Function(Epicenter) _then) = _$EpicenterCopyWithImpl;
@useResult
$Res call({
 String name, double latitude, double longitude, int depth
});




}
/// @nodoc
class _$EpicenterCopyWithImpl<$Res>
    implements $EpicenterCopyWith<$Res> {
  _$EpicenterCopyWithImpl(this._self, this._then);

  final Epicenter _self;
  final $Res Function(Epicenter) _then;

/// Create a copy of Epicenter
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? latitude = null,Object? longitude = null,Object? depth = null,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,latitude: null == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double,longitude: null == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double,depth: null == depth ? _self.depth : depth // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [Epicenter].
extension EpicenterPatterns on Epicenter {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Epicenter value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Epicenter() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Epicenter value)  $default,){
final _that = this;
switch (_that) {
case _Epicenter():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Epicenter value)?  $default,){
final _that = this;
switch (_that) {
case _Epicenter() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  double latitude,  double longitude,  int depth)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Epicenter() when $default != null:
return $default(_that.name,_that.latitude,_that.longitude,_that.depth);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  double latitude,  double longitude,  int depth)  $default,) {final _that = this;
switch (_that) {
case _Epicenter():
return $default(_that.name,_that.latitude,_that.longitude,_that.depth);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  double latitude,  double longitude,  int depth)?  $default,) {final _that = this;
switch (_that) {
case _Epicenter() when $default != null:
return $default(_that.name,_that.latitude,_that.longitude,_that.depth);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Epicenter implements Epicenter {
  const _Epicenter({required this.name, required this.latitude, required this.longitude, required this.depth});
  factory _Epicenter.fromJson(Map<String, dynamic> json) => _$EpicenterFromJson(json);

@override final  String name;
@override final  double latitude;
@override final  double longitude;
@override final  int depth;

/// Create a copy of Epicenter
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EpicenterCopyWith<_Epicenter> get copyWith => __$EpicenterCopyWithImpl<_Epicenter>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EpicenterToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Epicenter&&(identical(other.name, name) || other.name == name)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.depth, depth) || other.depth == depth));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,latitude,longitude,depth);

@override
String toString() {
  return 'Epicenter(name: $name, latitude: $latitude, longitude: $longitude, depth: $depth)';
}


}

/// @nodoc
abstract mixin class _$EpicenterCopyWith<$Res> implements $EpicenterCopyWith<$Res> {
  factory _$EpicenterCopyWith(_Epicenter value, $Res Function(_Epicenter) _then) = __$EpicenterCopyWithImpl;
@override @useResult
$Res call({
 String name, double latitude, double longitude, int depth
});




}
/// @nodoc
class __$EpicenterCopyWithImpl<$Res>
    implements _$EpicenterCopyWith<$Res> {
  __$EpicenterCopyWithImpl(this._self, this._then);

  final _Epicenter _self;
  final $Res Function(_Epicenter) _then;

/// Create a copy of Epicenter
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? latitude = null,Object? longitude = null,Object? depth = null,}) {
  return _then(_Epicenter(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,latitude: null == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double,longitude: null == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double,depth: null == depth ? _self.depth : depth // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$Area {

 String get name; String get intensity;
/// Create a copy of Area
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AreaCopyWith<Area> get copyWith => _$AreaCopyWithImpl<Area>(this as Area, _$identity);

  /// Serializes this Area to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Area&&(identical(other.name, name) || other.name == name)&&(identical(other.intensity, intensity) || other.intensity == intensity));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,intensity);

@override
String toString() {
  return 'Area(name: $name, intensity: $intensity)';
}


}

/// @nodoc
abstract mixin class $AreaCopyWith<$Res>  {
  factory $AreaCopyWith(Area value, $Res Function(Area) _then) = _$AreaCopyWithImpl;
@useResult
$Res call({
 String name, String intensity
});




}
/// @nodoc
class _$AreaCopyWithImpl<$Res>
    implements $AreaCopyWith<$Res> {
  _$AreaCopyWithImpl(this._self, this._then);

  final Area _self;
  final $Res Function(Area) _then;

/// Create a copy of Area
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? intensity = null,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,intensity: null == intensity ? _self.intensity : intensity // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [Area].
extension AreaPatterns on Area {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Area value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Area() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Area value)  $default,){
final _that = this;
switch (_that) {
case _Area():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Area value)?  $default,){
final _that = this;
switch (_that) {
case _Area() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  String intensity)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Area() when $default != null:
return $default(_that.name,_that.intensity);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  String intensity)  $default,) {final _that = this;
switch (_that) {
case _Area():
return $default(_that.name,_that.intensity);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  String intensity)?  $default,) {final _that = this;
switch (_that) {
case _Area() when $default != null:
return $default(_that.name,_that.intensity);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Area implements Area {
  const _Area({required this.name, required this.intensity});
  factory _Area.fromJson(Map<String, dynamic> json) => _$AreaFromJson(json);

@override final  String name;
@override final  String intensity;

/// Create a copy of Area
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AreaCopyWith<_Area> get copyWith => __$AreaCopyWithImpl<_Area>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AreaToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Area&&(identical(other.name, name) || other.name == name)&&(identical(other.intensity, intensity) || other.intensity == intensity));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,intensity);

@override
String toString() {
  return 'Area(name: $name, intensity: $intensity)';
}


}

/// @nodoc
abstract mixin class _$AreaCopyWith<$Res> implements $AreaCopyWith<$Res> {
  factory _$AreaCopyWith(_Area value, $Res Function(_Area) _then) = __$AreaCopyWithImpl;
@override @useResult
$Res call({
 String name, String intensity
});




}
/// @nodoc
class __$AreaCopyWithImpl<$Res>
    implements _$AreaCopyWith<$Res> {
  __$AreaCopyWithImpl(this._self, this._then);

  final _Area _self;
  final $Res Function(_Area) _then;

/// Create a copy of Area
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? intensity = null,}) {
  return _then(_Area(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,intensity: null == intensity ? _self.intensity : intensity // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$Earthquake {

 String get id; String get occurredAt; Epicenter get epicenter; double get magnitude; String get maxIntensity; bool get tsunami; List<Area> get areas;
/// Create a copy of Earthquake
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EarthquakeCopyWith<Earthquake> get copyWith => _$EarthquakeCopyWithImpl<Earthquake>(this as Earthquake, _$identity);

  /// Serializes this Earthquake to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Earthquake&&(identical(other.id, id) || other.id == id)&&(identical(other.occurredAt, occurredAt) || other.occurredAt == occurredAt)&&(identical(other.epicenter, epicenter) || other.epicenter == epicenter)&&(identical(other.magnitude, magnitude) || other.magnitude == magnitude)&&(identical(other.maxIntensity, maxIntensity) || other.maxIntensity == maxIntensity)&&(identical(other.tsunami, tsunami) || other.tsunami == tsunami)&&const DeepCollectionEquality().equals(other.areas, areas));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,occurredAt,epicenter,magnitude,maxIntensity,tsunami,const DeepCollectionEquality().hash(areas));

@override
String toString() {
  return 'Earthquake(id: $id, occurredAt: $occurredAt, epicenter: $epicenter, magnitude: $magnitude, maxIntensity: $maxIntensity, tsunami: $tsunami, areas: $areas)';
}


}

/// @nodoc
abstract mixin class $EarthquakeCopyWith<$Res>  {
  factory $EarthquakeCopyWith(Earthquake value, $Res Function(Earthquake) _then) = _$EarthquakeCopyWithImpl;
@useResult
$Res call({
 String id, String occurredAt, Epicenter epicenter, double magnitude, String maxIntensity, bool tsunami, List<Area> areas
});


$EpicenterCopyWith<$Res> get epicenter;

}
/// @nodoc
class _$EarthquakeCopyWithImpl<$Res>
    implements $EarthquakeCopyWith<$Res> {
  _$EarthquakeCopyWithImpl(this._self, this._then);

  final Earthquake _self;
  final $Res Function(Earthquake) _then;

/// Create a copy of Earthquake
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? occurredAt = null,Object? epicenter = null,Object? magnitude = null,Object? maxIntensity = null,Object? tsunami = null,Object? areas = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,occurredAt: null == occurredAt ? _self.occurredAt : occurredAt // ignore: cast_nullable_to_non_nullable
as String,epicenter: null == epicenter ? _self.epicenter : epicenter // ignore: cast_nullable_to_non_nullable
as Epicenter,magnitude: null == magnitude ? _self.magnitude : magnitude // ignore: cast_nullable_to_non_nullable
as double,maxIntensity: null == maxIntensity ? _self.maxIntensity : maxIntensity // ignore: cast_nullable_to_non_nullable
as String,tsunami: null == tsunami ? _self.tsunami : tsunami // ignore: cast_nullable_to_non_nullable
as bool,areas: null == areas ? _self.areas : areas // ignore: cast_nullable_to_non_nullable
as List<Area>,
  ));
}
/// Create a copy of Earthquake
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EpicenterCopyWith<$Res> get epicenter {
  
  return $EpicenterCopyWith<$Res>(_self.epicenter, (value) {
    return _then(_self.copyWith(epicenter: value));
  });
}
}


/// Adds pattern-matching-related methods to [Earthquake].
extension EarthquakePatterns on Earthquake {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Earthquake value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Earthquake() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Earthquake value)  $default,){
final _that = this;
switch (_that) {
case _Earthquake():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Earthquake value)?  $default,){
final _that = this;
switch (_that) {
case _Earthquake() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String occurredAt,  Epicenter epicenter,  double magnitude,  String maxIntensity,  bool tsunami,  List<Area> areas)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Earthquake() when $default != null:
return $default(_that.id,_that.occurredAt,_that.epicenter,_that.magnitude,_that.maxIntensity,_that.tsunami,_that.areas);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String occurredAt,  Epicenter epicenter,  double magnitude,  String maxIntensity,  bool tsunami,  List<Area> areas)  $default,) {final _that = this;
switch (_that) {
case _Earthquake():
return $default(_that.id,_that.occurredAt,_that.epicenter,_that.magnitude,_that.maxIntensity,_that.tsunami,_that.areas);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String occurredAt,  Epicenter epicenter,  double magnitude,  String maxIntensity,  bool tsunami,  List<Area> areas)?  $default,) {final _that = this;
switch (_that) {
case _Earthquake() when $default != null:
return $default(_that.id,_that.occurredAt,_that.epicenter,_that.magnitude,_that.maxIntensity,_that.tsunami,_that.areas);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Earthquake implements Earthquake {
  const _Earthquake({required this.id, required this.occurredAt, required this.epicenter, required this.magnitude, required this.maxIntensity, required this.tsunami, required final  List<Area> areas}): _areas = areas;
  factory _Earthquake.fromJson(Map<String, dynamic> json) => _$EarthquakeFromJson(json);

@override final  String id;
@override final  String occurredAt;
@override final  Epicenter epicenter;
@override final  double magnitude;
@override final  String maxIntensity;
@override final  bool tsunami;
 final  List<Area> _areas;
@override List<Area> get areas {
  if (_areas is EqualUnmodifiableListView) return _areas;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_areas);
}


/// Create a copy of Earthquake
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EarthquakeCopyWith<_Earthquake> get copyWith => __$EarthquakeCopyWithImpl<_Earthquake>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EarthquakeToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Earthquake&&(identical(other.id, id) || other.id == id)&&(identical(other.occurredAt, occurredAt) || other.occurredAt == occurredAt)&&(identical(other.epicenter, epicenter) || other.epicenter == epicenter)&&(identical(other.magnitude, magnitude) || other.magnitude == magnitude)&&(identical(other.maxIntensity, maxIntensity) || other.maxIntensity == maxIntensity)&&(identical(other.tsunami, tsunami) || other.tsunami == tsunami)&&const DeepCollectionEquality().equals(other._areas, _areas));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,occurredAt,epicenter,magnitude,maxIntensity,tsunami,const DeepCollectionEquality().hash(_areas));

@override
String toString() {
  return 'Earthquake(id: $id, occurredAt: $occurredAt, epicenter: $epicenter, magnitude: $magnitude, maxIntensity: $maxIntensity, tsunami: $tsunami, areas: $areas)';
}


}

/// @nodoc
abstract mixin class _$EarthquakeCopyWith<$Res> implements $EarthquakeCopyWith<$Res> {
  factory _$EarthquakeCopyWith(_Earthquake value, $Res Function(_Earthquake) _then) = __$EarthquakeCopyWithImpl;
@override @useResult
$Res call({
 String id, String occurredAt, Epicenter epicenter, double magnitude, String maxIntensity, bool tsunami, List<Area> areas
});


@override $EpicenterCopyWith<$Res> get epicenter;

}
/// @nodoc
class __$EarthquakeCopyWithImpl<$Res>
    implements _$EarthquakeCopyWith<$Res> {
  __$EarthquakeCopyWithImpl(this._self, this._then);

  final _Earthquake _self;
  final $Res Function(_Earthquake) _then;

/// Create a copy of Earthquake
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? occurredAt = null,Object? epicenter = null,Object? magnitude = null,Object? maxIntensity = null,Object? tsunami = null,Object? areas = null,}) {
  return _then(_Earthquake(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,occurredAt: null == occurredAt ? _self.occurredAt : occurredAt // ignore: cast_nullable_to_non_nullable
as String,epicenter: null == epicenter ? _self.epicenter : epicenter // ignore: cast_nullable_to_non_nullable
as Epicenter,magnitude: null == magnitude ? _self.magnitude : magnitude // ignore: cast_nullable_to_non_nullable
as double,maxIntensity: null == maxIntensity ? _self.maxIntensity : maxIntensity // ignore: cast_nullable_to_non_nullable
as String,tsunami: null == tsunami ? _self.tsunami : tsunami // ignore: cast_nullable_to_non_nullable
as bool,areas: null == areas ? _self._areas : areas // ignore: cast_nullable_to_non_nullable
as List<Area>,
  ));
}

/// Create a copy of Earthquake
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EpicenterCopyWith<$Res> get epicenter {
  
  return $EpicenterCopyWith<$Res>(_self.epicenter, (value) {
    return _then(_self.copyWith(epicenter: value));
  });
}
}


/// @nodoc
mixin _$EarthquakeResponse {

 List<Earthquake> get earthquakes;
/// Create a copy of EarthquakeResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EarthquakeResponseCopyWith<EarthquakeResponse> get copyWith => _$EarthquakeResponseCopyWithImpl<EarthquakeResponse>(this as EarthquakeResponse, _$identity);

  /// Serializes this EarthquakeResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EarthquakeResponse&&const DeepCollectionEquality().equals(other.earthquakes, earthquakes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(earthquakes));

@override
String toString() {
  return 'EarthquakeResponse(earthquakes: $earthquakes)';
}


}

/// @nodoc
abstract mixin class $EarthquakeResponseCopyWith<$Res>  {
  factory $EarthquakeResponseCopyWith(EarthquakeResponse value, $Res Function(EarthquakeResponse) _then) = _$EarthquakeResponseCopyWithImpl;
@useResult
$Res call({
 List<Earthquake> earthquakes
});




}
/// @nodoc
class _$EarthquakeResponseCopyWithImpl<$Res>
    implements $EarthquakeResponseCopyWith<$Res> {
  _$EarthquakeResponseCopyWithImpl(this._self, this._then);

  final EarthquakeResponse _self;
  final $Res Function(EarthquakeResponse) _then;

/// Create a copy of EarthquakeResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? earthquakes = null,}) {
  return _then(_self.copyWith(
earthquakes: null == earthquakes ? _self.earthquakes : earthquakes // ignore: cast_nullable_to_non_nullable
as List<Earthquake>,
  ));
}

}


/// Adds pattern-matching-related methods to [EarthquakeResponse].
extension EarthquakeResponsePatterns on EarthquakeResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EarthquakeResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EarthquakeResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EarthquakeResponse value)  $default,){
final _that = this;
switch (_that) {
case _EarthquakeResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EarthquakeResponse value)?  $default,){
final _that = this;
switch (_that) {
case _EarthquakeResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<Earthquake> earthquakes)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EarthquakeResponse() when $default != null:
return $default(_that.earthquakes);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<Earthquake> earthquakes)  $default,) {final _that = this;
switch (_that) {
case _EarthquakeResponse():
return $default(_that.earthquakes);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<Earthquake> earthquakes)?  $default,) {final _that = this;
switch (_that) {
case _EarthquakeResponse() when $default != null:
return $default(_that.earthquakes);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EarthquakeResponse implements EarthquakeResponse {
  const _EarthquakeResponse({required final  List<Earthquake> earthquakes}): _earthquakes = earthquakes;
  factory _EarthquakeResponse.fromJson(Map<String, dynamic> json) => _$EarthquakeResponseFromJson(json);

 final  List<Earthquake> _earthquakes;
@override List<Earthquake> get earthquakes {
  if (_earthquakes is EqualUnmodifiableListView) return _earthquakes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_earthquakes);
}


/// Create a copy of EarthquakeResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EarthquakeResponseCopyWith<_EarthquakeResponse> get copyWith => __$EarthquakeResponseCopyWithImpl<_EarthquakeResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EarthquakeResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EarthquakeResponse&&const DeepCollectionEquality().equals(other._earthquakes, _earthquakes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_earthquakes));

@override
String toString() {
  return 'EarthquakeResponse(earthquakes: $earthquakes)';
}


}

/// @nodoc
abstract mixin class _$EarthquakeResponseCopyWith<$Res> implements $EarthquakeResponseCopyWith<$Res> {
  factory _$EarthquakeResponseCopyWith(_EarthquakeResponse value, $Res Function(_EarthquakeResponse) _then) = __$EarthquakeResponseCopyWithImpl;
@override @useResult
$Res call({
 List<Earthquake> earthquakes
});




}
/// @nodoc
class __$EarthquakeResponseCopyWithImpl<$Res>
    implements _$EarthquakeResponseCopyWith<$Res> {
  __$EarthquakeResponseCopyWithImpl(this._self, this._then);

  final _EarthquakeResponse _self;
  final $Res Function(_EarthquakeResponse) _then;

/// Create a copy of EarthquakeResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? earthquakes = null,}) {
  return _then(_EarthquakeResponse(
earthquakes: null == earthquakes ? _self._earthquakes : earthquakes // ignore: cast_nullable_to_non_nullable
as List<Earthquake>,
  ));
}


}

// dart format on
