import 'dart:convert';

import 'package:flutter/material.dart';

class AdventureScreen extends StatefulWidget {
  const AdventureScreen({super.key});

  @override
  _AdventureScreenState createState() => _AdventureScreenState();
}

class _AdventureScreenState extends State<AdventureScreen> {
  Map<String, dynamic> data = json.decode('''
  {
    "start": {
      "text": "Welcome to the adventure!",
      "choices": [
        {
          "text": "Go left",
          "nextScene": "left"
        },
        {
          "text": "Go right",
          "nextScene": "right"
        }
      ]
    },
    "left": {
      "text": "You have come across a river. Do you swim or find a bridge?",
      "choices": [
        {
          "text": "Swim",
          "nextScene": "swim"
        },
        {
          "text": "Find a bridge",
          "nextScene": "find_a_bridge"
        }
      ]
    },
    "right": {
      "text": "You have come across a monster. Do you fight or run?",
      "choices": [
        {
          "text": "Fight",
          "nextScene": "fight"
        },
        {
          "text": "Run",
          "nextScene": "run"
        }
      ]
    },
    "swim": {
      "text": "You have reached the other side safely."
    },
    "find_a_bridge": {
      "text": "You have found a safe bridge and crossed the river."
    },
    "fight": {
      "text": "You have defeated the monster and gained a valuable treasure."
    },
    "run": {
      "text": "You have successfully escaped the monster."
    }
  }
  ''');

  String currentScene = "start";

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> scene = data[currentScene];
    var choices = scene["choices"];

    print(choices);

    return SafeArea(
      child: Scaffold(
        body: choices == null
            ? Text(scene["text"])
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(scene["text"]),
                  ...choices.map((choice) => TextButton(
                        child: Text(choice["text"]),
                        onPressed: () {
                          setState(() {
                            currentScene = choice["nextScene"];
                          });
                        },
                      )),
                ],
              ),
      ),
    );
  }
}
