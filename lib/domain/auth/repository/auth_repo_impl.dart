import 'package:dartz/dartz.dart';
import 'package:shelters/domain/auth/datasource/auth_datasource.dart';
import 'package:shelters/domain/shared_models/api/user_model.dart';
import 'package:injectable/injectable.dart';

import '../../core/entities/token.dart';
import '../../core/errors/failures.dart';
import 'auth_repo.dart';

@Injectable(as: AuthRepositoryI)
class AuthRepositoryImplementation implements AuthRepositoryI {
  AuthRepositoryImplementation(
    this.remoteDataSource,
  );

  final AuthDataSourceI remoteDataSource;

  @override
  Future<Either<Failure, Token>> getOAuthToken() async {
    return Right(Token.ofNoneType());
  }

  @override
  Future<Either<Failure, Token>> getRefreshToken(String refreshToken) async {
    return Right(Token.ofNoneType());
  }

  @override
  Future<Either<Failure, UserModel>> isUserSignedIn(String email) async {
    try {
      final result = await remoteDataSource.getUserByEmail(email);
      return Right(result);
    } on ServerFailure catch (exception) {
      return Left(ServerFailure(message: 'Something went wrong: $exception'));
    }
  }
}
