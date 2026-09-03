import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:livemcq3/core/network/websocket_client.dart';
part 'websocket_provider.g.dart';

final webSocketClientProvider = Provider<WebSocketClient>((ref) {
  throw UnimplementedError('Override in app scope');
});

@riverpod
class WebSocket extends _$WebSocket {
  @override
  bool build() => false;

  void connect(String appKey, String host) {
    final client = WebSocketClient(appKey: appKey, host: host);
    client.connect();
    state = true;
  }

  void disconnect() {
    state = false;
  }
}
