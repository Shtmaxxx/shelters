import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:injectable/injectable.dart';
import 'package:shelters/flows/menu/data/models/marker_point_model.dart';

@injectable
class FirestoreMarkers {
  FirestoreMarkers(this.firebaseFirestore)
      : _markersCollection = firebaseFirestore.collection('markers'),
        _chatsCollection = firebaseFirestore.collection('chats'),
        _usersCollection = firebaseFirestore.collection('users');

  final FirebaseFirestore firebaseFirestore;

  final CollectionReference<Map<String, dynamic>> _markersCollection;
  final CollectionReference<Map<String, dynamic>> _chatsCollection;
  final CollectionReference<Map<String, dynamic>> _usersCollection;

  Future<List<MarkerPointModel>> getMarkerPoints(String userId) async {
    final currentUserRef = _usersCollection.doc(userId);
    final chatsResult = await _chatsCollection
        .where(
          'isGroupChat',
          isEqualTo: true,
        )
        .where(
          'participantsRefs',
          arrayContains: currentUserRef,
        )
        .get();
    final result = await _markersCollection.get();
    final markersFutures = result.docs.map((doc) async {
      final DocumentReference chatRef = doc.get('chatRef');
      final chatDoc = await chatRef.get();
      final spotJoined =
          chatsResult.docs.firstWhereOrNull((doc) => doc.id == chatDoc.id) !=
              null;
      final GeoPoint geoPoint = doc.get('geopoint');

      return MarkerPointModel(
        id: doc.id,
        name: chatDoc.get('title'),
        description: chatDoc.get('description'),
        chatId: chatDoc.id,
        spotJoined: spotJoined,
        latitude: geoPoint.latitude,
        longitude: geoPoint.longitude,
      );
    }).toList();
    final markerPoints = await Future.wait(markersFutures);

    return markerPoints;
  }
}
