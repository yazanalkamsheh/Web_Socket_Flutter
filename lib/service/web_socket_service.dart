import 'dart:async';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class WebSocketService {
  static WebSocketService? _instance;
  WebSocketService._();
  factory WebSocketService() => _instance ??= WebSocketService._();

  WebSocketChannel? _channel;
  StreamController<String>? _streamController;

  bool get isConnected => _channel != null && _channel?.sink != null;

  void connect(String url) {
    if (!isConnected) {
      _channel = IOWebSocketChannel.connect(url);
      _streamController = StreamController<String>();
      _channel?.stream.listen(
            (data) {
          _streamController?.add(data);
        },
        onError: (error) {
          print('WebSocket error: $error');
        },
        onDone: () {
          print('WebSocket connection closed');
        },
      );
    }
  }

  void send(String message) {
    if (isConnected) {
      _channel?.sink.add(message);
    }
  }

  Stream<String>? get stream => _streamController?.stream;

  void disconnect() {
    if (isConnected) {
      _channel?.sink.close();
    }
  }

  void dispose() {
    disconnect();
    _streamController?.close();
  }
}
