import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frenly/domain/entities/reply_entity.dart';
import 'package:frenly/presentation/cubit/auth/auth_cubit.dart';
import 'package:frenly/presentation/cubit/auth/auth_state.dart';
import 'package:frenly/presentation/cubit/reply/reply_cubit.dart';
import 'package:frenly/presentation/screens/comment/widgets/reply_option.dart';
import 'package:ionicons/ionicons.dart';
import 'package:timeago/timeago.dart';

class ReplyItem extends StatefulWidget {
  final ReplyEntity reply;
  final Function() onReplyEdit;

  const ReplyItem({super.key, required this.reply, required this.onReplyEdit});

  @override
  State<ReplyItem> createState() => _ReplyItemState();
}

class _ReplyItemState extends State<ReplyItem> {
  var likeCount = 0;
  var liked = false;

  @override
  void initState() {
    likeCount = widget.reply.likeCount!;
    liked = widget.reply.liked!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final auth = context.read<AuthCubit>().state as Authenticated;

    return Padding(
      padding: const EdgeInsets.only(left: 36),
      child: InkWell(
        onLongPress: () {
          if (widget.reply.authorId == auth.user.id) {
            showModalBottomSheet(
              context: context,
              builder: (context) {
                return ReplyOption(
                  reply: widget.reply,
                  onReplyEdit: widget.onReplyEdit,
                );
              },
            );
          }
        },
        borderRadius: BorderRadius.circular(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(widget.reply.authorProfileImage!),
              ),
              title: Text('${widget.reply.authorName}'),
              contentPadding: EdgeInsets.zero,
            ),
            Text(
              '${widget.reply.message}',
              style: const TextStyle(fontSize: 13),
            ),
            if (widget.reply.image != null)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: SizedBox(
                  width: 240,
                  child: AspectRatio(
                    aspectRatio: 4 / 3,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        widget.reply.image!,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
            const SizedBox(height: 8),
            Row(
              children: [
                InkWell(
                  child: Icon(
                    liked == true ? Ionicons.heart : Ionicons.heart_outline,
                    size: 18,
                  ),
                  onTap: () {
                    context.read<ReplyCubit>().likeReply(ReplyEntity(
                          id: widget.reply.id,
                          commentId: widget.reply.commentId,
                          postId: widget.reply.postId,
                        ));
                    setState(() {
                      liked ? likeCount-- : likeCount++;
                      liked = !liked;
                    });
                  },
                ),
                const SizedBox(width: 4),
                Text(
                  '$likeCount',
                  style: const TextStyle(fontSize: 12),
                ),
                const SizedBox(width: 16),
                Text(
                  format(widget.reply.createdAt!.toDate()),
                  style: TextStyle(
                    color: Theme.of(context).disabledColor,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
