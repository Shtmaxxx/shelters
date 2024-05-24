import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:shelters/domain/core/errors/failures.dart';
import 'package:shelters/flows/main/domain/entities/message.dart';
import 'package:shelters/flows/main/domain/usecases/get_chat_messages.dart';
import 'package:shelters/flows/main/domain/usecases/send_message.dart';

part 'messages_state.dart';

@injectable
class MessagesCubit extends Cubit<MessagesState> {
  MessagesCubit(
    this.getChatMessagesUseCase,
    this.sendMessageUseCase,
  )   : messageController = TextEditingController(),
        super(MessagesLoading());

  final TextEditingController messageController;

  final GetChatMessagesUseCase getChatMessagesUseCase;
  final SendMessageUseCase sendMessageUseCase;

  void initStream(String chatId, String userId) {
    final result = getChatMessagesUseCase(chatId, userId);
    result.fold(
      (failure) {
        emit(
          MessagesError(failure: failure),
        );
      },
      (stream) {
        // stream.listen((event) {},);
        emit(
          MessagesInitial(stream: stream),
        );
      },
    );
  }

  Future<void> sendMessage({
    required String chatId,
    required String senderId,
    required DateTime dateTime,
  }) async {
    if (messageController.text.isNotEmpty) {
      final result = await sendMessageUseCase(
        SendMessageParams(
          chatId: chatId,
          senderId: senderId,
          dateTime: dateTime,
          text: messageController.text,
        ),
      );
      result.fold(
        (failure) {
          emit(
            MessagesError(failure: failure),
          );
        },
        (result) {},
      );
    }
  }

  void emitError(String error) => emit(
        MessagesError(
          failure: OtherFailure(
            message: error,
          ),
        ),
      );

  @override
  Future<void> close() {
    messageController.dispose();
    return super.close();
  }
}
