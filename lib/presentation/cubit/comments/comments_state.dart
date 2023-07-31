import 'package:equatable/equatable.dart';
import 'package:frenly/domain/entities/comment_entity.dart';

abstract class CommentsState extends Equatable {
  const CommentsState();
}

class CommentsInitial extends CommentsState {
  @override
  List<Object?> get props => [];
}

class CommentsFailure extends CommentsState {
  final String message;

  const CommentsFailure({required this.message});

  @override
  List<Object?> get props => [message];
}

class CommentsLoaded extends CommentsState {
  final List<CommentEntity> comments;

  const CommentsLoaded({required this.comments});

  @override
  List<Object?> get props => [comments];
}
