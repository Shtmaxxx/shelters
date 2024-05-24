enum MarkersIcons {
  shelter,
  shelterJoined,
}

class MarkersIconsMapper {
  static MarkersIcons toEnum(int index) => MarkersIcons.values[index];
}
