import 'package:carousel_slider/carousel_slider.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:frenly/domain/entities/post_entity.dart';
import 'package:frenly/presentation/cubit/auth/auth_cubit.dart';
import 'package:frenly/presentation/cubit/auth/auth_state.dart';
import 'package:frenly/presentation/cubit/post/post_cubit.dart';
import 'package:go_router/go_router.dart';
import 'package:ionicons/ionicons.dart';

class PostItem extends StatefulWidget {
  final PostEntity post;

  const PostItem({super.key, required this.post});

  @override
  State<PostItem> createState() => _PostItemState();
}

class _PostItemState extends State<PostItem> {
  var currentImage = 0;
  var likeCount = 0;
  var liked = false;

  @override
  void initState() {
    likeCount = widget.post.likeCount!;
    liked = widget.post.liked!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final auth = context.read<AuthCubit>().state as Authenticated;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(widget.post.authorProfileImage!),
            ),
            title: GestureDetector(
              child: Text('${widget.post.authorName}'),
              onTap: () {
                if (auth.user.id == widget.post.authorId) {
                  context.push('/profile');
                } else {
                  context.push('/user_detail/${widget.post.authorId}');
                }
              },
            ),
            subtitle: Text(
              formatDate(
                  widget.post.createdAt!.toDate(), [d, ' ', MM, ' ', yyyy]),
              style: TextStyle(
                color: Theme.of(context).disabledColor,
                fontSize: 12,
              ),
            ),
            contentPadding: EdgeInsets.zero,
          ),
          Stack(
            alignment: Alignment.bottomCenter,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: CarouselSlider.builder(
                  itemCount: widget.post.images?.length,
                  itemBuilder: (context, index, realIndex) {
                    return Image.network(
                      widget.post.images![index],
                      fit: BoxFit.cover,
                    );
                  },
                  options: CarouselOptions(
                    aspectRatio: 4 / 3,
                    viewportFraction: 1,
                    onPageChanged: (index, reason) {
                      setState(() {
                        currentImage = index;
                      });
                    },
                    scrollPhysics: widget.post.images!.length > 1
                        ? const AlwaysScrollableScrollPhysics()
                        : const NeverScrollableScrollPhysics(),
                  ),
                ),
              ),
              if (widget.post.images!.length > 1)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: widget.post.images!.asMap().entries.map((e) {
                    return Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor.withOpacity(
                              currentImage == e.key ? 1 : .3,
                            ),
                        shape: BoxShape.circle,
                      ),
                      width: 8,
                      height: 8,
                      margin: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 2),
                    );
                  }).toList(),
                ),
            ],
          ),
          const SizedBox(height: 8),
          Text('${widget.post.description}'),
          const SizedBox(height: 8),
          Row(
            children: [
              InkWell(
                child: Icon(liked ? Ionicons.heart : Ionicons.heart_outline),
                onTap: () {
                  context
                      .read<PostCubit>()
                      .likePost(PostEntity(id: widget.post.id));
                  setState(() {
                    liked ? likeCount-- : likeCount++;
                    liked = !liked;
                  });
                },
              ),
              const SizedBox(width: 4),
              Text(
                '$likeCount',
                style: const TextStyle(fontSize: 12),
              ),
              const SizedBox(width: 8),
              InkWell(
                child: const Icon(FeatherIcons.messageCircle),
                onTap: () => context.push('/post/${widget.post.id}/comments'),
              ),
              const SizedBox(width: 4),
              Text(
                '${widget.post.commentCount}',
                style: const TextStyle(fontSize: 12),
              ),
              const Spacer(),
              InkWell(
                child: Icon(FeatherIcons.bookmark),
                onTap: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}
