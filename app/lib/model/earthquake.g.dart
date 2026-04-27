// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'earthquake.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Epicenter _$EpicenterFromJson(Map<String, dynamic> json) => _Epicenter(
  name: json['name'] as String,
  latitude: (json['latitude'] as num).toDouble(),
  longitude: (json['longitude'] as num).toDouble(),
  depth: (json['depth'] as num).toInt(),
);

Map<String, dynamic> _$EpicenterToJson(_Epicenter instance) =>
    <String, dynamic>{
      'name': instance.name,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'depth': instance.depth,
    };

_Area _$AreaFromJson(Map<String, dynamic> json) =>
    _Area(name: json['name'] as String, intensity: json['intensity'] as String);

Map<String, dynamic> _$AreaToJson(_Area instance) => <String, dynamic>{
  'name': instance.name,
  'intensity': instance.intensity,
};

_Earthquake _$EarthquakeFromJson(Map<String, dynamic> json) => _Earthquake(
  id: json['id'] as String,
  occurredAt: json['occurredAt'] as String,
  epicenter: Epicenter.fromJson(json['epicenter'] as Map<String, dynamic>),
  magnitude: (json['magnitude'] as num).toDouble(),
  maxIntensity: json['maxIntensity'] as String,
  tsunami: json['tsunami'] as bool,
  areas: (json['areas'] as List<dynamic>)
      .map((e) => Area.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$EarthquakeToJson(_Earthquake instance) =>
    <String, dynamic>{
      'id': instance.id,
      'occurredAt': instance.occurredAt,
      'epicenter': instance.epicenter,
      'magnitude': instance.magnitude,
      'maxIntensity': instance.maxIntensity,
      'tsunami': instance.tsunami,
      'areas': instance.areas,
    };

_EarthquakeResponse _$EarthquakeResponseFromJson(Map<String, dynamic> json) =>
    _EarthquakeResponse(
      earthquakes: (json['earthquakes'] as List<dynamic>)
          .map((e) => Earthquake.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$EarthquakeResponseToJson(_EarthquakeResponse instance) =>
    <String, dynamic>{'earthquakes': instance.earthquakes};
