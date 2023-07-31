import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frenly/domain/entities/comment_entity.dart';
import 'package:frenly/domain/usecases/comment/get_comments_usecase.dart';
import 'package:frenly/presentation/cubit/comments/comments_state.dart';

class CommentsCubit extends Cubit<CommentsState> {
  final GetCommentsUseCase getCommentsUseCase;

  CommentsCubit({
    required this.getCommentsUseCase,
  }) : super(CommentsInitial());

  Future<void> getComments(CommentEntity comment) async {
    try {
      final comments = await getCommentsUseCase(comment);
      emit(CommentsLoaded(comments: comments));
    } catch (e) {
      emit(CommentsFailure(message: e.toString()));
    }
  }
}
