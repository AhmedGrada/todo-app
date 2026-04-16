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
import 'package:todo/features/auth/presentation/cubit/login/login_cubit.dart';
import 'package:todo/features/auth/presentation/cubit/reset_password/resetpassword_cubit.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LoginCubit>(create: (context) => getIt<LoginCubit>()),
        BlocProvider<ResetpasswordCubit>(
          create: (context) => getIt<ResetpasswordCubit>(),
        ),
      ],
      child: MultiBlocListener(
        listeners: [
          BlocListener<ResetpasswordCubit, ResetpasswordState>(
            listener: (context, state) {
              if (state is ResetpasswordSuccess) {
                context.showSnackBar(
                  'Password reset link sent to your email',
                  isSuccess: true,
                );
              } else if (state is ResetpasswordFailure) {
                context.showSnackBar(state.errorMessage, isSuccess: false);
              }
            },
          ),
        ],
        child: Builder(
          builder: (context) {
            return Scaffold(
              body: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    const SizedBox(height: 80),
                    SizedBox(
                      height: 250,
                      child: Column(
                        children: [
                          const Image(
                            image: AssetImage('assets/todo.png'),
                            height: 200,
                            width: 200,
                          ),
                          Text(
                            'Todo App',
                            style: AppStyles.medium25.copyWith(
                              color: AppColors.primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                'Login',
                                style: AppStyles.medium25.copyWith(
                                  color: AppColors.primaryColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            'Welcome back! Please enter your details to login.',
                            style: AppStyles.medium14.copyWith(
                              color: AppColors.grey,
                            ),
                          ),
                          const SizedBox(height: 24),
                          CustomTextField(
                            controller: emailController,
                            label: 'Email',
                            hintText: 'Enter your email',
                          ),
                          const SizedBox(height: 16),
                          PasswordTextField(
                            controller: passwordController,
                            labelText: 'Password',
                            hintText: 'Enter your password',
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () {
                                if (emailController.text.isNotEmpty) {
                                  context
                                      .read<ResetpasswordCubit>()
                                      .resetPassword(emailController.text);
                                } else {
                                  context.showSnackBar(
                                    'Please enter your email to reset password',
                                    isSuccess: false,
                                  );
                                }
                              },
                              child: Text(
                                'Forgot Password?',
                                style: AppStyles.medium14.copyWith(
                                  color: AppColors.primaryColor,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    BlocConsumer<LoginCubit, LoginState>(
                      listener: (context, state) {
                        if (state is LoginSuccess) {
                          context.go(AppRoutes.home);
                        } else if (state is LoginFailure) {
                          context.showSnackBar(
                            state.errorMessage,
                            isSuccess: false,
                          );
                        }
                      },
                      builder: (context, state) {
                        return Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: CustomButton(
                            text: 'Login',
                            isLoading: state is LoginLoading,
                            onPressed: () {
                              context.read<LoginCubit>().login(
                                emailController.text,
                                passwordController.text,
                              );
                            },
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              bottomNavigationBar: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 30),
                    ),
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
            );
          },
        ),
      ),
    );
  }
}
