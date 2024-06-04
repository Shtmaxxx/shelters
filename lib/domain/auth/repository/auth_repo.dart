import 'package:dartz/dartz.dart';
import 'package:shelters/domain/shared_models/api/user_model.dart';

import '../../core/errors/failures.dart';

abstract class AuthRepositoryI {
  Future<Either<Failure, UserModel>> isUserSignedIn(String email);
}
