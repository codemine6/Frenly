import 'package:frenly/domain/entities/chat_entity.dart';
import 'package:frenly/domain/entities/message_entity.dart';
import 'package:frenly/domain/repositories/message_repository.dart';

class GetMessagesUseCase {
  final MessageRepository repository;

  GetMessagesUseCase({required this.repository});

  Stream<List<MessageEntity>> call(ChatEntity chat) {
    return repository.getMessages(chat);
  }
}
