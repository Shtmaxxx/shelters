import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:shelters/domain/core/errors/failures.dart';
import 'package:shelters/flows/menu/domain/entities/marker_point.dart';
import 'package:shelters/flows/menu/domain/usecases/add_marker_point.dart';
import 'package:shelters/flows/menu/presentation/pages/shelters_map/enums/markers_icons.dart';
import 'package:shelters/flows/menu/presentation/pages/shelters_map/helpers/location_permissions_helper.dart';
import 'package:shelters/flows/menu/presentation/pages/shelters_map/helpers/map_constants.dart';
import 'package:shelters/flows/menu/presentation/pages/shelters_map/helpers/marker_helper.dart';

part 'pick_marker_location_state.dart';

@injectable
class PickMarkerLocationCubit extends Cubit<PickMarkerLocationState> {
  PickMarkerLocationCubit(this._addMarkerPointUseCase)
      : super(const PickMarkerLocationLoading());

  late final GoogleMapController controller;
  late final CameraPosition initialCameraPosition;
  late final Map<MarkersIcons, Uint8List> markersIcons;

  final AddMarkerPointUseCase _addMarkerPointUseCase;

  Future<void> loadMapData() async {
    if (await LocationPermissionsHelper.requestLocationPermissions()) {
      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      initialCameraPosition = CameraPosition(
        target: LatLng(position.latitude, position.longitude),
        zoom: 14,
      );
    } else {
      initialCameraPosition = MapConstants.defaultInitialCameraPosition;
    }

    markersIcons = await MarkerHelper.initMarkersIcons();
    final MarkerPoint markerPoint = MarkerPoint(
      name: 'Marker one',
      description: '',
      chatId: '',
      shelterJoined: false,
      latitude: initialCameraPosition.target.latitude,
      longitude: initialCameraPosition.target.longitude,
    );
    Marker(
      markerId: const MarkerId('pickLocationMarker'),
      position: LatLng(
        initialCameraPosition.target.latitude,
        initialCameraPosition.target.longitude,
      ),
      icon: BitmapDescriptor.fromBytes(
        markersIcons[MarkersIcons.shelterJoined]!,
      ),
    );
    await displayMarker(markerPoint);
  }

  Future<void> displayMarker(MarkerPoint markerPoint) async {
    final markers = {
      Marker(
        markerId: const MarkerId('pickLocationMarker'),
        position: LatLng(markerPoint.latitude, markerPoint.longitude),
        icon: BitmapDescriptor.fromBytes(
          markersIcons[MarkersIcons.shelterJoined]!,
        ),
      ),
    };

    emit(
      MapDataLoaded(
        markers: markers,
        markerPoint: markerPoint,
      ),
    );
  }

  Future<void> addMarkerPoint({
    required String name,
    required String description,
    required double lat,
    required double lon,
  }) async {
    AddMarkerPointParameters params = AddMarkerPointParameters(
      name: name,
      description: description,
      lat: lat,
      lon: lon,
    );

    final result = await _addMarkerPointUseCase(params);
    result.fold(
      (failure) {
        emit(
          PickLocationError(
            markers: state.markers,
            markerPoint: state.markerPoint,
            failure: failure,
          ),
        );
      },
      (_) {
        emit(
          MarkerAdded(
            markers: state.markers,
            markerPoint: state.markerPoint,
          ),
        );
      },
    );
  }

  void onMapPressed(LatLng position) {
    final lat = position.latitude;
    final lon = position.longitude;

    emit(
      MapDataLoaded(
        markers: {state.markers.first.copyWith(positionParam: position)},
        markerPoint: state.markerPoint?.copyWith(
          latitude: lat,
          longitude: lon,
        ),
      ),
    );
  }

  void onMapCreated(GoogleMapController mapController) {
    controller = mapController;
  }
}
