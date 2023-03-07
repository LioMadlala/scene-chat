import 'package:flutter/material.dart';

import '../../components/chat.dart';
import '../../models/chat_users.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  List<ChatUsers> chatUsers = [
    ChatUsers(
        text: "Sneh (Icu relationship)",
        jsonName: "sneh",
        secondaryText: "Hey can we talk",
        image: "assets/images/userImage5.jpeg",
        time: "Now"),
    ChatUsers(
        text: "Sugar Momma from Starbucks",
        jsonName: "sugar_mama",
        secondaryText: "Hey Handsome",
        image: "assets/images/sugar-mummy.jpg",
        time: "Now"),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(left: 16, right: 16, top: 13),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    // const Text(
                    //   "Scene chat",
                    //   style:
                    //       TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    // ),
                    Image.asset(
                      "assets/logos/SceneChat_logo.png",
                      height: 30,
                      alignment: Alignment.topLeft,
                    ),
                    // Container(
                    //   padding: const EdgeInsets.only(
                    //       left: 8, right: 8, top: 2, bottom: 2),
                    //   height: 30,
                    //   decoration: BoxDecoration(
                    //     borderRadius: BorderRadius.circular(30),
                    //     color: Colors.pink[50],
                    //   ),
                    //   child: Row(
                    //     children: const <Widget>[
                    //       Icon(
                    //         Icons.add,
                    //         color: Colors.pink,
                    //         size: 20,
                    //       ),
                    //       SizedBox(
                    //         width: 2,
                    //       ),
                    //       Text(
                    //         "New",
                    //         style: TextStyle(
                    //             fontSize: 14, fontWeight: FontWeight.bold),
                    //       ),
                    //     ],
                    //   ),
                    // )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16, left: 10, right: 10),
              child: SizedBox(
                height: 80,
                child: Card(
                  // color: Colors.blue,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.asset(
                              "assets/icons/forward.png",
                              height: 15,
                              color: Colors.grey,
                            ),
                          ),
                          const SizedBox(width: 2),
                          const Text(
                            "Forwarder by Leo",
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Center(
                          child: Text(
                            "Remember. To win achieve all the tasks listed for each chat.",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              color: Colors.grey[700],
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            ListView.builder(
              itemCount: chatUsers.length,
              shrinkWrap: true,
              padding: const EdgeInsets.only(top: 16),
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return ChatUsersList(
                  text: chatUsers[index].text,
                  secondaryText: chatUsers[index].secondaryText,
                  jsonName: chatUsers[index].jsonName,
                  image: chatUsers[index].image,
                  time: chatUsers[index].time,
                  isMessageRead: true,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
