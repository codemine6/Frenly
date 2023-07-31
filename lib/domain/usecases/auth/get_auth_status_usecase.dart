import 'package:frenly/domain/entities/user_entity.dart';
import 'package:frenly/domain/repositories/auth_repository.dart';

class GetAuthStatusUseCase {
  final AuthRepository repository;

  GetAuthStatusUseCase({required this.repository});

  Future<UserEntity> call() {
    return repository.getAuthStatus();
  }
}
