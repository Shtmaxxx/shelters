import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

class LocationPermissionsHelper {
  static const CameraPosition defaultInitialCameraPosition = CameraPosition(
    target: LatLng(50.448899667450405, 30.456975575830512),
    zoom: 15,
  );

  static Future<bool> requestLocationPermissions() async {
    final status = await Permission.location.request();
    return status == PermissionStatus.granted ||
        status == PermissionStatus.limited;
  }

  static Future<bool> checkLocationPermissions() async {
    final status = await Permission.location.status;
    return status == PermissionStatus.granted ||
        status == PermissionStatus.limited;
  }
}
