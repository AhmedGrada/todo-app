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
import 'package:todo/features/auth/presentation/cubit/register/register_cubit.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<RegisterCubit>(),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              context.go(AppRoutes.login);
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(height: 200),
              Text(
                'Register',
                style: AppStyles.medium25.copyWith(
                  color: AppColors.dark,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 24),
              CustomTextField(label: 'Email', controller: emailController),
              SizedBox(height: 16),
              PasswordTextField(
                labelText: 'Password',
                controller: passwordController,
              ),
              SizedBox(height: 16),

              BlocConsumer<RegisterCubit, RegisterState>(
                listener: (context, state) {
                  if (state is RegisterSuccess) {
                    context.go(AppRoutes.login);
                  } else if (state is RegisterFailure) {
                    context.showSnackBar(state.errorMessage, isSuccess: false);
                  }
                },
                builder: (context, state) {
                  return CustomButton(
                    text: 'Register',
                    isLoading: state is RegisterLoading,
                    onPressed: () {
                      context.read<RegisterCubit>().register(
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
