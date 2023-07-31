import 'package:frenly/presentation/cubit/auth/auth_cubit.dart';
import 'package:frenly/presentation/cubit/chat/chat_cubit.dart';
import 'package:frenly/presentation/cubit/chats/chats_cubit.dart';
import 'package:frenly/presentation/cubit/comment/comment_cubit.dart';
import 'package:frenly/presentation/cubit/comments/comments_cubit.dart';
import 'package:frenly/presentation/cubit/message/message_cubit.dart';
import 'package:frenly/presentation/cubit/messages/messages_cubit.dart';
import 'package:frenly/presentation/cubit/post/post_cubit.dart';
import 'package:frenly/presentation/cubit/posts/posts_cubit.dart';
import 'package:frenly/presentation/cubit/profile/profile_cubit.dart';
import 'package:frenly/presentation/cubit/replies/replies_cubit.dart';
import 'package:frenly/presentation/cubit/reply/reply_cubit.dart';
import 'package:frenly/presentation/cubit/user/user_cubit.dart';
import 'package:frenly/presentation/cubit/user_posts/user_posts_cubit.dart';
import 'package:frenly/presentation/cubit/users/users_cubit.dart';
import 'package:get_it/get_it.dart';

registerCubit(GetIt getIt) {
  getIt.registerFactory(() => AuthCubit(
        getAuthStatusUseCase: getIt.call(),
        signInUserUseCase: getIt.call(),
        signOutUserUseCase: getIt.call(),
        signUpUserUseCase: getIt.call(),
      ));
  getIt.registerFactory(() => ChatCubit(
        createChatUseCase: getIt.call(),
        deleteChatsUseCase: getIt.call(),
      ));
  getIt.registerFactory(() => ChatsCubit(
        getChatsUseCase: getIt.call(),
      ));
  getIt.registerFactory(() => CommentCubit(
        createCommentUseCase: getIt.call(),
        deleteCommentUseCase: getIt.call(),
        editCommentUseCase: getIt.call(),
        likeCommentUseCase: getIt.call(),
      ));
  getIt.registerFactory(() => CommentsCubit(
        getCommentsUseCase: getIt.call(),
      ));
  getIt.registerFactory(() => MessageCubit(
        createMessageUseCase: getIt.call(),
        deleteAllMessagesUseCase: getIt.call(),
        deleteMessagesUseCase: getIt.call(),
      ));
  getIt.registerFactory(() => MessagesCubit(
        getMessagesUseCase: getIt.call(),
      ));
  getIt.registerFactory(() => PostCubit(
        createPostUseCase: getIt.call(),
        likePostUseCase: getIt.call(),
      ));
  getIt.registerFactory(() => PostsCubit(
        getPostsUseCase: getIt.call(),
      ));
  getIt.registerFactory(() => ProfileCubit(
        setProfileUseCase: getIt.call(),
        setProfileImageUseCase: getIt.call(),
        setUsernameUseCase: getIt.call(),
      ));
  getIt.registerFactory(() => RepliesCubit(
        getRepliesUseCase: getIt.call(),
      ));
  getIt.registerFactory(() => ReplyCubit(
        createReplyUseCase: getIt.call(),
        deleteReplyUseCase: getIt.call(),
        editReplyUseCase: getIt.call(),
        likeReplyUseCase: getIt.call(),
      ));
  getIt.registerFactory(() => UserCubit(
        followUserUseCase: getIt.call(),
        getUserDetailUseCase: getIt.call(),
      ));
  getIt.registerFactory(() => UserPostsCubit(
        getUserPostsUseCase: getIt.call(),
      ));
  getIt.registerFactory(() => UsersCubit(
        getFollowersUserUseCase: getIt.call(),
        getFollowingUserUseCase: getIt.call(),
      ));
}
