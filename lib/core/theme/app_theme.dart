import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class AppTheme {

  AppTheme._();

  static ThemeData lightTheme = ThemeData(

    useMaterial3: true,

    scaffoldBackgroundColor: AppColors.background,

    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      brightness: Brightness.light,
    ),

    appBarTheme: const AppBarTheme(

      centerTitle: true,

      elevation: 0,

      backgroundColor: Colors.white,

      foregroundColor: AppColors.primary,

      surfaceTintColor: Colors.white,

    ),

    inputDecorationTheme: InputDecorationTheme(

      filled: true,

      fillColor: Colors.white,

      contentPadding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 16,
      ),

      border: OutlineInputBorder(

        borderRadius: BorderRadius.circular(16),

      ),

      focusedBorder: OutlineInputBorder(

        borderRadius: BorderRadius.circular(16),

        borderSide: const BorderSide(
          color: AppColors.primary,
          width: 2,
        ),

      ),

    ),

  );

}