import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frenly/domain/entities/user_entity.dart';
import 'package:frenly/presentation/cubit/auth/auth_cubit.dart';
import 'package:frenly/presentation/cubit/auth/auth_state.dart';
import 'package:frenly/presentation/cubit/user/user_cubit.dart';
import 'package:frenly/presentation/cubit/user/user_state.dart';
import 'package:frenly/presentation/cubit/user_posts/user_posts_cubit.dart';
import 'package:frenly/presentation/cubit/user_posts/user_posts_state.dart';
import 'package:frenly/presentation/screens/user/widgets/posts_grid.dart';
import 'package:frenly/presentation/screens/user/widgets/user_info.dart';
import 'package:go_router/go_router.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    final auth = context.read<AuthCubit>().state as Authenticated;
    context.read<UserCubit>().getUserDetail(UserEntity(id: auth.user.id));
    context.read<UserPostsCubit>().getUserPosts(UserEntity(id: auth.user.id));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final userState = context.watch<UserCubit>().state;
    final postsState = context.watch<UserPostsCubit>().state;

    if (userState is UserLoaded) {
      return Scaffold(
        appBar: AppBar(
          title: Text('@${userState.user.username}'),
          actions: [
            PopupMenuButton(
              itemBuilder: (context) {
                return [
                  PopupMenuItem(
                    onTap: () => context.push('/edit_profile'),
                    child: const Text('Edit Profile'),
                  ),
                ];
              },
            ),
          ],
        ),
        body: CustomScrollView(
          slivers: [
            UserInfo(user: userState.user),
            if (postsState is UserPostsLoaded)
              PostsGrid(posts: postsState.posts),
          ],
        ),
      );
    } else {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
  }
}
