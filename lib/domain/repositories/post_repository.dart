import 'package:frenly/domain/entities/post_entity.dart';
import 'package:frenly/domain/entities/user_entity.dart';

abstract class PostRepository {
  Future<void> createPost(PostEntity post);
  Future<List<PostEntity>> getPosts();
  Future<List<PostEntity>> getUserPosts(UserEntity user);
  Future<void> likePost(PostEntity post);
}
