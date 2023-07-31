import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frenly/domain/entities/comment_entity.dart';
import 'package:frenly/domain/usecases/comment/create_comment_usecase.dart';
import 'package:frenly/domain/usecases/comment/delete_comment_usecase.dart';
import 'package:frenly/domain/usecases/comment/edit_comment_usecase.dart';
import 'package:frenly/domain/usecases/comment/like_comment_usecase.dart';
import 'package:frenly/presentation/cubit/comment/comment_state.dart';

class CommentCubit extends Cubit<CommentState> {
  final CreateCommentUseCase createCommentUseCase;
  final DeleteCommentUseCase deleteCommentUseCase;
  final EditCommentUseCase editCommentUseCase;
  final LikeCommentUseCase likeCommentUseCase;

  CommentCubit({
    required this.createCommentUseCase,
    required this.deleteCommentUseCase,
    required this.editCommentUseCase,
    required this.likeCommentUseCase,
  }) : super(CommentInitial());

  Future<void> createComment(CommentEntity comment) async {
    try {
      emit(CommentLoading());
      await createCommentUseCase(comment);
      emit(CommentCreated());
    } catch (e) {
      emit(CommentFailure(message: e.toString()));
    }
  }

  Future<void> deleteComment(CommentEntity comment) async {
    try {
      emit(CommentLoading());
      await deleteCommentUseCase(comment);
      emit(CommentDeleted());
    } catch (e) {
      emit(CommentFailure(message: e.toString()));
    }
  }

  Future<void> editComment(CommentEntity comment) async {
    try {
      emit(CommentLoading());
      await editCommentUseCase(comment);
      emit(CommentEdited());
    } catch (e) {
      emit(CommentFailure(message: e.toString()));
    }
  }

  Future<void> likeComment(CommentEntity comment) async {
    try {
      await likeCommentUseCase(comment);
    } catch (e) {
      emit(CommentFailure(message: e.toString()));
    }
  }
}
