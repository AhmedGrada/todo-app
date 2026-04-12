import 'package:flutter/material.dart';
import 'package:todo/config/theme/app_colors.dart';
import 'package:todo/config/theme/app_styles.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    this.textStyle,
    this.height,
    this.color,
    this.icon,
  });

  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final TextStyle? textStyle;
  final double? height;
  final Color? color;
  final IconData? icon;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isLoading ? null : onPressed,
      style: ElevatedButton.styleFrom(
        overlayColor: AppColors.white,
        backgroundColor: color ?? AppColors.primaryColor,
        minimumSize: Size(double.infinity, height ?? 56),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        disabledBackgroundColor: color != null
            ? color!.withValues(alpha: 0.6)
            : AppColors.primaryColor.withValues(alpha: 0.6),
      ),
      child: isLoading
          ? SizedBox(
              height: 24,
              width: 24,
              child: CircularProgressIndicator(
                color: AppColors.white,
                strokeWidth: 3,
              ),
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (icon != null) ...[
                  Icon(icon, color: AppColors.white),
                  const SizedBox(width: 8),
                ],
                Text(
                  text,
                  style:
                      textStyle ??
                      AppStyles.medium16.copyWith(color: AppColors.white),
                ),
              ],
            ),
    );
  }
}
