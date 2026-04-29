import 'dart:convert';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../model/earthquake.dart';
import '../client/provider.dart';

part 'provider.g.dart';

const _baseUrl = 'http://127.0.0.1:8000';

@riverpod
class HistoryEq extends _$HistoryEq {
  @override
  Future<EarthquakeResponse> build() async {
    final client = ref.read(apiClientProvider(_baseUrl).notifier);

    final response = await client.get('/v1/history');

    if (response.statusCode != 200) {
      throw Exception('Failed to fetch history: ${response.statusCode}');
    }

    final json = jsonDecode(response.body);
    return EarthquakeResponse.fromJson(json);
  }
}
