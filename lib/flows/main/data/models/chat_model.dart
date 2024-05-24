import 'package:shelters/flows/main/domain/entities/chat.dart';

class ChatModel extends Chat {
  ChatModel({
    required super.id,
    required super.title,
    required super.recentMessage,
    required super.recentMessageDateTime,
    required super.isGroup,
  });
}
