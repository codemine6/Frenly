import 'package:frenly/domain/repositories/auth_repository.dart';

class SignOutUserUseCase {
  final AuthRepository repository;

  SignOutUserUseCase({required this.repository});

  Future<void> call() {
    return repository.signOutUser();
  }
}
