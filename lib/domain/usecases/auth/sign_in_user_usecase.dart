import 'package:frenly/domain/entities/user_entity.dart';
import 'package:frenly/domain/repositories/auth_repository.dart';

class SignInUserUseCase {
  final AuthRepository repository;

  SignInUserUseCase({required this.repository});

  Future<UserEntity> call(UserEntity user) {
    return repository.signInUser(user);
  }
}
