import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class MessageAttachment extends StatelessWidget {
  const MessageAttachment({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).focusColor,
              borderRadius: BorderRadius.circular(4),
            ),
            width: 48,
            height: 4,
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              InkWell(
                child: Icon(
                  Ionicons.camera_outline,
                  size: 32,
                  color: Theme.of(context).primaryColor,
                ),
                onTap: () {},
              ),
              const SizedBox(width: 24),
              InkWell(
                child: Icon(
                  Ionicons.images_outline,
                  size: 32,
                  color: Theme.of(context).primaryColor,
                ),
                onTap: () {},
              ),
              const SizedBox(width: 24),
              InkWell(
                child: Icon(
                  Ionicons.folder_open_outline,
                  size: 32,
                  color: Theme.of(context).primaryColor,
                ),
                onTap: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}
