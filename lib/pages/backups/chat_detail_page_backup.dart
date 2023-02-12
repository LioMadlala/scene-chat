// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';

// import '../components/chat_bubble.dart';
// import '../components/chat_detail_page_appbar.dart';
// import '../models/chat_message.dart';
// import '../models/send_menu_items.dart';

// enum MessageType {
//   Sender,
//   Receiver,
// }

// class ChatDetailPage extends StatefulWidget {
//   const ChatDetailPage({super.key});

//   @override
//   _ChatDetailPageState createState() => _ChatDetailPageState();
// }

// class _ChatDetailPageState extends State<ChatDetailPage> {
//   List<SendMenuItems> menuItems = [
//     SendMenuItems(
//         text: "Photos & Videos", icons: Icons.image, color: Colors.amber),
//     SendMenuItems(
//         text: "Document", icons: Icons.insert_drive_file, color: Colors.blue),
//     SendMenuItems(text: "Audio", icons: Icons.music_note, color: Colors.orange),
//     SendMenuItems(
//         text: "Location", icons: Icons.location_on, color: Colors.green),
//     SendMenuItems(text: "Contact", icons: Icons.person, color: Colors.purple),
//   ];

//   late Map<String, dynamic> data;

//   Future<void> fetchJson() async {
//     var jsonData = await rootBundle.loadString("assets/jsons/zama.json");
//     print(jsonData);
//     data = json.decode(jsonData);
//     setState(() {});
//   }

//   // Map<String, dynamic> data = json.decode(
//   //     '''
//   // {
//   //   "start": {
//   //     "text": "Its 2 o' damn clock in the morning Where you been?",
//   //     "choices": [
//   //       {
//   //         "text": "I was with my friends",
//   //         "nextScene": "with_friends"
//   //       },
//   //       {
//   //         "text": "i was kidnapped",
//   //         "nextScene": "kidnapped"
//   //       }
//   //     ]
//   //   },
//   //   "with_friends": {
//   //     "text": "You a lie!, I called Aya and Austin and they were both at home",
//   //     "choices": [
//   //       {
//   //         "text": "im not lying to you",
//   //         "nextScene": "not_lying"
//   //       },
//   //       {
//   //         "text": "Ask Ayabonga.",
//   //         "nextScene": "ask_aya"
//   //       }
//   //     ]
//   //   },
//   //   "kidnapped": {
//   //     "text": "How did that happen?",
//   //     "choices": [
//   //       {
//   //         "text": "I was out with friend and next thing i wake up in a dark room",
//   //         "nextScene": "dark_room"
//   //       },
//   //       {
//   //         "text": "i didn't kiss any girl",
//   //         "nextScene": "i_didnt"
//   //       }
//   //     ]
//   //   },
//   //   "not_lying": {
//   //     "text": "Austin said he was not with you",
//   //     "choices": [
//   //       {
//   //         "text": "Haaa this sanababhish Austin..i swear i was with him and Ayabonga 😲",
//   //         "nextScene": "i_swear"
//   //       },
//   //       {
//   //         "text": "Oksalaya im telling the truth",
//   //         "nextScene": "oksalayo"
//   //       }
//   //     ]
//   //   },

//   //   "dark_room": {
//   //     "text": "To be continued!"
//   //   },
//   //   "i_didnt": {
//   //     "text": "To be continued!"
//   //   },
//   //    "i_swear": {
//   //     "text": "To be continued."
//   //   },
//   //   "oksalayo": {
//   //     "text": "To be continued."
//   //   },
//   //   "ask_aya": {
//   //     "text": "to be continued"
//   //   },
//   //   "fight": {
//   //     "text": "You have defeated the monster and gained a valuable treasure."
//   //   },
//   //   "run": {
//   //     "text": "You have successfully escaped the monster."
//   //   }
//   // }
//   // ''');

//   String currentScene = "start";

//   List<ChatMessage> chatMessage = [];

//   final ScrollController _scrollController = ScrollController();

