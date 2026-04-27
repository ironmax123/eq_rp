import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:http/http.dart' as http;
import 'package:web_socket_channel/web_socket_channel.dart';

part 'provider.g.dart';

@riverpod
class ApiClient extends _$ApiClient {
  @override
  void build(String url) {}

  Future<http.Response> get(
    String endpoint, {
    Map<String, String>? headers,
  }) async {
    final uri = Uri.parse('$url$endpoint');
    return await http.get(uri, headers: headers);
  }

  WebSocketChannel ws(String endpoint) {
    // http/https -> ws/wss
    final wsBaseUrl = url.startsWith('https')
        ? url.replaceFirst('https', 'wss')
        : url.replaceFirst('http', 'ws');
    final uri = Uri.parse('$wsBaseUrl$endpoint');
    return WebSocketChannel.connect(uri);
  }
}
