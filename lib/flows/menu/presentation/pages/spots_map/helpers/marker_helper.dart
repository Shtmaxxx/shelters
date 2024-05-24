import 'dart:ui' as ui;
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shelters/flows/menu/presentation/pages/spots_map/enums/markers_icons.dart';
import 'package:shelters/gen/assets.gen.dart';

class MarkerHelper {
  static const int markerWidth = 80;

  static Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  static Future<int> getDistanceToMarker(double lat, double lon) async {
    final position = await Geolocator.getCurrentPosition();
    final distance = Geolocator.distanceBetween(
      position.latitude,
      position.longitude,
      lat,
      lon,
    ).toInt();
    return distance;
  }

  static Future<Map<MarkersIcons, Uint8List>> initMarkersIcons() async {
    return {
      MarkersIcons.shelter: await MarkerHelper.getBytesFromAsset(
        Assets.markers.spot.path,
        markerWidth,
      ),
      MarkersIcons.shelterJoined: await MarkerHelper.getBytesFromAsset(
        Assets.markers.spotJoined.path,
        markerWidth,
      ),
    };
  }
}
