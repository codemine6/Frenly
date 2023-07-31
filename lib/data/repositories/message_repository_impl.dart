import 'package:frenly/data/datasources/remote/message/message_remote_data.dart';
import 'package:frenly/domain/entities/message_entity.dart';
import 'package:frenly/domain/entities/chat_entity.dart';
import 'package:frenly/domain/repositories/message_repository.dart';

class MessageRepositoryImpl implements MessageRepository {
  final MessageRemoteData remoteData;

  MessageRepositoryImpl({required this.remoteData});

  @override
  Future<void> createMessage(MessageEntity message) {
    return remoteData.createMessage(message);
  }

  @override
  Future<void> deleteAllMessages(ChatEntity chat) {
    return remoteData.deleteAllMessages(chat);
  }

  @override
  Future<void> deleteMessages(List<MessageEntity> messages) {
    return remoteData.deleteMessages(messages);
  }

  @override
  Stream<List<MessageEntity>> getMessages(ChatEntity chat) {
    return remoteData.getMessages(chat);
  }
}
