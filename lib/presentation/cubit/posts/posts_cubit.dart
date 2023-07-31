import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frenly/domain/usecases/post/get_posts_usecase.dart';
import 'package:frenly/presentation/cubit/posts/posts_state.dart';

class PostsCubit extends Cubit<PostsState> {
  final GetPostsUseCase getPostsUseCase;

  PostsCubit({
    required this.getPostsUseCase,
  }) : super(PostsInitial());

  Future<void> getPosts() async {
    try {
      final posts = await getPostsUseCase();
      emit(PostsLoaded(posts: posts));
    } catch (e) {
      emit(PostsFailure(message: e.toString()));
    }
  }
}
