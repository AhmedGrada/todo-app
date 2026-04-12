import 'package:flutter/material.dart';
import 'package:todo/config/theme/app_colors.dart';
import 'package:todo/core/widgets/custom_text_field.dart';

class PasswordTextField extends StatefulWidget {
  final TextEditingController controller;
  final void Function(String)? onFieldSubmitted;
  final String? hintText;
  final String? labelText;

  const PasswordTextField({
    super.key,
    required this.controller,
    this.onFieldSubmitted,
    this.hintText,
    this.labelText,
  });

  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  bool _isObscured = true;

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      controller: widget.controller,
      label: widget.labelText ?? "Password",
      hintText: widget.hintText ?? "Enter your password",
      textInputAction: TextInputAction.done,
      keyboardType: TextInputType.visiblePassword,
      autofillHints: const [AutofillHints.password],
      onFieldSubmitted: widget.onFieldSubmitted,
      textAlign: TextAlign.start,
      obscureText: _isObscured,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Password is required";
        }
        return null;
      },
      suffixIcon: IconButton(
        icon: Icon(
          _isObscured ? Icons.visibility_off : Icons.visibility,
          color: AppColors.white,
        ),
        onPressed: () {
          setState(() {
            _isObscured = !_isObscured;
          });
        },
      ),
    );
  }
}
