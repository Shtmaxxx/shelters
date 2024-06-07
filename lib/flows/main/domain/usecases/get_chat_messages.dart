// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import 'package:shelters/domain/core/errors/failures.dart';
import 'package:shelters/domain/core/usecase/usecase.dart';
import 'package:shelters/flows/main/domain/entities/message.dart';
import 'package:shelters/flows/main/domain/repositories/chats_repository.dart';

@injectable
class GetChatMessagesUseCase
    implements UseCase<Stream<List<Message>>, GetChatMessagesParams> {
  final ChatsRepositoryI repository;

  GetChatMessagesUseCase(this.repository);

  @override
  Future<Either<Failure, Stream<List<Message>>>> call(
      GetChatMessagesParams params) async {
    return repository.getChatMessages(params.chatId, params.userId);
  }
}

class GetChatMessagesParams {
  GetChatMessagesParams({
    required this.chatId,
    required this.userId,
  });

  final String chatId;
  final String userId;
}
