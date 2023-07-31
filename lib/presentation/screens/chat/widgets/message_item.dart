import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frenly/domain/entities/message_entity.dart';
import 'package:frenly/presentation/cubit/auth/auth_cubit.dart';
import 'package:frenly/presentation/cubit/auth/auth_state.dart';
import 'package:ionicons/ionicons.dart';

class MessageItem extends StatelessWidget {
  final MessageEntity message;
  final Function() onTap;
  final Function() onLongPress;

  const MessageItem({
    super.key,
    required this.message,
    required this.onTap,
    required this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    final auth = context.read<AuthCubit>().state as Authenticated;
    final isEmoji = message.text!.length > 1 &&
        RegExp(r'(\u00a9|\u00ae|[\u2000-\u3300]|\ud83c[\ud000-\udfff]|\ud83d[\ud000-\udfff]|\ud83e[\ud000-\udfff])')
                .firstMatch(message.text!) !=
            null;

    if (isEmoji) {
      return Align(
        alignment: message.authorId == auth.user.id
            ? Alignment.centerRight
            : Alignment.centerLeft,
        child: Column(
          crossAxisAlignment: message.authorId == auth.user.id
              ? CrossAxisAlignment.end
              : CrossAxisAlignment.start,
          children: [
            Text(
              '${message.text}',
              style: const TextStyle(fontSize: 56),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (message.readed == true)
                  Padding(
                    padding: const EdgeInsets.only(right: 4),
                    child: Icon(
                      Ionicons.checkmark_done_outline,
                      size: 16,
                      color: Theme.of(context).disabledColor,
                    ),
                  ),
                Text(
                  formatDate(message.createdAt!.toDate(), [hh, ':', mm]),
                  style: TextStyle(
                    color: Theme.of(context).disabledColor,
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    } else if (message.authorId == auth.user.id) {
      return Align(
        alignment: Alignment.centerRight,
        child: Container(
          constraints:
              BoxConstraints(maxWidth: MediaQuery.of(context).size.width * .7),
          child: InkWell(
            onTap: onTap,
            onLongPress: onLongPress,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
              bottomLeft: Radius.circular(16),
            ),
            child: Ink(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                    bottomLeft: Radius.circular(16),
                  )),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '${message.text}',
                    style: TextStyle(color: Theme.of(context).canvasColor),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (message.readed == true)
                        Padding(
                          padding: const EdgeInsets.only(right: 4),
                          child: Icon(
                            Ionicons.checkmark_done_outline,
                            size: 16,
                            color:
                                Theme.of(context).canvasColor.withOpacity(.7),
                          ),
                        ),
                      Text(
                        formatDate(message.createdAt!.toDate(), [hh, ':', mm]),
                        style: TextStyle(
                          color: Theme.of(context).canvasColor.withOpacity(.7),
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    } else {
      return Align(
        alignment: Alignment.centerLeft,
        child: Container(
          constraints:
              BoxConstraints(maxWidth: MediaQuery.of(context).size.width * .7),
          child: InkWell(
            onTap: onTap,
            onLongPress: onLongPress,
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(16),
              bottomLeft: Radius.circular(16),
              bottomRight: Radius.circular(16),
            ),
            child: Ink(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              decoration: BoxDecoration(
                color: Theme.of(context).highlightColor,
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(16),
                  bottomLeft: Radius.circular(16),
                  bottomRight: Radius.circular(16),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${message.text}'),
                  Text(
                    formatDate(message.createdAt!.toDate(), [hh, ':', mm]),
                    style: TextStyle(
                      color: Theme.of(context).disabledColor,
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }
  }
}
