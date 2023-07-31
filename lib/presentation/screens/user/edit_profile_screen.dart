import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:frenly/domain/entities/user_entity.dart';
import 'package:frenly/presentation/cubit/auth/auth_cubit.dart';
import 'package:frenly/presentation/cubit/auth/auth_state.dart';
import 'package:frenly/presentation/cubit/profile/profile_cubit.dart';
import 'package:frenly/presentation/cubit/profile/profile_state.dart';
import 'package:frenly/presentation/screens/user/widgets/set_profile_image.dart';
import 'package:frenly/presentation/widgets/custom_button.dart';
import 'package:go_router/go_router.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  String? profileImage;
  var nameController = TextEditingController();
  var bioController = TextEditingController();

  @override
  void initState() {
    final auth = context.read<AuthCubit>().state as Authenticated;
    profileImage = auth.user.profileImage;
    nameController.text = auth.user.name!;
    bioController.text = auth.user.bio!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final auth = context.read<AuthCubit>().state as Authenticated;

    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(36),
        child: Column(
          children: [
            const Text(
              'Fill your profile',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Complete your profile.',
              style: TextStyle(color: Theme.of(context).disabledColor),
            ),
            const SizedBox(height: 24),
            SetProfileImage(url: profileImage!),
            const SizedBox(height: 36),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Username'),
                const SizedBox(height: 8),
                TextField(
                  decoration: InputDecoration(
                    hintText: '@${auth.user.username}',
                    suffixIcon: InkWell(
                      child: Icon(
                        FeatherIcons.edit3,
                        color: Theme.of(context).primaryColor,
                      ),
                      onTap: () => context.push('/set_username'),
                    ),
                  ),
                  readOnly: true,
                ),
                const SizedBox(height: 16),
                const Text('Name'),
                const SizedBox(height: 8),
                TextField(
                  controller: nameController,
                ),
                const SizedBox(height: 16),
                const Text('Bio'),
                const SizedBox(height: 8),
                TextField(
                  controller: bioController,
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(36),
        child: BlocConsumer<ProfileCubit, ProfileState>(
          builder: (context, state) {
            return CustomButton(
              onPressed: () {
                context.read<ProfileCubit>().setProfile(UserEntity(
                      bio: bioController.text,
                      name: nameController.text,
                    ));
              },
              text: 'Save',
              loading: state is ProfileLoading,
            );
          },
          listener: (context, state) {
            if (state is ProfileImageUploaded) {
              setState(() {
                profileImage = state.url;
              });
            } else if (state is ProfileUpdated) {
              context.read<AuthCubit>().getAuthStatus();
              context.pop();
            }
          },
        ),
      ),
    );
  }
}
