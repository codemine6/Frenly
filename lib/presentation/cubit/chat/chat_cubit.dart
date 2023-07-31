import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frenly/domain/entities/chat_entity.dart';
import 'package:frenly/domain/usecases/chat/create_chat_usecase.dart';
import 'package:frenly/domain/usecases/chat/delete_chats_usecase.dart';
import 'package:frenly/presentation/cubit/chat/chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  final CreateChatUseCase createChatUseCase;
  final DeleteChatsUseCase deleteChatsUseCase;

  ChatCubit({
    required this.createChatUseCase,
    required this.deleteChatsUseCase,
  }) : super(ChatInitial());

  Future<void> createChat(ChatEntity chat) async {
    try {
      final chatId = await createChatUseCase(chat);
      emit(ChatCreated(chatId: chatId));
    } catch (e) {
      emit(ChatFailure(message: e.toString()));
    }
  }

  Future<void> deleteChats(List<ChatEntity> chats) async {
    try {
      await deleteChatsUseCase(chats);
    } catch (e) {
      emit(ChatFailure(message: e.toString()));
    }
  }
}
