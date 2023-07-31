import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frenly/domain/entities/user_entity.dart';
import 'package:frenly/domain/usecases/user/get_followers_user_usecase.dart';
import 'package:frenly/domain/usecases/user/get_following_user_usecase.dart';
import 'package:frenly/presentation/cubit/users/users_state.dart';

class UsersCubit extends Cubit<UsersState> {
  final GetFollowersUserUseCase getFollowersUserUseCase;
  final GetFollowingUserUseCase getFollowingUserUseCase;

  UsersCubit({
    required this.getFollowersUserUseCase,
    required this.getFollowingUserUseCase,
  }) : super(UsersInitial());

  Future<void> getFollowersUser(UserEntity user) async {
    try {
      emit(UsersLaoding());
      final users = await getFollowersUserUseCase(user);
      emit(UsersLoaded(users: users));
    } catch (e) {
      emit(UsersFailure(message: e.toString()));
    }
  }

  Future<void> getFollowingUser(UserEntity user) async {
    try {
      emit(UsersLaoding());
      final users = await getFollowingUserUseCase(user);
      emit(UsersLoaded(users: users));
    } catch (e) {
      emit(UsersFailure(message: e.toString()));
    }
  }
}
