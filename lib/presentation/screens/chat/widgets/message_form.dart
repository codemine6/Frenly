import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:frenly/domain/entities/message_entity.dart';
import 'package:frenly/presentation/cubit/message/message_cubit.dart';
import 'package:frenly/presentation/screens/chat/widgets/message_attachment.dart';
import 'package:ionicons/ionicons.dart';

class MessageForm extends StatefulWidget {
  final String chatId;

  const MessageForm({super.key, required this.chatId});

  @override
  State<MessageForm> createState() => _MessageFormState();
}

class _MessageFormState extends State<MessageForm> {
  var textController = TextEditingController();
  var showOption = true;
  var showEmoji = false;
  var focusNode = FocusNode();

  @override
  void initState() {
    textController.addListener(() {
      setState(() {
        showOption = textController.text.isEmpty;
      });
    });
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        setState(() {
          showEmoji = false;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(24),
          color: Theme.of(context).canvasColor,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: TextField(
                  controller: textController,
                  focusNode: focusNode,
                  decoration: InputDecoration(
                    hintText: 'Type something..',
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 14, horizontal: 16),
                    prefixIcon: showOption
                        ? InkWell(
                            child: Icon(
                              Ionicons.happy_outline,
                              color: Theme.of(context).disabledColor,
                            ),
                            onTap: () {
                              focusNode.unfocus();
                              setState(() {
                                showEmoji = !showEmoji;
                              });
                            },
                          )
                        : null,
                    suffixIcon: showOption
                        ? InkWell(
                            child: Icon(
                              FeatherIcons.paperclip,
                              size: 22,
                              color: Theme.of(context).disabledColor,
                            ),
                            onTap: () {
                              showModalBottomSheet(
                                context: context,
                                builder: (context) => const MessageAttachment(),
                              );
                            },
                          )
                        : null,
                  ),
                  maxLines: 5,
                  minLines: 1,
                ),
              ),
              const SizedBox(width: 8),
              IconButton(
                onPressed: () {
                  if (textController.text.isNotEmpty) {
                    context.read<MessageCubit>().createMessage(MessageEntity(
                          chatId: widget.chatId,
                          text: textController.text,
                        ));
                    setState(() {
                      textController.clear();
                    });
                  }
                },
                style: IconButton.styleFrom(
                  foregroundColor: Theme.of(context).canvasColor,
                  backgroundColor: Theme.of(context).primaryColor,
                ),
                icon: const Icon(FeatherIcons.send),
              ),
            ],
          ),
        ),
        if (showEmoji)
          SizedBox(
            height: 250,
            child: EmojiPicker(
              textEditingController: textController,
              onBackspacePressed: () {},
            ),
          ),
      ],
    );
  }
}
