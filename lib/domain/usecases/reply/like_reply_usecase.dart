import 'package:frenly/domain/entities/reply_entity.dart';
import 'package:frenly/domain/repositories/reply_repository.dart';

class LikeReplyUseCase {
  final ReplyRepository repository;

  LikeReplyUseCase({required this.repository});

  Future<void> call(ReplyEntity reply) {
    return repository.likeReply(reply);
  }
}
