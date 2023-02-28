import 'package:flutter/material.dart';

import '../models/chat_message.dart';
import '../pages/chat/chat_detail_page.dart';

class ChatBubble extends StatefulWidget {
  ChatMessage chatMessage;
  Color senderColor;
  ChatBubble({
    super.key,
    required this.chatMessage,
    required this.senderColor,
  });
  @override
  _ChatBubbleState createState() => _ChatBubbleState();
}

bool hasEmotion = true;

class _ChatBubbleState extends State<ChatBubble> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    return Container(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 0, bottom: 10),
      child: Align(
        alignment: (widget.chatMessage.type == MessageType.Receiver
            ? Alignment.topLeft
            : Alignment.topRight),
        child: Container(
          constraints: BoxConstraints(maxWidth: width - 70),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: (widget.chatMessage.type == MessageType.Receiver
                ? Colors.white
                : widget.senderColor),
          ),
          padding: const EdgeInsets.all(10),
          child: widget.chatMessage.emotion != ""
              ? Wrap(
                  children: [
                    Text(widget.chatMessage.message),
                    Padding(
                      padding: const EdgeInsets.only(top: 4.0),
                      child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 6, vertical: 0),
                          decoration: BoxDecoration(
                              color: widget.senderColor.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(30)),
                          child: Text(
                            widget.chatMessage.emotion,
                            style: const TextStyle(
                              fontSize: 9,
                            ),
                          )),
                    ),
                  ],
                )
              : Text(
                  widget.chatMessage.message,
                  style: const TextStyle(
                    fontSize: 12,
                  ),
                ),
        ),
      ),
    );
  }
}
