import 'package:injectable/injectable.dart';
import 'package:shelters/domain/core/errors/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:shelters/flows/main/data/datasources/chats_datasource.dart';
import 'package:shelters/flows/main/domain/entities/chat.dart';
import 'package:shelters/flows/main/domain/entities/message.dart';
import 'package:shelters/flows/main/domain/repositories/chats_repository.dart';

@Injectable(as: ChatsRepositoryI)
class ChatsRepositoryImpl implements ChatsRepositoryI {
  final ChatsDatasourceI remoteDataSource;

  ChatsRepositoryImpl(this.remoteDataSource);

  @override
  Either<Failure, Stream<List<Chat>>> getUsersChats(String userId) {
    try {
      final result = remoteDataSource.getUsersChats(userId);
      return Right(result);
    } on ServerFailure catch (exception) {
      return Left(ServerFailure(message: 'Something went wrong: $exception'));
    }
  }

  @override
  Either<Failure, Stream<List<Message>>> getChatMessages(
      String chatId, String userId) {
    try {
      final result = remoteDataSource.getChatMessages(chatId, userId);
      return Right(result);
    } on ServerFailure catch (exception) {
      return Left(ServerFailure(message: 'Something went wrong: $exception'));
    }
  }

  @override
  Future<Either<Failure, void>> sendMessage({
    required String chatId,
    required String senderId,
    required DateTime dateTime,
    required String text,
  }) async {
    try {
      final result = await remoteDataSource.sendMessage(
        chatId: chatId,
        senderId: senderId,
        dateTime: dateTime,
        text: text,
      );
      return Right(result);
    } on ServerFailure catch (exception) {
      return Left(ServerFailure(message: 'Something went wrong: $exception'));
    }
  }

  @override
  Future<Either<Failure, void>> addUserToGroupChat({
    required String userId,
    required String chatId,
  }) async {
    try {
      final result = await remoteDataSource.addUserToGroupChat(
        userId: userId,
        chatId: chatId,
      );
      return Right(result);
    } on ServerFailure catch (exception) {
      return Left(ServerFailure(message: 'Something went wrong: $exception'));
    }
  }

  @override
  Future<Either<Failure, void>> removeUserFromGroupChat({
    required String userId,
    required String chatId,
  }) async {
    try {
      final result = await remoteDataSource.removeUserFromGroupChat(
        userId: userId,
        chatId: chatId,
      );
      return Right(result);
    } on ServerFailure catch (exception) {
      return Left(ServerFailure(message: 'Something went wrong: $exception'));
    }
  }
}
