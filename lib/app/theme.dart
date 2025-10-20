import 'package:flutter/material.dart';
import 'package:news_app/common/constants/app_colors.dart';

ThemeData buildLightTheme() {
  final base = ColorScheme.fromSeed(
    seedColor: AppColors.primaryBlue,
    brightness: Brightness.light,
  );

  final scheme = base.copyWith(
    primary: AppColors.primaryBlue,
    onPrimary: AppColors.white,
    surface: AppColors.white,
    onSurface: AppColors.black,
    secondary: AppColors.grey,
    outline: AppColors.darkGrey,
    onSurfaceVariant: AppColors.darkGrey,
    outlineVariant: AppColors.greyBorder,
  );

  return ThemeData(
    useMaterial3: true,
    colorScheme: scheme,
    scaffoldBackgroundColor: scheme.surface,


    appBarTheme: AppBarTheme(
      backgroundColor: scheme.surface,
      foregroundColor: scheme.onSurface,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: TextStyle(
        color: scheme.onSurface,
        fontSize: 18,
        fontWeight: FontWeight.w700,
      ),
    ),


  );
}

ThemeData buildDarkTheme() {
  final base = ColorScheme.fromSeed(
    seedColor: AppColors.primaryBlue,
    brightness: Brightness.dark,
  );

  final scheme = base.copyWith(
    primary: AppColors.primaryBlue,
    onPrimary: AppColors.white,
    surface: AppColors.black,
    onSurface: AppColors.white,
    secondary: AppColors.grey,
    outline: AppColors.darkGrey,
  );

  return ThemeData(
    useMaterial3: true,
    colorScheme: scheme,
    scaffoldBackgroundColor: scheme.surface,



    appBarTheme: AppBarTheme(
      backgroundColor: scheme.surface,
      foregroundColor: scheme.onSurface,
      elevation: 0,
      centerTitle: true,
    ),

  

  );
}
