import 'package:frenly/data/datasources/remote/post/post_remote_data.dart';
import 'package:frenly/domain/entities/post_entity.dart';
import 'package:frenly/domain/entities/user_entity.dart';
import 'package:frenly/domain/repositories/post_repository.dart';

class PostRepositoryImpl implements PostRepository {
  final PostRemoteData remoteData;

  PostRepositoryImpl({required this.remoteData});

  @override
  Future<void> createPost(PostEntity post) {
    return remoteData.createPost(post);
  }

  @override
  Future<List<PostEntity>> getPosts() {
    return remoteData.getPosts();
  }

  @override
  Future<List<PostEntity>> getUserPosts(UserEntity user) {
    return remoteData.getUserPosts(user);
  }

  @override
  Future<void> likePost(PostEntity post) {
    return remoteData.likePost(post);
  }
}
