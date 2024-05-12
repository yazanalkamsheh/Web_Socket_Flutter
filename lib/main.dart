import 'package:flutter/material.dart';
import 'package:task_web_socket/screens/web_socket_channel_test_screen.dart';

import 'screens/socket_io_client_test_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: false,
      ),
      home: const WebSocketChannelTestScreen(),
    );
  }
}