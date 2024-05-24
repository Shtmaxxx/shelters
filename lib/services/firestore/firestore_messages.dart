import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:shelters/flows/main/data/models/message_model.dart';

@injectable
class FirestoreMessages {
  FirestoreMessages(this.firebaseFirestore)
      : _chatsCollection = firebaseFirestore.collection('chats'),
        _usersCollection = firebaseFirestore.collection('users');

  final FirebaseFirestore firebaseFirestore;

  final CollectionReference<Map<String, dynamic>> _chatsCollection;
  final CollectionReference<Map<String, dynamic>> _usersCollection;

  Stream<List<MessageModel>> getChatMessages(String chatId, String userId) {
    final messagesSnapshot = _chatsCollection
        .doc(chatId)
        .collection('messages')
        .orderBy('dateTime', descending: true)
        .snapshots();
    final messages = messagesSnapshot.asyncMap(
      (s) => Future.wait(
        s.docs.map(
          (m) async {
            final data = m.data();
            final DocumentReference<Map<String, dynamic>> senderRef =
                data['senderRef'];
            final senderDoc = await senderRef.get();

            return MessageModel(
              id: m.id,
              senderName: senderDoc.get('name'),
              sentByUser: senderDoc.id == userId,
              messageText: data['text'],
              dateTime: data['dateTime'].toDate(),
            );
          },
        ).toList(),
      ),
    );

    return messages;
  }

  Future<void> addMessage({
    required String chatId,
    required String senderId,
    required DateTime dateTime,
    required String text,
  }) async {
    final senderRef = _usersCollection.doc(senderId);
    await _chatsCollection.doc(chatId).collection('messages').add({
      'dateTime': Timestamp.fromDate(dateTime),
      'text': text,
      'senderRef': senderRef,
    });
    await _chatsCollection.doc(chatId).update({
      'recentMessage': text,
      'recentMessageDateTime': Timestamp.fromDate(dateTime),
    });
  }
}
