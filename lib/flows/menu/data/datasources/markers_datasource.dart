import 'package:injectable/injectable.dart';
import 'package:shelters/domain/core/errors/failures.dart';
import 'package:shelters/flows/menu/data/models/marker_point_model.dart';
import 'package:shelters/services/firestore/firestore_markers.dart';

abstract class MarkersDatasourceI {
  Future<List<MarkerPointModel>> getMarkers(String userId);
  Future<void> addMarkerPoint({
    required String name,
    required String description,
    required double lat,
    required double lon,
  });
  Future<void> removeMarkerPoint({
    required String markerId,
    required String chatId,
  });
}

@Injectable(as: MarkersDatasourceI)
class MarkersDatasourceImpl implements MarkersDatasourceI {
  MarkersDatasourceImpl({
    required this.firestoreMarkers,
  });

  final FirestoreMarkers firestoreMarkers;

  @override
  Future<List<MarkerPointModel>> getMarkers(String userId) async {
    try {
      final result = await firestoreMarkers.getMarkerPoints(userId);
      return result;
    } catch (exception) {
      throw ServerFailure(message: 'Something went wrong: $exception');
    }
  }

  @override
  Future<void> addMarkerPoint({
    required String name,
    required String description,
    required double lat,
    required double lon,
  }) async {
    try {
      final result = await firestoreMarkers.addMarkerPoint(
        name: name,
        description: description,
        lat: lat,
        lon: lon,
      );
      return result;
    } catch (exception) {
      throw ServerFailure(message: 'Something went wrong: $exception');
    }
  }

  @override
  Future<void> removeMarkerPoint({
    required String markerId,
    required String chatId,
  }) async {
    try {
      final result = await firestoreMarkers.removeMarkerPoint(
        markerId: markerId,
        chatId: chatId,
      );
      return result;
    } catch (exception) {
      throw ServerFailure(message: 'Something went wrong: $exception');
    }
  }
}
