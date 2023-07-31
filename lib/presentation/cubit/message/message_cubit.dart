import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frenly/domain/entities/chat_entity.dart';
import 'package:frenly/domain/entities/message_entity.dart';
import 'package:frenly/domain/usecases/message/create_message_usecase.dart';
import 'package:frenly/domain/usecases/message/delete_all_messages_usecase.dart';
import 'package:frenly/domain/usecases/message/delete_messages_usecase.dart';
import 'package:frenly/presentation/cubit/message/message_state.dart';

class MessageCubit extends Cubit<MessageState> {
  final CreateMessageUseCase createMessageUseCase;
  final DeleteAllMessagesUseCase deleteAllMessagesUseCase;
  final DeleteMessagesUseCase deleteMessagesUseCase;

  MessageCubit({
    required this.createMessageUseCase,
    required this.deleteAllMessagesUseCase,
    required this.deleteMessagesUseCase,
  }) : super(MessageInitial());

  Future<void> createMessage(MessageEntity message) async {
    try {
      await createMessageUseCase(message);
    } catch (e) {
      emit(MessageFailure(message: e.toString()));
    }
  }

  Future<void> deleteAllMessages(ChatEntity chat) async {
    try {
      await deleteAllMessagesUseCase(chat);
    } catch (e) {
      emit(MessageFailure(message: e.toString()));
    }
  }

  Future<void> deleteMessages(List<MessageEntity> messages) async {
    try {
      await deleteMessagesUseCase(messages);
    } catch (e) {
      emit(MessageFailure(message: e.toString()));
    }
  }
}
