import 'package:frenly/domain/entities/user_entity.dart';
import 'package:frenly/domain/repositories/user_repository.dart';

class GetFollowersUserUseCase {
  final UserRepository repository;

  GetFollowersUserUseCase({required this.repository});

  Future<List<UserEntity>> call(UserEntity user) {
    return repository.getFollowersUser(user);
  }
}
