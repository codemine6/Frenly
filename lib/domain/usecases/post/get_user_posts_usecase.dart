import 'package:frenly/domain/entities/post_entity.dart';
import 'package:frenly/domain/entities/user_entity.dart';
import 'package:frenly/domain/repositories/post_repository.dart';

class GetUserPostsUseCase {
  final PostRepository repository;

  GetUserPostsUseCase({required this.repository});

  Future<List<PostEntity>> call(UserEntity user) {
    return repository.getUserPosts(user);
  }
}
