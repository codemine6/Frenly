import 'package:equatable/equatable.dart';

abstract class PostState extends Equatable {
  const PostState();
}

class PostInitial extends PostState {
  @override
  List<Object?> get props => [];
}

class PostLoading extends PostState {
  @override
  List<Object?> get props => [];
}

class PostFailure extends PostState {
  final String message;

  const PostFailure({required this.message});

  @override
  List<Object?> get props => [message];
}

class PostCreated extends PostState {
  @override
  List<Object?> get props => [];
}
