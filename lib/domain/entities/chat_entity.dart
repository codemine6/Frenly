import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class ChatEntity extends Equatable {
  final String? id;
  final String? userId;
  final int? messageCount;
  final Timestamp? messageCreatedAt;
  final bool? messageReaded;
  final String? messageText;
  final String? userName;
  final String? userProfileImage;

  const ChatEntity({
    this.id,
    this.userId,
    this.messageCount,
    this.messageCreatedAt,
    this.messageReaded,
    this.messageText,
    this.userName,
    this.userProfileImage,
  });

  @override
  List<Object?> get props => [
        id,
        userId,
        messageCount,
        messageCreatedAt,
        messageReaded,
        messageText,
        userName,
        userProfileImage,
      ];
}
