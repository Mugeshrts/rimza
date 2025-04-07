abstract class MqttState {}

class MqttInitial extends MqttState {}

class MqttConnecting extends MqttState {}

class MqttConnected extends MqttState {}

class MqttDisconnected extends MqttState {}

class MqttMessageReceived extends MqttState {
  final String message;
  MqttMessageReceived(this.message);
}

class MqttError extends MqttState {
  final String error;
  MqttError(this.error);
}
