import 'package:equatable/equatable.dart';
import 'package:frenly/domain/entities/post_entity.dart';

abstract class PostsState extends Equatable {
  const PostsState();
}

class PostsInitial extends PostsState {
  @override
  List<Object?> get props => [];
}

class PostsFailure extends PostsState {
  final String message;

  const PostsFailure({required this.message});

  @override
  List<Object?> get props => [message];
}

class PostsLoaded extends PostsState {
  final List<PostEntity> posts;

  const PostsLoaded({required this.posts});

  @override
  List<Object?> get props => [posts];
}
