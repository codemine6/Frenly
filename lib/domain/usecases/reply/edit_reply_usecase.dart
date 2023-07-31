import 'package:frenly/domain/entities/reply_entity.dart';
import 'package:frenly/domain/repositories/reply_repository.dart';

class EditReplyUseCase {
  final ReplyRepository repository;

  EditReplyUseCase({required this.repository});

  Future<void> call(ReplyEntity reply) {
    return repository.editReply(reply);
  }
}
