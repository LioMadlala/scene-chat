import 'package:flutter/material.dart';
import 'package:scene_chat/pages/chat/chat_json_processing_page.dart';

class ChatUsersList extends StatefulWidget {
  final String text;
  final String secondaryText;
  final String image;
  final String jsonName;
  final String time;
  final bool isMessageRead;

  const ChatUsersList(
      {super.key,
      required this.text,
      required this.secondaryText,
      required this.image,
      required this.jsonName,
      required this.time,
      required this.isMessageRead});

  @override
  _ChatUsersListState createState() => _ChatUsersListState();
}

class _ChatUsersListState extends State<ChatUsersList> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return JsonProcessingHome(
            jsonName: widget.jsonName,
            userName: widget.text,
            userImage: widget.image,
          );
        }));
      },
      child: Container(
        padding:
            const EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 10),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Row(
                children: <Widget>[
                  CircleAvatar(
                    backgroundImage: AssetImage(widget.image),
                    maxRadius: 30,
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: Container(
                      color: Colors.transparent,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(widget.text),
                          const SizedBox(
                            height: 6,
                          ),
                          Text(
                            widget.secondaryText,
                            style: TextStyle(
                                fontSize: 14, color: Colors.grey.shade500),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Text(
              widget.time,
              style: TextStyle(
                  fontSize: 12,
                  color: widget.isMessageRead
                      ? Theme.of(context).primaryColor
                      : Colors.grey.shade500),
            ),
          ],
        ),
      ),
    );
  }
}
