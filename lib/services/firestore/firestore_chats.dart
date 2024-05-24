import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:shelters/flows/main/data/models/chat_model.dart';

@injectable
class FirestoreChats {
  FirestoreChats(this.firebaseFirestore)
      : _chatsCollection = firebaseFirestore.collection('chats'),
        _usersCollection = firebaseFirestore.collection('users');

  final FirebaseFirestore firebaseFirestore;

  final CollectionReference<Map<String, dynamic>> _chatsCollection;
  final CollectionReference<Map<String, dynamic>> _usersCollection;

  Stream<List<ChatModel>> getUsersChats(String userId) {
    final currentUserRef = _usersCollection.doc(userId);
    final result = _chatsCollection
        .where(
          'participantsRefs',
          arrayContains: currentUserRef,
        )
        .snapshots();

    final chats = result.asyncMap(
      (c) => Future.wait(
        c.docs.map((item) async {
          final chatData = item.data();
          final String chatTitle;
          final bool isGroup = chatData['isGroupChat'];
          if (isGroup) {
            chatTitle = chatData['title'];
          } else {
            final List<DocumentReference> participantsRefs =
                chatData['participantsRefs']
                        ?.cast<DocumentReference<Map<String, dynamic>>>()
                        .toList() ??
                    List<DocumentReference>.empty;
            final chatUserRef =
                participantsRefs.firstWhere((u) => u != currentUserRef);
            chatTitle = (await chatUserRef.get()).get('email');
          }

          return ChatModel(
            id: item.id,
            title: chatTitle,
            recentMessage: chatData['recentMessage'],
            recentMessageDateTime: chatData['recentMessageDateTime'].toDate(),
            isGroup: isGroup,
          );
        }).toList(),
      ),
    );

    return chats;
  }

  Future<void> addUserToGroupChat({
    required String userId,
    required String chatId,
  }) async {
    final currentUserRef = _usersCollection.doc(userId);
    final chatDoc = await _chatsCollection.doc(chatId).get();
    final List participants = chatDoc.get('participantsRefs');
    if (!participants.any((p) => p.id == currentUserRef.id)) {
      await _chatsCollection.doc(chatId).update({
        'participantsRefs': FieldValue.arrayUnion([currentUserRef]),
      });
    }
  }
}
