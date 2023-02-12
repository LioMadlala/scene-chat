import '../pages/chat/chat_detail_page.dart';

class ChatMessage {
  final String message;
  final String emotion;
  final MessageType type;

  ChatMessage({
    required this.message,
    required this.type,
    required this.emotion,
  });
}
