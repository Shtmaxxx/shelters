import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:fluster/fluster.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:shelters/domain/core/errors/failures.dart';
import 'package:shelters/flows/main/domain/usecases/join_chat_group.dart';
import 'package:shelters/flows/menu/domain/entities/marker_point.dart';
import 'package:shelters/flows/menu/domain/usecases/get_markers.dart';
import 'package:shelters/flows/menu/presentation/pages/spots_map/enums/markers_icons.dart';
import 'package:shelters/flows/menu/presentation/pages/spots_map/helpers/location_permissions_helper.dart';
import 'package:shelters/flows/menu/presentation/pages/spots_map/helpers/map_constants.dart';
import 'package:shelters/flows/menu/presentation/pages/spots_map/helpers/map_marker.dart';
import 'package:shelters/flows/menu/presentation/pages/spots_map/helpers/marker_helper.dart';

part 'map_state.dart';

@injectable
class MapCubit extends Cubit<MapState> {
  MapCubit({
    required this.getMarkers,
    required this.joinChatGroup,
  }) : super(const Loading());

  final GetMarkersUseCase getMarkers;
  final JoinChatGroupUseCase joinChatGroup;

  static const CameraPosition defaultInitialCameraPosition =
      MapConstants.defaultInitialCameraPosition;

  int _currentZoom = MapConstants.defaultZoomValue.toInt();
  late final GoogleMapController controller;
  late Map<MarkersIcons, Uint8List> markersIcons;
  late Fluster<MapMarker> _fluster;

  Future<void> initMapData(String userId, {String? focusedPlaceId}) async {
    markersIcons = await MarkerHelper.initMarkersIcons();
    await loadMapData(userId, focusedPlaceId);
  }

