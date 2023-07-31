import 'package:frenly/domain/entities/comment_entity.dart';
import 'package:frenly/domain/repositories/comment_repository.dart';

class GetCommentsUseCase {
  final CommentRepository repository;

  GetCommentsUseCase({required this.repository});

  Future<List<CommentEntity>> call(CommentEntity comment) {
    return repository.getComments(comment);
  }
}
