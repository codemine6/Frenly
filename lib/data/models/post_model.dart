import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:frenly/domain/entities/post_entity.dart';

class PostModel extends PostEntity {
  final String? id;
  final String? authorId;
  final String? authorName;
  final String? authorProfileImage;
  final bool? archived;
  final int? commentCount;
  final Timestamp? createdAt;
  final String? description;
  final List? images;
  final int? likeCount;
  final bool? liked;

  const PostModel({
    this.id,
    this.authorId,
    this.authorName,
    this.authorProfileImage,
    this.archived,
    this.commentCount,
    this.createdAt,
    this.description,
    this.images,
    this.likeCount,
    this.liked,
  }) : super(
          id: id,
          authorId: authorId,
          authorName: authorName,
          authorProfileImage: authorProfileImage,
          archived: archived,
          commentCount: commentCount,
          createdAt: createdAt,
          description: description,
          images: images,
          likeCount: likeCount,
          liked: liked,
        );

  factory PostModel.fromDocument(DocumentSnapshot postSnapshot,
      [DocumentSnapshot? userSnapshot, bool? liked]) {
    final postData = postSnapshot.data() as Map<String, dynamic>;
    final userData = userSnapshot != null
        ? userSnapshot.data() as Map<String, dynamic>
        : null;

    return PostModel(
      id: postSnapshot.id,
      authorId: userSnapshot?.id,
      authorName: userData?['name'],
      authorProfileImage: userData?['profileImage'],
      commentCount: postData['commentCount'],
      createdAt: postData['createdAt'],
      description: postData['description'],
      images: postData['images'],
      likeCount: postData['likeCount'],
      liked: liked,
    );
  }

  Map<String, dynamic> toMap() => {
        'authorId': authorId,
        'archived': archived,
        'commentCount': commentCount,
        'createdAt': createdAt,
        'description': description,
        'images': images,
        'likeCount': likeCount,
      };
}
