import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
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
      LocationPermissionsHelper.defaultInitialCameraPosition;

  late final GoogleMapController controller;
  late Map<MarkersIcons, Uint8List> markersIcons;

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
              zoom: 14,
            );
          }
        } else if (await LocationPermissionsHelper
            .requestLocationPermissions()) {
          final position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high,
          );
          initialCameraPosition = CameraPosition(
            target: LatLng(position.latitude, position.longitude),
            zoom: 14,
          );
        }
        await displayMarkers(
          markerPoints,
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
        await displayMarkers(
          markerPoints,
          initialCameraPosition: state.initialCameraPosition,
        );
      },
    );
  }

  Future<void> displayMarkers(List<MarkerPoint> markerPoints,
      {CameraPosition? initialCameraPosition}) async {
    final markers = markerPoints
        .map(
          (m) => Marker(
            markerId: MarkerId(m.id),
            position: LatLng(m.latitude, m.longitude),
            icon: BitmapDescriptor.fromBytes(m.spotJoined
                ? markersIcons[MarkersIcons.shelterJoined]!
                : markersIcons[MarkersIcons.shelter]!),
            onTap: () => _onMarkerPressed(m.id),
          ),
        )
        .toSet();

    emit(
      MapDataLoaded(
        markers: markers,
        markerPoints: markerPoints,
        initialCameraPosition:
            initialCameraPosition ?? defaultInitialCameraPosition,
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

  void resetMap() => emit(
        MapDataLoaded(
          markers: state.markers,
          markerPoints: state.markerPoints,
        ),
      );

  void emitLoading() => emit(
        Loading(
          markers: state.markers,
          markerPoints: state.markerPoints,
        ),
      );

  void onMapCreated(GoogleMapController mapController) {
    controller = mapController;
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
