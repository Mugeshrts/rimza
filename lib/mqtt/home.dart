import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rimza/mqtt/bloc/mqtt_bloc.dart';
import 'package:rimza/mqtt/bloc/mqtt_event.dart';
import 'package:rimza/mqtt/bloc/mqtt_state.dart';

class MqttScreen extends StatelessWidget {
  final TextEditingController messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final mqttBloc = BlocProvider.of<MqttBloc>(context);

    return Scaffold(
      appBar: AppBar(title: Text('MQTT with Bloc')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            BlocBuilder<MqttBloc, MqttState>(
              builder: (context, state) {
                if (state is MqttConnecting) {
                  return Text('Connecting...');
                } else if (state is MqttConnected) {
                  return Text('Connected to MQTT Broker');
                } else if (state is MqttDisconnected) {
                  return Text('Disconnected');
                } else if (state is MqttError) {
                  return Text('Error: ${state.error}');
                }
                return ElevatedButton(
                  onPressed: () {
                    mqttBloc.add(ConnectMqtt());
                  },
                  child: Text('Connect'),
                );
              },
            ),
            TextField(
              controller: messageController,
              decoration: InputDecoration(labelText: 'Enter Message'),
            ),
            ElevatedButton(
              onPressed: () {
                mqttBloc.add(PublishMqtt(messageController.text));
                messageController.clear();
              },
              child: Text('Publish'),
            ),
            SizedBox(height: 20),
            Text('Received Messages:', style: TextStyle(fontWeight: FontWeight.bold)),
            Expanded(
              child: BlocBuilder<MqttBloc, MqttState>(
                builder: (context, state) {
                  if (state is MqttMessageReceived) {
                    return ListTile(
                      title: Text(state.message),
                    );
                  }
                  return Text('No messages yet');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}