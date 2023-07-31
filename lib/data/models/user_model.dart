import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:frenly/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  final String? id;
  final String? bio;
  final Timestamp? birthday;
  final String? email;
  final bool? followed;
  final int? followersCount;
  final int? followingCount;
  final Timestamp? joinAt;
  final String? name;
  final String? password;
  final String? profileImage;
  final Uint8List? profileImageFile;
  final String? username;

  const UserModel({
    this.id,
    this.bio,
    this.birthday,
    this.email,
    this.followed,
    this.followersCount,
    this.followingCount,
    this.joinAt,
    this.name,
    this.password,
    this.profileImage,
    this.profileImageFile,
    this.username,
  }) : super(
          id: id,
          bio: bio,
          birthday: birthday,
          email: email,
          followed: followed,
          followersCount: followersCount,
          followingCount: followingCount,
          joinAt: joinAt,
          name: name,
          password: password,
          profileImage: profileImage,
          profileImageFile: profileImageFile,
          username: username,
        );

  factory UserModel.fromDocument(DocumentSnapshot snapshot, [bool? followed]) {
    final data = snapshot.data() as Map<String, dynamic>;

    return UserModel(
      id: snapshot.id,
      bio: data['bio'],
      birthday: data['birthday'],
      email: data['email'],
      followed: followed,
      followersCount: data['followersCount'] ?? 0,
      followingCount: data['followingCount'] ?? 0,
      name: data['name'],
      profileImage: data['profileImage'],
      username: data['username'],
    );
  }

  Map<String, dynamic> toMap() => {
        'bio': bio,
        'email': email,
        'joinAt': joinAt,
        'name': name,
        'profileImage': profileImage,
      };
}
