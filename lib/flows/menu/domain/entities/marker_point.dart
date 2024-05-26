class MarkerPoint {
  const MarkerPoint({
    this.id = '',
    required this.name,
    required this.description,
    required this.chatId,
    required this.shelterJoined,
    required this.latitude,
    required this.longitude,
  });

  final String id;
  final String name;
  final String description;
  final String chatId;
  final bool shelterJoined;
  final double latitude;
  final double longitude;

  MarkerPoint copyWith({
    String? id,
    String? name,
    String? description,
    String? chatId,
    bool? shelterJoined,
    double? latitude,
    double? longitude,
  }) {
    return MarkerPoint(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      chatId: chatId ?? this.chatId,
      shelterJoined: shelterJoined ?? this.shelterJoined,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
    );
  }
}
