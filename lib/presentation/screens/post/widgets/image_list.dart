import 'dart:io';

import 'package:flutter/material.dart';
import 'package:frenly/presentation/screens/post/widgets/image_option.dart';
import 'package:ionicons/ionicons.dart';

class ImageList extends StatelessWidget {
  final List<File> images;
  final Function() pickCamera;
  final Function() pickGallery;
  final Function(File image) removeImage;

  const ImageList({
    super.key,
    required this.images,
    required this.pickCamera,
    required this.pickGallery,
    required this.removeImage,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 78,
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Theme.of(context).primaryColor),
              borderRadius: BorderRadius.circular(8),
            ),
            width: 70,
            height: 70,
            margin: const EdgeInsets.only(top: 8),
            child: InkWell(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return ImageOption(
                      pickCamera: pickCamera,
                      pickGallery: pickGallery,
                    );
                  },
                );
              },
              borderRadius: BorderRadius.circular(8),
              child: Icon(
                Ionicons.image_outline,
                size: 32,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Stack(
                  alignment: Alignment.topRight,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 8, right: 8),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: AspectRatio(
                          aspectRatio: 4 / 3,
                          child: Image.file(
                            images[index],
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Material(
                      shape: const CircleBorder(),
                      child: InkWell(
                        onTap: () => removeImage(images[index]),
                        borderRadius: BorderRadius.circular(24),
                        child: const Icon(
                          Ionicons.close_circle_outline,
                          size: 18,
                        ),
                      ),
                    ),
                  ],
                );
              },
              separatorBuilder: (context, index) {
                return const SizedBox(width: 4);
              },
              itemCount: images.length,
            ),
          ),
        ],
      ),
    );
  }
}
