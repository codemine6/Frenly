import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frenly/domain/entities/reply_entity.dart';
import 'package:frenly/domain/usecases/reply/get_replies_usecase.dart';
import 'package:frenly/presentation/cubit/replies/replies_state.dart';

class RepliesCubit extends Cubit<RepliesState> {
  final GetRepliesUseCase getRepliesUseCase;

  RepliesCubit({
    required this.getRepliesUseCase,
  }) : super(RepliesInitial());

  Future<void> getReplies(ReplyEntity reply) async {
    try {
      getRepliesUseCase(reply).listen((replies) {
        emit(RepliesLoaded(replies: replies));
      });
    } catch (e) {
      emit(RepliesFailure(message: e.toString()));
    }
  }
}
