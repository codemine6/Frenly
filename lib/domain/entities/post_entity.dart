import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class PostEntity extends Equatable {
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

  const PostEntity({
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
  });

  @override
  List<Object?> get props => [
        id,
        authorId,
        authorName,
        authorProfileImage,
        archived,
        commentCount,
        createdAt,
        description,
        images,
        likeCount,
        liked,
      ];
}
