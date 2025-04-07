import 'package:flutter/material.dart';
import 'package:rimza/mqttservice/mqttservice.dart';

class MqttPage extends StatefulWidget {
  const MqttPage({super.key});

  @override
  State<MqttPage> createState() => _MqttPageState();
}

class _MqttPageState extends State<MqttPage> {
  final MqttService mqttService = MqttService();
  final TextEditingController messageController = TextEditingController();
  final List<String> receivedMessages = [];

  @override
  void initState() {
    super.initState();
    mqttService.connect();
    mqttService.messageStream.listen((message) {
      setState(() {
        receivedMessages.insert(0, message);
      });
    });
  }

  @override
  void dispose() {
    mqttService.dispose();
    messageController.dispose();
    super.dispose();
  }

  void _publishMessage() {
    final msg = messageController.text.trim();
    if (msg.isNotEmpty) {
      mqttService.publishMessage(msg);
      messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('MQTT Client UI')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: messageController,
                    decoration: const InputDecoration(
                      labelText: 'Enter message',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: _publishMessage,
                  child: const Text('Send'),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Text('Received Messages:', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                reverse: true,
                itemCount: receivedMessages.length,
                itemBuilder: (context, index) => Card(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(receivedMessages[index]),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}