import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shelters/domain/core/errors/failures.dart';
import 'package:shelters/domain/core/usecase/usecase.dart';
import 'package:shelters/flows/auth/domain/repositories/auth_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class SignUpUseCase implements UseCase<UserCredential, SignUpParams> {
  final AuthRepositoryI repository;

  SignUpUseCase(this.repository);

  @override
  Future<Either<Failure, UserCredential>> call(SignUpParams parameters) async {
    return await repository.signUp(parameters);
  }
}

class SignUpParams {
  final String name;
  final String email;
  final String password;

  SignUpParams({
    required this.name,
    required this.email,
    required this.password,
  });
}
