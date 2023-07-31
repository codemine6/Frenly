import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frenly/domain/entities/user_entity.dart';
import 'package:frenly/presentation/cubit/user/user_cubit.dart';
import 'package:frenly/presentation/cubit/user/user_state.dart';
import 'package:frenly/presentation/cubit/user_posts/user_posts_cubit.dart';
import 'package:frenly/presentation/cubit/user_posts/user_posts_state.dart';
import 'package:frenly/presentation/screens/user/widgets/posts_grid.dart';
import 'package:frenly/presentation/screens/user/widgets/user_info.dart';
import 'package:frenly/presentation/screens/user/widgets/user_option.dart';

class UserDetailScreen extends StatefulWidget {
  final String userId;

  const UserDetailScreen({super.key, required this.userId});

  @override
  State<UserDetailScreen> createState() => _UserDetailScreenState();
}

class _UserDetailScreenState extends State<UserDetailScreen> {
  @override
  void initState() {
    context.read<UserCubit>().getUserDetail(UserEntity(id: widget.userId));
    context.read<UserPostsCubit>().getUserPosts(UserEntity(id: widget.userId));
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
        ),
        body: CustomScrollView(
          slivers: [
            UserInfo(user: userState.user),
            UserOption(user: userState.user),
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
