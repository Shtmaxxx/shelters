import 'package:firebase_auth/firebase_auth.dart';
import 'package:shelters/domain/core/errors/failures.dart';
import 'package:shelters/domain/shared_models/api/user_model.dart';
import 'package:shelters/services/firestore/firestore_users.dart';
import 'package:injectable/injectable.dart';

abstract class AuthDataSourceI {
  Future<UserCredential> signIn(String email, String password);
  Future<UserCredential> signUp({
    required String name,
    required String email,
    required String password,
  });
  Future<void> signOut();
  Future<UserModel> getUserByEmail(String email);
}

@Injectable(as: AuthDataSourceI)
class AuthDataSourceImpl implements AuthDataSourceI {
  AuthDataSourceImpl({
    required this.firebaseAuth,
    required this.firestoreUsers,
  });

  final FirebaseAuth firebaseAuth;
  final FirestoreUsers firestoreUsers;

  @override
  Future<UserCredential> signIn(String email, String password) async {
    try {
      final userCredential = await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential;
    } on FirebaseAuthException catch (exception) {
      throw (ServerFailure(message: exception.message ?? exception.code));
    } catch (exception) {
      throw (OtherFailure(message: 'Failed to sign in $exception'));
    }
  }

  @override
  Future<void> signOut() async {
    try {
      firebaseAuth.signOut();
    } catch (exception) {
      throw (ServerFailure(message: exception.toString()));
    }
  }

  @override
  Future<UserModel> getUserByEmail(String email) async {
    try {
      final result = await firestoreUsers.getUserByEmail(email);
      return result;
    } catch (exception) {
      throw ServerFailure(message: 'Something went wrong: $exception');
    }
  }

  @override
  Future<UserCredential> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final userCredential = await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final userEmail = userCredential.user!.email!;
      await firestoreUsers.addUser(name: name, email: userEmail);

      return userCredential;
    } on FirebaseAuthException catch (exception) {
      throw (ServerFailure(message: exception.message ?? exception.code));
    } catch (exception) {
      throw (OtherFailure(message: 'Failed to sign up $exception'));
    }
  }
}
