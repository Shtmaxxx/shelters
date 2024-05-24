class Chat {
  Chat({
    required this.id,
    required this.title,
    required this.recentMessage,
    required this.recentMessageDateTime,
    required this.isGroup,
  });

  final String id;
  final String title;
  final String recentMessage;
  final DateTime recentMessageDateTime;
  final bool isGroup;
}
