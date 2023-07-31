import 'package:frenly/domain/entities/user_entity.dart';
import 'package:frenly/domain/repositories/user_repository.dart';

class SetUsernameUseCase {
  final UserRepository repository;

  SetUsernameUseCase({required this.repository});

  Future<void> call(UserEntity user) {
    return repository.setUsername(user);
  }
}
