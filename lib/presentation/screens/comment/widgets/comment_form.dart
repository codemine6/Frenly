import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:frenly/domain/entities/comment_entity.dart';
import 'package:frenly/domain/entities/reply_entity.dart';
import 'package:frenly/presentation/cubit/comment/comment_cubit.dart';
import 'package:frenly/presentation/cubit/reply/reply_cubit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ionicons/ionicons.dart';

class CommentForm extends StatefulWidget {
  final String postId;
  final CommentEntity? editingComment;
  final ReplyEntity? editingReply;
  final CommentEntity? replyingComment;

  const CommentForm({
    super.key,
    required this.postId,
    this.editingComment,
    this.editingReply,
    this.replyingComment,
  });

  @override
  State<CommentForm> createState() => _CommentFormState();
}

class _CommentFormState extends State<CommentForm> {
  var messageController = TextEditingController();
  File? imageFile;
  String? imageUrl;

  pickImage() async {
    try {
      final file = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        maxWidth: 512,
        maxHeight: 512,
      );
      if (file != null) {
        setState(() {
          imageFile = File(file.path);
        });
      }
    } catch (_) {
      return null;
    }
  }

  @override
  void didUpdateWidget(covariant CommentForm oldWidget) {
    if (widget.editingComment != null) {
      messageController.text = widget.editingComment!.message!;
      imageUrl = widget.editingComment?.image;
    } else if (widget.editingReply != null) {
      messageController.text = widget.editingReply!.message!;
      imageUrl = widget.editingReply?.image;
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          if (imageFile != null || imageUrl != null)
            Padding(
              padding: const EdgeInsets.only(left: 24, right: 24, bottom: 18),
              child: Stack(
                alignment: Alignment.topRight,
                children: [
                  AspectRatio(
                    aspectRatio: 4 / 3,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: imageFile != null
                          ? Image.file(
                              imageFile!,
                              fit: BoxFit.cover,
                            )
                          : Image.network(
                              imageUrl!,
                              fit: BoxFit.cover,
                            ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Material(
                      shape: const CircleBorder(),
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            imageFile = null;
                            imageUrl = null;
                          });
                        },
                        borderRadius: BorderRadius.circular(24),
                        child: const Icon(Ionicons.close_circle_outline),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: messageController,
                  decoration: InputDecoration(
                    hintText: 'Type something..',
                    prefixIcon: GestureDetector(
                      onTap: pickImage,
                      child: Icon(
                        FeatherIcons.image,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              IconButton(
                onPressed: () {
                  if (widget.editingComment != null) {
                    context.read<CommentCubit>().editComment(CommentEntity(
                          id: widget.editingComment?.id,
                          postId: widget.editingComment?.postId,
                          imageFile: imageFile,
                          imageUrl: imageUrl,
                          message: messageController.text,
                        ));
                  } else if (widget.editingReply != null) {
                    context.read<ReplyCubit>().editReply(ReplyEntity(
                          id: widget.editingReply?.id,
                          commentId: widget.editingReply?.commentId,
                          postId: widget.editingReply?.postId,
                          imageFile: imageFile,
                          imageUrl: imageUrl,
                          message: messageController.text,
                        ));
                  } else if (widget.replyingComment != null) {
                    context.read<ReplyCubit>().createReply(ReplyEntity(
                          commentId: widget.replyingComment?.id,
                          postId: widget.replyingComment?.postId,
                          imageFile: imageFile,
                          message: messageController.text,
                        ));
                  } else {
                    context.read<CommentCubit>().createComment(CommentEntity(
                          postId: widget.postId,
                          imageFile: imageFile,
                          message: messageController.text,
                        ));
                  }
                  setState(() {
                    messageController.clear();
                    imageFile = null;
                    imageUrl = null;
                  });
                },
                style: IconButton.styleFrom(
                  foregroundColor: Theme.of(context).canvasColor,
                  backgroundColor: Theme.of(context).primaryColor,
                ),
                icon: const Icon(FeatherIcons.send),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
