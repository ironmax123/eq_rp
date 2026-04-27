import 'package:freezed_annotation/freezed_annotation.dart';

part 'earthquake.freezed.dart';
part 'earthquake.g.dart';

/// 震源情報
@freezed
abstract class Epicenter with _$Epicenter {
  const factory Epicenter({
    required String name,
    required double latitude,
    required double longitude,
    required int depth,
  }) = _Epicenter;

  factory Epicenter.fromJson(Map<String, dynamic> json) =>
      _$EpicenterFromJson(json);
}

/// 観測地域ごとの震度
@freezed
abstract class Area with _$Area {
  const factory Area({
    required String name,
    required String intensity,
  }) = _Area;

  factory Area.fromJson(Map<String, dynamic> json) => _$AreaFromJson(json);
}

/// 地震データ
@freezed
abstract class Earthquake with _$Earthquake {
  const factory Earthquake({
    required String id,
    required String occurredAt,
    required Epicenter epicenter,
    required double magnitude,
    required String maxIntensity,
    required bool tsunami,
    required List<Area> areas,
  }) = _Earthquake;

  factory Earthquake.fromJson(Map<String, dynamic> json) =>
      _$EarthquakeFromJson(json);
}

/// APIレスポンス
@freezed
abstract class EarthquakeResponse with _$EarthquakeResponse {
  const factory EarthquakeResponse({
    required List<Earthquake> earthquakes,
  }) = _EarthquakeResponse;

  factory EarthquakeResponse.fromJson(Map<String, dynamic> json) =>
      _$EarthquakeResponseFromJson(json);
}
