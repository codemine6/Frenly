import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frenly/domain/entities/chat_entity.dart';
import 'package:frenly/presentation/cubit/chat/chat_cubit.dart';
import 'package:frenly/presentation/cubit/chats/chats_cubit.dart';
import 'package:frenly/presentation/cubit/chats/chats_state.dart';
import 'package:frenly/presentation/screens/chat/widgets/chat_item.dart';
import 'package:go_router/go_router.dart';
import 'package:ionicons/ionicons.dart';

class ChatsScreen extends StatefulWidget {
  const ChatsScreen({super.key});

  @override
  State<ChatsScreen> createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {
  List<ChatEntity> selected = [];
  var showOption = false;

  @override
  Widget build(BuildContext context) {
    final chatsState = context.watch<ChatsCubit>().state;

    return WillPopScope(
      child: Scaffold(
        appBar: AppBar(
          actions: [
            if (chatsState is ChatsLoaded && showOption)
              IconButton(
                onPressed: () {
                  setState(() {
                    selected = chatsState.chats.length != selected.length
                        ? chatsState.chats
                        : [];
                  });
                },
                icon: const Icon(Ionicons.checkmark_done),
              ),
            if (showOption)
              IconButton(
                onPressed: () {
                  context.read<ChatCubit>().deleteChats(selected);
                  setState(() {
                    showOption = false;
                  });
                },
                icon: const Icon(Ionicons.trash),
              ),
          ],
        ),
        body: Column(
          children: [
            if (chatsState is ChatsLoaded)
              Expanded(
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    final chat = chatsState.chats[index];

                    return Row(
                      children: [
                        if (showOption)
                          Container(
                            width: 18,
                            margin: const EdgeInsets.only(left: 18),
                            child: Checkbox(
                              value: selected.contains(chat),
                              onChanged: (value) {
                                setState(() {
                                  if (selected.contains(chat)) {
                                    selected.remove(chat);
                                  } else {
                                    selected.add(chat);
                                  }
                                });
                              },
                            ),
                          ),
                        Expanded(
                          child: ChatItem(
                            chat: chat,
                            onTap: () {
                              if (showOption) {
                                setState(() {
                                  if (selected.contains(chat)) {
                                    selected.remove(chat);
                                  } else {
                                    selected.add(chat);
                                  }
                                });
                              } else {
                                context.push('/messages/${chat.userId}');
                              }
                            },
                            onLongPress: () {
                              setState(() {
                                selected.add(chat);
                                showOption = true;
                              });
                            },
                          ),
                        ),
                      ],
                    );
                  },
                  itemCount: chatsState.chats.length,
                ),
              )
            else
              const SizedBox(),
          ],
        ),
      ),
      onWillPop: () async {
        if (showOption) {
          setState(() {
            selected = [];
            showOption = false;
          });
          return false;
        }
        return true;
      },
    );
  }
}
