import 'package:frenly/data/repositories/auth_repository_impl.dart';
import 'package:frenly/data/repositories/chat_repository_impl.dart';
import 'package:frenly/data/repositories/comment_repository_impl.dart';
import 'package:frenly/data/repositories/message_repository_impl.dart';
import 'package:frenly/data/repositories/post_repository_impl.dart';
import 'package:frenly/data/repositories/reply_repository_impl.dart';
import 'package:frenly/data/repositories/user_repository_impl.dart';
import 'package:frenly/domain/repositories/auth_repository.dart';
import 'package:frenly/domain/repositories/chat_repository.dart';
import 'package:frenly/domain/repositories/comment_repository.dart';
import 'package:frenly/domain/repositories/message_repository.dart';
import 'package:frenly/domain/repositories/post_repository.dart';
import 'package:frenly/domain/repositories/reply_repository.dart';
import 'package:frenly/domain/repositories/user_repository.dart';
import 'package:get_it/get_it.dart';

registerRepository(GetIt getIt) {
  getIt.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(remoteData: getIt.call()));
  getIt.registerLazySingleton<ChatRepository>(
      () => ChatRepositoryImpl(remoteData: getIt.call()));
  getIt.registerLazySingleton<CommentRepository>(
      () => CommentRepositoryImpl(remoteData: getIt.call()));
  getIt.registerLazySingleton<MessageRepository>(
      () => MessageRepositoryImpl(remoteData: getIt.call()));
  getIt.registerLazySingleton<PostRepository>(
      () => PostRepositoryImpl(remoteData: getIt.call()));
  getIt.registerLazySingleton<ReplyRepository>(
      () => ReplyRepositoryImpl(remoteData: getIt.call()));
  getIt.registerLazySingleton<UserRepository>(
      () => UserRepositoryImpl(remoteData: getIt.call()));
}
