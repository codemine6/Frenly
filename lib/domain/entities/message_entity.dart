import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class MessageEntity extends Equatable {
  final String? id;
  final String? authorId;
  final String? chatId;
  final Timestamp? createdAt;
  final List? deletedFor;
  final bool? readed;
  final String? text;

  const MessageEntity({
    this.id,
    this.authorId,
    this.chatId,
    this.createdAt,
    this.deletedFor,
    this.readed,
    this.text,
  });

  @override
  List<Object?> get props => [
        id,
        authorId,
        chatId,
        createdAt,
        deletedFor,
        readed,
        text,
      ];
}
