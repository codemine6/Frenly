import 'package:equatable/equatable.dart';

abstract class CommentState extends Equatable {
  const CommentState();
}

class CommentInitial extends CommentState {
  @override
  List<Object?> get props => [];
}

class CommentLoading extends CommentState {
  @override
  List<Object?> get props => [];
}

class CommentFailure extends CommentState {
  final String message;

  const CommentFailure({required this.message});

  @override
  List<Object?> get props => [message];
}

class CommentCreated extends CommentState {
  @override
  List<Object?> get props => [];
}

class CommentDeleted extends CommentState {
  @override
  List<Object?> get props => [];
}

class CommentEdited extends CommentState {
  @override
  List<Object?> get props => [];
}
