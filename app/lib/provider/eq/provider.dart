import 'dart:convert';
import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../model/earthquake.dart';
import '../client/provider.dart';

part 'provider.g.dart';

const _baseUrl = 'http://127.0.0.1:8000';

@riverpod
class Eq extends _$Eq {
  Timer? _timer;

  @override
  EarthquakeResponse? build() {
    _startTimer();
    
    ref.onDispose(() {
      _timer?.cancel();
    });
    
    return null;
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 2), (_) => _poll());
  }

  Future<void> _poll() async {
    final client = ref.read(apiClientProvider(_baseUrl).notifier);
    final now = DateTime.now();
    final timestamp = '${now.year}${now.month.toString().padLeft(2, '0')}${now.day.toString().padLeft(2, '0')}${now.hour.toString().padLeft(2, '0')}${now.minute.toString().padLeft(2, '0')}${now.second.toString().padLeft(2, '0')}';

    try {
      final response = await client.get('/v1/eq/$timestamp');
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        final data = EarthquakeResponse.fromJson(json);
        
        // データがある場合のみ更新
        if (data.earthquakes.isNotEmpty) {
          state = data;
        }
      }
    } catch (e) {
      // ネットワークエラーなどは無視して次へ
    }
  }
}
