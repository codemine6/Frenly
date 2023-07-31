import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frenly/domain/entities/comment_entity.dart';
import 'package:frenly/domain/entities/reply_entity.dart';
import 'package:frenly/presentation/cubit/replies/replies_cubit.dart';
import 'package:frenly/presentation/cubit/replies/replies_state.dart';
import 'package:frenly/presentation/screens/comment/widgets/reply_item.dart';
import 'package:frenly/di/injection.dart' as di;

class RepliesComment extends StatefulWidget {
  final CommentEntity comment;
  final Function(ReplyEntity reply) onReplyEdit;

  const RepliesComment({
    super.key,
    required this.comment,
    required this.onReplyEdit,
  });

  @override
  State<RepliesComment> createState() => _RepliesCommentState();
}

class _RepliesCommentState extends State<RepliesComment> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RepliesCubit, RepliesState>(
      bloc: di.getIt()
        ..getReplies(ReplyEntity(
          commentId: widget.comment.id,
          postId: widget.comment.postId,
        )),
      builder: (context, state) {
        if (state is RepliesLoaded) {
          return Column(
            children: state.replies.map((reply) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: ReplyItem(
                  reply: reply,
                  onReplyEdit: () {
                    widget.onReplyEdit(reply);
                  },
                ),
              );
            }).toList(),
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
