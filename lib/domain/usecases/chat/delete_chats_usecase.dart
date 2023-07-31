import 'package:frenly/domain/entities/chat_entity.dart';
import 'package:frenly/domain/repositories/chat_repository.dart';

class DeleteChatsUseCase {
  final ChatRepository repository;

  DeleteChatsUseCase({required this.repository});

  Future<void> call(List<ChatEntity> chats) {
    return repository.deleteChats(chats);
  }
}
