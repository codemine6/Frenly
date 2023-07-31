import 'package:flutter/material.dart';
import 'package:frenly/presentation/screens/auth/sign_in_screen.dart';
import 'package:frenly/presentation/screens/auth/sign_up_screen.dart';
import 'package:frenly/presentation/screens/chat/chats_screen.dart';
import 'package:frenly/presentation/screens/chat/messages_screen.dart';
import 'package:frenly/presentation/screens/comment/post_comments_screen.dart';
import 'package:frenly/presentation/screens/home/home_screen.dart';
import 'package:frenly/presentation/screens/post/create_post_screen.dart';
import 'package:frenly/presentation/screens/user/edit_profile_screen.dart';
import 'package:frenly/presentation/screens/user/followers_screen.dart';
import 'package:frenly/presentation/screens/user/following_screen.dart';
import 'package:frenly/presentation/screens/user/profile_screen.dart';
import 'package:frenly/presentation/screens/user/set_username_screen.dart';
import 'package:frenly/presentation/screens/user/user_detail_screen.dart';
import 'package:frenly/presentation/widgets/custom_bottom_bar.dart';
import 'package:frenly/utils/constants.dart';
import 'package:go_router/go_router.dart';

final routes = [
  ShellRoute(
    builder: (context, state, child) {
      return Scaffold(
        body: child,
        bottomNavigationBar: const CustomBottomBar(),
      );
    },
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const HomeScreen(),
      ),
    ],
  ),
  GoRoute(
    path: '/sign_in',
    builder: (context, state) => const SignInScreen(),
  ),
  GoRoute(
    path: '/sign_up',
    builder: (context, state) => const SignUpScreen(),
  ),
  GoRoute(
    path: '/chats',
    builder: (context, state) => const ChatsScreen(),
    parentNavigatorKey: rootNavigatorKey,
  ),
  GoRoute(
    path: '/messages/:userId',
    builder: (context, state) =>
        MessagesScreen(userId: state.params['userId']!),
    parentNavigatorKey: rootNavigatorKey,
  ),
  GoRoute(
    path: '/create_post',
    builder: (context, state) => const CreatePostScreen(),
    parentNavigatorKey: rootNavigatorKey,
  ),
  GoRoute(
    path: '/post/:postId/comments',
    builder: (context, state) =>
        PostCommentsScreen(postId: state.params['postId']!),
    parentNavigatorKey: rootNavigatorKey,
  ),
  GoRoute(
    path: '/edit_profile',
    builder: (context, state) => const EditProfileScreen(),
    parentNavigatorKey: rootNavigatorKey,
  ),
  GoRoute(
    path: '/followers/:userId',
    builder: (context, state) =>
        FollowersScreen(userId: state.params['userId']!),
    parentNavigatorKey: rootNavigatorKey,
  ),
  GoRoute(
    path: '/following/:userId',
    builder: (context, state) =>
        FollowingScreen(userId: state.params['userId']!),
    parentNavigatorKey: rootNavigatorKey,
  ),
  GoRoute(
    path: '/profile',
    builder: (context, state) => const ProfileScreen(),
  ),
  GoRoute(
    path: '/set_username',
    builder: (context, state) => const SetUsernameScreen(),
  ),
  GoRoute(
    path: '/user_detail/:userId',
    builder: (context, state) =>
        UserDetailScreen(userId: state.params['userId']!),
    parentNavigatorKey: rootNavigatorKey,
  ),
];
