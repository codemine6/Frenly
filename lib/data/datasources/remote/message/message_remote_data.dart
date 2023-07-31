import 'package:frenly/domain/entities/chat_entity.dart';
import 'package:frenly/domain/entities/message_entity.dart';

abstract class MessageRemoteData {
  Future<void> createMessage(MessageEntity message);
  Future<void> deleteAllMessages(ChatEntity chat);
  Future<void> deleteMessages(List<MessageEntity> messages);
  Stream<List<MessageEntity>> getMessages(ChatEntity chat);
}
