import 'dart:convert';

import 'package:flutter/material.dart';

import 'dart:async';

import 'package:scene_chat/pages/chat/chat_detail_page.dart';

class JsonProcessingHome extends StatelessWidget {
  final String jsonName;
  final String userName;
  final String userImage;

  const JsonProcessingHome(
      {super.key,
      required this.jsonName,
      required this.userName,
      required this.userImage});

  Future<Map<String, dynamic>> fetchJson(BuildContext context) async {
    final jsonString = await DefaultAssetBundle.of(context)
        .loadString("assets/jsons/$jsonName.json")
        .onError((error, stackTrace) {
      return "No Json found";
    });
    print("JSON STRING ❤️" "$jsonString");
    return await json.decode(jsonString);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: fetchJson(context),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var data = snapshot.data;
          return ChatDetailPage(
            data: data!,
            jsonName: jsonName,
            userName: userName,
            userImage: userImage,
          );
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
