import 'package:shelters/flows/main/domain/entities/message.dart';

class MessageModel extends Message {
  MessageModel({
    required super.id,
    required super.senderName,
    required super.sentByUser,
    required super.messageText,
    required super.dateTime,
  });
}
