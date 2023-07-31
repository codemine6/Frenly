import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frenly/presentation/cubit/auth/auth_cubit.dart';
import 'package:frenly/presentation/cubit/auth/auth_state.dart';
import 'package:frenly/presentation/cubit/chat/chat_cubit.dart';
import 'package:frenly/presentation/cubit/chats/chats_cubit.dart';
import 'package:frenly/presentation/cubit/comment/comment_cubit.dart';
import 'package:frenly/presentation/cubit/comments/comments_cubit.dart';
import 'package:frenly/presentation/cubit/message/message_cubit.dart';
import 'package:frenly/presentation/cubit/post/post_cubit.dart';
import 'package:frenly/presentation/cubit/posts/posts_cubit.dart';
import 'package:frenly/presentation/cubit/profile/profile_cubit.dart';
import 'package:frenly/presentation/cubit/reply/reply_cubit.dart';
import 'package:frenly/presentation/cubit/user/user_cubit.dart';
import 'package:frenly/presentation/cubit/user_posts/user_posts_cubit.dart';
import 'package:frenly/presentation/cubit/users/users_cubit.dart';
import 'package:frenly/utils/constants.dart';
import 'package:frenly/utils/custom_theme.dart';
import 'package:frenly/di/injection.dart' as di;
import 'package:frenly/utils/notification_services.dart';
import 'package:frenly/utils/routes.dart';
import 'package:go_router/go_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FlutterError.onError = (details) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(details);
  };
  NotificationServices().init();
  di.setup();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => di.getIt<AuthCubit>()..getAuthStatus(),
        ),
        BlocProvider(
          create: (context) => di.getIt<ChatCubit>(),
        ),
        BlocProvider(
          create: (context) => di.getIt<ChatsCubit>(),
        ),
        BlocProvider(
          create: (context) => di.getIt<CommentCubit>(),
        ),
        BlocProvider(
          create: (context) => di.getIt<CommentsCubit>(),
        ),
        BlocProvider(
          create: (context) => di.getIt<MessageCubit>(),
        ),
        BlocProvider(
          create: (context) => di.getIt<PostCubit>(),
        ),
        BlocProvider(
          create: (context) => di.getIt<PostsCubit>(),
        ),
        BlocProvider(
          create: (context) => di.getIt<ProfileCubit>(),
        ),
        BlocProvider(
          create: (context) => di.getIt<ReplyCubit>(),
        ),
        BlocProvider(
          create: (context) => di.getIt<UserCubit>(),
        ),
        BlocProvider(
          create: (context) => di.getIt<UserPostsCubit>(),
        ),
        BlocProvider(
          create: (context) => di.getIt<UsersCubit>(),
        ),
      ],
      child: BlocConsumer<AuthCubit, AuthState>(
        builder: (context, state) {
          if (state is AuthInitial) {
            return const SizedBox();
          } else {
            return MaterialApp.router(
              routerConfig: GoRouter(
                routes: routes,
                initialLocation: state is Authenticated ? '/' : '/sign_in',
                navigatorKey: rootNavigatorKey,
              ),
              theme: customTheme,
              debugShowCheckedModeBanner: false,
            );
          }
        },
        listener: (context, state) {},
        buildWhen: (previous, current) {
          if (current is Authenticated || current is UnAuthenticated) {
            return true;
          }
          return false;
        },
      ),
    );
  }
}
