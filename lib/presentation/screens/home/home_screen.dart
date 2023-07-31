import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:frenly/presentation/cubit/posts/posts_cubit.dart';
import 'package:frenly/presentation/cubit/posts/posts_state.dart';
import 'package:frenly/presentation/screens/home/widgets/home_drawer.dart';
import 'package:frenly/presentation/widgets/post_item.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    context.read<PostsCubit>().getPosts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Frenly'),
        actions: [
          IconButton(
            onPressed: () => context.push('/create_post'),
            icon: const Icon(FeatherIcons.plusCircle),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(FeatherIcons.bell),
          ),
        ],
      ),
      body: Column(
        children: [
          BlocBuilder<PostsCubit, PostsState>(
            builder: (context, state) {
              if (state is PostsLoaded) {
                return Expanded(
                  child: ListView.separated(
                    itemBuilder: (context, index) {
                      return PostItem(post: state.posts[index]);
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(height: 24);
                    },
                    itemCount: state.posts.length,
                  ),
                );
              } else {
                return const SizedBox();
              }
            },
          ),
        ],
      ),
      drawer: const HomeDrawer(),
    );
  }
}
