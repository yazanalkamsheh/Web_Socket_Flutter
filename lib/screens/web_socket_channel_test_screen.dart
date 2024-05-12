import 'package:flutter/material.dart';
import '../service/web_socket_service.dart';

class WebSocketChannelTestScreen extends StatefulWidget {
  const WebSocketChannelTestScreen({super.key});

  @override
  _WebSocketChannelTestScreenState createState() => _WebSocketChannelTestScreenState();
}

class _WebSocketChannelTestScreenState extends State<WebSocketChannelTestScreen> {
  final TextEditingController _controller = TextEditingController();
  @override
  void initState() {
    super.initState();
    WebSocketService().connect("wss://ws.ifelse.io/");
  }

  @override
  void dispose() {
    WebSocketService().dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("WebSocket Test"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(labelText: "Enter message"),
              controller: _controller,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                WebSocketService().send(_controller.text);
              },
              child: Text("Send"),
            ),
            SizedBox(height: 20),
            StreamBuilder(
              stream: WebSocketService().stream,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Text(snapshot.data.toString());
                } else {
                  return Text("No data received yet");
                }
              },
            ),
          ],
        ),
      ),
    );
  }


}
