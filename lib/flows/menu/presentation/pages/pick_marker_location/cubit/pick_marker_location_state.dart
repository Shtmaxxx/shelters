part of 'pick_marker_location_cubit.dart';

abstract class PickMarkerLocationState extends Equatable {
  const PickMarkerLocationState({
    this.markers = const <Marker>{},
    this.markerPoint,
  });

  final Set<Marker> markers;
  final MarkerPoint? markerPoint;

  @override
  List<Object?> get props => [markers, markerPoint];
}

class PickMarkerLocationLoading extends PickMarkerLocationState {
  const PickMarkerLocationLoading({
    super.markers,
    super.markerPoint,
  });
}

class MapDataLoaded extends PickMarkerLocationState {
  const MapDataLoaded({
    super.markers,
    super.markerPoint,
  });
}

class MarkerAdded extends PickMarkerLocationState {
  const MarkerAdded({
    super.markers,
    super.markerPoint,
  });
}

class PickLocationError extends PickMarkerLocationState {
  const PickLocationError({
    super.markers,
    super.markerPoint,
    required this.failure,
  });

  final Failure failure;
}