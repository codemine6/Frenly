import 'package:frenly/domain/entities/user_entity.dart';
import 'package:frenly/domain/repositories/user_repository.dart';

class FollowUserUseCase {
  final UserRepository repository;

  FollowUserUseCase({required this.repository});

  Future<void> call(UserEntity user) {
    return repository.followUser(user);
  }
}
