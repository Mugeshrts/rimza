import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rimza/mqttservice/mqttservice.dart';
import 'mqtt_event.dart';
import 'mqtt_state.dart';


class MqttBloc extends Bloc<MqttEvent, MqttState> {
  final MqttService _mqttService;

  MqttBloc(this._mqttService) : super(MqttInitial()) {
    on<ConnectMqtt>(_connect);
    on<PublishMqtt>(_publish);
    on<DisconnectMqtt>(_disconnect);

    _mqttService.messageStream.listen((message) {
      add(MqttMessageReceived(message) as MqttEvent);
    });
  }

  Future<void> _connect(ConnectMqtt event, Emitter<MqttState> emit) async {
    emit(MqttConnecting());

    bool isConnected = await _mqttService.connect();
    if (isConnected) {
      emit(MqttConnected());
    } else {
      emit(MqttError('Failed to connect'));
    }
  }

  void _publish(PublishMqtt event, Emitter<MqttState> emit) {
    if(state is MqttConnected){
     _mqttService.publishMessage(event.message);
    print('Bloc: Published message -> ${event.message}');
    } else {
      print('Bloc: Cannot publish, not connected.');
    }
  }

  void _disconnect(DisconnectMqtt event, Emitter<MqttState> emit) {
    _mqttService.disconnect();
    emit(MqttDisconnected());
  }




  @override
  Future<void> close() {
    _mqttService.dispose();
    return super.close();
  }
}
