import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frenly/domain/entities/chat_entity.dart';
import 'package:frenly/domain/usecases/message/get_messages_usecase.dart';
import 'package:frenly/presentation/cubit/messages/messages_state.dart';

class MessagesCubit extends Cubit<MessagesState> {
  final GetMessagesUseCase getMessagesUseCase;
  StreamSubscription? subscription;

  MessagesCubit({
    required this.getMessagesUseCase,
  }) : super(MessagesInitial());

  void cancelSubscription() {
    subscription?.cancel();
  }

  Future<void> getMessages(ChatEntity chat) async {
    try {
      subscription = getMessagesUseCase(chat).listen((messages) {
        emit(MessagesLoaded(messages: messages));
      });
    } catch (e) {
      emit(MessagesFailure(message: e.toString()));
    }
  }
}
