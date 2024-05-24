import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:shelters/domain/core/errors/failures.dart';
import 'package:shelters/domain/core/usecase/usecase.dart';
import 'package:shelters/flows/main/domain/repositories/chats_repository.dart';

@injectable
class SendMessageUseCase implements UseCase<void, SendMessageParams> {
  final ChatsRepositoryI repository;

  SendMessageUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(SendMessageParams params) async {
    return await repository.sendMessage(
      chatId: params.chatId,
      senderId: params.senderId,
      dateTime: params.dateTime,
      text: params.text,
    );
  }
}

class SendMessageParams {
  SendMessageParams({
    required this.chatId,
    required this.senderId,
    required this.dateTime,
    required this.text,
  });

  final String chatId;
  final String senderId;
  final DateTime dateTime;
  final String text;
}
