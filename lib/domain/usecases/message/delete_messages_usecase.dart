import 'package:frenly/domain/entities/message_entity.dart';
import 'package:frenly/domain/repositories/message_repository.dart';

class DeleteMessagesUseCase {
  final MessageRepository repository;

  DeleteMessagesUseCase({required this.repository});

  Future<void> call(List<MessageEntity> messages) {
    return repository.deleteMessages(messages);
  }
}
