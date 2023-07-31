import 'package:firebase_storage/firebase_storage.dart';
import 'package:frenly/domain/entities/user_entity.dart';
import 'package:frenly/domain/repositories/user_repository.dart';

class SetProfileImageUseCase {
  final UserRepository repository;

  SetProfileImageUseCase({required this.repository});

  Stream<TaskSnapshot> call(UserEntity user) {
    return repository.setProfileImage(user);
  }
}
