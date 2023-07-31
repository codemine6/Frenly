import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:frenly/domain/entities/reply_entity.dart';

class ReplyModel extends ReplyEntity {
  final String? id;
  final String? authorId;
  final String? commentId;
  final String? postId;
  final String? authorName;
  final String? authorProfileImage;
  final Timestamp? createdAt;
  final String? image;
  final File? imageFile;
  final String? imageUrl;
  final int? likeCount;
  final bool? liked;
  final String? message;

  const ReplyModel({
    this.id,
    this.authorId,
    this.commentId,
    this.postId,
    this.authorName,
    this.authorProfileImage,
    this.createdAt,
    this.image,
    this.imageFile,
    this.imageUrl,
    this.likeCount,
    this.liked,
    this.message,
  }) : super(
          id: id,
          authorId: authorId,
          commentId: commentId,
          postId: postId,
          authorName: authorName,
          authorProfileImage: authorProfileImage,
          createdAt: createdAt,
          image: image,
          imageFile: imageFile,
          imageUrl: imageUrl,
          likeCount: likeCount,
          liked: liked,
          message: message,
        );

  factory ReplyModel.fromDocument(
    DocumentSnapshot replySnapshot,
    DocumentSnapshot userSnapshot,
    bool liked,
  ) {
    final replyData = replySnapshot.data() as Map<String, dynamic>;
    final userData = userSnapshot.data() as Map<String, dynamic>;

    return ReplyModel(
      id: replySnapshot.id,
      authorId: userSnapshot.id,
      commentId: replyData['commentId'],
      postId: replyData['postId'],
      authorName: userData['name'],
      authorProfileImage: userData['profileImage'],
      createdAt: replyData['createdAt'],
      image: replyData['image'],
      likeCount: replyData['likeCount'],
      liked: liked,
      message: replyData['message'],
    );
  }

  Map<String, dynamic> toMap() => {
        'authorId': authorId,
        'commentId': commentId,
        'postId': postId,
        'createdAt': createdAt,
        'image': image,
        'likeCount': likeCount,
        'message': message,
      };
}
