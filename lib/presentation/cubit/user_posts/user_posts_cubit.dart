import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frenly/domain/entities/user_entity.dart';
import 'package:frenly/domain/usecases/post/get_user_posts_usecase.dart';
import 'package:frenly/presentation/cubit/user_posts/user_posts_state.dart';

class UserPostsCubit extends Cubit<UserPostsState> {
  final GetUserPostsUseCase getUserPostsUseCase;

  UserPostsCubit({
    required this.getUserPostsUseCase,
  }) : super(UserPostsInitial());

  Future<void> getUserPosts(UserEntity user) async {
    try {
      final posts = await getUserPostsUseCase(user);
      emit(UserPostsLoaded(posts: posts));
    } catch (e) {
      emit(UserPostsFailure(message: e.toString()));
    }
  }
}
