import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frenly/domain/entities/message_entity.dart';
import 'package:frenly/presentation/cubit/message/message_cubit.dart';
import 'package:frenly/presentation/cubit/messages/messages_cubit.dart';
import 'package:frenly/presentation/screens/chat/widgets/message_item.dart';
import 'package:ionicons/ionicons.dart';
import 'package:sticky_grouped_list/sticky_grouped_list.dart';

class MessageList extends StatefulWidget {
  final List<MessageEntity> messages;

  const MessageList({
    super.key,
    required this.messages,
  });

  @override
  State<MessageList> createState() => _MessageListState();
}

class _MessageListState extends State<MessageList> {
  List<MessageEntity> selected = [];
  var showOption = false;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Column(
        children: [
          if (showOption)
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  child: const Icon(Ionicons.checkmark_done),
                  onTap: () {
                    setState(() {
                      selected = selected.length != widget.messages.length
                          ? widget.messages
                          : [];
                    });
                  },
                ),
                const SizedBox(width: 18),
                InkWell(
                  child: const Icon(Ionicons.trash_outline),
                  onTap: () {
                    context.read<MessageCubit>().deleteMessages(selected);
                    setState(() {
                      showOption = false;
                    });
                  },
                ),
                const SizedBox(width: 18),
              ],
            ),
          Expanded(
            child: StickyGroupedListView(
              elements: widget.messages,
              groupBy: (element) => element.createdAt!.toDate().day,
              groupSeparatorBuilder: (element) {
                return Padding(
                  padding: const EdgeInsets.all(8),
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                    decoration: BoxDecoration(
                      color: Theme.of(context).canvasColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      formatDate(
                          element.createdAt!.toDate(), [d, ' ', MM, ' ', yyyy]),
                      style: const TextStyle(fontSize: 12),
                      textAlign: TextAlign.center,
                    ),
                  ),
                );
              },
              itemBuilder: (context, element) {
                return Row(
                  children: [
                    if (showOption)
                      Container(
                        width: 18,
                        margin: const EdgeInsets.only(right: 8),
                        child: Checkbox(
                          value: selected.contains(element),
                          onChanged: (value) {
                            setState(() {
                              if (value == true) {
                                selected.add(element);
                              } else {
                                selected.remove(element);
                              }
                            });
                          },
                        ),
                      ),
                    Expanded(
                      child: MessageItem(
                        message: element,
                        onTap: () {
                          if (showOption) {
                            setState(() {
                              if (selected.contains(element)) {
                                selected.remove(element);
                              } else {
                                selected.add(element);
                              }
                            });
                          }
                        },
                        onLongPress: () {
                          setState(() {
                            selected.add(element);
                            showOption = true;
                          });
                        },
                      ),
                    ),
                  ],
                );
              },
              order: StickyGroupedListOrder.DESC,
              separator: const SizedBox(height: 18),
              floatingHeader: true,
              padding: const EdgeInsets.symmetric(horizontal: 24),
              reverse: true,
            ),
          ),
        ],
      ),
      onWillPop: () async {
        context.read<MessagesCubit>().cancelSubscription();
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
