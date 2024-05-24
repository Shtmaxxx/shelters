part of 'messages_cubit.dart';

abstract class MessagesState extends Equatable {
  const MessagesState();

  @override
  List<Object> get props => [];
}

class MessagesLoading extends MessagesState {}

class MessagesInitial extends MessagesState {
  const MessagesInitial({required this.stream});

  final Stream<List<Message>> stream;
}

class MessagesError extends MessagesState {
  const MessagesError({required this.failure});

  final Failure failure;
}
