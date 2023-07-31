import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:frenly/domain/entities/user_entity.dart';
import 'package:frenly/presentation/cubit/profile/profile_cubit.dart';
import 'package:frenly/presentation/cubit/profile/profile_state.dart';
import 'package:frenly/presentation/screens/user/widgets/image_crop.dart';
import 'package:image_picker/image_picker.dart';

class SetProfileImage extends StatelessWidget {
  final String url;

  const SetProfileImage({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    pickImage() async {
      try {
        final file = await ImagePicker().pickImage(
          source: ImageSource.gallery,
          maxWidth: 512,
          maxHeight: 512,
        );
        return file != null ? File(file.path) : null;
      } catch (_) {
        return null;
      }
    }

    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        CircleAvatar(
          backgroundImage: NetworkImage(url),
          radius: 56,
        ),
        BlocBuilder<ProfileCubit, ProfileState>(
          builder: (context, state) {
            if (state is ProfileImageUploading) {
              return SizedBox(
                width: 112,
                height: 112,
                child: CircularProgressIndicator(value: state.progress),
              );
            } else {
              return const SizedBox();
            }
          },
        ),
        Material(
          shape: const CircleBorder(),
          child: InkWell(
            onTap: () async {
              File? img = await pickImage();
              if (context.mounted && img != null) {
                showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return ImageCrop(
                      image: img.readAsBytesSync(),
                      onCropped: (image) {
                        context.read<ProfileCubit>().setProfileImage(
                            UserEntity(profileImageFile: image));
                        Navigator.pop(context);
                      },
                    );
                  },
                  enableDrag: false,
                );
              }
            },
            borderRadius: BorderRadius.circular(24),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Icon(
                FeatherIcons.camera,
                size: 16,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
