import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:shelters/domain/core/errors/failures.dart';
import 'package:shelters/flows/main/domain/entities/message.dart';
import 'package:shelters/flows/main/domain/repositories/chats_repository.dart';

@injectable
class GetChatMessagesUseCase {
  final ChatsRepositoryI repository;

  GetChatMessagesUseCase(this.repository); 

  Either<Failure, Stream<List<Message>>> call(String chatId, String userId) {
    return repository.getChatMessages(chatId, userId);
  }
}