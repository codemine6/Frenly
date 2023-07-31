import 'package:frenly/data/datasources/remote/chat/chat_remote_data.dart';
import 'package:frenly/domain/entities/chat_entity.dart';
import 'package:frenly/domain/repositories/chat_repository.dart';

class ChatRepositoryImpl implements ChatRepository {
  final ChatRemoteData remoteData;

  ChatRepositoryImpl({required this.remoteData});

  @override
  Future<String> createChat(ChatEntity chat) {
    return remoteData.createChat(chat);
  }

  @override
  Future<void> deleteChats(List<ChatEntity> chats) {
    return remoteData.deleteChats(chats);
  }

  @override
  Stream<List<ChatEntity>> getChats() {
    return remoteData.getChats();
  }
}
