import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shelters/domain/core/errors/failures.dart';
import 'package:shelters/flows/auth/domain/usecases/sign_up.dart';

import '../usecases/sign_in.dart';

abstract class AuthRepositoryI {
  Future<Either<Failure, UserCredential>> signIn(SignInParams params);
  Future<Either<Failure, UserCredential>> signUp(SignUpParams params);
  Future<Either<Failure, void>> signOut();
}
