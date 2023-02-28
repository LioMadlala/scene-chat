import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:scene_chat/pages/chat/chat_list_page.dart';
import 'package:scene_chat/pages/onboarding/onboarding_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'components/app_theme.dart';
import 'hive_adapters/chat_adapter.dart';

Future<void> main() async {
  await Hive.initFlutter();
  // await Hive.openBox('snehgameState');

  Hive.registerAdapter(ChatAdapter());
  WidgetsFlutterBinding.ensureInitialized();
  // MobileAds.instance.initialize();
  final prefs = await SharedPreferences.getInstance();
  final String firstName = prefs.getString('firstName') ?? "";
  final String lastName = prefs.getString('lastName') ?? "";
  final bool isfirstTime = prefs.getBool('isfirstTime') ?? false;
  final bool isRegistered = prefs.getBool('isRegistered') ?? false;

  runApp(MyApp(isfirstTime: isfirstTime));
}

class MyApp extends StatelessWidget {
  final bool isfirstTime;

  // This widget is the root of your application.
  const MyApp({super.key, required this.isfirstTime});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: whiteTheme,
      home: !isfirstTime ? const OnboardingPage() : const ChatPage(),
      // home: const AdventureScreen(),
    );
  }
}
