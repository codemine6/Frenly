import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frenly/domain/entities/comment_entity.dart';
import 'package:frenly/domain/entities/reply_entity.dart';
import 'package:frenly/presentation/cubit/auth/auth_cubit.dart';
import 'package:frenly/presentation/cubit/auth/auth_state.dart';
import 'package:frenly/presentation/cubit/comment/comment_cubit.dart';
import 'package:frenly/presentation/screens/comment/widgets/comment_option.dart';
import 'package:frenly/presentation/screens/comment/widgets/replies_comment.dart';
import 'package:ionicons/ionicons.dart';
import 'package:timeago/timeago.dart';

class CommentItem extends StatefulWidget {
  final CommentEntity comment;
  final Function() onCommentEdit;
  final Function(ReplyEntity reply) onReplyEdit;
  final Function() onReply;

  const CommentItem({
    super.key,
    required this.comment,
    required this.onCommentEdit,
    required this.onReplyEdit,
    required this.onReply,
  });

  @override
  State<CommentItem> createState() => _CommentItemState();
}

class _CommentItemState extends State<CommentItem> {
  var likeCount = 0;
  var liked = false;
  var showReplies = false;

  @override
  void initState() {
    likeCount = widget.comment.likeCount!;
    liked = widget.comment.liked!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final auth = context.read<AuthCubit>().state as Authenticated;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onLongPress: () {
              if (widget.comment.authorId == auth.user.id) {
                showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return CommentOption(
                      comment: widget.comment,
                      onCommentEdit: widget.onCommentEdit,
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
                    backgroundImage:
                        NetworkImage(widget.comment.authorProfileImage!),
                  ),
                  title: Text('${widget.comment.authorName}'),
                  contentPadding: EdgeInsets.zero,
                ),
                Text(
                  '${widget.comment.message}',
                  style: const TextStyle(fontSize: 13),
                ),
                if (widget.comment.image != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: SizedBox(
                      width: 240,
                      child: AspectRatio(
                        aspectRatio: 4 / 3,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            widget.comment.image!,
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
                        liked ? Ionicons.heart : Ionicons.heart_outline,
                        size: 18,
                      ),
                      onTap: () {
                        context.read<CommentCubit>().likeComment(CommentEntity(
                              id: widget.comment.id,
                              postId: widget.comment.postId,
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
                      format(widget.comment.createdAt!.toDate()),
                      style: TextStyle(
                        color: Theme.of(context).disabledColor,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(width: 16),
                    InkWell(
                      onTap: widget.onReply,
                      child: Text(
                        'Reply',
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          if (widget.comment.replyCount! > 0)
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: InkWell(
                child: Text(
                  '${showReplies ? 'Hide' : 'See'} ${widget.comment.replyCount} ${widget.comment.replyCount! > 1 ? 'replies' : 'reply'}',
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onTap: () {
                  setState(() {
                    showReplies = !showReplies;
                  });
                },
              ),
            ),
          if (showReplies)
            RepliesComment(
              comment: widget.comment,
              onReplyEdit: widget.onReplyEdit,
            ),
        ],
      ),
    );
  }
}
