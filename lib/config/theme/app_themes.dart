import 'package:flutter/material.dart';
import 'package:todo/config/theme/app_colors.dart';
import 'package:todo/config/theme/app_fonts.dart';
import 'package:todo/config/theme/app_styles.dart';

class AppThemes {
  // ================= LIGHT THEME =================
  static ThemeData light = ThemeData(
    brightness: Brightness.light,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primaryColor,
      primary: AppColors.primaryColor,
      onPrimary: AppColors.white,
      secondary: AppColors.secondaryColor,
      surface: AppColors.white,
      error: AppColors.error,
      brightness: Brightness.light,
    ),
    scaffoldBackgroundColor: AppColors.lightBlue,
    fontFamily: AppFonts.fontFamily,

    // ============ Input Decoration Theme For Text Fields ============
    inputDecorationTheme: InputDecorationTheme(
      hintStyle: AppStyles.medium14.copyWith(color: AppColors.grey),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: AppColors.grey, width: 1),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: AppColors.secondaryColor, width: 1),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: AppColors.secondaryColor, width: 1),
      ),
      errorStyle: AppStyles.medium10.copyWith(color: AppColors.secondaryColor),
    ),
  );
}
