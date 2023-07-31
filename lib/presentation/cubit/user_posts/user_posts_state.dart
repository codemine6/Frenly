import 'package:equatable/equatable.dart';
import 'package:frenly/domain/entities/post_entity.dart';

abstract class UserPostsState extends Equatable {
  const UserPostsState();
}

class UserPostsInitial extends UserPostsState {
  @override
  List<Object?> get props => [];
}

class UserPostsFailure extends UserPostsState {
  final String message;

  const UserPostsFailure({required this.message});

  @override
  List<Object?> get props => [message];
}

class UserPostsLoaded extends UserPostsState {
  final List<PostEntity> posts;

  const UserPostsLoaded({required this.posts});

  @override
  List<Object?> get props => [posts];
}
