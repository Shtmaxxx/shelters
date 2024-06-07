import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:shelters/domain/core/errors/failures.dart';
import 'package:shelters/flows/main/domain/entities/message.dart';
import 'package:shelters/flows/main/domain/usecases/get_chat_messages.dart';
import 'package:shelters/flows/main/domain/usecases/join_chat_group.dart';
import 'package:shelters/flows/main/domain/usecases/leave_chat_group.dart';
import 'package:shelters/flows/main/domain/usecases/send_message.dart';

part 'messages_state.dart';

@injectable
class MessagesCubit extends Cubit<MessagesState> {
  MessagesCubit(
    this.getChatMessagesUseCase,
    this.sendMessageUseCase,
    this.leaveChatGroupUseCase,
  )   : messageController = TextEditingController(),
        super(MessagesLoading());

  final TextEditingController messageController;

  final GetChatMessagesUseCase getChatMessagesUseCase;
  final SendMessageUseCase sendMessageUseCase;
  final LeaveChatGroupUseCase leaveChatGroupUseCase;

  Future<void> initStream(String chatId, String userId) async {
    final params = GetChatMessagesParams(chatId: chatId, userId: userId);
    final result = await getChatMessagesUseCase(params);
    result.fold(
      (failure) {
        emit(
          MessagesError(failure: failure),
        );
      },
      (stream) {
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
    if (messageController.text.trim().isNotEmpty) {
      final message = messageController.text;
      messageController.text = '';
      final result = await sendMessageUseCase(
        SendMessageParams(
          chatId: chatId,
          senderId: senderId,
          dateTime: dateTime,
          text: message,
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

  Future<void> leaveChat({
    required String userId,
    required String chatId,
  }) async {
    final params = ChatGroupParams(userId: userId, chatId: chatId);

    final result = await leaveChatGroupUseCase(params);
    result.fold(
      (failure) {
        emit(
          MessagesError(failure: failure),
        );
      },
      (result) {
        emit(const ChatGroupLeft());
      },
    );
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
