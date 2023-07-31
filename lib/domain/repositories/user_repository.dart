import 'package:firebase_storage/firebase_storage.dart';
import 'package:frenly/domain/entities/user_entity.dart';

abstract class UserRepository {
  Future<void> followUser(UserEntity user);
  Future<List<UserEntity>> getFollowersUser(UserEntity user);
  Future<List<UserEntity>> getFollowingUser(UserEntity user);
  Future<UserEntity> getUserDetail(UserEntity user);
  Future<void> setProfile(UserEntity user);
  Stream<TaskSnapshot> setProfileImage(UserEntity user);
  Future<void> setUsername(UserEntity user);
}
