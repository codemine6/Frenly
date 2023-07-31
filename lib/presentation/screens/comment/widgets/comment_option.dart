import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:frenly/domain/entities/comment_entity.dart';
import 'package:frenly/presentation/cubit/comment/comment_cubit.dart';

class CommentOption extends StatelessWidget {
  final CommentEntity comment;
  final Function() onCommentEdit;

  const CommentOption({
    super.key,
    required this.comment,
    required this.onCommentEdit,
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
            title: const Text('Edit Comment'),
            onTap: () {
              onCommentEdit();
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(FeatherIcons.trash),
            title: const Text('Delete Comment'),
            onTap: () {
              context.read<CommentCubit>().deleteComment(CommentEntity(
                    id: comment.id,
                    postId: comment.postId,
                  ));
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
