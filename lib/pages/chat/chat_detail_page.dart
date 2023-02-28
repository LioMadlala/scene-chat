import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:lottie/lottie.dart';
import 'package:scene_chat/hive_adapters/chat_adapter.dart';

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
  // String currentScene = "start";

  List<ChatMessage> chatMessage = [];

  final ScrollController _scrollController = ScrollController();

  late Box _box;
  late String currentScene;

  late Box<List<dynamic>> chatHistory;
  List<Chat>? chats;
  List<Chat> allChatsFromHiveDb = [];

  bool isLoading = true;
  bool isTyping = false;

  late Map<String, dynamic> scene;
  late var choices;
  String emotion = "";
  late String colorTheme;
  late Color color;

  getChatHistory() async {
    await Hive.openBox<List<dynamic>>('chathistory');
    chatHistory = Hive.box('chathistory');

    List<dynamic> data = chatHistory.get('chathistory') ?? [];
    List<Chat> chats = data.cast<Chat>().toList();

    // chats = chatHistory.get('chathistory');
    print(chats);
    allChatsFromHiveDb = [];
    allChatsFromHiveDb.addAll(chats);

    for (var e in allChatsFromHiveDb) {
      MessageType type;
      if (e.type == "sender") {
        type = MessageType.Sender;
      } else {
        type = MessageType.Receiver;
      }
      chatMessage
          .add(ChatMessage(message: e.message, type: type, emotion: e.emotion));
    }
    isLoading = false;
    setState(() {});
    print(chatMessage);
  }

  @override
  void initState() {
    super.initState();

    _box = Hive.box('gameState');
    currentScene = _box.get('currentScene', defaultValue: 'start');
    getChatHistory();
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
    if (isTyping) {
      Future.delayed(const Duration(seconds: 2)).then((value) {
        isTyping = false;
        setState(() {});
      });
    }
    if (!isLoading && !isTyping) {
      scene = widget.data[currentScene];
      choices = scene["choices"];

      emotion = widget.data[currentScene]["emotion"] ?? "";

      //*check if message already exist in chatlist
      if (chatMessage.isNotEmpty) {
        if (chatMessage.last.message != scene["text"]) {
          chatMessage.add(ChatMessage(
              message: scene["text"],
              type: MessageType.Receiver,
              emotion: emotion));

          print(chatMessage);

          allChatsFromHiveDb.add(
              Chat(message: scene["text"], emotion: emotion, type: "receiver"));
          chatHistory.add(allChatsFromHiveDb);
          chatHistory.put("chathistory", allChatsFromHiveDb);
        }
      } else {
        //*first time list
        chatMessage.add(ChatMessage(
            message: scene["text"],
            type: MessageType.Receiver,
            emotion: emotion));

        print(chatMessage);

        allChatsFromHiveDb.add(
            Chat(message: scene["text"], emotion: emotion, type: "receiver"));
        chatHistory.add(allChatsFromHiveDb);
        chatHistory.put("chathistory", allChatsFromHiveDb);
      }

      //*add to db
      colorTheme = widget.data["chatSettings"]["chatTheme"];
      color =
          Color(int.parse(colorTheme.substring(2), radix: 16)).withAlpha(0xFF);
      isTyping = false;
      setState(() {});
    }

    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: ChatDetailPageAppBar(
        userName: widget.userName,
        userImage: widget.userImage,
        isTyping: isTyping,
      ),
      body: !isLoading
          ? Stack(
              children: [
                SizedBox(
                  height: height,
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          itemCount: chatMessage.length,
                          shrinkWrap: true,
                          controller: _scrollController,
                          padding: const EdgeInsets.only(top: 10, bottom: 90),
                          // physics: const NeverScrollableScrollPhysics(),
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            return ChatBubble(
                              chatMessage: chatMessage[index],
                              senderColor: color,
                            );
                          },
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Container(
                          padding: const EdgeInsets.only(left: 16, bottom: 10),
                          // height: 80,
                          width: double.infinity,
                          color: Colors.white,

                          child: choices == null
                              ? Text(scene["text"])
                              : !isTyping
                                  ? Wrap(
                                      children: <Widget>[
                                        ...choices.map((choice) => Padding(
                                              padding:
                                                  const EdgeInsets.all(4.0),
                                              child: ActionChip(
                                                label: Text(choice["text"]),
                                                backgroundColor: color,
                                                onPressed: () async {
                                                  //*change to the next scene
                                                  currentScene =
                                                      choice["nextScene"];
                                                  print(currentScene);
                                                  _box.put('currentScene',
                                                      currentScene);

                                                  //*Add new chat from user to chatlist
                                                  chatMessage.add(ChatMessage(
                                                      message: choice["text"],
                                                      type: MessageType.Sender,
                                                      emotion: ""));

                                                  //*Add new chat from user to db class
                                                  allChatsFromHiveDb.add(Chat(
                                                      message: choice["text"],
                                                      emotion: "",
                                                      type: "sender"));

                                                  List<Chat>? rr = [];
                                                  rr.addAll(allChatsFromHiveDb);

                                                  chatHistory.put(
                                                      "chathistory", rr);

                                                  if (_scrollController
                                                      .hasClients) {
                                                    _scrollController.animateTo(
                                                      _scrollController.position
                                                              .maxScrollExtent +
                                                          100,
                                                      curve: Curves.easeOut,
                                                      duration: const Duration(
                                                          milliseconds: 500),
                                                    );
                                                  }

                                                  isTyping = true;

                                                  setState(() {});
                                                },
                                              ),
                                            )),
                                      ],
                                    )
                                  : SizedBox(
                                      height: 50,
                                      child: Center(
                                          child: Lottie.asset(
                                        "assets/lottie_animations/chat-typing.json",
                                        height: 30,
                                      ))),
                        ),
                      ),
                    ],
                  ),
                ),
                // const SizedBox(height: 50),
              ],
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }
}
