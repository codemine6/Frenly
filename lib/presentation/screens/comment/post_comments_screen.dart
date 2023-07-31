import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:frenly/domain/entities/comment_entity.dart';
import 'package:frenly/domain/entities/reply_entity.dart';
import 'package:frenly/presentation/cubit/comment/comment_cubit.dart';
import 'package:frenly/presentation/cubit/comment/comment_state.dart';
import 'package:frenly/presentation/cubit/comments/comments_cubit.dart';
import 'package:frenly/presentation/cubit/comments/comments_state.dart';
import 'package:frenly/presentation/cubit/reply/reply_cubit.dart';
import 'package:frenly/presentation/cubit/reply/reply_state.dart';
import 'package:frenly/presentation/screens/comment/widgets/comment_form.dart';
import 'package:frenly/presentation/screens/comment/widgets/comment_item.dart';

class PostCommentsScreen extends StatefulWidget {
  final String postId;

  const PostCommentsScreen({super.key, required this.postId});

  @override
  State<PostCommentsScreen> createState() => _PostCommentsScreenState();
}

class _PostCommentsScreenState extends State<PostCommentsScreen> {
  final scrollController = ScrollController();
  CommentEntity? editingComment;
  ReplyEntity? editingReply;
  CommentEntity? replyingComment;

  @override
  void initState() {
    context
        .read<CommentsCubit>()
        .getComments(CommentEntity(postId: widget.postId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Comments'),
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<CommentsCubit, CommentsState>(
              builder: (context, state) {
                if (state is CommentsLoaded) {
                  Future.delayed(const Duration(milliseconds: 200), () {
                    scrollController.animateTo(
                      scrollController.position.maxScrollExtent,
                      duration: const Duration(milliseconds: 200),
                      curve: Curves.easeOut,
                    );
                  });

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 24,
                        ),
                        child: Text(
                          '${state.comments.length} ${state.comments.length > 1 ? 'Comments' : 'Comment'}',
                          style: TextStyle(
                            color: Theme.of(context).disabledColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Expanded(
                        child: ListView.separated(
                          controller: scrollController,
                          itemBuilder: (context, index) {
                            return CommentItem(
                              comment: state.comments[index],
                              onCommentEdit: () {
                                setState(() {
                                  editingComment = state.comments[index];
                                  editingReply = null;
                                  replyingComment = null;
                                });
                              },
                              onReplyEdit: (reply) {
                                setState(() {
                                  editingComment = null;
                                  editingReply = reply;
                                  replyingComment = null;
                                });
                              },
                              onReply: () {
                                setState(() {
                                  editingComment = null;
                                  editingReply = null;
                                  replyingComment = state.comments[index];
                                });
                              },
                            );
                          },
                          separatorBuilder: (context, index) {
                            return const SizedBox(height: 16);
                          },
                          itemCount: state.comments.length,
                        ),
                      ),
                    ],
                  );
                } else {
                  return const SizedBox();
                }
              },
            ),
          ),
          if (editingComment != null ||
              editingReply != null ||
              replyingComment != null)
            Padding(
              padding: const EdgeInsets.fromLTRB(18, 18, 18, 0),
              child: Row(
                children: [
                  if (editingComment != null)
                    const Text('Editing comment')
                  else if (editingReply != null)
                    const Text('Editing reply for ')
                  else
                    const Text('Replying '),
                  Text(
                    '${editingReply != null ? editingReply?.authorName : replyingComment != null ? replyingComment?.authorName : ''}',
                    style: TextStyle(color: Theme.of(context).primaryColor),
                  ),
                  const SizedBox(width: 8),
                  InkWell(
                    child: const Icon(
                      FeatherIcons.xCircle,
                      size: 18,
                    ),
                    onTap: () {
                      setState(() {
                        editingComment = null;
                        editingReply = null;
                        replyingComment = null;
                      });
                    },
                  ),
                ],
              ),
            ),
          MultiBlocListener(
            listeners: [
              BlocListener<CommentCubit, CommentState>(
                listener: (context, state) {
                  if (state is CommentCreated ||
                      state is CommentDeleted ||
                      state is CommentEdited) {
                    context
                        .read<CommentsCubit>()
                        .getComments(CommentEntity(postId: widget.postId));
                  } else if (state is CommentLoading) {
                    setState(() {
                      editingComment = null;
                    });
                  }
                },
              ),
              BlocListener<ReplyCubit, ReplyState>(
                listener: (context, state) {
                  if (state is ReplyCreated || state is ReplyDeleted) {
                    context
                        .read<CommentsCubit>()
                        .getComments(CommentEntity(postId: widget.postId));
                  } else if (state is ReplyLoading) {
                    setState(() {
                      editingReply = null;
                      replyingComment = null;
                    });
                  }
                },
              ),
            ],
            child: CommentForm(
              postId: widget.postId,
              editingComment: editingComment,
              editingReply: editingReply,
              replyingComment: replyingComment,
            ),
          ),
        ],
      ),
    );
  }
}
