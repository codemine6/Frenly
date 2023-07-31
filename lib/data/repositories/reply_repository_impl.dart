import 'package:frenly/data/datasources/remote/reply/reply_remote_data.dart';
import 'package:frenly/domain/entities/reply_entity.dart';
import 'package:frenly/domain/repositories/reply_repository.dart';

class ReplyRepositoryImpl implements ReplyRepository {
  final ReplyRemoteData remoteData;

  ReplyRepositoryImpl({required this.remoteData});

  @override
  Future<void> createReply(ReplyEntity reply) {
    return remoteData.createReply(reply);
  }

  @override
  Future<void> deleteReply(ReplyEntity reply) {
    return remoteData.deleteReply(reply);
  }

  @override
  Future<void> editReply(ReplyEntity reply) {
    return remoteData.editReply(reply);
  }

  @override
  Stream<List<ReplyEntity>> getReplies(ReplyEntity reply) {
    return remoteData.getReplies(reply);
  }

  @override
  Future<void> likeReply(ReplyEntity reply) {
    return remoteData.likeReply(reply);
  }
}
