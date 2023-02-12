import 'package:flutter/material.dart';

import '../models/chat_message.dart';
import '../pages/chat/chat_detail_page.dart';

class ChatBubble extends StatefulWidget {
  ChatMessage chatMessage;
  Color senderColor;
  ChatBubble({super.key, required this.chatMessage, required this.senderColor});
  @override
  _ChatBubbleState createState() => _ChatBubbleState();
}

class _ChatBubbleState extends State<ChatBubble> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 0, bottom: 10),
      child: Align(
        alignment: (widget.chatMessage.type == MessageType.Receiver
            ? Alignment.topLeft
            : Alignment.topRight),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: (widget.chatMessage.type == MessageType.Receiver
                ? Colors.white
                : widget.senderColor),
          ),
          padding: const EdgeInsets.all(10),
          child: Text(widget.chatMessage.message),
        ),
      ),
    );
  }
}
