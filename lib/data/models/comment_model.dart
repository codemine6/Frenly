import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:frenly/domain/entities/comment_entity.dart';

class CommentModel extends CommentEntity {
  final String? id;
  final String? authorId;
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
  final int? replyCount;

  const CommentModel({
    this.id,
    this.authorId,
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
    this.replyCount,
  }) : super(
          id: id,
          authorId: authorId,
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
          replyCount: replyCount,
        );

  factory CommentModel.fromDocument(
    DocumentSnapshot commentSnapshot,
    DocumentSnapshot userSnapshot,
    bool liked,
  ) {
    final commentData = commentSnapshot.data() as Map<String, dynamic>;
    final userData = userSnapshot.data() as Map<String, dynamic>;

    return CommentModel(
      id: commentSnapshot.id,
      authorId: userSnapshot.id,
      postId: commentData['postId'],
      authorName: userData['name'],
      authorProfileImage: userData['profileImage'],
      createdAt: commentData['createdAt'],
      image: commentData['image'],
      likeCount: commentData['likeCount'],
      liked: liked,
      message: commentData['message'],
      replyCount: commentData['replyCount'],
    );
  }

  Map<String, dynamic> toMap() => {
        'authorId': authorId,
        'postId': postId,
        'createdAt': createdAt,
        'image': image,
        'likeCount': likeCount,
        'message': message,
        'replyCount': replyCount,
      };
}
