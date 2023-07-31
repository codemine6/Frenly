import 'package:frenly/domain/usecases/auth/get_auth_status_usecase.dart';
import 'package:frenly/domain/usecases/auth/sign_in_user_usecase.dart';
import 'package:frenly/domain/usecases/auth/sign_out_user_usecase.dart';
import 'package:frenly/domain/usecases/auth/sign_up_user_usecase.dart';
import 'package:frenly/domain/usecases/chat/create_chat_usecase.dart';
import 'package:frenly/domain/usecases/chat/delete_chats_usecase.dart';
import 'package:frenly/domain/usecases/chat/get_chats_usecase.dart';
import 'package:frenly/domain/usecases/comment/create_comment_usecase.dart';
import 'package:frenly/domain/usecases/comment/delete_comment_usecase.dart';
import 'package:frenly/domain/usecases/comment/edit_comment_usecase.dart';
import 'package:frenly/domain/usecases/comment/get_comments_usecase.dart';
import 'package:frenly/domain/usecases/comment/like_comment_usecase.dart';
import 'package:frenly/domain/usecases/message/create_message_usecase.dart';
import 'package:frenly/domain/usecases/message/delete_all_messages_usecase.dart';
import 'package:frenly/domain/usecases/message/delete_messages_usecase.dart';
import 'package:frenly/domain/usecases/message/get_messages_usecase.dart';
import 'package:frenly/domain/usecases/post/create_post_usecase.dart';
import 'package:frenly/domain/usecases/post/get_posts_usecase.dart';
import 'package:frenly/domain/usecases/post/get_user_posts_usecase.dart';
import 'package:frenly/domain/usecases/post/like_post_usecase.dart';
import 'package:frenly/domain/usecases/reply/create_reply_usecase.dart';
import 'package:frenly/domain/usecases/reply/delete_reply_usecase.dart';
import 'package:frenly/domain/usecases/reply/edit_reply_usecase.dart';
import 'package:frenly/domain/usecases/reply/get_replies_usecase.dart';
import 'package:frenly/domain/usecases/reply/like_reply_usecase.dart';
import 'package:frenly/domain/usecases/user/follow_user_usecase.dart';
import 'package:frenly/domain/usecases/user/get_followers_user_usecase.dart';
import 'package:frenly/domain/usecases/user/get_following_user_usecase.dart';
import 'package:frenly/domain/usecases/user/get_user_detail_usecase.dart';
import 'package:frenly/domain/usecases/user/set_profile_image_usecase.dart';
import 'package:frenly/domain/usecases/user/set_profile_usecase.dart';
import 'package:frenly/domain/usecases/user/set_username_usecase.dart';
import 'package:get_it/get_it.dart';

registerUseCase(GetIt getIt) {
  // Auth
  getIt.registerLazySingleton(
      () => GetAuthStatusUseCase(repository: getIt.call()));
  getIt
      .registerLazySingleton(() => SignInUserUseCase(repository: getIt.call()));
  getIt.registerLazySingleton(
      () => SignOutUserUseCase(repository: getIt.call()));
  getIt
      .registerLazySingleton(() => SignUpUserUseCase(repository: getIt.call()));

  // Chat
  getIt
      .registerLazySingleton(() => CreateChatUseCase(repository: getIt.call()));
  getIt.registerLazySingleton(
      () => DeleteChatsUseCase(repository: getIt.call()));
  getIt.registerLazySingleton(() => GetChatsUseCase(repository: getIt.call()));

  // Comment
  getIt.registerLazySingleton(
      () => CreateCommentUseCase(repository: getIt.call()));
  getIt.registerLazySingleton(
      () => DeleteCommentUseCase(repository: getIt.call()));
  getIt.registerLazySingleton(
      () => EditCommentUseCase(repository: getIt.call()));
  getIt.registerLazySingleton(
      () => GetCommentsUseCase(repository: getIt.call()));
  getIt.registerLazySingleton(
      () => LikeCommentUseCase(repository: getIt.call()));

  // Message
  getIt.registerLazySingleton(
      () => CreateMessageUseCase(repository: getIt.call()));
  getIt.registerLazySingleton(
      () => DeleteAllMessagesUseCase(repository: getIt.call()));
  getIt.registerLazySingleton(
      () => DeleteMessagesUseCase(repository: getIt.call()));
  getIt.registerLazySingleton(
      () => GetMessagesUseCase(repository: getIt.call()));

  // Post
  getIt
      .registerLazySingleton(() => CreatePostUseCase(repository: getIt.call()));
  getIt.registerLazySingleton(() => GetPostsUseCase(repository: getIt.call()));
  getIt.registerLazySingleton(
      () => GetUserPostsUseCase(repository: getIt.call()));
  getIt.registerLazySingleton(() => LikePostUseCase(repository: getIt.call()));

  // Reply
  getIt.registerLazySingleton(
      () => CreateReplyUseCase(repository: getIt.call()));
  getIt.registerLazySingleton(
      () => DeleteReplyUseCase(repository: getIt.call()));
  getIt.registerLazySingleton(() => EditReplyUseCase(repository: getIt.call()));
  getIt
      .registerLazySingleton(() => GetRepliesUseCase(repository: getIt.call()));
  getIt.registerLazySingleton(() => LikeReplyUseCase(repository: getIt.call()));

  // User
  getIt
      .registerLazySingleton(() => FollowUserUseCase(repository: getIt.call()));
  getIt.registerLazySingleton(
      () => GetFollowersUserUseCase(repository: getIt.call()));
  getIt.registerLazySingleton(
      () => GetFollowingUserUseCase(repository: getIt.call()));
  getIt.registerLazySingleton(
      () => GetUserDetailUseCase(repository: getIt.call()));
  getIt
      .registerLazySingleton(() => SetProfileUseCase(repository: getIt.call()));
  getIt.registerLazySingleton(
      () => SetProfileImageUseCase(repository: getIt.call()));
  getIt.registerLazySingleton(
      () => SetUsernameUseCase(repository: getIt.call()));
}
