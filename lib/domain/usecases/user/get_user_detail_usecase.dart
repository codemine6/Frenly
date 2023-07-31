import 'package:frenly/domain/entities/user_entity.dart';
import 'package:frenly/domain/repositories/user_repository.dart';

class GetUserDetailUseCase {
  final UserRepository repository;

  GetUserDetailUseCase({required this.repository});

  Future<UserEntity> call(UserEntity user) {
    return repository.getUserDetail(user);
  }
}
