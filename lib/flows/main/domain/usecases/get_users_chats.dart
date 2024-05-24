import 'package:injectable/injectable.dart';
import 'package:shelters/domain/core/errors/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:shelters/flows/main/domain/entities/chat.dart';
import 'package:shelters/flows/main/domain/repositories/chats_repository.dart';

@injectable
class GetUsersChatsUseCase {
  final ChatsRepositoryI repository;

  GetUsersChatsUseCase(this.repository);

  Either<Failure, Stream<List<Chat>>> call(String userId) {
    return repository.getUsersChats(userId);
  }
}