  Future<void> loadMapData(String userId, [String? focusedPlaceId]) async {
    final result = await getMarkers(userId);
    result.fold(
      (failure) {
        emit(
          MapError(
            markers: state.markers,
            markerPoints: state.markerPoints,
            failure: failure,
          ),
        );
      },
      (markerPoints) async {
        CameraPosition? initialCameraPosition;
        if (focusedPlaceId != null) {
          final markerPoint =
              markerPoints.firstWhereOrNull((m) => m.id == focusedPlaceId);
          if (markerPoint != null) {
            final lat = markerPoint.latitude;
            final lon = markerPoint.longitude;
            initialCameraPosition = CameraPosition(
              target: LatLng(lat, lon),
              zoom: MapConstants.defaultZoomValue,
            );
          }
        } else if (await LocationPermissionsHelper
            .requestLocationPermissions()) {
          final position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high,
          );
          initialCameraPosition = CameraPosition(
            target: LatLng(position.latitude, position.longitude),
            zoom: MapConstants.defaultZoomValue,
          );
        }

        updateFluster(markerPoints);
        await displayMarkers(
          markerPoints: markerPoints,
          initialCameraPosition: initialCameraPosition,
        );
      },
    );
  }

  Future<void> getMapMarkers(String userId) async {
    final result = await getMarkers(userId);
    result.fold(
      (failure) {
        emit(
          MapError(
            markers: state.markers,
            markerPoints: state.markerPoints,
            failure: failure,
          ),
        );
      },
      (markerPoints) async {
        updateFluster(markerPoints);
        await displayMarkers(
          markerPoints: markerPoints,
          initialCameraPosition: state.initialCameraPosition,
        );
      },
    );
  }

  Future<void> displayMarkers({
    List<MarkerPoint>? markerPoints,
    CameraPosition? initialCameraPosition,
  }) async {
    List<MapMarker> clusters =
        _fluster.clusters([-180, -85, 180, 85], _currentZoom);

    final markers = clusters.map((c) {
      if (c.isCluster ?? false) {
        return c.toMarker(onPressed: _onClusterPressed);
      }
      return c.toMarker(onPressed: _onMarkerPressed);
    }).toSet();
    
    emit(
      MapDataLoaded(
        markers: markers,
        markerPoints: markerPoints ?? state.markerPoints,
        initialCameraPosition:
            initialCameraPosition ?? state.initialCameraPosition,
      ),
    );
  }

  Future<void> joinSpot({
    required String userId,
    required String chatId,
    required String spotName,
  }) async {
    final result = await joinChatGroup(
      JoinChatParams(userId: userId, chatId: chatId),
    );
    result.fold(
      (failure) {
        emit(
          MapError(
            markers: state.markers,
            markerPoints: state.markerPoints,
            failure: failure,
          ),
        );
      },
      (_) {
        emit(
          SpotJoined(
            chatId: chatId,
            spotName: spotName,
            markers: state.markers,
            markerPoints: state.markerPoints,
          ),
        );
      },
    );
  }

  void updateFluster(List<MarkerPoint> markerPoints) {
    final mapMarkers = markerPoints
        .map(
          (m) => MapMarker(
            id: m.id,
            position: LatLng(m.latitude, m.longitude),
            icon: BitmapDescriptor.fromBytes(m.spotJoined
                ? markersIcons[MarkersIcons.shelterJoined]!
                : markersIcons[MarkersIcons.shelter]!),
          ),
        )
        .toList();
    _fluster = Fluster<MapMarker>(
      minZoom: MapConstants.flusterMinZoom,
      maxZoom: MapConstants.flusterMaxZoom,
      radius: MapConstants.flusterRadius,
      extent: MapConstants.flusterExtent,
      nodeSize: MapConstants.flusterNodeSize,
      points: mapMarkers,
      createCluster:
          (BaseCluster? cluster, double? longitude, double? latitude) {
        return MapMarker(
          id: cluster!.id.toString(),
          position: LatLng(latitude!, longitude!),
          icon: BitmapDescriptor.fromBytes(
            markersIcons[MarkersIcons.shelterCluster]!,
          ),
          isCluster: cluster.isCluster,
          clusterId: cluster.id,
          pointsSize: cluster.pointsSize,
          childMarkerId: cluster.childMarkerId,
        );
      },
    );
  }

  void resetMap() => emit(
        MapDataLoaded(
          markers: state.markers,
          markerPoints: state.markerPoints,
          initialCameraPosition: state.initialCameraPosition,
        ),
      );

  void emitLoading() => emit(
        Loading(
          markers: state.markers,
          markerPoints: state.markerPoints,
        ),
      );

  void onCameraMoved(double zoom) {
    if (_currentZoom != zoom.toInt()) {
      _currentZoom = zoom.toInt();
      if (state is MapDataLoaded) {
        displayMarkers();
      }
    }
  }

  void onMapCreated(GoogleMapController mapController) {
    controller = mapController;
  }

  void _onClusterPressed(String clusterId) async {
    final position =
        state.markers.firstWhere((m) => m.markerId.value == clusterId).position;
    while (_fluster.clusters([-180, -85, 180, 85], _currentZoom).any(
        (c) => c.position == position)) {
      _currentZoom++;
    }
    await controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(position.latitude, position.longitude),
          zoom: _currentZoom.toDouble(),
        ),
      ),
    );
  }

  void _onMarkerPressed(String id) {
    final pressedMarkerPoint =
        state.markerPoints.firstWhereOrNull((m) => m.id == id);

    if (pressedMarkerPoint != null) {
      emit(
        MarkerPressed(
          markers: state.markers,
          markerPoints: state.markerPoints,
          pressedMarkerPoint: pressedMarkerPoint,
        ),
      );
    } else {
      emit(
        MapError(
          markers: state.markers,
          markerPoints: state.markerPoints,
          failure: const OtherFailure(
            message: 'ERROR: Could not find any spot info',
          ),
        ),
      );
    }
  }

  @override
  Future<void> close() async {
    controller.dispose();
    super.close();
  }
}
