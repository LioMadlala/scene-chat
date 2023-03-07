import 'package:flutter/material.dart';
import 'package:scene_chat/pages/info/info_page.dart';

class ChatDetailPageAppBar extends StatefulWidget
    implements PreferredSizeWidget {
  final String userName;
  final String userImage;
  final String jsonName;
  final bool isTyping;

  const ChatDetailPageAppBar(
      {super.key,
      required this.userName,
      required this.userImage,
      required this.jsonName,
      required this.isTyping});

  @override
  State<ChatDetailPageAppBar> createState() => _ChatDetailPageAppBarState();

  @override
  // ToDo: implement preferredSize
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _ChatDetailPageAppBarState extends State<ChatDetailPageAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      automaticallyImplyLeading: false,
      backgroundColor: Colors.white,
      flexibleSpace: SafeArea(
        child: Container(
          padding: const EdgeInsets.only(right: 16),
          child: Row(
            children: <Widget>[
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                ),
              ),
              const SizedBox(
                width: 2,
              ),
              CircleAvatar(
                backgroundImage: AssetImage(widget.userImage),
                maxRadius: 20,
              ),
              const SizedBox(
                width: 12,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      widget.userName,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    widget.isTyping
                        ? const Text(
                            "Typing...",
                            style: TextStyle(color: Colors.green, fontSize: 12),
                          )
                        : const Text(
                            "Online",
                            style: TextStyle(color: Colors.green, fontSize: 12),
                          ),
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return InfoPage(
                      jsonName: widget.jsonName,
                      userName: widget.userName,
                      userImage: widget.userImage,
                      fromChat: true,
                    );
                  }));
                },
                child: Icon(
                  Icons.info_outline_rounded,
                  color: Colors.grey.shade700,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
