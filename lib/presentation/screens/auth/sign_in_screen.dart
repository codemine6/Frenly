import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:frenly/domain/entities/user_entity.dart';
import 'package:frenly/presentation/cubit/auth/auth_cubit.dart';
import 'package:frenly/presentation/cubit/auth/auth_state.dart';
import 'package:frenly/presentation/widgets/custom_button.dart';
import 'package:go_router/go_router.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var obscurePassword = true;

  @override
  void initState() {
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
                'Welcome Back',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Please Sign In with your account.',
                style: TextStyle(color: Theme.of(context).disabledColor),
              ),
              const SizedBox(height: 48),
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
              const SizedBox(height: 48),
              BlocConsumer<AuthCubit, AuthState>(
                builder: (context, state) {
                  return CustomButton(
                    onPressed: () {
                      context.read<AuthCubit>().signInUser(UserEntity(
                            email: emailController.text,
                            password: passwordController.text,
                          ));
                    },
                    text: 'Sign In',
                    loading: state is AuthLoading,
                  );
                },
                listener: (context, state) {
                  if (state is AuthFailure) {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text(state.message)));
                  }
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Don\'t have an account?'),
                  TextButton(
                    onPressed: () => context.go('/sign_up'),
                    child: const Text('Sign Up'),
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
