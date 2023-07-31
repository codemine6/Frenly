import 'package:frenly/domain/entities/reply_entity.dart';
import 'package:frenly/domain/repositories/reply_repository.dart';

class CreateReplyUseCase {
  final ReplyRepository repository;

  CreateReplyUseCase({required this.repository});

  Future<void> call(ReplyEntity reply) {
    return repository.createReply(reply);
  }
}
