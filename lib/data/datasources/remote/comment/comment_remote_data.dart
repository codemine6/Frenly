import 'package:frenly/domain/entities/comment_entity.dart';

abstract class CommentRemoteData {
  Future<void> createComment(CommentEntity comment);
  Future<void> deleteComment(CommentEntity comment);
  Future<void> editComment(CommentEntity comment);
  Future<List<CommentEntity>> getComments(CommentEntity comment);
  Future<void> likeComment(CommentEntity comment);
}
