import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frenly/domain/entities/post_entity.dart';
import 'package:frenly/domain/usecases/post/create_post_usecase.dart';
import 'package:frenly/domain/usecases/post/like_post_usecase.dart';
import 'package:frenly/presentation/cubit/post/post_state.dart';

class PostCubit extends Cubit<PostState> {
  final CreatePostUseCase createPostUseCase;
  final LikePostUseCase likePostUseCase;

  PostCubit({
    required this.createPostUseCase,
    required this.likePostUseCase,
  }) : super(PostInitial());

  Future<void> createPost(PostEntity post) async {
    try {
      emit(PostLoading());
      await createPostUseCase(post);
      emit(PostCreated());
    } catch (e) {
      emit(PostFailure(message: e.toString()));
    }
  }

  Future<void> likePost(PostEntity post) async {
    try {
      await likePostUseCase(post);
    } catch (e) {
      emit(PostFailure(message: e.toString()));
    }
  }
}
