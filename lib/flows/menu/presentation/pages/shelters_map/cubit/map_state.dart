part of 'map_cubit.dart';

abstract class MapState extends Equatable {
  const MapState({
    this.markers = const <Marker>{},
    this.markerPoints = const [],
    this.initialCameraPosition = MapCubit.defaultInitialCameraPosition,
  });
  final Set<Marker> markers;
  final List<MarkerPoint> markerPoints;
  final CameraPosition initialCameraPosition;

  @override
  List<Object> get props => [markers, markerPoints, initialCameraPosition];
}

class Loading extends MapState {
  const Loading({
    super.markers,
    super.markerPoints,
  });
}

class MapDataLoaded extends MapState {
  const MapDataLoaded({
    super.markers,
    super.markerPoints,
    super.initialCameraPosition,
  });
}

class MarkerPressed extends MapDataLoaded {
  const MarkerPressed({
    super.markers,
    super.markerPoints,
    required this.pressedMarkerPoint,
  });

  final MarkerPoint pressedMarkerPoint;
}

class MarkerDeleted extends MapState {
  const MarkerDeleted({
    super.markers,
    super.markerPoints,
  });
}

class ShelterJoined extends MapDataLoaded {
  const ShelterJoined({
    super.markers,
    super.markerPoints,
    required this.chatId,
    required this.shelterName,
  });

  final String chatId;
  final String shelterName;
}

class MapError extends MapDataLoaded {
  const MapError({
    super.markers,
    super.markerPoints,
    required this.failure,
  });

  final Failure failure;
}

