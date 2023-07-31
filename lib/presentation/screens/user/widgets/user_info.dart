import 'package:flutter/material.dart';
import 'package:frenly/domain/entities/user_entity.dart';
import 'package:go_router/go_router.dart';

class UserInfo extends StatelessWidget {
  final UserEntity user;

  const UserInfo({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        children: [
          const SizedBox(height: 24),
          CircleAvatar(
            backgroundImage: NetworkImage(user.profileImage!),
            radius: 56,
          ),
          const SizedBox(height: 16),
          Text(
            '${user.name}',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Text(
            '${user.bio}',
            style: TextStyle(
              color: Theme.of(context).disabledColor,
              fontSize: 13,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: const [
                    Text('459'),
                    Text(
                      'Posts',
                      style: TextStyle(fontSize: 13),
                    ),
                  ],
                ),
                InkWell(
                  child: Column(
                    children: [
                      Text('${user.followersCount}'),
                      const Text(
                        'Followers',
                        style: TextStyle(fontSize: 13),
                      ),
                    ],
                  ),
                  onTap: () {
                    context.push('/followers/${user.id}');
                  },
                ),
                InkWell(
                  child: Column(
                    children: [
                      Text('${user.followingCount}'),
                      const Text(
                        'Following',
                        style: TextStyle(fontSize: 13),
                      ),
                    ],
                  ),
                  onTap: () {
                    context.push('/following/${user.id}');
                  },
                ),
                Column(
                  children: const [
                    Text('909M'),
                    Text(
                      'Likes',
                      style: TextStyle(fontSize: 13),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
