import 'package:firebase_storage/firebase_storage.dart';
import 'package:frenly/data/datasources/remote/user/user_remote_data.dart';
import 'package:frenly/domain/entities/user_entity.dart';
import 'package:frenly/domain/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRemoteData remoteData;

  UserRepositoryImpl({required this.remoteData});

  @override
  Future<void> followUser(UserEntity user) {
    return remoteData.followUser(user);
  }

  @override
  Future<List<UserEntity>> getFollowersUser(UserEntity user) {
    return remoteData.getFollowersUser(user);
  }

  @override
  Future<List<UserEntity>> getFollowingUser(UserEntity user) {
    return remoteData.getFollowingUser(user);
  }

  @override
  Future<UserEntity> getUserDetail(UserEntity user) {
    return remoteData.getUserDetail(user);
  }

  @override
  Future<void> setProfile(UserEntity user) {
    return remoteData.setProfile(user);
  }

  @override
  Stream<TaskSnapshot> setProfileImage(UserEntity user) {
    return remoteData.setProfileImage(user);
  }

  @override
  Future<void> setUsername(UserEntity user) {
    return remoteData.setUsername(user);
  }
}
