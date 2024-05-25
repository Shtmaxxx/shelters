enum MarkersIcons {
  shelter,
  shelterJoined,
  shelterCluster,
}

class MarkersIconsMapper {
  static MarkersIcons toEnum(int index) => MarkersIcons.values[index];
}
