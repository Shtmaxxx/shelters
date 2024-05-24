import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:routemaster/routemaster.dart';
import 'package:shelters/flows/main/presentation/pages/chat_page/chat_page.dart';
import 'package:shelters/flows/main/presentation/pages/main/cubit/chats_cubit.dart';
import 'package:shelters/flows/main/presentation/pages/main/widgets/chat_item.dart';
import 'package:shelters/flows/menu/presentation/widgets/navigation_menu.dart';
import 'package:shelters/gen/assets.gen.dart';
import 'package:shelters/navigation/app_state_cubit/app_state_cubit.dart';
import 'package:shelters/services/injectible/injectible_init.dart';
import 'package:shelters/widgets/circular_loading.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  static const String path = '/';

  @override
  Widget build(BuildContext context) {
    final user = (context.read<AppStateCubit>().state as AuthorizedState).user;

    return BlocProvider(
      create: (context) => getIt<ChatsCubit>()..getUsersChats(user.id),
      child: BlocListener<ChatsCubit, ChatsState>(
        listener: (context, state) {
          if (state is ChatsError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.failure.message)),
            );
          }
        },
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Chats'),
          ),
          drawer: const NavigationMenu(),
          body: Stack(
            children: [
              // Opacity(
              //   opacity: 0.2,
              //   child: Image.asset(
              //     Assets.chatsBackground.path,
              //     height: MediaQuery.of(context).size.height,
              //     width: MediaQuery.of(context).size.width,
              //     fit: BoxFit.cover,
              //   ),
              // ),
              BlocBuilder<ChatsCubit, ChatsState>(
                builder: (context, state) {
                  if (state is ChatsInitial) {
                    if (state.chats.isNotEmpty) {
                      return ListView.builder(
                        itemCount: state.chats.length,
                        itemBuilder: (context, index) {
                          final chat = state.chats[index];

                          return ChatItem(
                            title: chat.title,
                            recentMessage: chat.recentMessage,
                            dateTime: chat.recentMessageDateTime,
                            onPressed: () => Routemaster.of(context).push(
                              ChatPage.path,
                              queryParameters: {
                                'chatId': chat.id,
                                'chatName': chat.title,
                                'isGroup': chat.isGroup ? 'true' : 'false',
                              },
                            ),
                          );
                        },
                      );
                    } else {
                      return const Center(
                        child: Text('You have no chats :('),
                      );
                    }
                  } else if (state is ChatsLoading) {
                    return const CircularLoading();
                  }
                  return Container();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
