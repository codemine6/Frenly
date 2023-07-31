import 'package:frenly/domain/entities/user_entity.dart';
import 'package:frenly/domain/repositories/auth_repository.dart';

class SignUpUserUseCase {
  final AuthRepository repository;

  SignUpUserUseCase({required this.repository});

  Future<void> call(UserEntity user) {
    return repository.signUpUser(user);
  }
}
