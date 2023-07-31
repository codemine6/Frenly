import 'dart:typed_data';

import 'package:crop_your_image/crop_your_image.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class ImageCrop extends StatelessWidget {
  final Uint8List image;
  final Function(Uint8List image) onCropped;

  const ImageCrop({super.key, required this.image, required this.onCropped});

  @override
  Widget build(BuildContext context) {
    final cropController = CropController();

    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).highlightColor,
              borderRadius: BorderRadius.circular(4),
            ),
            width: 48,
            height: 4,
          ),
          const SizedBox(height: 24),
          Expanded(
            child: Crop(
              image: image,
              onCropped: onCropped,
              aspectRatio: 1 / 1,
              withCircleUi: true,
              controller: cropController,
              progressIndicator: const CircularProgressIndicator(),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                onPressed: () => cropController.crop(),
                style: IconButton.styleFrom(
                  foregroundColor: Theme.of(context).canvasColor,
                  backgroundColor: Theme.of(context).primaryColor,
                ),
                icon: const Icon(Ionicons.checkmark),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
