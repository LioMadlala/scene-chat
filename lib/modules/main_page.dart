import 'package:flutter/material.dart';

import 'chat_page.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: ChatPage(),
    );
  }
}
