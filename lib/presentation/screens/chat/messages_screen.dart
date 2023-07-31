import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frenly/domain/entities/chat_entity.dart';
import 'package:frenly/presentation/cubit/chat/chat_cubit.dart';
import 'package:frenly/presentation/cubit/chat/chat_state.dart';
import 'package:frenly/presentation/cubit/message/message_cubit.dart';
import 'package:frenly/presentation/cubit/messages/messages_cubit.dart';
import 'package:frenly/presentation/cubit/messages/messages_state.dart';
import 'package:frenly/presentation/screens/chat/widgets/message_form.dart';
import 'package:frenly/presentation/screens/chat/widgets/message_list.dart';
import 'package:frenly/di/injection.dart' as di;

class MessagesScreen extends StatefulWidget {
  final String userId;

  const MessagesScreen({super.key, required this.userId});

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  @override
  void initState() {
    context.read<ChatCubit>().createChat(ChatEntity(userId: widget.userId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          PopupMenuButton(
            itemBuilder: (context) {
              return [
                PopupMenuItem(
                  onTap: () {
                    context
                        .read<MessageCubit>()
                        .deleteAllMessages(ChatEntity(userId: widget.userId));
                  },
                  child: const Text('Delete Chat'),
                ),
              ];
            },
          )
        ],
      ),
      body: BlocBuilder<ChatCubit, ChatState>(
        builder: (context, state) {
          if (state is ChatCreated) {
            return Column(
              children: [
                Expanded(
                  child: BlocProvider(
                    create: (context) => di.getIt<MessagesCubit>()
                      ..getMessages(ChatEntity(id: state.chatId)),
                    child: BlocBuilder<MessagesCubit, MessagesState>(
                      builder: (context, state) {
                        if (state is MessagesLoaded && state.messages.isNotEmpty) {
                          return MessageList(messages: state.messages);
                        } else {
                          return const SizedBox();
                        }
                      },
                    ),
                  ),
                ),
                MessageForm(chatId: state.chatId),
              ],
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
