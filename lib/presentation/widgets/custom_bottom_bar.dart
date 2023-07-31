import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:frenly/presentation/cubit/chats/chats_cubit.dart';
import 'package:frenly/presentation/cubit/chats/chats_state.dart';
import 'package:go_router/go_router.dart';

class CustomBottomBar extends StatefulWidget {
  const CustomBottomBar({super.key});

  @override
  State<CustomBottomBar> createState() => _CustomBottomBarState();
}

class _CustomBottomBarState extends State<CustomBottomBar> {
  @override
  void initState() {
    context.read<ChatsCubit>().getChats();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final paths = [
      '/',
      '/activity',
      '/search',
      '/chats',
      '/profile',
    ];

    final location = GoRouter.of(context).location;
    final currentIndex = paths.contains(location) ? paths.indexOf(location) : 0;

    return BlocBuilder<ChatsCubit, ChatsState>(
      builder: (context, state) {
        final newMessages = state is ChatsLoaded && state.chats.isNotEmpty
            ? () {
                return state.chats
                    .map((e) => e.messageCount)
                    .reduce((value, element) => value! + element!);
              }()
            : 0;

        return CupertinoTabBar(
          items: [
            const BottomNavigationBarItem(icon: Icon(FeatherIcons.home)),
            const BottomNavigationBarItem(icon: Icon(FeatherIcons.zap)),
            const BottomNavigationBarItem(icon: Icon(FeatherIcons.search)),
            BottomNavigationBarItem(
              icon: Badge(
                label: Text('$newMessages'),
                isLabelVisible: newMessages! > 0,
                child: const Icon(FeatherIcons.messageCircle),
              ),
            ),
            const BottomNavigationBarItem(icon: Icon(FeatherIcons.user)),
          ],
          onTap: (value) => context.push(paths[value]),
          currentIndex: currentIndex,
          activeColor: Theme.of(context).primaryColor,
          iconSize: 26,
        );
      },
    );
  }
}
