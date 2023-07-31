import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frenly/domain/entities/user_entity.dart';
import 'package:frenly/domain/usecases/user/follow_user_usecase.dart';
import 'package:frenly/domain/usecases/user/get_user_detail_usecase.dart';
import 'package:frenly/presentation/cubit/user/user_state.dart';

class UserCubit extends Cubit<UserState> {
  final FollowUserUseCase followUserUseCase;
  final GetUserDetailUseCase getUserDetailUseCase;

  UserCubit({
    required this.followUserUseCase,
    required this.getUserDetailUseCase,
  }) : super(UserInitial());

  Future<void> followUser(UserEntity user) async {
    try {
      await followUserUseCase(user);
    } catch (e) {
      emit(UserFailure(message: e.toString()));
    }
  }

  Future<void> getUserDetail(UserEntity user) async {
    try {
      emit(UserLoading());
      final userData = await getUserDetailUseCase(user);
      emit(UserLoaded(user: userData));
    } catch (e) {
      emit(UserFailure(message: e.toString()));
    }
  }
}
