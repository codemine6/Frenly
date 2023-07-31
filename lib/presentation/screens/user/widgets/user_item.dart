import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frenly/domain/entities/user_entity.dart';
import 'package:frenly/presentation/cubit/user/user_cubit.dart';
import 'package:go_router/go_router.dart';

class UserItem extends StatefulWidget {
  final UserEntity user;

  const UserItem({super.key, required this.user});

  @override
  State<UserItem> createState() => _UserItemState();
}

class _UserItemState extends State<UserItem> {
  var followed = false;

  @override
  void initState() {
    followed = widget.user.followed ?? false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: NetworkImage(widget.user.profileImage!),
          radius: 24,
        ),
        title: Text('${widget.user.name}'),
        subtitle: Text(
          '@${widget.user.username}',
          style: TextStyle(color: Theme.of(context).disabledColor),
        ),
        trailing: InkWell(
          onTap: () {
            context
                .read<UserCubit>()
                .followUser(UserEntity(id: widget.user.id));
            setState(() {
              followed = !followed;
            });
          },
          borderRadius: BorderRadius.circular(4),
          child: Ink(
            padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 6),
            decoration: BoxDecoration(
              color: followed
                  ? Theme.of(context).canvasColor
                  : Theme.of(context).primaryColor,
              border: Border.all(color: Theme.of(context).primaryColor),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              followed ? 'Unfollow' : 'Follow',
              style: TextStyle(
                color: followed
                    ? Theme.of(context).primaryColor
                    : Theme.of(context).canvasColor,
              ),
            ),
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 24),
      ),
      onTap: () {
        context.push('/user_detail/${widget.user.id}');
      },
    );
  }
}
