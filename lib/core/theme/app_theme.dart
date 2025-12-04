import 'package:flutter/material.dart';
import 'package:task10_figma_auth/core/theme/app_colors.dart';

abstract final class AppTheme {
  static ThemeData appTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.whiteColor,

    textTheme: const TextTheme(
      titleLarge: TextStyle(
        color: AppColors.blueColor,
        fontSize: 42,
        fontWeight: FontWeight.w700,
      ),
      titleMedium: TextStyle(
        color: AppColors.blueColor,
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
      bodyLarge: TextStyle(
        color: AppColors.greyColor,
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
      bodyMedium: TextStyle(
        color: AppColors.greyColor,
        fontSize: 14,
        fontWeight: FontWeight.w600,
      ),
      headlineLarge: TextStyle(
        color: AppColors.whiteColor,
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
      headlineMedium: TextStyle(
        color: AppColors.yellowColor,
        fontSize: 14,
        fontWeight: FontWeight.w600,
      ),
    ),
  );
}
