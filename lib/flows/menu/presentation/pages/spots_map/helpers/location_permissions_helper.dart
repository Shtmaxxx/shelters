import 'package:permission_handler/permission_handler.dart';

class LocationPermissionsHelper {
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
