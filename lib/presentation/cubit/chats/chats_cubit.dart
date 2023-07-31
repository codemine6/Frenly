import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frenly/domain/usecases/chat/get_chats_usecase.dart';
import 'package:frenly/presentation/cubit/chats/chats_state.dart';

class ChatsCubit extends Cubit<ChatsState> {
  final GetChatsUseCase getChatsUseCase;

  ChatsCubit({
    required this.getChatsUseCase,
  }) : super(ChatsInitial());

  Future<void> getChats() async {
    try {
      getChatsUseCase().listen((chats) {
        emit(ChatsLoaded(chats: chats));
      });
    } catch (e) {
      emit(ChatsFailure(message: e.toString()));
    }
  }
}
