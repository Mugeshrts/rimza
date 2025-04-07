import 'dart:async';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

class MqttService {
  final String broker = 'broker.emqx.io';
  final int port = 1883;
  final String clientId = 'flutter_bloc_${DateTime.now().millisecondsSinceEpoch}';
  final String topic = 'mqtt/test23';

  late MqttServerClient _client;
  final StreamController<String> _messageController = StreamController.broadcast();
  Timer? _reconnectTimer; // ✅ Declare _reconnectTimer

  Stream<String> get messageStream => _messageController.stream;

  MqttService() {
    _client = MqttServerClient(broker, clientId);
    _client.port = port;
    _client.keepAlivePeriod = 60;
    _client.onConnected = onConnected;
    _client.onDisconnected = onDisconnected;
    _client.onSubscribed = onSubscribed;
    _client.logging(on: false);
  }

  Future<bool> connect() async {
    final connMessage = MqttConnectMessage()
        .withClientIdentifier(clientId)
        .startClean()
        .withWillQos(MqttQos.atMostOnce);
    _client.connectionMessage = connMessage;

    try {
      print('MQTT: Attempting to connect...');
      await _client.connect();

      if (_client.connectionStatus?.state == MqttConnectionState.connected) {
        print('MQTT: Connected!');
        _subscribe();
        return true;
      } else {
        print('MQTT: Connection failed!');
         _scheduleReconnect();
        return false;
      }
    } catch (e) {
      print('MQTT Error: $e');
      _scheduleReconnect(); // ✅ Handle exception by reconnecting
      return false;
    }
  }

  void _subscribe() {
    print('MQTT: Subscribing to topic $topic...');
    _client.subscribe(topic, MqttQos.atMostOnce);
    _client.updates?.listen((messages) {
      final recMessage = messages[0].payload as MqttPublishMessage;
      final String receivedMsg = MqttPublishPayload.bytesToStringAsString(recMessage.payload.message);
      _messageController.add(receivedMsg);
    });
  }

  void publishMessage(String message) {
    final builder = MqttClientPayloadBuilder();
    builder.addString(message);

    if (_client.connectionStatus?.state == MqttConnectionState.connected) {
      _client.publishMessage(topic, MqttQos.atMostOnce, builder.payload!);
      print('MQTT: Message published -> $message');
    } else {
      print('MQTT: Cannot publish, not connected.');
    }
  }

  void disconnect() {
    _client.disconnect();
    print('MQTT: Disconnected');
  }

  void onConnected() => print('MQTT: Connected to Broker');
  void onDisconnected() => print('MQTT: Disconnected from Broker');
  void onSubscribed(String topic) => print('MQTT: Subscribed to $topic');

  void dispose() {
    _messageController.close();
  }

  void _scheduleReconnect() {
  if (_reconnectTimer == null || !_reconnectTimer!.isActive) {
    print('MQTT: Reconnecting in 5 seconds...');
    _reconnectTimer = Timer(Duration(seconds: 5), () {
      connect();
    });
  }
}

}
