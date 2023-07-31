import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
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

  const UserEntity({
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
  });

  @override
  List<Object?> get props => [
        id,
        bio,
        birthday,
        email,
        followed,
        followersCount,
        followingCount,
        joinAt,
        name,
        password,
        profileImage,
        profileImageFile,
        username,
      ];
}
