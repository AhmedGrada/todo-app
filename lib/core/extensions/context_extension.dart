import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todo/config/theme/app_colors.dart';

extension ContextExtension on BuildContext {
  ScaffoldMessengerState get scaffoldMessenger => ScaffoldMessenger.of(this);

  GoRouter get router => GoRouter.of(this);

  /// Show [SnackBar]
  void showSnackBar(
    String text, {
    bool isError = true,
    bool isSuccess = false,
    String? actionText,
    VoidCallback? onPressed,
  }) {
    scaffoldMessenger.hideCurrentSnackBar();
    scaffoldMessenger.showSnackBar(
      SnackBar(
        showCloseIcon: true,
        behavior: SnackBarBehavior.floating,
        elevation: 3,
        action: onPressed != null
            ? SnackBarAction(
                backgroundColor: Colors.white24,
                label: actionText ?? 'ok',
                textColor: Colors.white,
                onPressed: () {
                  // Delay the action to let snackbar close first
                  Future.delayed(const Duration(milliseconds: 150), onPressed);
                },
              )
            : null,
        backgroundColor: isSuccess
            ? AppColors.lightGreen
            : isError
            ? AppColors.error
            : AppColors.lightText,
        content: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 10,
          children: [
            Icon(
              isSuccess
                  ? Icons.check_circle_outline_rounded
                  : isError
                  ? Icons.error_outline_rounded
                  : Icons.info_outline_rounded,
              color: Colors.white,
            ),
            Flexible(
              child: Text(text, style: const TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
