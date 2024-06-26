import 'package:fluster/fluster.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapMarker extends Clusterable {
  final String id;
  final LatLng position;
  final BitmapDescriptor icon;

  MapMarker({
    required this.id,
    required this.position,
    required this.icon,
    isCluster = false,
    clusterId,
    pointsSize,
    childMarkerId,
  }) : super(
          markerId: id,
          latitude: position.latitude,
          longitude: position.longitude,
          isCluster: isCluster,
          clusterId: clusterId,
          pointsSize: pointsSize,
          childMarkerId: childMarkerId,
        );

  Marker toMarker(
          {ValueChanged<String>? onPressed}) =>
      Marker(
        markerId: MarkerId(id),
        position: LatLng(
          position.latitude,
          position.longitude,
        ),
        icon: icon,
        onTap: () => onPressed != null ? onPressed(id) : null,
      );
}
