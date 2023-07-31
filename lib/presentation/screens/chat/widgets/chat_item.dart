import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:frenly/domain/entities/chat_entity.dart';

class ChatItem extends StatelessWidget {
  final ChatEntity chat;
  final Function() onTap;
  final Function() onLongPress;

  const ChatItem({
    super.key,
    required this.chat,
    required this.onTap,
    required this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      onLongPress: onLongPress,
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: NetworkImage(chat.userProfileImage!),
          radius: 24,
        ),
        title: Row(
          children: [
            Expanded(child: Text('${chat.userName}')),
            const SizedBox(width: 24),
            Text(
              formatDate(chat.messageCreatedAt!.toDate(), [hh, ':', mm]),
              style: TextStyle(
                color: Theme.of(context).disabledColor,
                fontSize: 13,
              ),
            ),
          ],
        ),
        subtitle: Row(
          children: [
            Expanded(
              child: Text(
                '${chat.messageText}',
                style: TextStyle(
                    fontWeight: chat.messageReaded == true
                        ? FontWeight.normal
                        : FontWeight.bold),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
            if (chat.messageCount! > 1)
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  shape: BoxShape.circle,
                ),
                margin: const EdgeInsets.only(left: 8),
                child: Text(
                  '${chat.messageCount}',
                  style: TextStyle(
                    color: Theme.of(context).canvasColor,
                    fontSize: 12,
                  ),
                ),
              ),
          ],
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 24),
      ),
    );
  }
}
