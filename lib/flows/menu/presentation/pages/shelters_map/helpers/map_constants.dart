import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapConstants {
  static const int markerWidth = 80;
  static const int clusterWidth = 110;
  static const double defaultZoomValue = 14.7;
  static const int flusterMinZoom = 0;
  static const int flusterMaxZoom = 20;
  static const int flusterRadius = 150;
  static const int flusterExtent = 2048;
  static const int flusterNodeSize = 64;
  static const CameraPosition defaultInitialCameraPosition = CameraPosition(
    target: LatLng(50.448899667450405, 30.456975575830512),
    zoom: 15,
  );
}
