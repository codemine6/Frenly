import 'package:equatable/equatable.dart';
import 'package:frenly/domain/entities/message_entity.dart';

abstract class MessagesState extends Equatable {
  const MessagesState();
}

class MessagesInitial extends MessagesState {
  @override
  List<Object?> get props => [];
}

class MessagesFailure extends MessagesState {
  final String message;

  const MessagesFailure({required this.message});

  @override
  List<Object?> get props => [message];
}

class MessagesLoaded extends MessagesState {
  final List<MessageEntity> messages;

  const MessagesLoaded({required this.messages});

  @override
  List<Object?> get props => [messages];
}
