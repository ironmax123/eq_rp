import 'dart:convert';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../model/earthquake.dart';
import '../client/provider.dart';

part 'provider.g.dart';

/// デモ用: localhost のベースURL
const _baseUrl = 'api link';

/// デモ用: ハードコードされたリクエスト時刻
const _requestTime = '20260427140000';

@riverpod
class Eq extends _$Eq {
  @override
  Future<EarthquakeResponse> build() async {
    final client = ref.read(apiClientProvider(_baseUrl).notifier);

    final response = await client.get(
      '/earthquakes',
      headers: {'X-Request-Time': _requestTime},
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to fetch earthquakes: ${response.statusCode}');
    }

    final json = jsonDecode(response.body);
    return EarthquakeResponse.fromJson(json);
  }
}
