import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:frenly/domain/entities/reply_entity.dart';
import 'package:frenly/presentation/cubit/reply/reply_cubit.dart';

class ReplyOption extends StatelessWidget {
  final ReplyEntity reply;
  final Function() onReplyEdit;

  const ReplyOption({
    super.key,
    required this.reply,
    required this.onReplyEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).highlightColor,
              borderRadius: BorderRadius.circular(4),
            ),
            width: 48,
            height: 4,
          ),
          const SizedBox(height: 24),
          ListTile(
            leading: const Icon(FeatherIcons.edit),
            title: const Text('Edit Reply'),
            onTap: () {
              onReplyEdit();
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(FeatherIcons.trash),
            title: const Text('Delete Reply'),
            onTap: () {
              context.read<ReplyCubit>().deleteReply(ReplyEntity(
                    id: reply.id,
                    commentId: reply.commentId,
                    postId: reply.postId,
                  ));
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
