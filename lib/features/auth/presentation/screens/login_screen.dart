import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:todo/config/routes/app_routes.dart';
import 'package:todo/config/theme/app_colors.dart';
import 'package:todo/config/theme/app_styles.dart';
import 'package:todo/core/extensions/context_extension.dart';
import 'package:todo/core/services/get_it_service.dart';
import 'package:todo/core/widgets/custom_button.dart';
import 'package:todo/core/widgets/custom_text_field.dart';
import 'package:todo/core/widgets/password_text_field.dart';
import 'package:todo/features/auth/presentation/cubit/cubit/login_cubit.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<LoginCubit>(),
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(height: 250),

              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          'Login',
                          style: AppStyles.medium25.copyWith(
                            color: AppColors.dark,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      'Welcome back! Please enter your details to login.',
                      style: AppStyles.medium14.copyWith(color: AppColors.grey),
                    ),
                    SizedBox(height: 24),
                    CustomTextField(
                      controller: emailController,
                      label: 'Email',
                      hintText: 'Enter your email',
                    ),
                    SizedBox(height: 16),
                    PasswordTextField(
                      controller: passwordController,
                      labelText: 'Password',
                      hintText: 'Enter your password',
                    ),
                  ],
                ),
              ),
              SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {
                      context.go(AppRoutes.register);
                    },
                    child: Text(
                      'Don\'t have an account? Register',
                      style: AppStyles.medium14.copyWith(color: AppColors.dark),
                    ),
                  ),
                ],
              ),
              BlocConsumer<LoginCubit, LoginState>(
                listener: (context, state) {
                  if (state is LoginSuccess) {
                    context.go(AppRoutes.home);
                  } else if (state is LoginFailure) {
                    context.showSnackBar(state.errorMessage, isSuccess: false);
                  }
                },
                builder: (context, state) {
                  return CustomButton(
                    text: 'Login',
                    isLoading: state is LoginLoading,
                    onPressed: () {
                      context.read<LoginCubit>().login(
                        emailController.text,
                        passwordController.text,
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
