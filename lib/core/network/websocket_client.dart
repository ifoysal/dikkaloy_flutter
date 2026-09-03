import 'dart:async';
import 'dart:convert';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:livemcq3/core/constants/app_constants.dart';

class WebSocketClient {
  final String appKey;
  final String host;
  WebSocketChannel? _channel;
  final _controllers = <String, StreamController<dynamic>>{};

  WebSocketClient({required this.appKey, required this.host});

  Uri get _uri => Uri.parse('$host/app/$appKey')
      .replace(queryParameters: {
        'protocol': '7',
        'client': 'flutter',
        'version': '1.0',
        'flash': 'false',
      });

  void connect() {
    try {
      _channel = WebSocketChannel.connect(_uri);
      _channel!.stream.listen(
        _onMessage,
        onError: _onError,
        onDone: _onDone,
        cancelOnError: true,
      );
    } catch (e) {
      throw Exception('WebSocket connection failed: $e');
    }
  }

  void _onMessage(dynamic message) {
    final data = jsonDecode(message as String);
    final event = data['event'] as String?;
    final channel = data['channel'] as String?;
    final payload = data['data'];

    if (event != null && channel != null && _controllers.containsKey(channel)) {
      _controllers[channel]?.add({'event': event, 'data': payload});
    }
  }

  void _onError(error) {
    for (final c in _controllers.values) {
      c.addError(error);
    }
  }

  void _onDone() {
    for (final c in _controllers.values) {
      c.close();
    }
    _controllers.clear();
  }

  Stream<dynamic> subscribe(String channelName) {
    if (_channel == null) connect();

    final controller = StreamController<dynamic>.broadcast();
    _controllers[channelName] = controller;

    _channel!.sink.add(jsonEncode({
      'event': 'pusher:subscribe',
      'data': {'channel': channelName},
    }));

    return controller.stream;
  }

  void unsubscribe(String channelName) {
    if (_channel != null) {
      _channel!.sink.add(jsonEncode({
        'event': 'pusher:unsubscribe',
        'data': {'channel': channelName},
      }));
    }
    _controllers[channelName]?.close();
    _controllers.remove(channelName);
  }

  void disconnect() {
    _channel?.sink.close();
    _onDone();
    _channel = null;
  }
}
