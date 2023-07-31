import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:frenly/domain/entities/user_entity.dart';
import 'package:frenly/presentation/cubit/auth/auth_cubit.dart';
import 'package:frenly/presentation/cubit/auth/auth_state.dart';
import 'package:frenly/presentation/widgets/custom_button.dart';
import 'package:go_router/go_router.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();
  var obscurePassword = true;
  var obscureConfirmPassword = true;

  @override
  void initState() {
    nameController.text = 'Jonathan Smith';
    emailController.text = 'jonathan@mail.com';
    passwordController.text = 'qwerty';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(36),
          child: Column(
            children: [
              const Text(
                'Create Account',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Please Sign Up to start exploring.',
                style: TextStyle(color: Theme.of(context).disabledColor),
              ),
              const SizedBox(height: 48),
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  hintText: 'Name',
                  prefixIcon: Icon(
                    FeatherIcons.user,
                    size: 20,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              TextField(
                controller: emailController,
                decoration: const InputDecoration(
                  hintText: 'Email',
                  prefixIcon: Icon(
                    FeatherIcons.mail,
                    size: 20,
                  ),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 24),
              TextField(
                controller: passwordController,
                decoration: InputDecoration(
                  hintText: 'Password',
                  prefixIcon: const Icon(
                    FeatherIcons.lock,
                    size: 20,
                  ),
                  suffixIcon: InkWell(
                    child: Icon(
                      obscurePassword ? FeatherIcons.eye : FeatherIcons.eyeOff,
                      size: 20,
                    ),
                    onTap: () {
                      setState(() {
                        obscurePassword = !obscurePassword;
                      });
                    },
                  ),
                ),
                obscureText: obscurePassword,
              ),
              const SizedBox(height: 24),
              TextField(
                controller: confirmPasswordController,
                decoration: InputDecoration(
                  hintText: 'Confirm Password',
                  prefixIcon: const Icon(
                    FeatherIcons.lock,
                    size: 20,
                  ),
                  suffixIcon: InkWell(
                    child: Icon(
                      obscureConfirmPassword
                          ? FeatherIcons.eye
                          : FeatherIcons.eyeOff,
                      size: 20,
                    ),
                    onTap: () {
                      setState(() {
                        obscureConfirmPassword = !obscureConfirmPassword;
                      });
                    },
                  ),
                ),
                obscureText: obscureConfirmPassword,
              ),
              const SizedBox(height: 48),
              BlocConsumer<AuthCubit, AuthState>(
                builder: (context, state) {
                  return CustomButton(
                    onPressed: () {
                      context.read<AuthCubit>().signUpUser(UserEntity(
                            email: emailController.text,
                            name: nameController.text,
                            password: passwordController.text,
                          ));
                    },
                    text: 'Sign Up',
                    loading: state is AuthLoading,
                  );
                },
                listener: (context, state) {
                  if (state is AuthFailure) {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text(state.message)));
                  } else if (state is AuthCreated) {
                    context.go('/set_username');
                  }
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Already have account?'),
                  TextButton(
                    onPressed: () => context.go('/sign_in'),
                    child: const Text('Sign In'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
