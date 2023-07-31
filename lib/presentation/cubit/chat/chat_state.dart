import 'package:equatable/equatable.dart';

abstract class ChatState extends Equatable {
  const ChatState();
}

class ChatInitial extends ChatState {
  @override
  List<Object?> get props => [];
}

class ChatFailure extends ChatState {
  final String message;

  const ChatFailure({required this.message});

  @override
  List<Object?> get props => [message];
}

class ChatCreated extends ChatState {
  final String chatId;

  const ChatCreated({required this.chatId});

  @override
  List<Object?> get props => [chatId];
}
