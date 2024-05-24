import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:routemaster/routemaster.dart';
import 'package:shelters/flows/main/domain/entities/message.dart';
import 'package:shelters/flows/main/presentation/pages/chat_page/cubit/messages_cubit.dart';
import 'package:shelters/flows/main/presentation/pages/chat_page/widgets/group_message_item.dart';
import 'package:shelters/flows/main/presentation/pages/chat_page/widgets/message_item.dart';
import 'package:shelters/flows/main/presentation/pages/chat_page/widgets/message_text_field.dart';
import 'package:shelters/flows/menu/presentation/pages/profile/profile_page.dart';
import 'package:shelters/gen/assets.gen.dart';
import 'package:shelters/navigation/app_state_cubit/app_state_cubit.dart';
import 'package:shelters/services/injectible/injectible_init.dart';
import 'package:shelters/widgets/circular_loading.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({
    required this.chatId,
    required this.chatName,
    required this.isGroup,
    super.key,
  });

  static const path = '/chat';

  final String chatId;
  final String chatName;
  final bool isGroup;

  @override
  Widget build(BuildContext context) {
    final user = (context.read<AppStateCubit>().state as AuthorizedState).user;

    return BlocProvider(
      create: (context) => getIt<MessagesCubit>()
        ..initStream(
          chatId,
          user.id,
        ),
      child: BlocListener<MessagesCubit, MessagesState>(
        listener: (context, state) {
          if (state is MessagesError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.failure.message)),
            );
          }
        },
        child: Builder(builder: (context) {
          return Scaffold(
            appBar: AppBar(
              title: Text(chatName),
            ),
            backgroundColor: Theme.of(context).canvasColor,
            body: Stack(
              children: [
                BlocBuilder<MessagesCubit, MessagesState>(
                  builder: (context, state) {
                    if (state is MessagesInitial) {
                      return StreamBuilder<List<Message>>(
                        stream: state.stream,
                        builder: (context, snapshot) {
                          if (snapshot.hasError) {
                            context.read<MessagesCubit>().emitError(
                                  'Error: ${snapshot.error.toString()}',
                                );
                          } else if (snapshot.hasData) {
                            final messages = snapshot.data!;

                            return Container(
                              height: MediaQuery.of(context).size.height,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(
                                    Assets.chatsBackground.path,
                                  ),
                                  opacity: 0.2,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              child: SingleChildScrollView(
                                reverse: true,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  verticalDirection: VerticalDirection.up,
                                  children: [
                                    const SizedBox(height: 100),
                                    ...messages.map((item) {
                                      if (!isGroup || item.sentByUser) {
                                        return MessageItem(
                                          message: item.messageText,
                                          time: DateFormat.Hm()
                                              .format(item.dateTime),
                                          sentByUser: item.sentByUser,
                                        );
                                      } else {
                                        return GroupMessageItem(
                                          message: item.messageText,
                                          time: DateFormat.Hm()
                                              .format(item.dateTime),
                                          senderName: item.senderName,
                                          sentByUser: false,
                                          onUserAvatarPressed: () =>
                                              Routemaster.of(context).push(
                                            Routemaster.of(context)
                                                    .currentRoute
                                                    .path +
                                                ProfilePage.path,
                                            queryParameters: {
                                              'name': item.senderName,
                                            },
                                          ),
                                        );
                                      }
                                    }).toList(),
                                  ],
                                ),
                              ),
                            );
                          }
                          return const CircularLoading();
                        },
                      );
                    }
                    return Container();
                  },
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: 90,
                    decoration: const BoxDecoration(
                      color: Color(0xffdcddfa),
                    ),
                    padding:
                        const EdgeInsets.only(left: 20, top: 10, right: 15),
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            MessageTextField(
                              controller: context
                                  .read<MessagesCubit>()
                                  .messageController,
                            ),
                            const SizedBox(width: 10),
                            TextButton(
                              onPressed: () async => await context
                                  .read<MessagesCubit>()
                                  .sendMessage(
                                    chatId: chatId,
                                    senderId: user.id,
                                    dateTime: DateTime.now(),
                                  ),
                              style: TextButton.styleFrom(
                                backgroundColor: Theme.of(context).primaryColor,
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                padding: const EdgeInsets.all(6),
                                minimumSize: const Size(0, 0),
                              ),
                              child: const Text(
                                'Send',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
