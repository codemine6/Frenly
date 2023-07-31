import 'package:frenly/domain/entities/chat_entity.dart';
import 'package:frenly/domain/repositories/chat_repository.dart';

class CreateChatUseCase {
  final ChatRepository repository;

  CreateChatUseCase({required this.repository});

  Future<String> call(ChatEntity chat) {
    return repository.createChat(chat);
  }
}
