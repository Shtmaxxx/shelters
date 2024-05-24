import 'package:dartz/dartz.dart';
import 'package:shelters/domain/shared_models/api/user_model.dart';

import '../../core/entities/token.dart';
import '../../core/errors/failures.dart';

abstract class AuthRepositoryI {
  Future<Either<Failure, Token>> getOAuthToken();
  Future<Either<Failure, Token>> getRefreshToken(String refreshToken);
  Future<Either<Failure, UserModel>> isUserSignedIn(String email);
}
