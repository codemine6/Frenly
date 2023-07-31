import 'package:flutter/material.dart';
import 'package:frenly/domain/entities/post_entity.dart';

class PostsGrid extends StatelessWidget {
  final List<PostEntity> posts;

  const PostsGrid({super.key, required this.posts});

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.all(28),
      sliver: SliverGrid(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: Image.network(
                posts[index].images![0],
                fit: BoxFit.cover,
              ),
            );
          },
          childCount: posts.length,
        ),
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 150,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
        ),
      ),
    );
  }
}
