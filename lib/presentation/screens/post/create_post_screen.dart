import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frenly/domain/entities/post_entity.dart';
import 'package:frenly/presentation/cubit/post/post_cubit.dart';
import 'package:frenly/presentation/cubit/post/post_state.dart';
import 'package:frenly/presentation/screens/post/widgets/image_list.dart';
import 'package:frenly/presentation/widgets/custom_button.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

class CreatePostScreen extends StatefulWidget {
  const CreatePostScreen({super.key});

  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  var descriptionController = TextEditingController();
  List<File> images = [];

  pickCamera() async {
    try {
      final file = await ImagePicker().pickImage(
        source: ImageSource.camera,
        maxWidth: 512,
        maxHeight: 384,
      );
      if (file != null) {
        setState(() {
          images.add(File(file.path));
        });
      }
    } catch (_) {}
  }

  pickGallery() async {
    try {
      final files = await ImagePicker().pickMultiImage(
        maxWidth: 512,
        maxHeight: 384,
      );
      final imagesFile = files.map((e) => File(e.path));
      setState(() {
        images = [...images, ...imagesFile];
      });
    } catch (_) {}
  }

  @override
  void initState() {
    descriptionController.text = 'Have a nice day to meet you..';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(
                hintText: 'Description',
                contentPadding: EdgeInsets.all(18),
              ),
              maxLines: 5,
            ),
            const SizedBox(height: 18),
            ImageList(
              images: images,
              pickCamera: pickCamera,
              pickGallery: pickGallery,
              removeImage: (image) {
                setState(() {
                  images.remove(image);
                });
              },
            ),
            const Spacer(),
            BlocConsumer<PostCubit, PostState>(
              builder: (context, state) {
                return CustomButton(
                  onPressed: () {
                    context.read<PostCubit>().createPost(PostEntity(
                          description: descriptionController.text,
                          images: images,
                        ));
                  },
                  text: 'Create',
                  loading: state is PostLoading,
                );
              },
              listener: (context, state) {
                if (state is PostCreated) {
                  context.pop();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
