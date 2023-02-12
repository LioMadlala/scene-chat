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
      "text": "Where were you last night",
      "choices": [
        {
          "text": "I was with my friends",
          "nextScene": "with_friends"
        },
        {
          "text": "i was out clubbing",
          "nextScene": "clubbing"
        }
      ]
    },
    "with_friends": {
      "text": "Why are you lying to me?",
      "choices": [
        {
          "text": "im not lying to you",
          "nextScene": "not_lying"
        },
        {
          "text": "Ask Ayabonga.",
          "nextScene": "ask_aya"
        }
      ]
    },
    "clubbing": {
      "text": "Who was that girl you kissed?",
      "choices": [
        {
          "text": "Who told you that",
          "nextScene": "who_told_you"
        },
        {
          "text": "i didn't kiss any girl",
          "nextScene": "i_didnt"
        }
      ]
    },
    "not_lying": {
      "text": "Austin said he was not with you",
      "choices": [
        {
          "text": "Haaa this sanababhish Austin..i swear i was with him and Ayabonga 😲",
          "nextScene": "i_swear"
        },
        {
          "text": "Oksalaya im telling the truth",
          "nextScene": "oksalayo"
        }
      ]
    },
    "who_told_you": {
      "text": "To be continued!"
    },
    "i_didnt": {
      "text": "To be continued!"
    },
     "i_swear": {
      "text": "To be continued."
    },
    "oksalayo": {
      "text": "To be continued."
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
            ? Center(child: Text(scene["text"]))
            : Center(
                child: Column(
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
      ),
    );
  }
}
