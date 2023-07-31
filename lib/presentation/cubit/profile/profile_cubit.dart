import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frenly/domain/entities/user_entity.dart';
import 'package:frenly/domain/usecases/user/set_profile_image_usecase.dart';
import 'package:frenly/domain/usecases/user/set_profile_usecase.dart';
import 'package:frenly/domain/usecases/user/set_username_usecase.dart';
import 'package:frenly/presentation/cubit/profile/profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final SetProfileUseCase setProfileUseCase;
  final SetProfileImageUseCase setProfileImageUseCase;
  final SetUsernameUseCase setUsernameUseCase;

  ProfileCubit({
    required this.setProfileUseCase,
    required this.setProfileImageUseCase,
    required this.setUsernameUseCase,
  }) : super(ProfileInitial());

  Future<void> setProfile(UserEntity user) async {
    try {
      emit(ProfileLoading());
      await setProfileUseCase(user);
      emit(ProfileUpdated());
    } catch (e) {
      emit(ProfileFailure(message: e.toString()));
    }
  }

  Future<void> setProfileImage(UserEntity user) async {
    try {
      setProfileImageUseCase(user).listen((event) async {
        if (event.state == TaskState.running) {
          emit(ProfileImageUploading(
              progress: event.bytesTransferred / event.totalBytes));
        } else if (event.state == TaskState.success) {
          final url = await event.ref.getDownloadURL();
          emit(ProfileImageUploaded(url: url));
        }
      });
    } catch (e) {
      emit(ProfileFailure(message: e.toString()));
    }
  }

  Future<void> setUsername(UserEntity user) async {
    try {
      emit(ProfileLoading());
      await setUsernameUseCase(user);
      emit(ProfileUpdated());
    } catch (_) {
      emit(const ProfileFailure(message: 'Username not available'));
    }
  }
}
