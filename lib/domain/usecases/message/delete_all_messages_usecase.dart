import 'package:frenly/domain/entities/chat_entity.dart';
import 'package:frenly/domain/repositories/message_repository.dart';

class DeleteAllMessagesUseCase {
  final MessageRepository repository;

  DeleteAllMessagesUseCase({required this.repository});

  Future<void> call(ChatEntity chat) {
    return repository.deleteAllMessages(chat);
  }
}
