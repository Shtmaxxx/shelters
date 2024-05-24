class Message {
  Message({
    required this.id,
    required this.senderName,
    required this.sentByUser,
    required this.messageText,
    required this.dateTime,
  });

  final String id;
  final String senderName;
  final bool sentByUser;
  final String messageText;
  final DateTime dateTime;
}
