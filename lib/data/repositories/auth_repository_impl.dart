import 'package:frenly/data/datasources/remote/auth/auth_remote_data.dart';
import 'package:frenly/domain/entities/user_entity.dart';
import 'package:frenly/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteData remoteData;

  AuthRepositoryImpl({required this.remoteData});

  @override
  Future<UserEntity> getAuthStatus() {
    return remoteData.getAuthStatus();
  }

  @override
  Future<UserEntity> signInUser(UserEntity user) {
    return remoteData.signInUser(user);
  }

  @override
  Future<void> signOutUser() {
    return remoteData.signOutUser();
  }

  @override
  Future<void> signUpUser(UserEntity user) {
    return remoteData.signUpUser(user);
  }
}
