import 'package:frenly/domain/entities/reply_entity.dart';
import 'package:frenly/domain/repositories/reply_repository.dart';

class GetRepliesUseCase {
  final ReplyRepository repository;

  GetRepliesUseCase({required this.repository});

  Stream<List<ReplyEntity>> call(ReplyEntity reply) {
    return repository.getReplies(reply);
  }
}
