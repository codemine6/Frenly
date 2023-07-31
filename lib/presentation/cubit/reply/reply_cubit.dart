import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frenly/domain/entities/reply_entity.dart';
import 'package:frenly/domain/usecases/reply/create_reply_usecase.dart';
import 'package:frenly/domain/usecases/reply/delete_reply_usecase.dart';
import 'package:frenly/domain/usecases/reply/edit_reply_usecase.dart';
import 'package:frenly/domain/usecases/reply/like_reply_usecase.dart';
import 'package:frenly/presentation/cubit/reply/reply_state.dart';

class ReplyCubit extends Cubit<ReplyState> {
  final CreateReplyUseCase createReplyUseCase;
  final DeleteReplyUseCase deleteReplyUseCase;
  final EditReplyUseCase editReplyUseCase;
  final LikeReplyUseCase likeReplyUseCase;

  ReplyCubit({
    required this.createReplyUseCase,
    required this.deleteReplyUseCase,
    required this.editReplyUseCase,
    required this.likeReplyUseCase,
  }) : super(ReplyInitial());

  Future<void> createReply(ReplyEntity reply) async {
    try {
      emit(ReplyLoading());
      await createReplyUseCase(reply);
      emit(ReplyCreated());
    } catch (e) {
      emit(ReplyFailure(message: e.toString()));
    }
  }

  Future<void> deleteReply(ReplyEntity reply) async {
    try {
      emit(ReplyLoading());
      await deleteReplyUseCase(reply);
      emit(ReplyDeleted());
    } catch (e) {
      emit(ReplyFailure(message: e.toString()));
    }
  }

  Future<void> editReply(ReplyEntity reply) async {
    try {
      emit(ReplyLoading());
      await editReplyUseCase(reply);
    } catch (e) {
      emit(ReplyFailure(message: e.toString()));
    }
  }

  Future<void> likeReply(ReplyEntity reply) async {
    try {
      await likeReplyUseCase(reply);
    } catch (e) {
      emit(ReplyFailure(message: e.toString()));
    }
  }
}
