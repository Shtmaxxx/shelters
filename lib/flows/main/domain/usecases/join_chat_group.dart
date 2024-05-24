import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:shelters/domain/core/errors/failures.dart';
import 'package:shelters/domain/core/usecase/usecase.dart';
import 'package:shelters/flows/main/domain/repositories/chats_repository.dart';

@injectable
class JoinChatGroupUseCase implements UseCase<void, JoinChatParams> {
  final ChatsRepositoryI repository;

  JoinChatGroupUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(JoinChatParams params) async {
    return await repository.addUserToGroupChat(
      userId: params.userId,
      chatId: params.chatId,
    );
  }
}

class JoinChatParams {
  JoinChatParams({
    required this.userId,
    required this.chatId,
  });

  final String userId;
  final String chatId;
}