// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:scene_chat/pages/chat/chat_detail_page.dart';
import 'package:scene_chat/pages/widgets/custom_btn.dart';
import 'package:scene_chat/pages/widgets/validation_checkboxes.dart';

class InfoPage extends StatefulWidget {
  final String jsonName;
  final String userName;
  final String userImage;
  final Map<String, dynamic>? data;
  final bool fromChat;

  const InfoPage({
    Key? key,
    required this.jsonName,
    required this.userName,
    required this.userImage,
    required this.fromChat,
    this.data,
  }) : super(key: key);

  @override
  State<InfoPage> createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  List<String> tasks = [];

  getData() {
    var chatInfo = widget.data!["chatInfo"]["options"] ?? [];
    for (var option in chatInfo) {
      if (!tasks.contains(option["option"])) {
        tasks.add(option["option"]);
      }
    }
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: ExactAssetImage('assets/images/flat-design.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 4, left: 10, right: 10),
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundImage: AssetImage(widget.userImage),
                          maxRadius: 30,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                widget.userName,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w600),
                              ),
                              const SizedBox(
                                height: 6,
                              ),
                              const Text(
                                "Online",
                                style: TextStyle(
                                    color: Colors.green, fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 16, left: 10, right: 10),
                    child: Text("Win by getting all the objectives ",
                        style: TextStyle(
                          fontSize: 11,
                        )),
                  ),
                  ListView.builder(
                    itemCount: tasks.length,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding:
                            const EdgeInsets.only(top: 4, left: 10, right: 10),
                        child: InfoCard(
                          objective: tasks[index],
                          index: index + 1,
                        ),
                      );
                    },
                  ),
                ],
              )),
            )),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
            child: CustomBtn(
              text: widget.fromChat ? "Back to Chat" : "Go to Chat",
              textColor: Colors.white,
              outlineBtn: false,
              onPressed: () async {
                if (widget.fromChat) {
                  Navigator.pop(context);
                } else {
                  Navigator.pushReplacement(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          ChatDetailPage(
                        data: widget.data!,
                        jsonName: widget.jsonName,
                        userName: widget.userName,
                        userImage: widget.userImage,
                      ),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                        return child;
                      },
                    ),
                  );
                }
              },
              isDisabled: false,
              isLoading: false,
            )),
      ),
    );
  }
}

class InfoCard extends StatelessWidget {
  final String objective;
  final int index;

  const InfoCard({
    super.key,
    required this.objective,
    required this.index,
  });
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: Card(
        // color: Colors.blue,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          //set border radius more than 50% of height and width to make circle
        ),
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
                Text(
                  "Objective $index",
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Center(
                child: ValidationCheckbox(
                  hasValidValue: false,
                  name: objective,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
