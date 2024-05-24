part of 'chats_cubit.dart';

abstract class ChatsState extends Equatable {
  const ChatsState();

  @override
  List<Object> get props => [];
}

class ChatsLoading extends ChatsState {}

class ChatsInitial extends ChatsState {
  const ChatsInitial({required this.chats});

  final List<Chat> chats;

  @override
  List<Object> get props => [chats];
}

class ChatsError extends ChatsState {
  const ChatsError({required this.failure});

  final Failure failure;
}
