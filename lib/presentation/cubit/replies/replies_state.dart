import 'package:equatable/equatable.dart';
import 'package:frenly/domain/entities/reply_entity.dart';

abstract class RepliesState extends Equatable {
  const RepliesState();
}

class RepliesInitial extends RepliesState {
  @override
  List<Object?> get props => [];
}

class RepliesFailure extends RepliesState {
  final String message;

  const RepliesFailure({required this.message});

  @override
  List<Object?> get props => [message];
}

class RepliesLoaded extends RepliesState {
  final List<ReplyEntity> replies;

  const RepliesLoaded({required this.replies});

  @override
  List<Object?> get props => [replies];
}
