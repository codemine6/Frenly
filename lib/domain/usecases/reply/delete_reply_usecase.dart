import 'package:frenly/domain/entities/reply_entity.dart';
import 'package:frenly/domain/repositories/reply_repository.dart';

class DeleteReplyUseCase {
  final ReplyRepository repository;

  DeleteReplyUseCase({required this.repository});

  Future<void> call(ReplyEntity reply) {
    return repository.deleteReply(reply);
  }
}
