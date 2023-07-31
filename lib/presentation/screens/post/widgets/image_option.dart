import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class ImageOption extends StatelessWidget {
  final Function() pickCamera;
  final Function() pickGallery;

  const ImageOption({
    super.key,
    required this.pickCamera,
    required this.pickGallery,
  });

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
                onTap: () {
                  Navigator.pop(context);
                  pickCamera();
                },
                borderRadius: BorderRadius.circular(8),
                child: Column(
                  children: [
                    Icon(
                      Ionicons.camera_outline,
                      size: 28,
                      color: Theme.of(context).primaryColor,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Camera',
                      style: TextStyle(color: Theme.of(context).primaryColor),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 24),
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                  pickGallery();
                },
                borderRadius: BorderRadius.circular(8),
                child: Column(
                  children: [
                    Icon(
                      Ionicons.images_outline,
                      size: 28,
                      color: Theme.of(context).primaryColor,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Gallery',
                      style: TextStyle(color: Theme.of(context).primaryColor),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
