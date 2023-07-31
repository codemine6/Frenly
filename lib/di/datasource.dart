import 'package:frenly/data/datasources/remote/auth/auth_remote_data.dart';
import 'package:frenly/data/datasources/remote/auth/auth_remote_data_impl.dart';
import 'package:frenly/data/datasources/remote/chat/chat_remote_data.dart';
import 'package:frenly/data/datasources/remote/chat/chat_remote_data_impl.dart';
import 'package:frenly/data/datasources/remote/comment/comment_remote_data.dart';
import 'package:frenly/data/datasources/remote/comment/comment_remote_data_impl.dart';
import 'package:frenly/data/datasources/remote/message/message_remote_data.dart';
import 'package:frenly/data/datasources/remote/message/message_remote_data_impl.dart';
import 'package:frenly/data/datasources/remote/post/post_remote_data.dart';
import 'package:frenly/data/datasources/remote/post/post_remote_data_impl.dart';
import 'package:frenly/data/datasources/remote/reply/reply_remote_data.dart';
import 'package:frenly/data/datasources/remote/reply/reply_remote_data_impl.dart';
import 'package:frenly/data/datasources/remote/user/user_remote_data.dart';
import 'package:frenly/data/datasources/remote/user/user_remote_data_impl.dart';
import 'package:get_it/get_it.dart';

registerDataSource(GetIt getIt) {
  getIt.registerLazySingleton<AuthRemoteData>(() => AuthRemoteDataImpl(
        auth: getIt.call(),
        firestore: getIt.call(),
      ));
  getIt.registerLazySingleton<ChatRemoteData>(() => ChatRemoteDataImpl(
        auth: getIt.call(),
        firestore: getIt.call(),
      ));
  getIt.registerLazySingleton<CommentRemoteData>(() => CommentRemoteDataImpl(
        auth: getIt.call(),
        firestore: getIt.call(),
        storage: getIt.call(),
      ));
  getIt.registerLazySingleton<MessageRemoteData>(() => MessageRemoteDataImpl(
        auth: getIt.call(),
        firestore: getIt.call(),
        storage: getIt.call(),
      ));
  getIt.registerLazySingleton<PostRemoteData>(() => PostRemoteDataImpl(
        auth: getIt.call(),
        firestore: getIt.call(),
        storage: getIt.call(),
      ));
  getIt.registerLazySingleton<ReplyRemoteData>(() => ReplyRemoteDataImpl(
        auth: getIt.call(),
        firestore: getIt.call(),
        storage: getIt.call(),
      ));
  getIt.registerLazySingleton<UserRemoteData>(() => UserRemoteDataImpl(
        auth: getIt.call(),
        firestore: getIt.call(),
        storage: getIt.call(),
      ));
}
