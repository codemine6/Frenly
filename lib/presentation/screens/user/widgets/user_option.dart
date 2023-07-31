import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frenly/domain/entities/user_entity.dart';
import 'package:frenly/presentation/cubit/user/user_cubit.dart';
import 'package:go_router/go_router.dart';
import 'package:ionicons/ionicons.dart';

class UserOption extends StatefulWidget {
  final UserEntity user;

  const UserOption({super.key, required this.user});

  @override
  State<UserOption> createState() => _UserOptionState();
}

class _UserOptionState extends State<UserOption> {
  var followed = false;

  @override
  void initState() {
    followed = widget.user.followed!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 36),
        child: Row(
          children: [
            InkWell(
              onTap: () {
                context
                    .read<UserCubit>()
                    .followUser(UserEntity(id: widget.user.id));
                setState(() {
                  followed = !followed;
                });
              },
              borderRadius: BorderRadius.circular(8),
              child: Ink(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Icon(
                      followed
                          ? Ionicons.person_remove_outline
                          : Ionicons.person_add_outline,
                      size: 16,
                      color: Theme.of(context).canvasColor,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      followed ? 'Unfollow' : 'Follow',
                      style: TextStyle(color: Theme.of(context).canvasColor),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 8),
            InkWell(
              onTap: () => context.push('/messages/${widget.user.id}'),
              borderRadius: BorderRadius.circular(8),
              child: Ink(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                decoration: BoxDecoration(
                  border: Border.all(color: Theme.of(context).primaryColor),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Icon(
                      Ionicons.chatbubble_ellipses,
                      size: 16,
                      color: Theme.of(context).primaryColor,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Message',
                      style: TextStyle(color: Theme.of(context).primaryColor),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
