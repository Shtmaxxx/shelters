import 'dart:math';
import 'dart:ui' as ui;
import 'package:flutter/services.dart';
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

  static double calculateDistance(lat1, lon1, lat2, lon2) {
    const p = 0.017453292519943295;
    const c = cos;
    final a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }

  static Future<Map<MarkersIcons, Uint8List>> initMarkersIcons() async {
    return {
      MarkersIcons.spot: await MarkerHelper.getBytesFromAsset(
        Assets.markers.spot.path,
        markerWidth,
      ),
      MarkersIcons.spotJoined: await MarkerHelper.getBytesFromAsset(
        Assets.markers.spotJoined.path,
        markerWidth,
      ),
    };
  }
}
