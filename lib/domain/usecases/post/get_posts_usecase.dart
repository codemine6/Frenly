import 'package:frenly/domain/entities/post_entity.dart';
import 'package:frenly/domain/repositories/post_repository.dart';

class GetPostsUseCase {
  final PostRepository repository;

  GetPostsUseCase({required this.repository});

  Future<List<PostEntity>> call() {
    return repository.getPosts();
  }
}
