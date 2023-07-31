import 'package:frenly/domain/entities/message_entity.dart';
import 'package:frenly/domain/repositories/message_repository.dart';

class CreateMessageUseCase {
  final MessageRepository repository;

  CreateMessageUseCase({required this.repository});

  Future<void> call(MessageEntity message) {
    return repository.createMessage(message);
  }
}
