import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shelters/domain/shared_models/api/user_model.dart';
import 'package:injectable/injectable.dart';

@injectable
class FirestoreUsers {
  FirestoreUsers(this.firebaseFirestore)
      : _usersCollection = firebaseFirestore.collection('users');

  final FirebaseFirestore firebaseFirestore;

  final CollectionReference<Map<String, dynamic>> _usersCollection;

  Future<bool> checkUserExists(String email) async {
    final result = await _usersCollection
        .where(
          'email',
          isEqualTo: email,
        )
        .get();
    return result.docs.isNotEmpty;
  }

  Future<void> addUser({required String name, required String email}) async {
    await _usersCollection.add({'email': email, 'name': name});
  }

  Future<UserModel> getUserByEmail(String email) async {
    final result =
        await _usersCollection.where('email', isEqualTo: email).get();
    final user = result.docs.first;
    final userData = user.data();
    return UserModel(
      id: user.id,
      name: userData['name'],
      email: userData['email'],
    );
  }
}
