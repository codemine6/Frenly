import 'package:frenly/domain/entities/comment_entity.dart';
import 'package:frenly/domain/repositories/comment_repository.dart';

class EditCommentUseCase {
  final CommentRepository repository;

  EditCommentUseCase({required this.repository});

  Future<void> call(CommentEntity comment) {
    return repository.editComment(comment);
  }
}
