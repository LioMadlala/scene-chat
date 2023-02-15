// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:hive/hive.dart';
import 'package:scene_chat/pages/chat/chat_detail_page.dart';

// command to build the Model
// flutter packages pub run build_runner build --delete-conflicting-outputs
part 'chat_adapter.g.dart';

@HiveType(typeId: 1)
class Chat {
  @HiveField(0)
  String message;
  @HiveField(1)
  String emotion;
  @HiveField(2)
  String type;

  Chat({
    required this.message,
    required this.emotion,
    required this.type,
  });
}
