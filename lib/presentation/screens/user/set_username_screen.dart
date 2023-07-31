import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:frenly/domain/entities/user_entity.dart';
import 'package:frenly/presentation/cubit/profile/profile_cubit.dart';
import 'package:frenly/presentation/cubit/profile/profile_state.dart';
import 'package:frenly/presentation/widgets/custom_button.dart';
import 'package:go_router/go_router.dart';

class SetUsernameScreen extends StatefulWidget {
  const SetUsernameScreen({super.key});

  @override
  State<SetUsernameScreen> createState() => _SetUsernameScreenState();
}

class _SetUsernameScreenState extends State<SetUsernameScreen> {
  var usernameController = TextEditingController();

  @override
  void initState() {
    usernameController.text = 'jonat21';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(36),
        child: Column(
          children: [
            const SizedBox(height: 36),
            const Text(
              'Set username',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Add unique username, so people can find you.',
              style: TextStyle(color: Theme.of(context).disabledColor),
            ),
            const SizedBox(height: 24),
            TextField(
              controller: usernameController,
              decoration: const InputDecoration(
                prefixIcon: Icon(
                  FeatherIcons.atSign,
                  size: 20,
                ),
              ),
            ),
            const Spacer(),
            BlocConsumer<ProfileCubit, ProfileState>(
              builder: (context, state) {
                return CustomButton(
                  onPressed: () {
                    context.read<ProfileCubit>().setUsername(
                        UserEntity(username: usernameController.text));
                  },
                  text: 'Next',
                  loading: state is ProfileLoading,
                );
              },
              listener: (context, state) {
                if (state is ProfileFailure) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text(state.message)));
                } else if (state is ProfileUpdated) {
                  context.go('/');
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
