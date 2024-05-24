enum MarkersIcons {
  spot,
  spotJoined,
}

class MarkersIconsMapper {
  static MarkersIcons toEnum(int index) => MarkersIcons.values[index];
}
