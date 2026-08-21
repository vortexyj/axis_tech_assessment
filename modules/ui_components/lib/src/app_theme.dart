import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'font_family.dart';
import 'text_styles.dart';

enum ThemeTypes { light, dark }

class AppTheme {
  AppTheme._();
  static ThemeTypes theme = ThemeTypes.light;

  static ThemeData get currentTheme {
    switch (theme) {
      case ThemeTypes.light:
        return light;
      case ThemeTypes.dark:
        return dark;
    }
  }

  static ThemeData get light => ThemeData(
    textTheme: TextTheme(
      labelLarge: TextStyles.bold,
      labelSmall: TextStyles.light,
      labelMedium: TextStyles.medium,
      displayLarge: TextStyles.bold,
      displayMedium: TextStyles.medium,
      displaySmall: TextStyles.light,
      bodyMedium: TextStyles.medium,
      bodyLarge: TextStyles.extraBold,
      bodySmall: TextStyles.body,
      titleMedium: TextStyles.body,
      titleLarge: TextStyles.bold,
      titleSmall: TextStyles.medium,
      headlineLarge: TextStyles.bold,
      headlineMedium: TextStyles.medium,
      headlineSmall: TextStyles.semiBold,
    ),
    fontFamily: FontFamily().cairo,
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
    brightness: Brightness.light,
    primaryColor: AppColors.mainColor,
    textSelectionTheme: TextSelectionThemeData(
      selectionColor: AppColors.mainColor.withValues(alpha: 0.3),
      cursorColor: AppColors.mainColor,
      selectionHandleColor: AppColors.mainColor,
    ),
    colorScheme: ColorScheme.fromSwatch(
        primarySwatch: MaterialColor(
          AppColors.generateColorScheme(AppColors.mainColor, 9)[300]!.toARGB32(),
          AppColors.generateColorScheme(AppColors.mainColor, 9),
        )).copyWith(
      brightness: Brightness.light,
      primary: AppColors.mainColor,
      secondary: AppColors.lightMainColor,
      error: AppColors.errorColor,
      surface: AppColors.backgroundColor,
      tertiary: AppColors.hintGrey,
      onSurface: AppColors.hintGrey,
      onPrimary: AppColors.textColor,
    ),
  );
  static ThemeData get dark => ThemeData(
    primaryColor: AppColors.mainColor,
    textSelectionTheme: TextSelectionThemeData(
      selectionColor: AppColors.mainColor.withValues(alpha: 0.3),
      cursorColor: AppColors.mainColor,
      selectionHandleColor: AppColors.mainColor,
    ),
    colorScheme: ColorScheme.fromSwatch(
        primarySwatch: MaterialColor(
      AppColors.generateColorScheme(AppColors.mainColor, 9)[300]!.toARGB32(),
      AppColors.generateColorScheme(AppColors.mainColor, 9),
    )).copyWith(
      brightness: Brightness.dark,
      primary: AppColors.mainColor,
      secondary: AppColors.backgroundColor,
      error: AppColors.errorColor,
      surface: AppColors.backgroundColor,
      tertiary: AppColors.hintGrey,
      onSurface: AppColors.hintGrey,
      onPrimary: AppColors.textColor,
    ),
  );
}