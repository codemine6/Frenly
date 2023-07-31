import 'package:equatable/equatable.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();
}

class ProfileInitial extends ProfileState {
  @override
  List<Object?> get props => [];
}

class ProfileLoading extends ProfileState {
  @override
  List<Object?> get props => [];
}

class ProfileFailure extends ProfileState {
  final String message;

  const ProfileFailure({required this.message});

  @override
  List<Object?> get props => [message];
}

class ProfileUpdated extends ProfileState {
  @override
  List<Object?> get props => [];
}

class ProfileImageUploading extends ProfileState {
  final double progress;

  const ProfileImageUploading({required this.progress});

  @override
  List<Object?> get props => [progress];
}

class ProfileImageUploaded extends ProfileState {
  final String url;

  const ProfileImageUploaded({required this.url});

  @override
  List<Object?> get props => [url];
}
