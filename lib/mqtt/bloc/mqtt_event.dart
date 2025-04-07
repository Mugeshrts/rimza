abstract class MqttEvent {}

class ConnectMqtt extends MqttEvent {}

class PublishMqtt extends MqttEvent {
  final String message;
  PublishMqtt(this.message);
}

class DisconnectMqtt extends MqttEvent {}
