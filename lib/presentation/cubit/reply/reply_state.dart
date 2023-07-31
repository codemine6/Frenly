import 'package:equatable/equatable.dart';

abstract class ReplyState extends Equatable {
  const ReplyState();
}

class ReplyInitial extends ReplyState {
  @override
  List<Object?> get props => [];
}

class ReplyLoading extends ReplyState {
  @override
  List<Object?> get props => [];
}

class ReplyFailure extends ReplyState {
  final String message;

  const ReplyFailure({required this.message});

  @override
  List<Object?> get props => [message];
}

class ReplyCreated extends ReplyState {
  @override
  List<Object?> get props => [];
}

class ReplyDeleted extends ReplyState {
  @override
  List<Object?> get props => [];
}
