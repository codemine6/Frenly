import 'package:frenly/domain/entities/user_entity.dart';
import 'package:frenly/domain/repositories/user_repository.dart';

class GetFollowingUserUseCase {
  final UserRepository repository;

  GetFollowingUserUseCase({required this.repository});

  Future<List<UserEntity>> call(UserEntity user) {
    return repository.getFollowingUser(user);
  }
}
