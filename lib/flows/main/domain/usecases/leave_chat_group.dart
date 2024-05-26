import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:shelters/domain/core/errors/failures.dart';
import 'package:shelters/domain/core/usecase/usecase.dart';
import 'package:shelters/flows/main/domain/repositories/chats_repository.dart';
import 'package:shelters/flows/main/domain/usecases/join_chat_group.dart';

@injectable
class LeaveChatGroupUseCase implements UseCase<void, ChatGroupParams> {
  final ChatsRepositoryI repository;

  LeaveChatGroupUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(ChatGroupParams params) async {
    return await repository.removeUserFromGroupChat(
      userId: params.userId,
      chatId: params.chatId,
    );
  }
}
