import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:frenly/domain/entities/chat_entity.dart';

class ChatModel extends ChatEntity {
  final String? id;
  final String? userId;
  final int? messageCount;
  final Timestamp? messageCreatedAt;
  final bool? messageReaded;
  final String? messageText;
  final String? userName;
  final String? userProfileImage;

  const ChatModel({
    this.id,
    this.userId,
    this.messageCount,
    this.messageCreatedAt,
    this.messageReaded,
    this.messageText,
    this.userName,
    this.userProfileImage,
  }) : super(
          id: id,
          userId: userId,
          messageCount: messageCount,
          messageCreatedAt: messageCreatedAt,
          messageReaded: messageReaded,
          messageText: messageText,
          userName: userName,
          userProfileImage: userProfileImage,
        );

  factory ChatModel.fromDocument(
    DocumentSnapshot chatSnapshot,
    DocumentSnapshot userSnapshot,
    List<QueryDocumentSnapshot> messages,
  ) {
    final userData = userSnapshot.data() as Map<String, dynamic>;
    final messageData = messages.first;
    final messageCount = messages
        .where((element) => (element['authorId'] == userSnapshot.id &&
            element['readed'] == false))
        .length;
    final messageReaded = (messageData['authorId'] == userSnapshot.id)
        ? messageData['readed']
        : true;

    return ChatModel(
      id: chatSnapshot.id,
      userId: userSnapshot.id,
      messageCount: messageCount,
      messageCreatedAt: messageData['createdAt'],
      messageReaded: messageReaded,
      messageText: messageData['text'],
      userName: userData['name'],
      userProfileImage: userData['profileImage'],
    );
  }

  Map<String, dynamic> toMap() => {};
}
