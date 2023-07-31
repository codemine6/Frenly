import 'package:frenly/domain/entities/chat_entity.dart';

abstract class ChatRepository {
  Future<String> createChat(ChatEntity chat);
  Future<void> deleteChats(List<ChatEntity> chats);
  Stream<List<ChatEntity>> getChats();
}
