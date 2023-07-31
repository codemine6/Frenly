import 'package:frenly/domain/entities/reply_entity.dart';

abstract class ReplyRemoteData {
  Future<void> createReply(ReplyEntity reply);
  Future<void> deleteReply(ReplyEntity reply);
  Future<void> editReply(ReplyEntity reply);
  Stream<List<ReplyEntity>> getReplies(ReplyEntity reply);
  Future<void> likeReply(ReplyEntity reply);
}