//   @override
//   void initState() {
//     super.initState();
//     fetchJson();
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       if (_scrollController.hasClients) {
//         _scrollController.animateTo(
//           _scrollController.position.maxScrollExtent,
//           curve: Curves.easeOut,
//           duration: const Duration(milliseconds: 500),
//         );
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     late Map<String, dynamic> scene;
//     late var choices;

//     setState(() {});

//     return Scaffold(
//       appBar: const ChatDetailPageAppBar(),
//       body: FutureBuilder(
//           future: fetchJson(),
//           builder: (context, snapshot) {
//             if (snapshot.hasData) {
//               snapshot.data;
//               print("has data");
//               scene = data[currentScene];
//               choices = scene["choices"];

//               print(choices);

//               chatMessage.add(ChatMessage(
//                   message: scene["text"], type: MessageType.Receiver));

//               return Stack(
//                 children: [
//                   ListView.builder(
//                     itemCount: chatMessage.length,
//                     shrinkWrap: true,
//                     controller: _scrollController,
//                     padding: const EdgeInsets.only(top: 10, bottom: 90),
//                     physics: const BouncingScrollPhysics(),
//                     itemBuilder: (context, index) {
//                       return ChatBubble(
//                         chatMessage: chatMessage[index],
//                       );
//                     },
//                   ),
//                   const SizedBox(height: 50),
//                   Align(
//                     alignment: Alignment.bottomLeft,
//                     child: Container(
//                       padding: const EdgeInsets.only(left: 16, bottom: 10),
//                       // height: 80,
//                       width: double.infinity,
//                       color: Colors.white,

//                       child: choices == null
//                           ? Text(scene["text"])
//                           : Wrap(
//                               children: <Widget>[
//                                 ...choices.map((choice) => Padding(
//                                       padding: const EdgeInsets.all(4.0),
//                                       child: ActionChip(
//                                         label: Text(choice["text"]),
//                                         onPressed: () {
//                                           currentScene = choice["nextScene"];
//                                           print(currentScene);
//                                           chatMessage.add(ChatMessage(
//                                               message: choice["text"],
//                                               type: MessageType.Sender));

//                                           // if (_scrollController.hasClients) {
//                                           //   _scrollController.animateTo(
//                                           //     _scrollController
//                                           //             .position.maxScrollExtent +
//                                           //         100,
//                                           //     curve: Curves.easeOut,
//                                           //     duration:
//                                           //         const Duration(milliseconds: 500),
//                                           //   );
//                                           // }

//                                           // Future.delayed(const Duration(seconds: 1))
//                                           //     .whenComplete(() {
//                                           //   chatMessage.add(ChatMessage(
//                                           //       message: scene["text"],
//                                           //       type: MessageType.Receiver));

//                                           //   // if (_scrollController.hasClients) {
//                                           //   //   _scrollController.animateTo(
//                                           //   //     _scrollController
//                                           //   //             .position.maxScrollExtent +
//                                           //   //         100,
//                                           //   //     curve: Curves.easeInOut,
//                                           //   //     duration:
//                                           //   //         const Duration(milliseconds: 500),
//                                           //   //   );
//                                           //   // }

//                                           //   setState(() {});
//                                           // });

//                                           setState(() {});
//                                         },
//                                       ),
//                                     )),
//                               ],
//                             ),
//                     ),
//                   ),
//                   // Align(
//                   //   alignment: Alignment.bottomRight,
//                   //   child: Container(
//                   //     padding: const EdgeInsets.only(right: 30, bottom: 50),
//                   //     child: FloatingActionButton(
//                   //       onPressed: () async {
//                   //         chatMessage.add(ChatMessage(
//                   //             message: controller.text, type: MessageType.Sender));

//                   //         if (_scrollController.hasClients) {
//                   //           _scrollController.animateTo(
//                   //             _scrollController.position.maxScrollExtent + 100,
//                   //             curve: Curves.easeOut,
//                   //             duration: const Duration(milliseconds: 500),
//                   //           );
//                   //         }

//                   //         Future.delayed(const Duration(seconds: 1)).whenComplete(() {
//                   //           chatMessage.add(ChatMessage(
//                   //               message: "Uyangdakelwa!", type: MessageType.Receiver));

//                   //           if (_scrollController.hasClients) {
//                   //             _scrollController.animateTo(
//                   //               _scrollController.position.maxScrollExtent + 100,
//                   //               curve: Curves.easeInOut,
//                   //               duration: const Duration(milliseconds: 500),
//                   //             );
//                   //           }

//                   //           setState(() {});
//                   //         });

//                   //         setState(() {});
//                   //       },
//                   //       backgroundColor: Colors.pink,
//                   //       elevation: 0,
//                   //       child: const Icon(
//                   //         Icons.send,
//                   //         color: Colors.white,
//                   //       ),
//                   //     ),
//                   //   ),
//                   // )
//                 ],
//               );
//             } else {
//               return const Text("Error loading json");
//             }
//           }),
//     );
//   }
// }
