import 'package:flutter/material.dart';
import 'package:scene_chat/from-chat-gpt.dart';

import 'modules/main_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: MainPage(),
      home: const AdventureScreen(),
    );
  }
}
