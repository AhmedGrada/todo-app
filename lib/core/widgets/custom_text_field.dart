import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:todo/config/theme/app_colors.dart';
import 'package:todo/config/theme/app_styles.dart';
import 'package:todo/core/utils/safe_text_input_formatter.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.label,
    required this.controller,
    this.hintText,
    this.validator,
    this.keyboardType,
    this.inputFormatters,
    this.autofillHints,
    this.onFieldSubmitted,
    this.suffixIcon,
    this.obscureText = false,
    this.textAlign = TextAlign.start,
    this.maxLines = 1,
    this.maxLength,
    this.textInputAction,
    this.textColor,
  });

  final String label;
  final TextEditingController controller;
  final String? hintText;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final Iterable<String>? autofillHints;
  final void Function(String)? onFieldSubmitted;
  final Widget? suffixIcon;
  final bool obscureText;
  final TextAlign textAlign;
  final int maxLines;
  final TextInputAction? textInputAction;
  final int? maxLength;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label.isNotEmpty) ...[
          Text(label, style: AppStyles.medium14.copyWith(color: textColor)),
          const SizedBox(height: 8),
        ],
        TextFormField(
          maxLength: maxLength,
          controller: controller,
          validator: validator,
          textInputAction: textInputAction,
          keyboardType: keyboardType,
          inputFormatters: [SafeTextInputFormatter(), ...?inputFormatters],
          autofillHints: autofillHints,
          onFieldSubmitted: onFieldSubmitted,
          obscureText: obscureText,
          textAlign: textAlign,
          maxLines: maxLines,
          onTapOutside: (_) => FocusScope.of(context).unfocus(),
          style: AppStyles.medium14.copyWith(color: AppColors.dark),
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            counterText: '',
            hintText: hintText,
            hintStyle: AppStyles.medium14.copyWith(color: AppColors.grey),
            suffixIcon: suffixIcon,
          ),
        ),
      ],
    );
  }
}
