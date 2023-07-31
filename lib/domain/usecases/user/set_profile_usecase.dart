import 'package:frenly/domain/entities/user_entity.dart';
import 'package:frenly/domain/repositories/user_repository.dart';

class SetProfileUseCase {
  final UserRepository repository;

  SetProfileUseCase({required this.repository});

  Future<void> call(UserEntity user) {
    return repository.setProfile(user);
  }
}
