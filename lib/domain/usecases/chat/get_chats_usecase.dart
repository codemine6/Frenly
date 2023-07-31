import 'package:frenly/domain/entities/chat_entity.dart';
import 'package:frenly/domain/repositories/chat_repository.dart';

class GetChatsUseCase {
  final ChatRepository repository;

  GetChatsUseCase({required this.repository});

  Stream<List<ChatEntity>> call() {
    return repository.getChats();
  }
}
