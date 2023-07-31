import 'package:equatable/equatable.dart';
import 'package:frenly/domain/entities/chat_entity.dart';

abstract class ChatsState extends Equatable {
  const ChatsState();
}

class ChatsInitial extends ChatsState {
  @override
  List<Object?> get props => [];
}

class ChatsFailure extends ChatsState {
  final String message;

  const ChatsFailure({required this.message});

  @override
  List<Object?> get props => [message];
}

class ChatsLoaded extends ChatsState {
  final List<ChatEntity> chats;

  const ChatsLoaded({required this.chats});

  @override
  List<Object?> get props => [chats];
}
