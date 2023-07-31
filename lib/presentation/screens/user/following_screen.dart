import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frenly/domain/entities/user_entity.dart';
import 'package:frenly/presentation/cubit/users/users_cubit.dart';
import 'package:frenly/presentation/cubit/users/users_state.dart';
import 'package:frenly/presentation/screens/user/widgets/user_item.dart';

class FollowingScreen extends StatefulWidget {
  final String userId;

  const FollowingScreen({super.key, required this.userId});

  @override
  State<FollowingScreen> createState() => _FollowingScreenState();
}

class _FollowingScreenState extends State<FollowingScreen> {
  @override
  void initState() {
    context.read<UsersCubit>().getFollowingUser(UserEntity(id: widget.userId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Following'),
      ),
      body: BlocBuilder<UsersCubit, UsersState>(
        builder: (context, state) {
          if (state is UsersLoaded) {
            return ListView.builder(
              itemBuilder: (context, index) {
                return UserItem(user: state.users[index]);
              },
              itemCount: state.users.length,
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
