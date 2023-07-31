import 'package:equatable/equatable.dart';

abstract class MessageState extends Equatable {
  const MessageState();
}

class MessageInitial extends MessageState {
  @override
  List<Object?> get props => [];
}

class MessageFailure extends MessageState {
  final String message;

  const MessageFailure({required this.message});

  @override
  List<Object?> get props => [message];
}
