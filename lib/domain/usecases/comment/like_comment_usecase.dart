import 'package:frenly/domain/entities/comment_entity.dart';
import 'package:frenly/domain/repositories/comment_repository.dart';

class LikeCommentUseCase {
  final CommentRepository repository;

  LikeCommentUseCase({required this.repository});

  Future<void> call(CommentEntity comment) {
    return repository.likeComment(comment);
  }
}
