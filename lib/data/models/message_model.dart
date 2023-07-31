import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:frenly/domain/entities/message_entity.dart';

class MessageModel extends MessageEntity {
  final String? id;
  final String? authorId;
  final String? chatId;
  final Timestamp? createdAt;
  final List? deletedFor;
  final bool? readed;
  final String? text;

  const MessageModel({
    this.id,
    this.authorId,
    this.chatId,
    this.createdAt,
    this.deletedFor,
    this.readed,
    this.text,
  }) : super(
          id: id,
          authorId: authorId,
          chatId: chatId,
          createdAt: createdAt,
          deletedFor: deletedFor,
          readed: readed,
          text: text,
        );

  factory MessageModel.fromDocument(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;

    return MessageModel(
      id: snapshot.id,
      authorId: data['authorId'],
      chatId: data['chatId'],
      createdAt: data['createdAt'],
      deletedFor: data['deletedFor'],
      readed: data['readed'],
      text: data['text'],
    );
  }

  Map<String, dynamic> toMap() => {
        'authorId': authorId,
        'chatId': chatId,
        'createdAt': createdAt,
        'deletedFor': deletedFor,
        'readed': readed,
        'text': text,
      };
}
