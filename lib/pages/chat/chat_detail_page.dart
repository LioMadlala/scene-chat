import 'package:flutter/material.dart';

import '../../components/chat_bubble.dart';
import '../../components/chat_detail_page_appbar.dart';
import '../../models/chat_message.dart';

enum MessageType {
  Sender,
  Receiver,
}

class ChatDetailPage extends StatefulWidget {
  final Map<String, dynamic> data;
  final String jsonName;
  final String userName;
  final String userImage;

  const ChatDetailPage(
      {super.key,
      required this.data,
      required this.jsonName,
      required this.userName,
      required this.userImage});

  @override
  _ChatDetailPageState createState() => _ChatDetailPageState();
}

class _ChatDetailPageState extends State<ChatDetailPage> {
  String currentScene = "start";

  List<ChatMessage> chatMessage = [];

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          curve: Curves.easeOut,
          duration: const Duration(milliseconds: 500),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> scene = widget.data[currentScene];
    var choices = scene["choices"];

    chatMessage
        .add(ChatMessage(message: scene["text"], type: MessageType.Receiver));

    setState(() {});

    String colorTheme = widget.data["chatSettings"]["chatTheme"];

    Color color =
        Color(int.parse(colorTheme.substring(2), radix: 16)).withAlpha(0xFF);

    return Scaffold(
      appBar: ChatDetailPageAppBar(
          userName: widget.userName, userImage: widget.userImage),
      body: Stack(
        children: [
          ListView.builder(
            itemCount: chatMessage.length,
            shrinkWrap: true,
            controller: _scrollController,
            padding: const EdgeInsets.only(top: 10, bottom: 90),
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              return ChatBubble(
                chatMessage: chatMessage[index],
                senderColor: color,
              );
            },
          ),
          const SizedBox(height: 50),
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              padding: const EdgeInsets.only(left: 16, bottom: 10),
              // height: 80,
              width: double.infinity,
              color: Colors.white,

              child: choices == null
                  ? Text(scene["text"])
                  : Wrap(
                      children: <Widget>[
                        ...choices.map((choice) => Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: ActionChip(
                                label: Text(choice["text"]),
                                backgroundColor: color,
                                // backgroundColor: Color(colorTheme),
                                onPressed: () {
                                  currentScene = choice["nextScene"];
                                  print(currentScene);
                                  chatMessage.add(ChatMessage(
                                      message: choice["text"],
                                      type: MessageType.Sender));

                                  setState(() {});
                                },
                              ),
                            )),
                      ],
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
