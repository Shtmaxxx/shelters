class MarkerPoint {
  const MarkerPoint({
    this.id = '',
    required this.name,
    required this.description,
    required this.chatId,
    required this.spotJoined,
    required this.latitude,
    required this.longitude,
  });

  final String id;
  final String name;
  final String description;
  final String chatId;
  final bool spotJoined;
  final double latitude;
  final double longitude;

  MarkerPoint copyWith({
    String? id,
    String? name,
    String? description,
    String? chatId,
    bool? spotJoined,
    double? latitude,
    double? longitude,
  }) {
    return MarkerPoint(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      chatId: chatId ?? this.chatId,
      spotJoined: spotJoined ?? this.spotJoined,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
    );
  }
}
